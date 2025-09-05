-- Theme
-------------------
--

local M = {}

M.set_options = function()
    -- vim.cmd.colorscheme 'uaihu'

    -- Modeline
    -- See `:help modeline`
    -- vim: ts=2 sts=2 sw=2 et
end

M.ui = {
  icons = vim.g.have_nerd_font and {} or {
    cmd = '⌘',
    config = '🛠',
    event = '📅',
    ft = '📂',
    init = '⚙',
    keys = '🗝',
    lazy = '💤 ',
    plugin = '🔌',
    require = '🌙',
    runtime = '💻',
    source = '📄',
    start = '🚀',
    task = '📌',
  },
}

return M
