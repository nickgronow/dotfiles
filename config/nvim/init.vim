" Set the wm title
set title
set titlestring=%.30t%(\ %M%)\ -\ NVIM
set titleold=bash

" Important general settings
filetype plugin indent on
set encoding=utf-8
set mouse=a
set wildcharm=<Tab>

" Leader key
let mapleader = " "
let maplocalleader = "\r"

syntax on
syntax sync minlines=10000
filetype on
set hidden
set inccommand=split
set showtabline=0
set nu
set rnu
" Insert spaces when TAB is pressed.
set expandtab
" Render TABs using this many spaces.
set softtabstop=2
" Indentation amount for < and > commands.
set shiftwidth=2
" Horizontal split below current.
set splitbelow
" Vertical split to right of current.
set splitright
set nocompatible
set ignorecase
set smartcase
" the intro is annoying
set shortmess+=I
" swap file warnings are annoying
set shortmess+=A
set virtualedit=block
set lazyredraw
set backspace=indent,eol,start
set autoread
set incsearch
set noequalalways
" wrap to prev/next line with movement keys
set whichwrap+=<,>,h,l,[,]
set autowrite
set nostartofline
set fillchars+=vert:│
" Provides tab-completion
set path+=**
set wildmenu
set wildmode=longest,full
" Highlight tabs (aka the devil)
highlight SpecialKey ctermfg=1
set list
set listchars=tab:··
set autowrite
set autowriteall
set smarttab
set smartindent
set autoindent " might not want this in the future, up to you
" Gutter config
set numberwidth=4
set signcolumn=yes:1

hi CursorLineNr cterm=bold
hi CursorLine cterm=none ctermbg=black
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Python
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab textwidth=88

" C
autocmd BufRead,BufNewFile *.h setfiletype c
autocmd FileType c setlocal tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab nolist

" XML
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" ejson
au BufRead,BufNewFile *.ejson set syntax=json

" Run PlugInstall if there's missing plugins
autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   PlugInstall --sync | q
      \| endif

" Key timing
set timeout
set timeoutlen=400 ttimeoutlen=0

call plug#begin('~/.local/share/nvim/plugged')

" SQL & PLPG
Plug 'lifepillar/pgsql.vim'

" COC ZSH
Plug 'tjdevries/coc-zsh'

" xterm colors
Plug 'guns/xterm-color-table.vim'

" Graphql
Plug 'jparise/vim-graphql'

" Dracula colors
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'chriskempson/base16-vim'

" iTerm2
Plug 'tomjrees/vim-iterm2-navigator'

" Vue syntax
Plug 'posva/vim-vue'
autocmd FileType vue syntax sync fromstart

" Earthly syntax
Plug 'earthly/earthly.vim', { 'branch': 'main' }

Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-p']

" Docker
Plug 'ekalinin/Dockerfile.vim'

Plug 'haya14busa/incsearch.vim'
" tpopes vim-commentary better then nerdcommentor. All it is is just the gc
" command.
" to toggle a comment on one line do: gcc
" to toggle all surrounding commented lines: gcgc
" Can be used as an operator. gcip to comment toggle a paragraph. etc.
Plug 'tpope/vim-commentary'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-endwise'

" Ferret
Plug 'wincent/ferret'

" Git stuff
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter' " signs in gutter on changes in git
let g:gitgutter_max_signs=9999
" Git is on G so you can do :G status in vim to see git status, or :G commit
" to commit. very nice.
command! -nargs=+ G :te git <args>

" Always reopen to last place in a file. try closing this and reopen it and
" youll see.
" Plug 'farmergreg/vim-lastplace'

Plug 'ludovicchabant/vim-gutentags'
" Gutentags exclusions
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ 'build',
      \ 'dist',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '.vim',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '.vscode',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.ccls-cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]
let g:gutentags_ctags_executable = 'ctags'
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['.git']
let g:gutentags_add_default_project_roots = 0

"""""""""""""""""
""* Clipboard *""
"""""""""""""""""
set clipboard+=unnamedplus

Plug 'svermeulen/vim-subversive'
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

Plug 'svermeulen/vim-yoink'
let g:yoinkAutoFormatPaste = 1
let g:yoinkSyncNumberedRegisters = 1
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)
" nmap p <plug>(YoinkPaste_p)
" nmap P <plug>(YoinkPaste_P)
nmap [y <plug>(YoinkRotateBack)
nmap ]y <plug>(YoinkRotateForward)
nmap <c-=> <plug>(YoinkPostPasteToggleFormat)
nmap y <plug>(YoinkYankPreserveCursorPosition)
xmap y <plug>(YoinkYankPreserveCursorPosition)
inoremap <silent> <c-v> <c-o>P

