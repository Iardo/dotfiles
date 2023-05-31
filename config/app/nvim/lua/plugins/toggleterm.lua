-- Toggleterm
-------------------
-- https://github.com/akinsho/toggleterm.nvim

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    open_mapping = [[<C-\>]],
    size = 55,
    shade_terminals = true,
    direction = 'vertical',
    close_on_exit = true,
  },
}
