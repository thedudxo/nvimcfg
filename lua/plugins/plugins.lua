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
                    enabled = false
                },
                panel = { enabled = false },
                filetypes = {
                    markdown = true,
                  },
                })
        end,
    },

    {
        "NickvanDyke/opencode.nvim",
        config = function()
            ---@type opencode.Opts
            vim.g.opencode_opts = {}

            -- Required for `opts.events.reload`.
            vim.o.autoread = true

            require("keymaps.opencode")
        end,
    },

    -- Powershell LSP
    {'TheLeoP/powershell.nvim',
        ft = { 'ps1' },
        opts = {
            bundle_path = vim.fn.stdpath "data"
                .. '/mason/packages/powershell-editor-services'
        }
    },

    {'saghen/blink.cmp',
        version = '1.*',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'fang2hou/blink-copilot'
        },
        opts = {
            keymap = {
                preset = 'default',
                ['<C-space>'] = {
                    function(cmp)
                        cmp.show({ providers = { 
                            'copilot',
                            'snippets'
                            }
                        }) 
                    end 
                },
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            sources = {
                default = {
                    'lsp',
                    'buffer',
                    'snippets',
                    'path',
                    'copilot'
                },
                providers = {
                    lsp = {
                        fallback = {}
                    },
                    copilot = {
                        name = 'copilot',
                        module = 'blink-copilot',
                        -- score_offset = 100,
                        async = true
                    }
                }
            },
            signature = { enabled = true },
            completion = {
                documentation = {
                  auto_show = true,
                  auto_show_delay_ms = 200,
                }
            },
            fuzzy = {
                implementation = 'prefer_rust_with_warning',
                max_typos = function(keyword) 
                    return math.floor(#keyword / 4)
                end,
                frecency = {
                    enabled = true,
                    path = vim.fn.stdpath('state')
                        .. '/blink/cmp/frecency.dat',
                },
            },
        },
    },

    -- LspConfig
    {'neovim/nvim-lspconfig',
        dependencies = {
            'saghen/blink.cmp',
        },
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
            vim.lsp.config('csharp_ls', {
                capabilities = capabilities,
                filetypes = { "cs" }
            })

            vim.lsp.enable('ols')
            vim.lsp.enable('csharp_ls')
        end
    },

    -- -- Debugger
    -- {'puremourning/vimspector',
    --      ft = { 'cs' },
    --      init = function()
    --          vim.g.vimspector_enable_mappings = 'HUMAN'
    --      end
    -- },

}
