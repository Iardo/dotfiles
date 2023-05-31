-- Keymaps
-------------------
--  See `:help vim.keymap.set()`
--  See `:help wincmd` for a list of all window commands

local M = {}

M.set_options = function()
    -- Clear highlights on search when pressing <Esc> in normal mode
    --  See `:help hlsearch`
    vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

    -- Diagnostic keymaps
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

    -- Keybinds to make split navigation easier.
    vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
    vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
    vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
    vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

    -- TIP: Disable arrow keys in normal mode
    -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
    -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
    -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
    -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

    -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
    -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
    -- is not what someone will guess without a bit more experience.
    --
    -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
    -- or just use <C-\><C-n> to exit terminal mode
    vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

    -- Buffers
    vim.keymap.set('n', '<A-,>', '<cmd>BufferPrevious<CR>', { desc = 'Previous buffer' })
    vim.keymap.set('n', '<A-.>', '<cmd>BufferNext<CR>', { desc = 'Next buffer' })
    vim.keymap.set('n', '<A-<>', '<cmd>BufferMovePrevious<CR>', { desc = 'Move buffer left' })
    vim.keymap.set('n', '<A->>', '<cmd>BufferMoveNext<CR>', { desc = 'Move buffer right' })
    for position = 1, 9 do
        vim.keymap.set('n', '<A-' .. position .. '>', '<cmd>BufferGoto ' .. position .. '<CR>', { desc = 'Go to buffer ' .. position })
    end
    vim.keymap.set('n', '<A-0>', '<cmd>BufferLast<CR>', { desc = 'Go to last buffer' })
    vim.keymap.set('n', '<A-c>', '<cmd>BufferClose<CR>', { desc = 'Close buffer' })
    vim.keymap.set('n', '<A-p>', '<cmd>BufferPick<CR>', { desc = 'Pick buffer' })
    vim.keymap.set('n', '<leader>bb', '<cmd>BufferOrderByBufferNumber<CR>', { desc = 'Order buffers by number' })
    vim.keymap.set('n', '<leader>bd', '<cmd>BufferOrderByDirectory<CR>', { desc = 'Order buffers by directory' })
    vim.keymap.set('n', '<leader>bl', '<cmd>BufferOrderByLanguage<CR>', { desc = 'Order buffers by language' })
end

return M
