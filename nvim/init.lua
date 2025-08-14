-- General ---------------------------------------------------------------------

vim.opt.tabstop = 4                     -- 4 space tabs by default
vim.opt.softtabstop = 4                 -- 4 space tabs by default
vim.opt.shiftwidth = 4                  -- 4 space tabs by default
vim.opt.expandtab = true                -- insert spaces when tab is pressed
vim.opt.linebreak = true                -- wrap long lines at word boundaries
vim.opt.scrolloff = 5                   -- scroll when 5 lines away from edge of screen
vim.opt.ignorecase = true               -- ignore case when searching...
vim.opt.smartcase = true                -- ...unless a capital letter was typed
vim.opt.completeopt = "longest,menuone" -- popup menu completion options
vim.opt.wildmode = "longest:full"
vim.opt.backup = false                  -- don't save backup files
vim.opt.writebackup = false             -- don't save backup files
vim.opt.swapfile = false                -- don't create .swp files
vim.opt.foldlevel = 99                  -- open all folds by default
vim.opt.title = true                    -- set window title to filename
vim.opt.signcolumn = "yes"              -- show sign column
vim.opt.clipboard = "unnamedplus"       -- share system clipboard
vim.opt.hlsearch = false                -- don't leave search highlights
vim.opt.fillchars = "fold:-,vert:▏"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.tabline = ""

vim.cmd("helptags ALL")

-- Statusline ------------------------------------------------------------------

-- asdf
local statusline = ""
statusline = statusline .. " %f"      -- path to file relative to cwd
statusline = statusline .. " %m"      -- modified flag
statusline = statusline .. "%="       -- right-align
statusline = statusline .. "%y"       -- filetype
statusline = statusline .. " · %p%%"  -- file percent
statusline = statusline .. " · %l/%L" -- line number
statusline = statusline .. " · %-3c"  -- column number
vim.opt.statusline = statusline

-- Colorscheme -----------------------------------------------------------------

vim.cmd("colorscheme retcon-snes")
vim.opt.termguicolors = true -- use GUI colors in terminal
vim.opt.colorcolumn = "81"

-- Presentation Mode -----------------------------------------------------------
-- vim.opt.colorcolumn = "0"
-- vim.opt.statusline = "%t"
-- vim.opt.laststatus = 3
-- vim.opt.cmdheight = 0
-- vim.opt.showmode = false
-- vim.keymap.set("n", "<Left>", ":bprev<CR>")
-- vim.keymap.set("n", "<Right>", ":bnext<CR>")

-- Key Mappings ----------------------------------------------------------------

-- movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set({"c", "i"}, "<C-a>", "<Home>")
vim.keymap.set({"c", "i"}, "<C-e>", "<End>")
vim.keymap.set({"c", "i"}, "<C-b>", "<Left>")
vim.keymap.set({"c", "i"}, "<C-f>", "<Right>")
vim.keymap.set("n", "j", "gj") -- wrapped line movement
vim.keymap.set("n", "k", "gk") -- wrapped line movement

-- leader shortcuts
local nvimdir = "$HOME/.dotfiles/nvim"
vim.g.mapleader = ","
vim.keymap.set("n", "<LEADER>ev", ":vsplit $MYVIMRC<CR>")
vim.keymap.set("n", "<LEADER>en", ":vsplit "..nvimdir.."<CR>")
vim.keymap.set("n", "<LEADER>ec", ":vsplit "..nvimdir.."/colors/retcon-snes.vim<CR>")
vim.keymap.set("n", "<LEADER>sv", ":source $MYVIMRC<CR>:e<CR>")
vim.keymap.set("n", "<LEADER>f", ":Files<CR>")
vim.keymap.set("n", "<LEADER>b", ":Buffers<CR>")
vim.keymap.set("n", "<LEADER>a", ":RG<CR>")
vim.keymap.set("n", "<LEADER>C", ":Colors<CR>")
vim.keymap.set("n", "<LEADER>m", ":make<CR>")
vim.keymap.set("n", "<LEADER>tt", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<LEADER>tl", ":TagbarToggle<CR>")
vim.keymap.set("n", "<LEADER>TL", ":TagbarOpen fj<CR>")
vim.keymap.set("n", "<LEADER>h", ":set hlsearch!<CR>")
vim.keymap.set("n", "<LEADER>cd", ":cd %:p:h<CR>:pwd<CR>")
vim.keymap.set("n", "<LEADER>S", [[:echo join(reverse(map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')),' ')<CR>]])
vim.keymap.set("n", "<LEADER>gb", ":Git blame -w<CR>")
vim.keymap.set("n", "<LEADER>=", "yyp<C-v>$r=") -- underline with ===
vim.keymap.set("n", "<LEADER>-", "yyp<C-v>$r-") -- underline with ---

-- Autocommands ----------------------------------------------------------------

-- strip trailing whitespace on save
vim.api.nvim_create_augroup("trailing_whitespace", {clear = true})
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    group = "trailing_whitespace",
    command = [[:%s/\s\+$//e]],
})

-- automatically save changes
vim.api.nvim_create_augroup("autosave", {clear = true})
vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
    group = "autosave",
    command = "if &l:buftype == '' | silent update | endif",
})

-- additional filetypes
vim.api.nvim_create_augroup("filetypes", {clear = true})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    group = "filetypes",
    pattern = "*.h",
    command = "set filetype=c",
})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    group = "filetypes",
    pattern = "*.tpl",
    command = "set filetype=gotexttmpl",
})

