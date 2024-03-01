" === BASIC VIM SETTING ===================================================
set showcmd     " Show (partial) command in status line.
set smartcase
set incsearch   " Incremental search
set autowrite   " Automatically save before commands like :next and :make
set hidden      " Hide buffers when they are abandoned
set mouse=a     " Enable mouse usage (all modes)

set nofixendofline
set termguicolors
set ignorecase
set smartcase
set splitright
set splitbelow
set undofile


" Helps force plug-ins to load correctly when it is turned back on below.
filetype off

" Turn on syntax highlighting.
syntax on

" For plug-ins to load correctly.
filetype plugin indent on

" Turn off modelines
set modelines=0

set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

" FILE EXPLORER
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Display 5 lines above/below the cursor when scrolling with a mouse.
set scrolloff=5

" Fixes common backspace problems
set backspace=indent,eol,start

" Speed up scrolling in Vim
set ttyfast

" Status bar
set laststatus=2

" Display options
set showmode
set showcmd

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
set list
set listchars+=tab:›\ ,extends:#,trail:·

" Show line numbers
set number

" Set status line display
set statusline=%F%m%r%h%w\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]
set statusline=[B%n]\ %<%F%M\ %=\ [.%Y]\ [%l:%v/%L]

" Encoding
set encoding=utf-8

" Use ctrl+C / ctrl+V clipboard
set clipboard=unnamedplus

" Highlight matching search patterns
set nohlsearch

" Store info from no more than 100 files at a time, 9999 lines of text, 
" 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

set completeopt=longest,menuone
set completeopt=noinsert,menuone,noselect
set completeopt=menu,menuone,noselect

" Disable that bar on the left
" set signcolumn=no

" === RUSSIAN LANGUAGE SUPPORT ============================================
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan


" === SUPPORT MY OWN TIME FORMAT FILES ====================================
au BufRead,BufNewFile *.time set filetype=time

" === KEY REMAPS (VANILLA)=================================================
" Insert a closing bracket if enter was pressed
map j gj
map k gk
map <Up> g<Up>
map <Down> g<Down>
autocmd FileType beancount inoremap . .<C-\><C-O>:AlignCommodity<CR>
autocmd FileType beancount nnoremap <buffer> <leader>= :AlignCommodity<CR>
autocmd FileType beancount vnoremap <buffer> <leader>= :AlignCommodity<CR>
nnoremap <M-1> <cmd>NvimTreeFocus<cr>
nnoremap <leader>ft <cmd>NvimTreeFindFile<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fG <cmd>Telescope resume<cr>
nnoremap <leader>fe <cmd>Telescope oldfiles<cr>
nnoremap <leader>fj <cmd>Telescope jumplist<cr>
nnoremap <leader>fm <cmd>Telescope marks<cr>
nnoremap <leader>fu <cmd>Telescope lsp_references<cr>
nnoremap <leader>fp <cmd>Telescope planets<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>dt <Plug>(toggle-lsp-diag)


command! -bar FormatBeancount ,$s:\v( |-)(\d+\.?\d{0,2}) ([A-Z]{3}):\=printf('%s%.2f %s',submatch(1),str2float(submatch(2)),submatch(3)):g|g:^$:d|,$AlignCommodity

" === PLUGINS =============================================================
call plug#begin('~/.config/nvim/plugged')

" library plugins
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'

" core plugins (syntax, lsp, cmp, snip)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp' " thats all for completion
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" tools and features
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-telescope/telescope.nvim'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'kylechui/nvim-surround'
Plug 'vim-scripts/ReplaceWithRegister'

" visuals
Plug 'norcalli/nvim-colorizer.lua'
Plug 'RRethy/vim-illuminate' " <a-n> and <a-p> as keymaps to move between references
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'
Plug 'jacoborus/tender.vim'
Plug 'cormacrelf/vim-colors-github'

" lang specific
Plug 'simrat39/rust-tools.nvim'
Plug 'nathangrigg/vim-beancount'
Plug 'ron-rs/ron.vim'
Plug 'mechatroner/rainbow_csv'

call plug#end()

colorscheme tender

if !exists('g:neovide')
    highlight Normal     ctermbg=NONE guibg=NONE
    highlight LineNr     ctermbg=NONE guibg=NONE
    highlight SignColumn ctermbg=NONE guibg=NONE
en


" === LSP =================================================================
lua << EOF

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require'cmp'
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    -- { name = 'buffer' },
    { name = "path" },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

require("nvim-surround").setup()
require("nvim-autopairs").setup {}

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()


vim.keymap.set('n', '<S-F2>', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<F2>', vim.diagnostic.goto_next, opts)

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>

    -- Mappings.
    local bufopts = { noremap=true, silent=true, buffer=bufnr }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gu', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<a-cr>', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<S-F6>', vim.lsp.buf.rename, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150
}

require'lspconfig'.beancount.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
    cmd = { "beancount-language-server", "--stdio" },
    init_options = { 
        journal_file = "/home/alexesmet/Documents/Accounting/root.beancount"
    }
}
require('lspconfig')['pyright'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
    filetypes = {"javascript", "javascriptreact", "javascript.jsx",
    "typescript", "typescriptreact", "typescript.tsx"},
    cmd = { "typescript-language-server", "--stdio" }
}

local rt = require("rust-tools")
rt.setup({
  server = {
    settings = {
      ["rust-analyzer"] = {
        diagnostics = { enable = true, experimental = { enable = false } },
        checkOnSave = { enable = true }
      }
    },
    capabilities = capabilities,
    flags = lsp_flags,
    on_attach = function(_, bufnr)
      on_attach()
      vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
      vim.keymap.set("n", "<a-cr>", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
  tools = { -- rust-tools options
    executor = require("rust-tools.executors").termopen,
    inlay_hints = { auto = true, }
  }
})
require'toggle_lsp_diagnostics'.init()
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {"rust", "vim", "lua", "javascript", "python"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {  },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
require('illuminate').configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
        'lsp',
        'treesitter',
        -- 'regex',
    },
    -- delay: delay in milliseconds
    delay = 10,
    -- filetype_overrides: filetype specific overrides.
    -- The keys are strings to represent the filetype while the values are tables that
    -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
    filetype_overrides = {},
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
        'dirvish',
        'fugitive',
    },
    -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
    filetypes_allowlist = {},
    -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
    -- See `:help mode()` for possible values
    modes_denylist = {},
    -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
    -- See `:help mode()` for possible values
    modes_allowlist = {},
    -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_denylist = {},
    -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_allowlist = {},
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = false,
    -- large_file_cutoff: number of lines at which to use large_file_config
    -- The `under_cursor` option is disabled when this cutoff is hit
    large_file_cutoff = nil,
    -- large_file_config: config to use for large files (based on large_file_cutoff).
    -- Supports the same keys passed to .configure
    -- If nil, vim-illuminate will be disabled for large files.
    large_file_overrides = nil,
    -- min_count_to_highlight: minimum number of matches required to perform highlighting
    min_count_to_highlight = 1,
})


-- empty setup using defaults
require("nvim-tree").setup({
    hijack_cursor = true,
    open_on_tab = true,
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
            resize_window = trueniceties
        }
    }
})
require("toggleterm").setup{
  open_mapping = [[<M-\>]],
}
vim.opt.list = true
require'colorizer'.setup()

vim.diagnostic.config({ signs = false })


EOF

