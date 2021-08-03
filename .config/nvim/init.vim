" === BASIC VIM SETTING ===================================================
set showcmd     " Show (partial) command in status line.
set smartcase
set incsearch   " Incremental search
set autowrite   " Automatically save before commands like :next and :make
set hidden      " Hide buffers when they are abandoned
set mouse=a     " Enable mouse usage (all modes)

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
" set hlsearch

" Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

set completeopt=longest,menuone

" Disable that bar on the left
set signcolumn=no

" === RUSSIAN LANGUAGE SUPPORT ============================================
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan


" === KEY REMAPS ==========================================================
" Insert a closing bracket if enter was pressed
inoremap {<CR>  {<CR>}<Esc>O
map j gj
map k gk
map <Up> g<Up>
map <Down> g<Down>



" === NEOVIDE UI SETTINGS =================================================
hi Pmenu guibg=grey10
hi! link NonText Ignore


" === PLUGINS =============================================================
call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'rust-lang/rust.vim',          { 'for': 'rust' }

call plug#end()

" === LSP =================================================================
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<S-F2>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "rust_analyzer" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

EOF

" === COMPLETION ==========================================================

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()
" Disable auto-popup
let g:completion_enable_auto_popup = 0

"map <c-p> to manually trigger completion
imap <silent> <C-Space> <Plug>(completion_trigger)

