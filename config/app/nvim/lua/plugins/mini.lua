-- Mini
-------------------
--

return {
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    local starter = require 'mini.starter'
    local project_items = {}
    for _, project in ipairs(require 'configs.projects') do
      table.insert(project_items, {
        name = project.name,
        section = 'Projects',
        action = function()
          vim.cmd.cd(vim.fn.expand(project.path))
          vim.cmd.edit '.'
        end,
      })
    end
    local project_markers = { '.git', 'composer.json', 'package.json', 'Cargo.toml', 'go.mod', 'pyproject.toml' }
    local is_project = false
    for _, marker in ipairs(project_markers) do
      if vim.uv.fs_stat(vim.fn.getcwd() .. '/' .. marker) then
        is_project = true
        break
      end
    end
    if is_project and vim.fn.argc() == 0 then
      local function open_explorer_if_empty()
        vim.schedule(function()
          local buffer_is_empty = vim.fn.bufname '' == '' and vim.bo.buftype == '' and vim.fn.line '$' == 1 and vim.fn.getline(1) == ''
          if buffer_is_empty then
            vim.cmd 'Explore'
          end
        end)
      end
      vim.api.nvim_create_autocmd({ 'VimEnter', 'SessionLoadPost' }, {
        once = true,
        callback = open_explorer_if_empty,
      })
    end

    starter.setup {
      autoopen = not is_project,
      header = '',
      footer = '',
      items = project_items,
      content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.aligning('center', 'center'),
      },
    }

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
