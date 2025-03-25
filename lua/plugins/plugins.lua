return{
    -- External tooling manager, can install things like LSP, Linter, etc
    {"williamboman/mason.nvim"},

    -- C# LSP client
    {"OmniSharp/omnisharp-vim",
        config = function()
            vim.keymap.set('n', '<leader>gd', ':OmniSharpGotoDefinition<CR>')
            vim.keymap.set('n', '<leader>gi', ':OmniSharpFindImplementations<CR>')
            vim.keymap.set('n', '<leader>gu', ':OmniSharpFindUsages<CR>')
            vim.keymap.set('n', '<leader>rn', ':OmniSharpRename<CR>')
            vim.keymap.set('n', '<leader>ti', ':OmniSharpTypeLookup<CR>')
            vim.keymap.set('n', '<leader>ca', ':OmniSharpGetCodeActions<CR>')
        end
    },

    -- Theme
    --{'folke/tokyonight.nvim', name = 'tokyonight' },
    { 'nanotech/jellybeans.vim', name = 'jellybeans' },

    -- Telescope (file navigation)
    {'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require("keymaps.telescope")
      end
    },

    -- Indentation guidelines
    {"lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup({
                indent = {char = '┊'}
            })
        end
    }
}
