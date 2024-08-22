-- local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
-- vim.cmd.source(vimrc)

-- TODO:
-- Nvim signature / marks.nvim
-- Disable completion in comments
-- Allow inserting time: nnoremap <leader>dt "=strftime("%F")<CR>p
-- LSP: Show parameters of a currently used function


-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Editor options - Making good default configs
vim.opt.showcmd = true -- Show (partial) command in the last line of the screen.
vim.opt.encoding = "UTF-8" -- Sets the character encoding used inside Vim.
vim.opt.clipboard = "unnamedplus" -- Use global clipboard
vim.opt.termguicolors = true -- Use extended color palette
vim.opt.mouse = "a" -- Enable the use of the mouse.
vim.opt.ttyfast = true
vim.opt.splitright = true
vim.opt.splitbelow = true -- Split to correct directions
vim.opt.hidden = true -- When on a buffer becomes hidden when it is |abandon|ed
vim.opt.fixendofline = false
vim.opt.undofile = true -- preserve undo history between sessions
vim.opt.modelines = 0

-- coding style and behaviour
vim.opt.expandtab = true -- Use the spaces to insert a <Tab>.
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent.
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for.
vim.opt.softtabstop = 4 -- ???
vim.opt.shiftround = true -- round < and > commands
vim.opt.spelllang = { "en" }
vim.opt.spelloptions:append("noplainbuffer")

-- Configure search in file
vim.opt.hlsearch = false  -- disable highlighting during search
vim.opt.ignorecase = true
vim.opt.smartcase = true  -- turn off ignore-case when typing uppercase
vim.opt.incsearch = true

-- Configure visuals
vim.opt.syntax = "on" -- When this option is set, the syntax with this name is loaded.
vim.opt.signcolumn = "auto" -- Left gutter with symbols
vim.opt.number = true -- Line numbers
vim.opt.scrolloff = 5 -- min distance between cursor and edge of the screen
vim.opt.statusline = "[B%n] %<%F%M %= [.%Y] [%l:%v/%L]"
vim.opt.list = true -- display whitespace characters
vim.opt.listchars = vim.opt.listchars + ",tab:› ,extends:#,trail:·" -- chars to show
vim.opt.display:append { 'lastline' } -- don't display @ on too long lines

if vim.g.neovide then
    vim.g.neovide_cursor_vfx_mode = "wireframe"
    vim.g.neovide_scroll_animation_length = 0.1
    vim.g.neovide_hide_mouse_when_typing = true
end

-- Personal hacks
vim.opt.virtualedit:append { 'block' } -- allow the cursor to go anywhere in visual block mode.

vim.opt.ttimeoutlen = 0 -- The time in milliseconds that is waited for a key code or mapped key sequence to complete.
-- vim.opt.wildmenu = true -- When 'wildmenu' is on, command-line completion operates in an enhanced mode.
-- vim.opt.inccommand = "split" -- When nonempty, shows the effects of :substitute,  and user commands with the flag as you type.


-- enable my own time format 
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
    pattern = { '*.time' },
    callback = function()
        vim.opt.filetype = "time"
    end,
})


require("config.lazy")
