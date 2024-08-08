-- # LSP and Highlighting and completion.
-- mason
-- mason-lspconfig
-- nvim-lspconfig
-- nvim-treesitter
-- vim-illuminate
-- nvim-cmp

return {
  {
    "williamboman/mason.nvim",
    opts = {}
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "tsserver"
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    keys = {
      { 'K', vim.lsp.buf.hover, desc = "Inpect current element" },
      { 'gD', vim.lsp.buf.declaration, desc = "Go to declaration" },
      { 'gd', vim.lsp.buf.definition, desc = "Go to definition" },
      { 'gi', vim.lsp.buf.implementation, desc = "Go to implementation" },
      { 'gu', vim.lsp.buf.references, desc = "Show usages of the current element" },
      { '<a-cr>', vim.lsp.buf.code_action, desc = "Show available quick actions" },
      {  '<F18>',  vim.lsp.buf.rename, desc = "Rename current element" },
      {  '<S-F6>', vim.lsp.buf.rename, desc = "Rename current element" },
      { '<F2>', vim.diagnostic.goto_next, desc = "Jump to next diagnostics" },
      {  '<F14>',  vim.diagnostic.goto_prev, desc = "Jump to previous diagnostics" },
      {  '<S-F2>', vim.diagnostic.goto_prev, desc = "Jump to previous diagnostics" }
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')

      lspconfig.lua_ls.setup({ settings = { Lua = {
          diagnostics = { globals = { "vim" }, },
      } }, capabilities = capabilities, })

      lspconfig.tsserver.setup({ capabilities = capabilities, })

      lspconfig.rust_analyzer.setup({ capabilities = capabilities, })

      lspconfig.beancount.setup({ init_options = {
            journal_file = "/home/alexesmet/Documents/Accounting/root.beancount"
      }, capabilities = capabilities, })

      vim.diagnostic.config( { update_in_insert = true, signs = false, virtual_text = false } )

      -- not sure why i needed that in the first place
      -- local bufopts = { noremap=true, silent=true } -- buffer=bufnr
      -- vim.keymap.set('n', '<C-p>', vim.lsp.buf.signature_help, bufopts)
      -- vim.keymap.set('i', '<A-p>', vim.lsp.buf.signature_help, bufopts)

    end,
  },
  { -- Faster and more accurate syntax highlighting.
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nushell/tree-sitter-nu" },
    },
    lazy = false,
    version = false, -- last release is way too old and doesn't work on Windows
    -- event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    -- lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    --init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      -- require("lazy.core.loader").add_to_rtp(plugin)
      -- require("nvim-treesitter.query_predicates")
    --end,
    --cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = { enable = true, disable = { "yaml" } },
        indent = { enable = true },
        auto_install = true,
        ensure_installed = {
          "bash",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "python",
          "rust",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
      })
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      require('illuminate').configure({
        -- providers: 
        providers = { -- provider used to get references in the buffer, ordered by priority
            'lsp',
            'treesitter',
            -- 'regex',
        },
        delay = 10, -- delay: delay in milliseconds
        -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
        filetypes_denylist = {
            'dirvish',
            'fugitive',
        },
        under_cursor = false, --  whether or not to illuminate under the cursor
        large_file_overrides = nil, -- If nil, vim-illuminate will be disabled for large files.
        min_count_to_highlight = 2 -- minimum number of matches required to perform highlighting
        -- MORE: vim modes, regex, filetypes can also be configured
      })
    end,
  },
  { -- completion plugin
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-buffer",
    -- "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local auto_select = true
      return {
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        -- Not all LSP servers add brackets when completing a function.
        auto_brackets = {}, -- configure any filetype to auto add brackets
        completion = {
          completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
        },
        preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
          -- Accept currently selected item. Set  to `false` to only confirm explicitly selected items.
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
          -- ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
          -- ["<C-CR>"] = function(fallback)
          --   cmp.abort()
          --   fallback()
          -- end,
          ['<C-Space>'] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
        }, {
          -- { name = "buffer" },
          -- MY VARIANT WAS
          -- { name = 'nvim_lsp' },
          -- { name = 'vsnip' },
          -- -- { name = 'buffer' },
          -- { name = "path" },
          -- { name = 'nvim_lsp_signature_help' }
        }),
        experimental = {
          ghost_text = false -- or { hl_group = "CmpGhostText", },
        },
      }
    end,
  },
}
