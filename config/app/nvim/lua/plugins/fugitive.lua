-- Fugitive
-------------------
-- https://github.com/tpope/vim-fugitive

return {
  'tpope/vim-fugitive',
  cmd = { 'G', 'GBrowse', 'Gdiffsplit', 'Git', 'Gread', 'Gwrite' },
  dependencies = {
    { 'tpope/vim-rhubarb' },
  },
}
