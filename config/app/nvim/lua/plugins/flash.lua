-- Flash
-------------------
-- https://github.com/folke/flash.nvim

return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = {
    { 'gs', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash jump' },
    { 'gS', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash treesitter' },
  },
}
