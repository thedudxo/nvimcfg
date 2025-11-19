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

-- split string at cursor
vim.keymap.set('n', '<leader>s<CR>', 'i"<Esc>la +<CR>"<Esc>', { noremap = true })

-- Neovide
if vim.g.neovide then
    vim.o.guifont = "GoMono Nerd Font Mono:h14"

    vim.keymap.set('n', '<C-s>', ':w<CR>') -- Save
    vim.keymap.set('v', '<C-c>', '"+y') -- Copy
    vim.keymap.set('n', '<C-v>', '"+P') -- Paste normal mode
    vim.keymap.set('v', '<C-v>', '"+P') -- Paste visual mode
    vim.keymap.set('c', '<C-v>', '<C-R>+') -- Paste command mode
    vim.keymap.set('i', '<C-v>', '<ESC>l"+Pli') -- Paste insert mode
end

-- stahpt arruw keys bruh
local function show_popup(message)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
        "",
        "  " .. message .. "  ",
        ""
    })
    
    local width = #message + 4
    local height = 3
    local win = vim.api.nvim_open_win(buf, false, {
        relative = "cursor",
        row = 1,
        col = 1,
        width = width,
        height = height,
        style = "minimal",
        border = "rounded",
    })
    
    -- Auto-close after 1 second
    vim.defer_fn(function()
        vim.api.nvim_win_close(win, true)
    end, 1000)
end

-- Map arrow keys to show popup
vim.keymap.set({'n', 'i'}, '<Up>', function() show_popup("dont touch that") end)
vim.keymap.set({'n', 'i'}, '<Down>', function() show_popup("dont touch that") end)
vim.keymap.set({'n', 'i'}, '<Left>', function() show_popup("dont touch that") end)
vim.keymap.set({'n', 'i'}, '<Right>', function() show_popup("dont touch that") end)
