-- Uaihu
-------------------
-- https://github.com/Iardo/uaihu-colorscheme

local M = {}

local VERSION_THEME = 'main'
local URL_THEME = 'https://raw.githubusercontent.com/Iardo/uaihu-colorscheme/' .. VERSION_THEME .. '/build/uaihu-nvim.lua'
local PATH_THEME = vim.fn.stdpath 'config' .. '/lua/themes/uaihu.lua'

local download = function()
    local path_partial = PATH_THEME .. '.partial'
    vim.fn.mkdir(vim.fn.fnamemodify(PATH_THEME, ':h'), 'p')
    local result = vim.system({ 'curl', '--fail', '--silent', '--show-error', '--location', '--max-time', '30', '--output', path_partial, URL_THEME }, { text = true }):wait()
    if result.code ~= 0 then
        vim.fn.delete(path_partial)
        vim.notify('Uaihu: download failed\n' .. (result.stderr or ''), vim.log.levels.WARN)
        return false
    end
    return (vim.uv.fs_rename(path_partial, PATH_THEME)) == true
end

local apply = function()
    package.loaded['themes.uaihu'] = nil
    local loaded, theme = pcall(require, 'themes.uaihu')
    if loaded then
        theme.set_options()
    else
        vim.notify('Uaihu: theme not available, run :UaihuUpdate', vim.log.levels.WARN)
    end
end

M.set_options = function()
    vim.api.nvim_create_user_command('UaihuUpdate', function()
        if download() then
            apply()
            vim.notify('Uaihu: updated to ' .. VERSION_THEME)
        end
    end, { desc = 'Download the Uaihu theme again and apply it' })

    if not vim.uv.fs_stat(PATH_THEME) then
        download()
    end
    apply()
end

return M
