vim.g.python3_host_prog = 'C:\\Program Files\\Python313\\python.exe'

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

--  spaces
vim.opt.tabstop = 4       -- Tab size
vim.opt.shiftwidth = 4    -- Autoindent spaces
vim.opt.expandtab = true -- Convert tabs to spaces

-- Tabs
-- vim.opt.tabstop = 2       -- Tab size
-- vim.opt.shiftwidth = 0    -- Autoindent spaces
-- vim.opt.expandtab = false -- Convert tabs to spaces

-- Clipboard (sync with system clipboard)
vim.opt.clipboard = 'unnamedplus'

-- Show whitespace
vim.opt.list = true
vim.opt.listchars = { trail = '⊠', leadtab = '  ', tab = '▸ '}
-- vim.opt.listchars = 'trail:□,tab:→ ,leadtab:  '
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

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
      "git", "clone",
      "--filter=blob:none",
      "--branch=stable",
      lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

plugins = {
    -- Theme
    {"folke/tokyonight.nvim",
        priority = 1000,
        opts = {
            on_colors = function(c)
                c.fg = "#bbbbbb"
                c.blue = "#9092d1"
            end,

            on_highlights = function(hl, c)
                hl.Normal = { fg = c.fg, bg = c.bg }
                hl.Constant = { fg = c.fg, bg = c.bg }
                hl["@variable"] = { fg = c.fg, bg = c.bg }
                hl["@variable.member"] = { fg = c.fg, bg = c.bg }
                hl["@variable.parameter"] = { fg = c.fg, bg = c.bg }
                hl.Function = { fg = "#cccccc", bg = c.bg}
                hl["@function"] = { fg = "#cccccc", bg = c.bg}

                hl["@operator"] = { fg = "#9fc6c9", bg = c.bg}
                hl.Special = { fg = "#9fc6c9", bg = c.bg}
                hl.PreProc = { fg = "#9fc6c9", bg = c.bg}

                hl.String = { fg = "#64916f", bg = c.bg}

                hl["@keyword"] = { fg = c.blue, bg = c.bg }
                hl["@type.builtin"] = { fg = c.blue, bg = c.bg }
                hl.Type = { fg = c.blue, bg = c.bg }

                hl["@punctuation.bracket"] = { fg = "#cccccc", bg = c.bg }
                hl["@punctuation.delimiter"] = { fg = c.fg, bg = c.bg }

                hl["@keyword.return"] = { fg = c.red1, bg = c.bg_dark1,
                    underline = true, bold = true}
                hl["@keyword.conditional"] = { fg = c.orange}
                hl.Statement = { fg = c.orange, bg = c.bg }
            end,
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight-moon")
        end,
    },

    -- External tooling manager, can install things like LSP, Linter, etc
    {"williamboman/mason.nvim"},

    -- -- Indentation guidelines
    -- {"lukas-reineke/indent-blankline.nvim",
    --     main = "ibl",
    --     config = function()
    --         require("ibl").setup({
    --             indent = {char = '⁚'}
    --         })
    --     end
    -- },

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
            local builtin = require('telescope.builtin')

            vim.keymap.set('n', '<leader>fb', builtin.buffers, {
                desc = 'Telescope buffers' })

            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {
                desc = 'Telescope help tags' })

            vim.keymap.set('n', '<leader>fs', builtin.git_status, {
                desc = 'Telescope git status' })

            vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {
                desc = 'Telescope diagnostics' })

            vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find,
                {desc = 'Telescope fuzzy search in buffer' })
            require("telescope").setup {
                defaults = {
                    path_display = {"filename_first"}
                }
            }
      end
    },

    {'dmtrKovalenko/fff.nvim',
        build = function()
            -- downloads a prebuilt binary or falls back to cargo build
            require("fff.download").download_or_build_binary()
        end,
        opts = {
            debug = {
                enabled = true,
                show_scores = true,
            },
        },
        lazy = false, -- the plugin lazy-initialises itself
        keys = {
            { "ff", function() require('fff').find_files() end,
                desc = 'FFFind files' },
            { "fg", function() require('fff').live_grep() end,
                desc = 'LiFFFe grep' },
            { "fz",
                function() require('fff').live_grep(
                    { grep = { modes = { 'fuzzy', 'plain' } } }) end,
                desc = 'Live fffuzy grep',
            },
            { "fw",
                function() require('fff').live_grep_under_cursor() end,
                mode = { 'n', 'x' },
                desc = 'Search current word / selection',
            },
        },
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
                settings = {
                    advanced = {
                        listCount = 10, -- #for panel
                        inlineSuggestCount = 3, -- #for getCompletions
                        temperature = 0.5,
                        top_p = 0.95,
                    }
                }
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
                        fallback = {},
                        transform_items = (function()
                            local exclusions = {
                                ['else'] = true,
                                ['for'] = true,
                                ['foreach'] = true,
                                ['forr'] = true,
                                ['if'] = true,
                                ['switch'] = true,
                                ['try'] = true,
                                ['while'] = true,
                            }

                            -- AUDIT-BEGIN
                            -- Track only local snippet prefixes with confirmed
                            -- exact csharp_ls conflicts. Assess additions,
                            -- removals, and renames for conflicts, and remove
                            -- obsolete exclusions.
                            -- AUDIT-END

                            return function(ctx, items)
                                -- Prefer local snippets to LSP duplicates.
                                return vim.tbl_filter(function(item)
                                    return not exclusions[item.label]
                                end, items)
                            end
                        end)()
                    },
                    copilot = {
                        name = 'copilot',
                        module = 'blink-copilot',
                        score_offset = 0,
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

    {"ThePrimeagen/99",
        config = function()
            local _99 = require("99")
            local cwd = vim.uv.cwd()
            local basename = vim.fs.basename(cwd)
            _99.setup({
                provider = _99.Providers.OpenCodeProvider,
                -- model is optional, overrides the provider's default
                -- model = "openai/gpt-5.5",
                logger = {
                    level = _99.DEBUG,
                    path = "/tmp/" .. basename .. ".99.debug",
                    print_on_error = true,
                },
                -- When setting this to something that is not inside the CWD
                -- tools such as claude code or opencode will have permission
                -- issues and generation will fail refer to tool documentation
                -- to resolve
                -- https://opencode.ai/docs/permissions/#external-directories
                -- https://code.claude.com/docs/en/permissions#read-and-edit
                tmp_dir = "./tmp",

                --- Completions: #rules and @files in the prompt buffer
                completion = {
                    custom_rules = {
                      "scratch/custom_rules/",
                    },
                    --- Configure @file completion (all fields optional,
                    --- sensible defaults)
                    files = {
                        -- enabled = true,
                        -- max_file_size = 102400,     -- bytes, skip files larger than this
                        -- max_files = 5000,            -- cap on total discovered files
                        -- exclude = { ".env", ".env.*", "node_modules", ".git", ... },
                    },
                    source = "blink",
                },

                --- WARNING: if you change cwd then this is likely broken
                md_files = {
                    "AGENT.md",
                },
            })

            vim.keymap.set("v", "<leader>pp", function()
                _99.visual()
            end)

            vim.keymap.set("v", "<leader>pi", function()
              _99.visual({additional_prompt = "Implement this function"})
            end)

            vim.keymap.set("n", "<leader>ps", function()
                _99.search()
            end)

            vim.keymap.set("n", "<leader>pb", function()
                require("99").vibe()
            end)

            --- if you have a request you dont want to make any changes,
            --- just cancel it
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

-- Setup lazy.nvim
require("lazy").setup({
  spec = plugins,
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require("mason").setup()
