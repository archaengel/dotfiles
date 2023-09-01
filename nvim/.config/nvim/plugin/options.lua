local opt = vim.opt
local cmd = vim.cmd

opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.completeopt = "menu,menuone,noselect"
opt.cursorline = true
opt.colorcolumn = "80,100"
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true
opt.incsearch = true
opt.hlsearch = false
opt.scrolloff = 8
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 50
opt.listchars = "tab:» ,trail:-,nbsp:+,eol:↲"
opt.list = true
opt.signcolumn = "yes:1"
opt.path = "."
opt.regexpengine = 0
opt.wrap = false
opt.laststatus = 3
opt.winbar = "%#TabLineFill#%{%v:lua.require'nvim-navic'.get_location()%}%=%m%f"
-- Disabling for now, causes :Ex to print before opening file
-- opt.cmdheight = 0

-- Indentation
cmd [[
    filetype plugin on
    syntax on
]]

-- Completion Highlight
cmd [[
    highlight link CompeDocumentation NormalFloat
]]

cmd [[colorscheme tokyonight]]
cmd [[syntax on]]
-- opt.background = "dark"
