return {
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    'sainnhe/sonokai',
    lazy = false,
    config = function()
      vim.g.sonokai_enable_italic = true
      vim.g.sonokai_style = 'shusia'
      vim.g.sonokai_current_word = 'underline'
      vim.g.sonokai_transparent_background = vim.g.neovide and 0 or 1
      vim.cmd.colorscheme('sonokai')
    end
  },
  { -- hotkeys to surround content with brackets and quotes.
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {}
  },
  {
    'famiu/bufdelete.nvim',
    keys = {
      { "<leader>bd", "<Cmd>Bdelete<CR>", desc = "Close buffer nicely" },
    }
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = { enabled = false },
        highlight = {
          backdrop = false,
        }
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" }
    },
    config = function (_m,opts)
      require("flash").setup(opts)
      vim.cmd("hi FlashLabel ctermfg=235 ctermbg=179 guifg=#2d2a2e guibg=#e5c463 gui=bold")
      vim.cmd("hi! link FlashCurrent FlashMatch")
    end,
  },
  { -- Highlight color codes with their color
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {}
  },
  { -- a `gr` command
    "vim-scripts/ReplaceWithRegister",
    lazy = true,
    keys = { { "gr", mode = "v" } },
  },
  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>tc", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Change text's case" },
    },
    config = function (_, opts)
      require("textcase").setup(opts)
      require("telescope").load_extension("textcase")
    end,
    opts = {
      default_keymappings_enabled = false,
      enabled_methods = {
        "to_snake_case",
        "to_dash_case",
        "to_constant_case",
        "to_camel_case",
        "to_pascal_case",
      }
    }
  },
  { -- spell check with programmer context
    "psliwka/vim-dirtytalk",
    build = ":DirtytalkUpdate",
    config = function()
        vim.opt.spelllang = { "en", "programming" }
    end,
  },
  { -- automatically guess indentation style
    "tpope/vim-sleuth"
  },
  { -- kick the bad habits - stop repeating hjkl
    "takac/vim-hardtime",
    init = function()
      vim.g.hardtime_default_on = 1
      vim.g.hardtime_timeout = 100
      vim.g.hardtime_maxcount = 5
      vim.g.hardtime_allow_different_key = 1
    end,
  },
  { -- automatically close buffers when there are too many
    'axkirillov/hbac.nvim',
    config = true,
    opts = {
      threshold = 7
    }
  },
  {
    'windwp/nvim-autopairs',
    opts = {
      enable_check_bracket_line = true
    }
  }
}
