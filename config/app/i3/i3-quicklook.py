#!/usr/bin/env python3

import json
import mimetypes
import os
import select
import subprocess
import sys
import time

from Xlib import X, display

CLASS_VIEWER = "imv"
INSTANCE_WINDOW = "quicklook"
PATH_CONFIG = os.path.expanduser("~/.config/imv/quicklook.conf")
MASK_BUTTONS = X.Button1Mask | X.Button2Mask | X.Button3Mask
SECONDS_GRACE = 0.4
SECONDS_POLL = 0.03
SECONDS_TIMEOUT_WINDOW = 5.0


def run_command(command):
    subprocess.run(["i3-msg", command], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


def read_tree():
    return json.loads(subprocess.check_output(["i3-msg", "-t", "get_tree"]))


def find_window(node):
    properties = node.get("window_properties") or {}
    if properties.get("class") == CLASS_VIEWER and properties.get("instance") == INSTANCE_WINDOW:
        return node["id"]
    for child in node.get("nodes", []) + node.get("floating_nodes", []):
        found = find_window(child)
        if found is not None:
            return found
    return None


def find_node(node, container_id):
    if node["id"] == container_id:
        return node
    for child in node.get("nodes", []) + node.get("floating_nodes", []):
        found = find_node(child, container_id)
        if found is not None:
            return found
    return None


def find_workspace(node, container_id, workspace=None):
    if node.get("type") == "workspace":
        workspace = node["name"]
    if node["id"] == container_id:
        return workspace
    for child in node.get("nodes", []) + node.get("floating_nodes", []):
        found = find_workspace(child, container_id, workspace)
        if found is not None:
            return found
    return None


def is_inside(rect, pointer):
    return rect["x"] <= pointer.root_x < rect["x"] + rect["width"] and rect["y"] <= pointer.root_y < rect["y"] + rect["height"]


def is_image(path):
    mime_type, _ = mimetypes.guess_type(path)
    return bool(mime_type) and mime_type.startswith("image/")


def wait_window(viewer):
    deadline = time.monotonic() + SECONDS_TIMEOUT_WINDOW
    while time.monotonic() < deadline and viewer.poll() is None:
        container_id = find_window(read_tree())
        if container_id is not None:
            return container_id
        time.sleep(0.05)
    return None


def watch(viewer, container_id):
    root = display.Display().screen().root
    process = subprocess.Popen(
        ["i3-msg", "-t", "subscribe", "-m", '["window"]'],
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
        text=True,
    )
    start = time.monotonic()
    was_pressed = False
    try:
        while viewer.poll() is None:
            ready, _, _ = select.select([process.stdout], [], [], SECONDS_POLL)
            if ready:
                line = process.stdout.readline()
                if not line:
                    return
                event = json.loads(line)
                if time.monotonic() - start >= SECONDS_GRACE and event.get("change") == "focus" and event["container"]["id"] != container_id:
                    tree = read_tree()
                    if find_workspace(tree, event["container"]["id"]) != find_workspace(tree, container_id):
                        run_command(f"[con_id={container_id}] kill")
                        return
                    run_command(f"[con_id={container_id}] focus")

            pointer = root.query_pointer()
            is_pressed = bool(pointer.mask & MASK_BUTTONS)
            if is_pressed and not was_pressed:
                node = find_node(read_tree(), container_id)
                if node is not None and not is_inside(node["rect"], pointer):
                    run_command(f"[con_id={container_id}] kill")
                    return
            was_pressed = is_pressed
    finally:
        process.terminate()


def main():
    if len(sys.argv) < 2 or not is_image(sys.argv[1]):
        return
    existing = find_window(read_tree())
    if existing is not None:
        run_command(f"[con_id={existing}] kill")
        return

    environment = {**os.environ, "imv_config": PATH_CONFIG}
    viewer = subprocess.Popen(
        ["imv", "-i", INSTANCE_WINDOW, sys.argv[1]],
        env=environment,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
    container_id = wait_window(viewer)
    if container_id is None:
        viewer.terminate()
        return
    watch(viewer, container_id)
    if viewer.poll() is None:
        viewer.terminate()


if __name__ == "__main__":
    main()
