return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Must be loaded before dependants
      { 'williamboman/mason.nvim', config = true },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'j-hui/fidget.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- if vim.g.have_nerd_font then
      --   local signs = { Error = '', Warn = '', Hint = '', Info = '' }
      --   for type, icon in pairs(signs) do
      --     local hl = 'DiagnosticSign' .. type
      --     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      --   end
      -- end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- rust_analyzer = {},
        bashls = {},
        cssls = {},
        emmet_ls = {},
        ltex_plus = {
          settings = {
            ltex = {
              language = 'auto',
            },
          },
        },
        pyright = {},
        ts_ls = {},

        lua_ls = {
          -- cmd = {},
          -- filetypes = {},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'ada-language-server',
        'asmfmt',
        'autopep8',
        'awk-language-server',
        'beautysh',
        'biome',
        'buf',
        'clang-format',
        'clangd',
        'cobol-language-support',
        'crystalline',
        'djlint',
        'dockerfile-language-server',
        'elixir-ls',
        'elm-format',
        'elm-language-server',
        'elp',
        'eslint_d',
        'fortls',
        'fprettify',
        'gdtoolkit',
        'gersemi',
        'ginko_ls',
        'glint',
        'graphql-language-service-cli',
        'haxe-language-server',
        'hdl-checker',
        'html-lsp',
        'intelephense',
        'jinja-lsp',
        'jq',
        'json-lsp',
        'julia-lsp',
        'kotlin-lsp',
        'ktlint',
        'lemminx',
        'markdownlint',
        'marksman',
        'mbake',
        'mdformat',
        'mdx-analyzer',
        'millet',
        'neocmakelsp',
        'nginx-config-formatter',
        'nimlangserver',
        'nixfmt',
        'ols',
        'pgformatter',
        'php-cs-fixer',
        'postgres-language-server',
        'powershell-editor-services',
        'prettier',
        'prolog-lsp',
        'pug-lsp',
        'raku-navigator',
        'rescript-language-server',
        'roc_language_server',
        'ruff',
        'rust-analyzer',
        'rust_hdl',
        'shfmt',
        'shopify-cli',
        'some-sass-language-server',
        'sql-formatter',
        'stylua',
        'svelte-language-server',
        'swiftformat',
        'systemd-lsp',
        'taplo',
        'tinymist',
        'twiggy-language-server',
        'typstyle',
        'verible',
        'vim-language-server',
        'vsg',
        'vue-language-server',
        'wasm-language-tools',
        'wgsl-analyzer',
        'xmlformatter',
        'yaml-language-server',
        'zls',
      })
      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
      }
      for server_name, server in pairs(servers) do
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        vim.lsp.config(server_name, server)
      end
      require('mason-lspconfig').setup {
        automatic_enable = { exclude = { 'ltex' } },
      }
    end,
  },
}
