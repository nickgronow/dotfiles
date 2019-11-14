set shell=/bin/sh
set nocompatible

" Turn on syntax highlighting
syntax on

" Store swap files in fixed location, not current directory.
set dir=~/.vimswap//,/var/tmp//,/tmp//,.

" Case sensitivity
set ignorecase
set smartcase

" Global substitution
set gdefault

" Easier command selection
set wildmenu

" Allow windows to be closed without closing the file
set hidden

" Highlight searching is great
set hlsearch
set incsearch

" Line too long
highlight LineTooLong ctermbg=darkred ctermfg=white
let w:long_line_match=80

" Cursor settings
set guicursor="i-ci:ver100iCursor-blinkwait1000-blinkon400-blinkoff300"
let &t_SI = "\<Esc>[5 q"
let &t_EI = "\<Esc>[2 q"

" Filetype stuff
filetype on
filetype plugin on
filetype indent on

"Color Scheme
"colorscheme Tomorrow-Night

" Change highlight color
hi Search cterm=NONE ctermfg=none ctermbg=237
hi Search cterm=NONE ctermfg=black ctermbg=yellow

" Git Gutter
highlight GitGutterAdd ctermfg=White ctermbg=22
highlight GitGutterChange ctermfg=White ctermbg=100
highlight GitGutterDelete ctermfg=White ctermbg=DarkRed
highlight GitGutterChangeDelete ctermfg=White ctermbg=100
let g:gitgutter_max_signs = 2000

" Leader key
let mapleader = " "
let maplocalleader = "\r"

" Tabs

set tabstop=2
set smartindent
set shiftwidth=2
set autoindent
set expandtab

" Scrolling
set scrolloff=3

" Backspace in insert mode
set backspace=2

" Do not update the display when executing macros
set lazyredraw

" Show what mode you are in
set showmode

" Disable json quote concealing, we like our quotes
let g:vim_json_syntax_conceal = 0

" Netrw
let g:netrw_banner = 1
let g:netrw_liststyle = 0
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_list_hide= '\.DS_Store$,.*\.swp$,^\./$'

" Moving and copying files
let g:netrw_localmovecmd="mv"
let g:netrw_localcopycmd="cp"
let g:netrw_localmkdir="mkdir"
let g:netrw_localrmdir="rmdir"

" Strip HTML Tags
command! Htmlstrip execute "%s /<[a-zA-Z/].\{-}>//"

" Relative line numbers by default
set number
set rnu
au WinEnter * :set rnu
au WinLeave * :set nornu
au InsertEnter * :set nornu
au InsertLeave * :set rnu

" Status Line
set statusline=
set statusline+=%#warningmsg#
set statusline+=%*
set statusline +=\ %n\             "buffer number
set statusline +=%{&ff}            "file format
set statusline +=%y                "file type
set statusline +=\ %f            "full path
set statusline +=%m                "modified flag
set statusline +=%5l             "current line
set statusline +=/%L               "total lines
set statusline +=%4v\              "virtual column number
"set statusline +=%{fugitive#statusline()}
set laststatus=2

" Powerline Status Line
"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

" Hidden characters
set listchars=tab:>-,trail:~,extends:>,precedes:<

" Copy / paste in tmux
"set clipboard=unnamed

" Popup menu coloring
highlight Pmenu ctermfg=grey ctermbg=black
highlight PmenuSel ctermfg=darkgrey ctermbg=lightgrey

" Bg highlighting
highlight Normal ctermbg=none ctermfg=255
highlight NonText cterm=none

" Gdiff bug fix
autocmd BufNewFile,BufRead fugitive://* set bufhidden=delete

" Default filetypes to shell
autocmd BufNewFile,BufRead * if &ft == '' | set ft=sh | endif

" No cursor line. Certain syntax highlighting does not play well with it
"set nocursorline

" Statusline coloring - Is visible at certain times even with powerline
hi StatusLine ctermfg=darkblue ctermbg=black

" wrapping
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function! ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
  endif
endfunction

" Strip Trailing Whitespace
"autocmd Filetype vim,php,rb,js,css,sass,scss autocmd BufWritePre <buffer> StripWhitespace
let g:better_whitespace_filetypes_blacklist=['slim']

" Inky filetype as slim
au BufRead,BufNewFile *.inky setfiletype slim

" Strip Empty Lines
command! -bar StripEmptyLines g/^\s*$/d

" Strip Newline characters
command! -bar StripNewLineCharacters %s/\\n//

" Strip HTML Tags
command! FormatHTML set ft=html|StripNewLineCharacters|%s/<[^>]*>/\r&\r/e|StripEmptyLines|normal ggVG=

" Ruby convert string keys to symbol keys
command! ConvertStringKeysToSymbols s/\v['"]([^'"]*)['"]\s*\=\>/\1:/

" SQL formatting
command! FormatSQL silent! %s/\v<(from|join|where|order|group|having)>/\r&/e|silent! %s/\v [^,]+,/\r \0/e|nohlsearch|StripEmptyLines|normal gg

" Format JSON
com! FormatJSON %!python -m json.tool

" FuzzyFinder
set rtp+=~/.fzf

" Common tasks
command! LinesToCommas %s/ //|%s/\n/,/|normal $xv0y

" Addition
let g:S = 0
function! Sum(number)
  let g:S = g:S + a:number
  return a:number
endfunction

source ~/.config/nvim/mappings.vim
