return{

    -- Theme
    {'folke/tokyonight.nvim', name = 'tokyonight' },

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

    {'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            local ts = require('nvim-treesitter')
            ts.setup({})
            ts.install({
                    "lua",
                    "sql",
                    "odin",
                    "c_sharp" })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "lua", "sql", "odin", "cs" },
                callback = function() vim.treesitter.start() end,
            })
        end
    },

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

    -- Powershell LSP
    {'TheLeoP/powershell.nvim',
        ft = { 'ps1' },
        opts = {
            bundle_path = vim.fn.stdpath "data"
                .. '/mason/packages/powershell-editor-services'
        }
    },

    -- compat layer for nvim.cmp -> blink.cmp
    {'saghen/blink.compat',
        -- use v2.* for blink.cmp v1.*
        version = '2.*',
        lazy = true,
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup
        opts = {},
    },

    -- Autocomplete, snippets, copilot suggestions
    {'saghen/blink.cmp',
        version = '1.*',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'fang2hou/blink-copilot'
        },
        opts = {
            keymap = {
                preset = "none",
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<C-l>"] = { "select_and_accept", "fallback" },
                ["<C-e>"] = { "hide", "fallback" },
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

    {
        "ThePrimeagen/99",
        config = function()
            local _99 = require("99")

            -- For logging that is to a file if you wish to trace through requests
            -- for reporting bugs, i would not rely on this, but instead the provided
            -- logging mechanisms within 99.  This is for more debugging purposes
            local cwd = vim.uv.cwd()
            local basename = vim.fs.basename(cwd)
            _99.setup({
                provider = _99.Providers.OpenCodeProvider,  -- default: OpenCodeProvider
                -- model is optional, overrides the provider's default
                model = "openai/gpt-5.5",

                logger = {
                    level = _99.DEBUG,
                    path = "/tmp/" .. basename .. ".99.debug",
                    print_on_error = true,
                },
                -- When setting this to something that is not inside the CWD tools
                -- such as claude code or opencode will have permission issues
                -- and generation will fail refer to tool documentation to resolve
                -- https://opencode.ai/docs/permissions/#external-directories
                -- https://code.claude.com/docs/en/permissions#read-and-edit
                tmp_dir = "./tmp",

                --- Completions: #rules and @files in the prompt buffer
                completion = {
                    -- I am going to disable these until i understand the
                    -- problem better.  Inside of cursor rules there is also
                    -- application rules, which means i need to apply these
                    -- differently
                    -- cursor_rules = "<custom path to cursor rules>"

                    --- A list of folders where you have your own SKILL.md
                    --- Expected format:
                    --- /path/to/dir/<skill_name>/SKILL.md
                    ---
                    --- Example:
                    --- Input Path:
                    --- "scratch/custom_rules/"
                    ---
                    --- Output Rules:
                    --- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
                    --- ... the other rules in that dir ...
                    ---
                    custom_rules = {
                      "scratch/custom_rules/",
                    },

                    --- Configure @file completion (all fields optional, sensible defaults)
                    files = {
                        -- enabled = true,
                        -- max_file_size = 102400,     -- bytes, skip files larger than this
                        -- max_files = 5000,            -- cap on total discovered files
                        -- exclude = { ".env", ".env.*", "node_modules", ".git", ... },
                    },
                    --- File Discovery:
                    --- - In git repos: Uses `git ls-files` which automatically respects .gitignore
                    --- - Non-git repos: Falls back to filesystem scanning with manual excludes
                    --- - Both methods apply the configured `exclude` list on top of gitignore

                    --- What autocomplete engine to use. Defaults to native (built-in) if not specified.
                    source = "blink", -- "native" (default), "cmp", or "blink"
                },

                --- WARNING: if you change cwd then this is likely broken
                --- ill likely fix this in a later change
                ---
                --- md_files is a list of files to look for and auto add based on the location
                --- of the originating request.  That means if you are at /foo/bar/baz.lua
                --- the system will automagically look for:
                --- /foo/bar/AGENT.md
                --- /foo/AGENT.md
                --- assuming that /foo is project root (based on cwd)
                md_files = {
                    "AGENT.md",
                },
            })

            -- take extra note that i have visual selection only in v mode
            -- technically whatever your last visual selection is, will be used
            -- so i have this set to visual mode so i dont screw up and use an
            -- old visual selection
            --
            -- likely ill add a mode check and assert on required visual mode
            -- so just prepare for it now
            vim.keymap.set("v", "<leader>pv", function()
                _99.visual()
            end)

            vim.keymap.set("n", "<leader>ps", function()
                _99.search()
            end)

            vim.keymap.set("n", "<leader>pb", function()
                require("99").vibe()
            end, { desc = "99 vibe" })

            --- if you have a request you dont want to make any changes, just cancel it
            vim.keymap.set("n", "<leader>px", function()
                _99.stop_all_requests()
            end)

            vim.keymap.set("n", "<leader>pw", function()
                require("99").Extensions.Worker.set_work()
            end)

            vim.keymap.set("n", "<leader>pW", function()
                require("99").Extensions.Worker.search()
            end)

            vim.keymap.set("n", "<leader>pm", function()
                require("99.extensions.telescope").select_model()
            end)

            vim.keymap.set("n", "<leader>pp", function()
                require("99.extensions.telescope").select_provider()
            end)
        end,
    },

}

