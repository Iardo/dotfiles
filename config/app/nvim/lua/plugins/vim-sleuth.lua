-- VIM Sleuth
-------------------
-- Detect tabstop and shiftwidth automatically

return {
  'tpope/vim-sleuth',
  init = function()
    -- Sleuth has no event after detecting, so this runs after it
    local function show_tabs_four_wide(buffer)
      if not vim.api.nvim_buf_is_loaded(buffer) or vim.bo[buffer].buftype ~= '' then
        return
      end
      if not vim.bo[buffer].expandtab then
        vim.bo[buffer].tabstop = 4
        vim.bo[buffer].shiftwidth = 4
      end
    end

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(event)
        vim.schedule(function()
          show_tabs_four_wide(event.buf)
        end)
      end,
    })

    -- Restored session buffers skip sleuth, so they keep the global tabstop
    vim.api.nvim_create_autocmd('SessionLoadPost', {
      callback = function()
        vim.schedule(function()
          for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buffer) and vim.bo[buffer].buftype == '' then
              vim.api.nvim_buf_call(buffer, function()
                vim.cmd 'silent! Sleuth'
              end)
              show_tabs_four_wide(buffer)
            end
          end
        end)
      end,
    })
  end,
}
