
" === BASIC VIM SETTING ===================================================


" FILE EXPLORER
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 25

" Fixes common backspace problems
" set backspace=indent,eol,start

" Status bar
" set laststatus=2

" Display options
" set showmode
" set showcmd

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
" set matchpairs+=<:>

" Display different types of white spaces.





" Store info from no more than 100 files at a time, 9999 lines of text,
" 100kb of data. Useful for copying large amounts of data between files.
" set viminfo='100,<9999,s100
"
" set completeopt=longest,menuone
" set completeopt=noinsert,menuone,noselect
" set completeopt=menu,menuone,noselect

" Disable that bar on the left
" set signcolumn=no

" === RUSSIAN LANGUAGE SUPPORT ============================================
" set keymap=russian-jcukenwin
" set iminsert=0
" set imsearch=0
" highlight lCursor guifg=NONE guibg=Cyan



" === KEY REMAPS (VANILLA)=================================================
" Insert a closing bracket if enter was pressed
" map j gj
" map k gk
" map <Up> g<Up>
" map <Down> g<Down>
" imap <C-p> <Nop>
" nmap <C-p> <Nop>
" map <C-p> <Nop>
" nnoremap <M-1> <cmd>NvimTreeFocus<cr>

" nnoremap <leader>]  <cmd>b#<cr>




" === PLUGINS =============================================================
" "call plug#begin('~/.config/nvim/plugged')
" "
"library plugins
" "
" core plugins (syntax, lsp, cmp, snip)
" "Plug 'neovim/nvim-lspconfig'
" "Plug 'hrsh7th/cmp-nvim-lsp'
" "Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
" "Plug 'hrsh7th/cmp-nvim-lua'
" "Plug 'hrsh7th/cmp-buffer'
" "Plug 'hrsh7th/cmp-path'
" "Plug 'hrsh7th/cmp-cmdline'
" "Plug 'hrsh7th/nvim-cmp'
" "Plug 'hrsh7th/vim-vsnip'
" "Plug 'hrsh7th/vim-vsnip-integ'
" "Plug 'hrsh7th/cmp-vsnip'
" "
" "
"  tools and features
" "Plug ''
" "Plug ''
" "Plug 'akinsho/toggleterm.nvim', {'tag' : '*'} -- will be replaced
" "Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
" "Plug 'windwp/nvim-autopairs' -- looks like I don't need it
" "Plug ''
" "Plug 'FooSoft/vim-argwrap'
" "Plug 'johmsalas/text-case.nvim'
" "
" "
" viyess
" "Plug 'kshenoy/vim-signature'
" "
" lang specific
" "Plug 'simrat39/rust-tools.nvim'
" "Plug 'nathangrigg/vim-beancount'
" "Plug 'ron-rs/ron.vim'
" "Plug 'mechatroner/rainbow_csv'
" "Plug 'freitass/todo.txt-vim'
" "
" "call plug#end()


" The configuration options should be placed before `colorscheme sonokai`.
" "let g:sonokai_style = 'shusia'
" "let g:sonokai_current_word = 'underline'
" "
" "if !exists('g:neovide')
" "    let g:sonokai_transparent_background = 1
"        highlight Normal     ctermbg=NONE guibg=NONE
"        highlight LineNr     ctermbg=NONE guibg=NONE
"        highlight SignColumn ctermbg=NONE guibg=NONE
" "en

" colorscheme sonokai



" === LSP =================================================================
lua << EOF

-- For dark theme (neovim's default)
-- vim.o.background = 'dark'
--
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- local cmp = require'cmp'
-- cmp.event:on(
--   'confirm_done',
--   cmp_autopairs.on_confirm_done()
-- )
-- cmp.setup({
--   snippet = {
--     -- REQUIRED - you must specify a snippet engine
--     expand = function(args)
--       vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--       -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--       -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
--       -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--     end,
--   },
--   window = {
--     -- completion = cmp.config.window.bordered(),
--     -- documentation = cmp.config.window.bordered(),
--   },
--   mapping = cmp.mapping.preset.insert({
--     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.abort(),
--     ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--   }),
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'vsnip' },
--     -- { name = 'buffer' },
--     { name = "path" },
--     { name = 'nvim_lsp_signature_help' }
--   })
-- })
--
-- -- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--   }, {
--     { name = 'buffer' },
--   })
-- })
--
-- -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline({ '/', '?' }, {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' }
--   }
-- })
--
-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })

-- require("nvim-autopairs").setup {}
-- 
--
-- -- Set up lspconfig.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
--
--
-- vim.keymap.set('n', '<S-F2>', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', '<F2>', vim.diagnostic.goto_next, opts)
--
-- local on_attach = function(client, bufnr)
--     -- Enable completion triggered by <c-x><c-o>
--
--     -- Mappings.
--     local bufopts = { noremap=true, silent=true, buffer=bufnr }
--
--     -- See `:help vim.lsp.*` for documentation on any of the below functions
--     vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
--     vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
--     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
--     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--     vim.keymap.set('n', 'gu', vim.lsp.buf.references, bufopts)
--     vim.keymap.set('n', '<a-cr>', vim.lsp.buf.code_action, bufopts)
--     vim.keymap.set('n', '<S-F6>', vim.lsp.buf.rename, bufopts)
--     vim.keymap.set('n', '<C-p>', vim.lsp.buf.signature_help, bufopts)
--     vim.keymap.set('i', '<A-p>', vim.lsp.buf.signature_help, bufopts)
-- end
--
-- local lsp_flags = {
--   -- This is the default in Nvim 0.7+
--   debounce_text_changes = 150
-- }
--
-- require'lspconfig'.beancount.setup{
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = lsp_flags,
--     -- cmd = { "beancount-language-server", "--stdio" },
--     init_options = {
--         journal_file = "/home/alexesmet/Documents/Accounting/root.beancount"
--     }
-- }
-- require('lspconfig')['pyright'].setup{
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = lsp_flags,
-- }
-- require('lspconfig')['tsserver'].setup{
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = lsp_flags,
--     filetypes = {"javascript", "javascriptreact", "javascript.jsx",
--     "typescript", "typescriptreact", "typescript.tsx"},
--     cmd = { "typescript-language-server", "--stdio" }
-- }
--
-- require('telescope').setup{
-- }
--
-- local rt = require("rust-tools")
-- rt.setup({
--   server = {
--     settings = {
--       ["rust-analyzer"] = {
--         diagnostics = { enable = true, experimental = { enable = false } },
--         checkOnSave = { enable = true }
--       }
--     },
--     capabilities = capabilities,
--     flags = lsp_flags,
--     on_attach = function(_, bufnr)
--       on_attach()
--       vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
--       vim.keymap.set("n", "<a-cr>", rt.code_action_group.code_action_group, { buffer = bufnr })
--     end,
--   },
--   tools = { -- rust-tools options
--     executor = require("rust-tools.executors").termopen,
--     inlay_hints = { auto = true, }
--   }
-- })
-- require'toggle_lsp_diagnostics'.init()
-- require('illuminate').configure()

-- require('textcase').setup {
--   default_keymappings_enabled = true,
--   enabled_methods = {
-- --  "to_upper_case",
-- --  "to_lower_case",
--     "to_snake_case",
--     "to_dash_case",
-- --  "to_title_dash_case",
--     "to_constant_case",
-- --  "to_dot_case",
-- --  "to_phrase_case",
--     "to_camel_case",
--     "to_pascal_case",
-- --  "to_title_case",
-- --  "to_path_case",
-- --  "to_upper_phrase_case",
-- --  "to_lower_phrase_case",
--   },
-- }


EOF

