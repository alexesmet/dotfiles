-- # Additional non-editor features like search, explorer
-- telescope
-- gitsigns
-- nvim-tree
-- toggleterm
-- bufferline

local utils = require('util')

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
    enabled = true,
    lazy = true,
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    keys = {
      {"<M-1>", "<cmd>NvimTreeFocus<cr>", desc = "Open file explorer" },
      {"<leader>ft", "<cmd>NvimTreeFindFile<cr>", desc = "Show current file in explorer" },
    },
    opts = {
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        -- default mappings
        api.config.mappings.default_on_attach(bufnr)
        -- custom mappings
        vim.keymap.set("n", "<Right>", function()
          local node = api.tree.get_node_under_cursor()
          if node.nodes ~= nil and not node.open then
            api.node.open.edit()
          else
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Down>', true, true, true))
          end
        end, opts("Smart open directory"))
        vim.keymap.set("n", "<Left>", function()
          local node = api.tree.get_node_under_cursor()
          if node.nodes ~= nil and node.open then
            api.node.open.edit()
          else
            api.node.navigate.parent()
          end
        end,         opts("Smart close directory"))
      end,
      hijack_cursor = true,
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
  { -- persist and toggle multiple terminals during an editing session
    {
      'akinsho/toggleterm.nvim',
      lazy = true,
      keys = { "<M-\\>" },
      cmd = "ToggleTerm",
      version = "*",
      opts = {
        open_mapping = [[<M-\>]],
        direction = "float",
        close_on_exit = true,


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
    },
    opts = function()
      return {
        options = {
          -- fix closing active buffer with opened file explorer
          close_command = function(n) utils.bufremove(n) end,
          right_mouse_command = function(n) utils.bufremove(n) end,
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
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
}