-- vertical help window
vim.api.nvim_create_augroup("vertical_help", {clear = true})
vim.api.nvim_create_autocmd({"FileType"}, {
    group = "vertical_help",
    pattern = "help",
    command = "wincmd L",
})

-- restore cursor position (from defaults.vim)
vim.api.nvim_create_augroup("restore_cursor", {clear = true})
vim.api.nvim_create_autocmd({"BufReadPost"}, {
    group = "restore_cursor",
    command = [[
        if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
            exe "normal! g`\""
        endif
    ]]
})

-- Git
vim.api.nvim_create_augroup("git", {clear = true})
vim.api.nvim_create_autocmd({"FileType"}, {
    group = "git",
    pattern = "git",
    callback = function()
        vim.opt_local.tabstop = 8
        vim.opt_local.softtabstop = 8
        vim.opt_local.shiftwidth = 8
        vim.opt_local.colorcolumn = "73"
    end
})

-- Go
vim.api.nvim_create_augroup("go", {clear = true})
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    group = "go",
    pattern = "*.go",
    callback = function()
        vim.lsp.buf.code_action({
            context = { only = { 'source.organizeImports' }, },
            apply = true,
        })
        vim.lsp.buf.format()
    end
})
vim.api.nvim_create_autocmd({"FileType"}, {
    group = "go",
    pattern = "go",
    callback = function()
        vim.opt_local.formatprg = ''
        vim.opt_local.tabstop = 8
        vim.opt_local.softtabstop = 8
        vim.opt_local.shiftwidth = 8
        vim.opt_local.expandtab = false
        vim.keymap.set("n", "<LEADER>r", ":!cd %:p:h && go run .<CR>", { buffer = true })
    end
})

-- Zig
vim.api.nvim_create_augroup("zig", {clear = true})
vim.api.nvim_create_autocmd({"FileType"}, {
    group = "zig",
    pattern = "zig",
    command = "compiler zig_build_exe",
})
vim.api.nvim_create_autocmd({"FileType"}, {
    group = "zig",
    pattern = "zig",
    command = "nnoremap <buffer> <LEADER>r :!zig run %<CR>",
})

-- Plugins ---------------------------------------------------------------------

-- Disable standard plugin highlighting matching paren.
vim.g.loaded_matchparen = 1

-- lazy.vim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "tpope/vim-commentary",
    "tpope/vim-surround",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "ziglang/zig.vim",
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip.loaders.from_snipmate").lazy_load()
            vim.cmd([[
            imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
            inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
            ]])
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            filetypes = { "css", "vim" },
            user_default_options = {
                mode = "virtualtext",
            },
        },
    },
    {
        "junegunn/fzf.vim",
        dependencies = { "junegunn/fzf" },
        init = function()
            vim.cmd([[
            let g:fzf_colors = {
            \   'fg':      ['fg', 'Normal'],
            \   'bg':      ['bg', 'Normal'],
            \   'hl':      ['fg', 'Comment'],
            \   'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \   'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \   'hl+':     ['fg', 'Statement'],
            \   'info':    ['fg', 'PreProc'],
            \   'border':  ['fg', 'Ignore'],
            \   'prompt':  ['fg', 'Conditional'],
            \   'pointer': ['fg', 'Exception'],
            \   'marker':  ['fg', 'Keyword'],
            \   'spinner': ['fg', 'Label'],
            \   'header':  ['fg', 'Comment']
            \ }

            " Rerun ripgrep search for every query change.
            function! RipgrepFzf(query, fullscreen)
                let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
                let initial_command = printf(command_fmt, shellescape(a:query))
                let reload_command = printf(command_fmt, '{q}')
                let spec = {'options': ['--disabled', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
                let spec = fzf#vim#with_preview(spec, 'right', 'ctrl-/')
                call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
            endfunction
            command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
            ]])
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        opts  = {
            signs = {
                changedelete = { text = '┃' },
            },
        }
    },
    "neovim/nvim-lspconfig",
    {
        "nvim-tree/nvim-tree.lua",
        opts = {},
    },
})

-- lspconfig
local lspconfig = require('lspconfig')
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        -- TODO: Make references open in fzf window?
        vim.keymap.set('n', 'gr', vim.lsp.buf.references,copts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>F', function()
            vim.lsp.buf.format()
            vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
        end, opts)
        vim.keymap.set('n', '<leader>D', function()
            if vim.diagnostic.is_disabled() then
                vim.diagnostic.enable()
            else
                vim.diagnostic.disable()
            end
        end)
    end,
})
vim.diagnostic.config({
    virtual_text = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "•",
            [vim.diagnostic.severity.WARN] = "•",
            [vim.diagnostic.severity.HINT] = "•",
            [vim.diagnostic.severity.INFO] = "•",
        },
    }
})
lspconfig.gopls.setup({
    settings = {
        gopls = {
            ["local"] = "liftoff.io/",
            gofumpt = true
        },
    },
})
lspconfig.zls.setup({
    settings = {
        zls = {
            semantic_tokens = "none",
        }
    }
})
