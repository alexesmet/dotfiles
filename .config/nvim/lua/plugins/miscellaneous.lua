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
  }
}
