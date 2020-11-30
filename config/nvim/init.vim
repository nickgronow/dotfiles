" Set the wm title
set title
set titlestring=%.30t%(\ %M%)\ -\ NVIM
set titleold=bash

" Important general settings
filetype plugin indent on
set encoding=utf-8
set tags=./tags;/
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
set showtabline=2
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
set cursorline
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
" Enable completion where available.
" This setting must be set before ALE is loaded.
let g:ale_completion_enabled = 0

" Python
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab

" C
autocmd BufRead,BufNewFile *.h setfiletype c
autocmd FileType c setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab nolist

" Run PlugInstall if there's missing plugins
autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   PlugInstall --sync | q
      \| endif

" Key timing
set timeout
set timeoutlen=400 ttimeoutlen=0

call plug#begin('~/.local/share/nvim/plugged')

" Tmux navigation across vim panes
Plug 'christoomey/vim-tmux-navigator'

" Tomorrow night colors
Plug 'chriskempson/base16-vim'

" jellybeans
Plug 'nanotech/jellybeans.vim'

" Vue syntax
Plug 'posva/vim-vue'
autocmd FileType vue syntax sync fromstart

" my theme. you can use something else.
Plug 'crusoexia/vim-monokai'

Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

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
      \ '*.min.js',
      \ '*htl*',
      \ 'jquery*.js',
      \ '*/vendor/*',
      \ 'node_modules',
      \ '*/node_modules/*',
      \ '*/python2.7/*',
      \ '*.sql',
      \ '*/migrate/*.rb'
      \ ]
let g:gutentags_ctags_executable = 'ctags'

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

" Terminals (sayonara is to make closing them better/easier)
Plug 'mhinz/vim-sayonara'
tnoremap <silent> <esc> <C-\><c-n>:Sayonara<CR>
tnoremap <silent> <c-c> <C-\><c-n>
tnoremap <silent> <c-h> <C-\><c-n>:bp<CR>
tnoremap <silent> <c-l> <C-\><c-n>:bn<CR>
tnoremap <silent> <c-Left> <C-\><c-n>:bp<CR>
tnoremap <silent> <c-Right> <C-\><c-n>:bn<CR>
autocmd TermOpen * startinsert
autocmd TermClose * stopinsert
au TermOpen * setlocal nonumber norelativenumber
" I also  bind sayonara to ctrl b ctrl d
" nnoremap <silent> <c-b><c-d> :Sayonara!<CR>
" nnoremap <silent> <c-b><c-q> :Sayonara!<CR>
" It does this https://github.com/mhinz/vim-sayonara
" quote:
" This plugin provides a single command that deletes the current buffer and
" handles the current window in a smart way.  Basically you don't have to
" think in terms of :bdelete, :close, :quit etc. anymore. The plugin does that
" for you.  First of all, :Sayonara or :Sayonara! will only delete the buffer,
" if it isn't shown in any other window. Otherwise :bdelete would close these
" windows as well. Therefore both commands always only affect the current
" window. This is what the user expects and is easy reason about.  If the
" buffer contains unsaved changes, you'll be prompted on what to do.

" Airline
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_section_b = "%p%% - %l/%L"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tagbar#flags = 'f'  " show full tag hierarchy
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#fugitiveline#enabled = 0
let g:airline#extensions#gutentags#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 0
let g:airline_skip_empty_sections = 1

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

" Plug 'dense-analysis/ale'
let g:ale_linters = {'gql': ['eslint'] }
" Ale is the best plugin out there for linting... look into it: https://github.com/w0rp/ale
" let g:ale_fixers = {
" \   '*': ['remove_trailing_lines', 'trim_whitespace'],
" \   'javascript': ['eslint'],
" \   'ruby': ['rubocop'],
" \}

" Hit F4 to pray ale will fix your code
" nmap <F4> <Plug>(ale_fix)
" Set this variable to 1 to fix files when you save them.
" let g:ale_fix_on_save = 0
" Write this in your vimrc file
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'

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

" Needed for SQL formatting
Plug 'vim-scripts/Align'

