-- # Somethimes treesitter with a languase server is not enough.
--
return {
  {
    "nathangrigg/vim-beancount",
    dependencies = {
      "neovim/nvim-lspconfig"
    },
    init = function ()
      -- personal command that formats beancount ledger to the end of the file
      vim.api.nvim_create_user_command('FormatBeancount', function(args)
        -- format money values
        vim.cmd("silent! " .. args.line1 .. "," .. args.line2 .. [[s:\v( |-)(\d+\.?\d{0,2}) ([A-Z]{3}):\=printf('%s%.2f %s',submatch(1),str2float(submatch(2)),submatch(3)):g]])
        -- align numbers in one column
        vim.cmd(args.line1 .. "," .. args.line2 .. [[AlignCommodity]])
        -- delete empty lines
        vim.cmd("silent! " .. args.line1 .. "," .. args.line2 .. [[g:^$:d]])
      end, { range = true, nargs = 0 })
    end
  },
  "mechatroner/rainbow_csv"
}


