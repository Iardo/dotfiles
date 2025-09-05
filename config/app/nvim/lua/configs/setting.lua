-- Settings
-------------------
-- 

local M = {}

M.set_options = function()
    -- Status column
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.statuscolumn = '%s %l %r '
    vim.opt.wrap = false

    -- Enable mouse mode
    vim.opt.mouse = 'a'

    -- Don't show the mode,
    -- since it's already in the status line
    vim.opt.showmode = false

    -- Sync clipboard between OS and Neovim.
    --  Schedule the setting after `UiEnter` because it can increase startup-time.
    --  Remove this option if you want your OS clipboard to remain independent.
    --  See `:help 'clipboard'`
    vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
    end)

    vim.opt.breakindent = true
    vim.opt.endofline = true
    vim.opt.expandtab = true
    vim.opt.ignorecase = true
    vim.opt.shiftwidth = 2
    vim.opt.signcolumn = 'yes'
    vim.opt.smartcase = true
    vim.opt.softtabstop = 2
    vim.opt.splitbelow = true
    vim.opt.splitright = true
    vim.opt.tabstop = 2
    vim.opt.timeoutlen = 300
    vim.opt.undofile = true
    vim.opt.updatetime = 250

    -- Sets how neovim will display certain whitespace characters in the editor.
    --  See `:help 'list'`
    --  and `:help 'listchars'`
    vim.opt.list = true
    vim.opt.listchars = { tab = '│ ', trail = '·', nbsp = '␣' }

    -- Preview substitutions live, as you type!
    vim.opt.inccommand = 'split'

    -- Show which line your cursor is on
    vim.opt.cursorline = true

    -- Minimal number of screen lines to keep above and below the cursor.
    vim.opt.scrolloff = 10
end

return M
