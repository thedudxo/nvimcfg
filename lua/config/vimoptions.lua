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

-- Minimal lines to keep above/below cursor
vim.opt.scrolloff = 25

-- 80 column indicator
vim.opt.colorcolumn = '81'

-- Tabs
vim.opt.tabstop = 4       -- Tab size
vim.opt.shiftwidth = 4    -- Autoindent spaces
vim.opt.expandtab = true  -- Convert tabs to spaces

-- Show whitespace
vim.opt.list = true
vim.opt.listchars = { trail = '◌', tab = '▸ '}
-- Here is some whitespace for visualising:
--			
--                
