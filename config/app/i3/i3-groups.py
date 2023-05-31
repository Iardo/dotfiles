#!/usr/bin/env python3

import fcntl
import json
import os
import subprocess
import sys
import time

WORKSPACE_NUMBER = 1
MARK_BY_CLASS = {
    "google-chrome": "grp_chrome",
    "mpv": "grp_mpv",
}
PATH_LOCK = os.path.join(os.environ.get("XDG_RUNTIME_DIR", "/tmp"), "i3-groups.lock")
FLOATING_STATES = ("auto_on", "user_on")


def run_command(command):
    subprocess.run(["i3-msg", command], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


def read_tree():
    return json.loads(subprocess.check_output(["i3-msg", "-t", "get_tree"]))


def walk(node, parent=None, workspace=None):
    if node["type"] == "workspace":
        workspace = node
    yield node, parent, workspace
    for child in node.get("nodes", []):
        yield from walk(child, node, workspace)


def window_class(node):
    properties = node.get("window_properties") or {}
    return (properties.get("class") or "").lower()


def find_parent(window_id):
    for node, parent, _ in walk(read_tree()):
        if node["id"] == window_id:
            return parent
    return None


def group_window(window_id, class_name, mark_by_class=None, workspace_number=None):
    mark_by_class = mark_by_class or MARK_BY_CLASS
    workspace_number = workspace_number or WORKSPACE_NUMBER
    mark = mark_by_class.get(class_name)
    if mark is None:
        return

    nodes = list(walk(read_tree()))
    target = next(((n, p, w) for n, p, w in nodes if n["id"] == window_id), None)
    if target is None:
        return
    node, parent, workspace = target
    if workspace is None or workspace.get("num") != workspace_number:
        return
    if node.get("floating") in FLOATING_STATES:
        return

    peers = [
        (n, p)
        for n, p, w in nodes
        if w is workspace
        and n["id"] != window_id
        and window_class(n) == class_name
        and n.get("floating") not in FLOATING_STATES
    ]

    if peers:
        peer, peer_parent = peers[0]
        if peer_parent["type"] == "workspace":
            run_command(f"[con_id={peer['id']}] split v, layout tabbed")
        run_command(f"[con_id={peer['id']}] mark --add {mark}")
        run_command(f"[con_id={window_id}] move window to mark {mark}")
        return

    for _ in range(8):
        parent = find_parent(window_id)
        if parent is None or parent["type"] == "workspace":
            break
        run_command(f"[con_id={window_id}] move right")
    run_command(f"[con_id={window_id}] split v, layout tabbed")


def handle_event(event):
    if event.get("change") != "new":
        return
    container = event.get("container") or {}
    properties = container.get("window_properties") or {}
    class_name = (properties.get("class") or "").lower()
    if class_name in MARK_BY_CLASS:
        time.sleep(0.2)
        group_window(container["id"], class_name)


def listen():
    process = subprocess.Popen(
        ["i3-msg", "-t", "subscribe", "-m", '["window"]'],
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
        text=True,
    )
    for line in process.stdout:
        try:
            handle_event(json.loads(line))
        except Exception as error:
            print(f"i3-groups: {error}", file=sys.stderr)
    process.wait()


def main():
    lock = open(PATH_LOCK, "w")
    try:
        fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
    except OSError:
        return
    while True:
        listen()
        time.sleep(1)


if __name__ == "__main__":
    main()
