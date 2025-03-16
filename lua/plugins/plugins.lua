return{
    -- External tooling manager, can install things like LSP, Linter, etc
    {"williamboman/mason.nvim"},

    -- C# LSP client
    {"OmniSharp/omnisharp-vim"},

    -- Theme
    {'folke/tokyonight.nvim', name = 'tokyonight' },

    -- Telescope (file navigation)
    {'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' }
    }
}
