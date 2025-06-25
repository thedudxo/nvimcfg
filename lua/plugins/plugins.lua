return{
    -- External tooling manager, can install things like LSP, Linter, etc
    {"williamboman/mason.nvim"},

    -- C# LSP client
    {"OmniSharp/omnisharp-vim",
        config = function()
            vim.g.OmniSharp_want_snippet = 1

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

    -- Powershell LSP
    {'TheLeoP/powershell.nvim',
        opts = {
            bundle_path = vim.fn.stdpath "data" .. '/mason/packages/powershell-editor-services'
        }
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
                indent = {char = '⁚'}
            })
        end
    },

    -- Autocompletion
    -- Error highligting
    -- Outliner
    {'neoclide/coc.nvim',
        branch = 'release'
    },

    -- Copilot
    {'github/copilot.vim',
        branch = 'release'
    },

    -- Snippets
    -- Does not seem to be working well?
    -- probably needs to intergrate with coc properly.
    -- see :CocList sources
    -- see https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources
    -- {'SirVer/ultisnips'},   -- Engine
    -- {'honza/vim-snippets'}, -- Snippets

    -- Allow scrolling up above the top of the file
    {'nullromo/go-up.nvim',
        opts = {
            --mapZZ = false,
            --respectScrolloff = true,
            goUpLimit = 'center'},
        config = function(_, opts)
            local goUp = require('go-up')
            goUp.setup(opts)
            vim.api.nvim_create_autocmd(
                {"CursorMoved", "BufEnter"},{
                pattern = "*",
                callback = function()
                    require('go-up').centerScreen();
                end,
            })
            vim.api.nvim_create_autocmd("CursorMovedI", {
                pattern = "*",
                callback = function()
                    local win = vim.api.nvim_get_current_win()
                    local cursor = vim.api.nvim_win_get_cursor(win) -- {row, col}
                    require('go-up').centerScreen()
                    vim.api.nvim_win_set_cursor(win, cursor)
                end,
            })
        end,
    }
}
