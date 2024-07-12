-- # Additional non-editor features like search, explorer
-- telescope
-- gitsigns
-- nvim-tree
-- bufferline

return {
  { -- UI for searching all kinds of things
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cmd = "Telescope",
    keys = {
      {"<leader>ff", "<cmd>Telescope find_files<cr>" },
      {"<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Search in project" },
      {"<leader>fG", "<cmd>Telescope resume<cr>" },
      {"<leader>fe", "<cmd>Telescope oldfiles<cr>" },
      {"<leader>fj", "<cmd>Telescope jumplist<cr>" },
      {"<leader>fm", "<cmd>Telescope marks<cr>" },
      {"<leader>fu", "<cmd>Telescope lsp_references<cr>" },
      {"<leader>fp", "<cmd>Telescope planets<cr>" },
      {"<leader>fb", "<cmd>Telescope buffers<cr>" },
      {"<leader>fh", "<cmd>Telescope help_tags<cr>" },
      {"<leader>fd", "<cmd>Telescope diagnostics<cr>" },
    },
    opts = {
      pickers = {
        oldfiles = {
          cwd_only = true,
        }
      }
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    keys = {
      {"<leader>gb", "<cmd>lua require('gitsigns').blame_line{full=true}<cr>", desc = "How this line got committed" },
      {"<leader>gB", "<cmd>lua require('gitsigns').toggle_current_line_blame()<cr>", desc = "Auto-blame current lines" },
    },
    opts = {}
  },
  { -- file explorer
    "nvim-tree/nvim-tree.lua",
    lazy = true,
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    keys = {
      {"<M-1>", "<cmd>NvimTreeFocus<cr>", desc = "Open file explorer" },
      {"<leader>ft", "<cmd>NvimTreeFindFile<cr>", desc = "Show current file in explorer" },
    },
    opts = {
      hijack_cursor = true,
      -- open_on_tab = true,
      view = {
        adaptive_size = false,
        centralize_selection = false,
        width = 50,
      },
      renderer = {
        highlight_diagnostics = "none",
        icons = {
          git_placement = "after"
        }
      },
      actions = {
        open_file = {
          resize_window = true
        }
      }
    }
  },
  { -- IDE tabs
    "akinsho/bufferline.nvim",
    lazy = false,
    keys = { -- more keys in `:h bufferline-mappings`
      { "<M-left>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<M-right>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Pin Buffer" },
      { "<leader>bd", "<Cmd>BufferLinePickClose<CR>", desc = "Choose buffer to close" },
    },
    opts = function()
      return {
        options = {
          offsets = {{
            filetype = "NvimTree",
            separator = true,
            text = "File Explorer",
            highlight = "BufferLineOffsetSeparator"
          }},
          indicator = {
            style = "none"
          },
          always_show_bufferline = false,
          auto_toggle_bufferline = true,
          show_buffer_icons = false,
          max_name_length = 35,
          max_prefix_length = 15,
          truncate_names = true,
          tab_size = 0,
          diagnostics = "nvim_lsp",
          diagnostics_update_on_event = true,
          separator_style = vim.g.neovide and "slant" or { '│', '│' },
          style_preset = {
            require('bufferline').style_preset.no_italic,
          }
        },
        highlights = {
          error = {
            undercurl = true
          },
        },
      }
    end,
  },
}
