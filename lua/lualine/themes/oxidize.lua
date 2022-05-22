-- File: oxidize.lua
-- Description: A lualine theme for the 'oxidize' Vim color scheme
-- Author: Ryan Turner <zdbiohazard2@gmail.com>
-- Source: https://github.com/ZDBioHazard/vim-oxidize

local function lookup(group)
    -- We're using cterm colors here to let lualine generate the RGB colors
    -- lualine will leave out the cterm colors entirely if we use RGB here
    local color = vim.api.nvim_get_hl_by_name(group, false)
    return { fg = color.foreground, bg = color.background }
end

local a = {
    text     = lookup('SignColumn').bg,
    normal   = lookup('StatusLine').fg,
    insert   = lookup('Statement').fg,
    replace  = lookup('Number').fg,
    visual   = lookup('Identifier').fg,
    command  = lookup('PreProc').fg,
    inactive = lookup('StatusLineNC').fg,
}

return {
    normal = {
        a = {fg = a.text, bg = a.normal, gui = 'bold'},
        b = lookup('SignColumn'),
        c = lookup('StatusLine'),
    },
    insert   = {a = {fg = a.text, bg = a.insert, gui = 'bold'}},
    replace  = {a = {fg = a.text, bg = a.replace, gui = 'bold'}},
    visual   = {a = {fg = a.text, bg = a.visual, gui = 'bold'}},
    command  = {a = {fg = a.text, bg = a.command, gui = 'bold'}},
    inactive = {
        a = {fg = a.text, bg = a.inactive, gui = 'bold'},
        c = lookup('StatusLineNC'),
    },
}
