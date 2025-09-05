-- Configs
-------------------------
require('themes.uaihu').set_options()
require('configs.global').set_options()
require('configs.theme').set_options()
-- require('configs.health').set_options()
require('configs.autocmd').set_options()
require('configs.keymaps').set_options()
require('configs.plugins').set_options()
require('configs.setting').set_options()

-- Plugins
-------------------------
-- Status :Lazy
-- Update :Lazy update

require('lazy').setup({
  require 'plugins.autocomplete',
  require 'plugins.autoformat',
  require 'plugins.autopairs',
  require 'plugins.comment',
--   require 'plugins.debug',
  require 'plugins.gitsigns',
  require 'plugins.heirline',
  require 'plugins.indent-line',
  require 'plugins.lint',
  require 'plugins.lsp',
  require 'plugins.mini',
  require 'plugins.neo-tree',
  require 'plugins.project',
  require 'plugins.sort',
--   require 'plugins.statuscol',
  require 'plugins.telescope',
  require 'plugins.todo',
  require 'plugins.treesitter',
  require 'plugins.vim-sleuth',
  require 'plugins.which-key',
}, {
  ui = require('configs.theme').ui,
})


-- https://www.reddit.com/r/neovim/comments/1djjc6q/statuscolumn_a_beginers_guide/
-- https://www.reddit.com/r/neovim/comments/1d16sx1/can_absolute_and_relative_line_numbers_be_used/?rdt=58212
-- https://www.reddit.com/r/neovim/comments/10bmy9w/lets_see_your_status_columns/
-- https://www.reddit.com/r/neovim/comments/10bmy9w/comment/j4bpohp/
-- https://github.com/neovim/neovim/issues/27709
-- https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md
-- https://www.reddit.com/r/neovim/comments/yd56wc/heirline_copypaste_examples/
-- https://github.com/anuvyklack/dotfiles/tree/main/roles/neovim/files/lua/anuvyklack/heirline
-- https://github.com/princejoogie/dir-telescope.nvim