" Airline
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_section_b = "%p%% - %l/%L"

let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#fnamemod = ''

let g:airline#extensions#tagbar#flags = 'f'  " show full tag hierarchy
let g:airline#extensions#tagbar#enabled = 1

let g:airline#extensions#fugitiveline#enabled = 0
let g:airline#extensions#gutentags#enabled = 1
let g:airline#extensions#gutentags#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline_powerline_fonts = 0
let g:airline_skip_empty_sections = 1
let g:airline_theme='base16'

" Highlight colors in any buffer
Plug 'ap/vim-css-color'

" sandwhich is a better vim-surround
Plug 'machakann/vim-sandwich'

" do gl<some character> to align by that character
Plug 'tommcdo/vim-lion'

" This just makes repeat way better, makes it work in some instances where it
" usually doesn't
Plug 'tpope/vim-repeat'

" Vim sugar for the unix shell commands
Plug 'tpope/vim-eunuch'

" hit <F5> to open undo tree, hit <F5> again to close it
Plug 'mbbill/undotree'
nnoremap <silent> <F5> :UndotreeToggle<cr>
let g:undotree_WindowLayout = 4
let g:undotree_SplitWidth = 25
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_HelpLine = 0
let g:undotree_HighlightChangedText = 0
let g:undotree_ShortIndicators = 1
set undofile
set undodir=~/.vim/undo
set undolevels=10000
set undoreload=10000

" Ripgrep searching - :Rg
" Word under cursor will be searched if no argument is passed to Rg
Plug 'jremmen/vim-ripgrep'
let g:rg_highlight = 1

