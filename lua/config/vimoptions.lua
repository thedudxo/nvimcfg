-- From lazy.nvim example:
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Full colour support
vim.opt.termguicolors = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true;

-- Minimal lines to keep above/below cursor
-- Big number keeps the cursor centerd
vim.opt.scrolloff = 999

-- 80 column indicator
vim.opt.colorcolumn = '81'

-- Tabs
vim.opt.tabstop = 4       -- Tab size
vim.opt.shiftwidth = 4    -- Autoindent spaces
vim.opt.expandtab = true  -- Convert tabs to spaces

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Show whitespace
vim.opt.list = true
vim.opt.listchars = { trail = '◌', tab = '▸ '}
-- Here is some whitespace for visualising:
--			
--                

-- sensible sentinces (end with one space)
vim.opt.joinspaces = false

-- case insensitive search
vim.opt.ignorecase = true;

-- Turn of LSP log (it gets huge)
vim.lsp.log.set_level(vim.lsp.log.levels.OFF)

-- uno reversed enter key
vim.keymap.set('n', '<leader><Enter>', 'DO<C-r>"<Esc>_i', {noremap = true})