" Bracket, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" Help and Documentation
nnoremap <silent> <leader>hh :Helptags!<CR>
" search related docsets
nnoremap <leader>hdr :Dasht<Space>
" search ALL the docsets
nnoremap <leader>hda :Dasht!<Space>
" search related docsets
" nnoremap <silent> <Leader>ks :call Dasht([expand('<cword>'), expand('<cWORD>')])<Return>
" search ALL the docsets
nnoremap <silent> <leader>hd :call Dasht([expand('<cword>'), expand('<cWORD>')], '!')<Return>
" search related docsets
" vnoremap <silent> <Leader>k y:<C-U>call Dasht(getreg(0))<Return>
" search ALL the docsets
vnoremap <silent> <leader>hd y:<C-U>call Dasht(getreg(0), '!')<Return>
" socli
nnoremap <leader>hs :te socli -iq<space>
" Googler
nmap <leader>hg :te googler<cr>

" move by visual lines when lines wrap (very useful)
" nmap j gj
" nmap k gk

" By default CTRL+G in vim displays the name of the current buffer in the
" statusline, which isn't very useful if you use plugins which always display
" it, so I remap CTRL+G to copy the filename:line to the clipboard.
" nmap <c-g> :let @+ = expand("%:p") . ":" . line(".") \| echo 'copied ' . @+ . ' to the clipboard.'<CR>

" D is for Do scripts (running scripts)
nnoremap <leader>dh :History:!<CR>
nnoremap <leader>dd :te<space>
nnoremap <leader>dr :te ruby %<cr>
nnoremap <leader>db :te bash %<cr>

" Rails
nnoremap <leader>rr :te bin/rails c<cr>

" Save yourself from typos
command! Wq :wq
command! WQ :wq

" Open (if you assign $MYVIMRC to the location of this file in your zsh config
" or whatever, you can do space o v to resource the file after making changes.
" very handy.
" you can change these to zsh
" nmap <silent> <space>ott :te bash<CR>
" nmap <silent> <space>otv :vsplit term://bash<CR>
" nmap <silent> <space>ots :split term://bash<CR>

" FZF (my fzf stuff looks ugly but I think you'll like it.)
command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0)
" Search text and filenames recursively, but ignore specs and migrations.
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   "rg --smart-case -g '!vendor/bundle/gems' -g '!spec' -g '!migrate' --color=never --column --line-number --no-heading -Tsql ".shellescape(<q-args>), 1,
      \   <bang>0)
" Search all text and filenames recursively.
command! -bang -nargs=* RG
      \ call fzf#vim#grep(
      \   "rg --smart-case --color=never --column --line-number --no-heading -Tsql ".shellescape(<q-args>), 1,
      \   <bang>0)
" Search all usages of text, ignore filenames, sql, json, migrations, and specs.
command! -bang -nargs=* Ru
      \ call fzf#vim#grep(
      \   "rg --smart-case -g '!spec' -g '!migrate' --color=never --column --line-number --no-heading -Tsql -Tjson ".shellescape(<q-args>), 1,
      \   <bang>0)
" Search all usages of text, but ignore nothing.
command! -bang -nargs=* RU
      \ call fzf#vim#grep(
      \   "rg --smart-case --color=never --column --line-number --no-heading ".shellescape(<q-args>), 1,
      \   <bang>0)

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

call plug#end()

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

" If you don't like the default completion menu colors you can edit them:
" highlight Pmenu ctermbg=8 guibg=#606060
" highlight PmenuSel ctermbg=1 guifg=#dddd00 guibg=#1f82cd
" highlight PmenuSbar ctermbg=0 guibg=#d6d6d6

" JSON formatter
com! FormatJSON %!python -m json.tool

" SQL formatter
com! FormatSql execute '%!sqlformat --reindent --keywords upper --identifiers lower -' | set ft=sql

" Add autocomplete dictionary if it exists
if filereadable(".vim-dictionary")
  set dictionary+=.vim-dictionary
endif

" Coloring

set background=dark
set t_Co=256
set termguicolors
let base16colorspace=256
colorscheme base16-default-dark
hi Normal guibg=NONE ctermbg=NONE

" Vimdiff color scheme
if &diff
  colorscheme jellybeans
  set nocursorline
endif

source ~/.config/nvim/mappings.vim

" Open files
com! OpenFiles call fzf#run({'source': 'find . -type f ! -path "./coverage/*" ! -path "./tmp/cache/*" ! -path "**/node_modules*" ! -path "**/migrations*" ! -path "./.git/*" ! -path "./dist/*"' , 'sink': 'e'})

" Buffers
function! GetActiveBuffers()
    let l:blist = getbufinfo({'bufloaded': 1, 'buflisted': 1})
    let l:result = []
    for l:item in l:blist
        "skip unnamed buffers; also skip hidden buffers?
        if empty(l:item.name)
            continue
        endif
        call add(l:result, shellescape(l:item.name))
    endfor
    return join(l:result)
endfunction
