local M = {}

M.set_options = function()
    -- Interface
    -- --------------------
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.statuscolumn = '%s %l %r '
    vim.opt.wrap = false
    vim.opt.mouse = 'a'
    vim.opt.showmode = false

    -- Clipboard
    -- --------------------
    -- Scheduled after `UiEnter` because it can increase startup time
    vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
    end)

    -- Editing
    -- --------------------
    vim.opt.breakindent = true
    vim.opt.endofline = true
    vim.opt.expandtab = true
    vim.opt.ignorecase = true
    vim.opt.shiftwidth = 2
    vim.opt.signcolumn = 'yes'
    vim.opt.smartcase = true
    vim.opt.smarttab = true
    vim.opt.softtabstop = 2
    vim.opt.splitbelow = true
    vim.opt.splitright = true
    vim.opt.tabstop = 4
    vim.opt.timeoutlen = 300
    vim.opt.undofile = true
    vim.opt.updatetime = 250

    -- Display
    -- --------------------
    vim.opt.list = true
    vim.opt.listchars = { tab = '│ ', trail = '·', nbsp = '␣' }
    vim.opt.inccommand = 'split'
    vim.opt.conceallevel = 2
    vim.opt.cursorline = true
    vim.opt.fillchars = { eob = ' ' }
    vim.opt.scrolloff = 10
end

return M
