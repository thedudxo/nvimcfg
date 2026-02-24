return{
    -- External tooling manager, can install things like LSP, Linter, etc
    {"williamboman/mason.nvim"},

    -- C# LSP client
    {"OmniSharp/omnisharp-vim",
        config = function()

            -- goto definition
            vim.keymap.set('n', '<leader>gd', ':OmniSharpGotoDefinition<CR>')

            -- goto implementations
            vim.keymap.set('n', '<leader>gi', ':OmniSharpFindImplementations<CR>')

            -- goto usages
            vim.keymap.set('n', '<leader>gu', ':OmniSharpFindUsages<CR>')

            -- Re-Name
            vim.keymap.set('n', '<leader>rn', ':OmniSharpRename<CR>')

            -- Read Manual
            vim.keymap.set('n', '<leader>rm', ':OmniSharpDocumentation<CR>')

            -- Peek Definition
            vim.keymap.set('n', '<leader>pd', ':OmniSharpPreviewDefinition<CR>')

            --  Code Action
            vim.keymap.set('n', '<leader>ca', ':OmniSharpGetCodeActions<CR>')
            -- Viusal code action gives error "No range allowed"
            vim.keymap.set('v', '<leader>ca', ":OmniSharp#CodeActions('visual')<CR>")

            -- Reload Project
            vim.keymap.set('n', '<leader>rp', ':OmniSharpReloadProject<CR>')
        end
    },

    -- Debugger
    {'puremourning/vimspector',
        init = function()
            vim.g.vimspector_enable_mappings = 'HUMAN'
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
            require("telescope").setup {
                defaults = {
                    path_display = {"filename_first"}
                }
            }
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
    },

    --Autocompletion
    --Error highligting
    --Outliner
    {'neoclide/coc.nvim',
        branch = 'release'
    }
}
