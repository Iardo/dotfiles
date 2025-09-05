-- Project
-------------------
-- 

return {
  "coffebar/neovim-project",
  lazy = false,
  priority = 100,
  init = function()
    -- enable saving the state of plugins in the session
    vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  end,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
    { "ibhagwan/fzf-lua" },
    { "Shatur/neovim-session-manager" },
  },
  keys = {
    { '<c-p>', ':NeovimProjectDiscover<CR>', desc = 'Project Select', silent = true },
  },
  opts = {
    projects = {
      "~/.config/*",
      "~/projects/*",
    },
    last_session_on_startup = true,
    picker = {
      type = "telescope", -- or "fzf-lua"
    }
  },
}
