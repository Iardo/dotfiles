-- Barbar
-------------------
-- https://github.com/romgrk/barbar.nvim

return {
  'romgrk/barbar.nvim',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    animation = true,
    clickable = true,
    tabpages = true,
    icons = {
      filetype = { enabled = vim.g.have_nerd_font },
    },
  },
}
