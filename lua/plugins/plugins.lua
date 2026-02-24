return{

    -- Theme
    {'folke/tokyonight.nvim', name = 'tokyonight' },
    --{ 'nanotech/jellybeans.vim', name = 'jellybeans' },

    -- External tooling manager, can install things like LSP, Linter, etc
    {"williamboman/mason.nvim"},

    -- Indentation guidelines
    {"lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup({
                indent = {char = '⁚'}
            })
        end
    },

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

    -- Keep the cursor in the center of the screen always
    {'nullromo/go-up.nvim',
        opts = {goUpLimit = 'center'},
        config = function(_, opts)
            local goUp = require('go-up')
            goUp.setup(opts)

            --Keep centered
            vim.api.nvim_create_autocmd(
                {"CursorMoved", "BufEnter"},{
                pattern = "*",
                callback = function()
                    require('go-up').centerScreen();
                end,
            })

            --Insert mode needs to respect cursor position more carefully
            vim.api.nvim_create_autocmd("CursorMovedI", {
                pattern = "*",
                callback = function()
                    local win = vim.api.nvim_get_current_win()
                    local cursor = vim.api.nvim_win_get_cursor(win)
                    require('go-up').centerScreen()
                    vim.api.nvim_win_set_cursor(win, cursor)
                end,
            })
        end,
    },

    -- Copilot
    {'zbirenbaum/copilot.lua',
        config = function()
            require('copilot').setup({
                suggestion = {
                    auto_trigger = true,
                    keymap = {
                        accept_line = "<M-y>",
                    },
                },
                filetypes = {
                    markdown = true,
                  },
                })
        end,
    },

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

            -- Global code check
            vim.keymap.set('n', '<leader>cc', ':OmniSharpGlobalCodeCheck<CR>')

            vim.g.OmniSharp_popup_options = {
                border = 'rounded'
            }
            vim.g.OmniSharp_popup_position = 'center'
        end
    },

    -- Autocompletion
    -- Error highligting
    -- Outliner
    -- intergrates with omnisharp
    {'neoclide/coc.nvim',
        branch = 'release',
        ft = { 'cs', 'csproj', 'sln', 'slnx' },
    },

    -- Powershell LSP
    {'TheLeoP/powershell.nvim',
        ft = { 'ps1' },
        opts = {
            bundle_path = vim.fn.stdpath "data" .. '/mason/packages/powershell-editor-services'
        }
    },

    {'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        ft = { 'odin' },
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            signature = { enabled = true }
        },
    },

    -- LspConfig
    {'neovim/nvim-lspconfig',
        dependencies = {
            'saghen/blink.cmp',
        },
        ft = { 'odin' },
        config = function()
            local mason_path = vim.fn.stdpath("data") .. "/mason/bin"
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            vim.lsp.config('ols', {
                cmd = { mason_path .. "/ols" },
                capabilities = capabilities,
                root_markers = {"ols.json", ".git"},
                filetypes = { "odin" },
                init_options = {
                    enable_semantic_tokens = true,
                }
            })

            vim.lsp.enable('ols')
        end
    },

    -- Debugger
    {'puremourning/vimspector',
         ft = { 'cs' },
         init = function()
             vim.g.vimspector_enable_mappings = 'HUMAN'
         end
    },

    -- Snippets
    -- TODO: TRY IT WITH blink! (wasnt there before)
    -- {'SirVer/ultisnips'},   -- Engine
    -- {'honza/vim-snippets'}, -- Snippets
}