" hit " in normal more or ctrl-r (like you normally would when selecting a
" register) and you'll get a visual representation of the available registers
Plug 'junegunn/vim-peekaboo'

" snippets!
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" To see this in action, go to a ruby file on a new line and type def<enter> or
" fun<enter> in a vim file
" Look up ultisnips to learn more and make your own

" Testing!! rspec!
Plug 'janko-m/vim-test'
let test#strategy = "neovim"
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

" Switch anything with gs (ex. true -> false) try hitting gs with your cursor
" on true or false. This works with MANY things: https://github.com/AndrewRadev/switch.vim
Plug 'AndrewRadev/switch.vim'

" custom text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
" vil is the line, val is the line with \n at the end
Plug 'kana/vim-textobj-entire'
" vie, die, cie to act on the entire buffer
Plug 'kana/vim-textobj-syntax'
" viv, div, civ to act on inner segments of CamelCase
Plug 'idbrii/textobj-word-column.vim'
" vic, dic, cic to act on columns of text (just try it) (also viC goes to
" spaces)
Plug 'julian/vim-textobj-variable-segment'
Plug 'tpope/vim-unimpaired'
" viv, div, civ to act on inner segments of CamelCase
" Remember: the ruby plugin that comes built in to pathogen defines a ruby
" method textobject. dim to delete inside a method or dam to delet the whole
" method.

" SQL formatting
Plug 'vim-scripts/SQLUtilities'

" Bracket, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

function! RipgrepFzf(query, fullscreen, ...)
  let iglob = ''
  if a:0
    let iglob = "--iglob '" . a:1 . "/**/*'"
  endif
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s -- %s || true'
  let initial_command = printf(command_fmt, iglob, shellescape(a:query))
  let reload_command = printf(command_fmt, iglob, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(printf('\b%s\b', expand('<cword>')), <bang>0, <f-args>)

let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }

function! SearchWordWithRg()
  execute 'Rg' expand('<cword>')
endfunction

function! SearchVisualSelectionWithRg() range
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  execute 'Rg' selection
endfunction

" Install ripgrep if you don't have it: https://github.com/BurntSushi/ripgrep
" (its faster and better then ag) If you don't want to you can change these ag
" (but don't)
" Just try all these out, theyre self explanatory
" But the important ones are:
" space f f to look for files
" space f u to look for text in files (ignore file names, only text: ignore sql and migrations)
" space f U to look for text in files (ignore file names, only text: don't ignore sql and migrations)
" space f a to look for text in files (don't ignore file names ignore sql and migrations)
" space f A to look for text in files (don't ignore file names don't ignore sql and migrations)
" Also when using things like space f f or space f u you can hit tab to select multiple
" files, and they pop into the quick fix list. When you get more into the
" quickfix list you might want to try https://github.com/romainl/vim-qf
nnoremap <silent> <leader>/ :execute 'Rg ' . input('ripgrep: ')<CR>
nnoremap <silent> <leader>/ :execute 'Rg ' . input('ripgrep: ')<CR>
nnoremap <silent> <leader>* :call SearchWordWithRg()<CR>
vnoremap <silent> <leader>* :call SearchVisualSelectionWithRg()<CR>
nnoremap <silent> <leader>fl :BLines<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fL :Lines<CR>
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fa :Ag!<CR>
nnoremap <silent> <leader>fr :Rg!<CR>
nnoremap <silent> <leader>fR :RG!<CR>
nnoremap <silent> <leader>ft :BTags!<CR>
nnoremap <silent> <leader>fT :Tags!<CR>
nnoremap <silent> <leader>fu :Ru!<CR>
nnoremap <silent> <leader>fU :RU!<CR>
nnoremap <silent> <leader>fh :History!<CR>
nnoremap <silent> <leader>fH :Helptags!<CR>
nnoremap <silent> <leader>fw :Windows!<CR>
nnoremap <silent> <leader><leader> :Commands<CR>
nnoremap <silent> <leader>f: :History:!<CR>
nnoremap <silent> <leader>f/ :History/!<CR>
" When in insert mode, press Ctrl-x-f (as a sequence, not a chord) to insert a path
imap <c-x><c-f> <plug>(fzf-complete-path)
" Global line completion (not just open buffers. ripgrep required.)
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
      \ 'prefix': '^.*$',
      \ 'source': 'rg -n ^ --color always',
      \ 'options': '--ansi --delimiter : --nth 3..',
      \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

" ctrl h and ctl l to move between buffers (makes sense when you see buffers
" in the top airline bar, but if you hate this feel free to delete it)
map <silent> <C-h> :bprevious<CR>
map <silent> <C-l> :bnext<CR>
"  Backspace to last buffer (I love this but delete it if you hate it)
" nnoremap <BS> <C-^>

" Macro shortcut: qq to record, Q to replay.
" Also gets rid of ex mode.
nnoremap Q @q

" Undo stuff (u and U makes more sense then u and c-r)
nmap U <C-r>

" no one uses parens for their motion (it's sentence motion, completely
" useless) So this makes them move to beginning or end of line. try c( or d)
nnoremap <silent> ) $
nnoremap <silent> ( 0

" hit escape to remove highlighting from incremental search
nnoremap <silent> <esc> :noh<return><esc>

" LSP support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-solargraph']
" hi CocErrorSign ctermbg=black
hi Pmenu ctermbg=234 ctermfg=251
hi PmenuSel ctermbg=232 ctermfg=255
" hi PmenuSbar ctermbg=0 guibg=#d6d6d6

call plug#end()

colorscheme base16-default-dark

" " Finally, some more autocomplete settings that need to happen outside the vim
" " plug block:
" let g:SuperTabDefaultCompletionType = "<c-n>"
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#auto_completion_start_length = 1
" " deoplete: use smartcase, tweak delay to your liking. Define auto complete sources.
" call deoplete#custom#option({
" \ 'auto_complete_delay': 50,
" \ 'smart_case': v:true,
" \ 'sources': {
" \ '_':   ['neco-syntax', 'buffer', 'tag', 'around', 'file', 'omni'],
" \ 'vim': ['neco-vim', 'buffer', 'tag', 'around', 'file', 'omni']
" \ }
" \ })
" " Remember: enter to insert snippet, tab and shift tab to insert completions

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" JSON formatter
com! FormatJSON %!python3 -m json.tool
com! ParseJSON execute 'normal G$xgg^x:%s/\v(\\)?\\"/"/g' | FormatJSON

" SQL formatter
com! FormatSql execute '%!sqlformat --reindent --keywords upper --identifiers lower -' | set ft=sql

" XML formatter
com! FormatXML %! xmllint --format -

" Add autocomplete dictionary if it exists
if filereadable(".vim-dictionary")
  set dictionary+=.vim-dictionary
endif

" Coloring

" set background=dark
" set t_Co=256
" set termguicolors
" let base16colorspace=256
" colorscheme base16-default-dark
hi Normal ctermbg=None

" Vimdiff color scheme
if &diff
  colorscheme jellybeans
  set nocursorline
endif

source ~/.config/nvim/mappings.vim

" Open files
com! OpenFiles call fzf#run({'source': 'find . -type d \( -path ./coverage -o -path ./tmp/cache -o -path ./node_modules -o -path ./migrations -o -path ./.git -o -path ./dist \) -prune -o -type f' , 'sink': 'e'})

" CTags
com! TS execute 'ts '.expand("<cword>")

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
