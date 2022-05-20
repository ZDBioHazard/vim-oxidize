-- File: oxidize.lua
-- Description: A lualine theme for the 'oxidize' Vim color scheme
-- Author: Ryan Turner <zdbiohazard2@gmail.com>
-- Source: https://github.com/ZDBioHazard/vim-oxidize

return {
    -- We're using cterm colors here to let lualine generate the RGB colors
    -- lualine will leave out the cterm colors entirely if we use RGB here
    normal = {
        a = {fg = 233, bg = 178, gui = 'bold'},
        b = {fg = 250, bg = 233},
        c = {fg = 178, bg = 235},
    },
    insert   = {a = {fg = 233, bg = 208, gui = 'bold'}},
    replace  = {a = {fg = 233, bg = 166, gui = 'bold'}},
    visual   = {a = {fg = 233, bg =  31, gui = 'bold'}},
    command  = {a = {fg = 233, bg =  96, gui = 'bold'}},
    inactive = {a = {fg = 250, bg = 240, gui = 'bold'}},
}
