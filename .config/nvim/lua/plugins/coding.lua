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
        "ts_ls",
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
      { '<F18>',  vim.lsp.buf.rename, desc = "Rename current element" },
      { '<S-F6>', vim.lsp.buf.rename, desc = "Rename current element" },
      { '<F2>',   vim.diagnostic.goto_next, desc = "Jump to next diagnostics" },
      { '<F14>',  vim.diagnostic.goto_prev, desc = "Jump to previous diagnostics" },
      { '<S-F2>', vim.diagnostic.goto_prev, desc = "Jump to previous diagnostics" }
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')

      lspconfig.lua_ls.setup({ settings = { Lua = {
          diagnostics = { globals = { "vim" }, },
      } }, capabilities = capabilities, })

      lspconfig.ts_ls.setup({ capabilities = capabilities, })

      lspconfig.gopls.setup({ settings = { gopls = {
        usePlaceholders = true,
        completeUnimported = true,
        analyses = {
          fieldalignment = true,
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
      } }, capabilities = capabilities, })

      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end,
        settings = {
          ["rust-analyzer"] = {
            completion = {
              callable = {
                snippets = "add_parentheses", -- Disables argument placeholders in function completions
              },
            },
            diagnostics = {
              enable = true,
              experimental = { enable = true }
            }
          }
        }
      })

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
        highlight = { enable = true, disable = { "yaml", "docker" } },
        indent = { enable = true, disable = { "yaml" } },
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
    opts = {
      delay = 20,
      providers = { 'lsp', 'treesitter' },
      filetypes_denylist = { 'dirvish', 'fugitive' },
      under_cursor = false,
      large_file_overrides = nil,
      min_count_to_highlight = 2
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },
  { -- completion plugin
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "windwp/nvim-autopairs"
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require("cmp")
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
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
