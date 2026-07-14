-- From lazy.nvim:
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Full colour support
vim.opt.termguicolors = true

-- no left coloumn 
vim.opt.number = false 
vim.opt.relativenumber = false
vim.opt.signcolumn = "no"

-- Minimal lines to keep above/below cursor
-- Big number keeps the cursor centerd
vim.opt.scrolloff = 999

-- 80 column indicator
vim.opt.colorcolumn = "81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98"

-- Tabs
vim.opt.tabstop = 4       -- Tab size
vim.opt.shiftwidth = 4    -- Autoindent spaces
vim.opt.expandtab = true  -- Convert tabs to spaces

-- Clipboard (sync with system clipboard)
vim.opt.clipboard = 'unnamedplus'

-- Show whitespace
vim.opt.list = true
vim.opt.listchars = { trail = '⊠', tab = '▸ '}
-- Here is some whitespace for visualising:
-- some(code); 
--			
--                

-- sensible sentinces (end with one space)
vim.opt.joinspaces = false

-- case insensitive search
vim.opt.ignorecase = true

-- round borders for floating windows
vim.opt.winborder = "rounded"

-- Turn of LSP log (it gets huge)
vim.lsp.log.set_level(vim.lsp.log.levels.OFF)
-- vim.lsp.log.set_level(vim.lsp.log.levels.DEBUG)

-- dont scribble crayons everywhere
vim.lsp.semantic_tokens.enable(false)

-- uno reversed enter key
vim.keymap.set('n', '<leader><Enter>', 'DO<C-r>"<Esc>_i', {noremap = true})

-- split string at cursor
vim.keymap.set('n', '<leader>s<CR>', 'i"<Esc>la +<CR>"<Esc>', { noremap = true })

-- J and K to scroll half a page up/down
vim.keymap.set({'n', 'v'}, 'K', '<C-u>', { noremap = true })
vim.keymap.set({'n', 'v'}, 'J', '<C-d>', { noremap = true })
-- K got stood on
vim.keymap.set('n', '<C-k>', '<cmd>normal! K<CR>', { noremap = true })
vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, { noremap = true })
-- J got stood on
vim.keymap.set('n', '<leader>j', '<cmd>normal! J<CR>', { noremap = true })

-- Neovide
if vim.g.neovide then
    vim.o.guifont = "GoMono Nerd Font Mono:h12"

    vim.g.neovide_no_idle = true

    vim.keymap.set('v', '<C-c>', '"+y') -- Copy
    vim.keymap.set('n', '<C-v>', '"+P') -- Paste normal mode
    vim.keymap.set('v', '<C-v>', '"+P') -- Paste visual mode
    vim.keymap.set('c', '<C-v>', '<C-R>+') -- Paste command mode
    vim.keymap.set('i', '<C-v>', '<ESC>l"+Pli') -- Paste insert mode
end
