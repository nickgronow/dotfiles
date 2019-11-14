" Ferret (search tool)

nmap <leader>aa <Plug>(FerretAck)
nmap <leader>ar <Plug>(FerretAcks)
nmap <leader>aw <Plug>(FerretAckWord)

" Buffer navigation
nnoremap <leader>bb :Buffers<cr>

" Copy all
nnoremap <leader>ca mzgg"+yG'z

" Copy adjustments
nnoremap Y y$

" CD to the directory containing the file in the buffer
nmap  <leader>cd :lcd %:h

" Deleting stuff goes into the black hole register
nnoremap d "_d

" Clear all
nnoremap <leader>da ggdG

" Explore the current directory
nnoremap <leader>ee :Explore<cr>

" Edit mappings
nmap <silent> <leader>em :e ~/.config/nvim/mappings.vim<cr>

" Quit explore (I don't think we need this that we are using netrw)
nnoremap <leader>eq :RExplore<cr>

" Reload file
nnoremap <leader>er :e! %<cr>
" nnoremap <leader>er :exec 'source '.bufname('%')<CR>

" Edit vimrc
nmap <silent> <leader>ev :e $MYVIMRC<cr>

" Explore the root project directory
nnoremap <leader>ew :Explore .<cr>

" Toggle last buffer
nnoremap <leader>l :b#<cr>

" Search for any file
nnoremap <leader>o :OpenFiles<cr>

" Jump to start of line
nnoremap 0 ^

" Toggle highlighting
nnoremap  <leader>n :set hlsearch!<cr>

" Toggle line numbering
nnoremap <leader>u :set rnu!<cr>

" Toggle viewing whitespaces
nnoremap <leader>wh :ToggleWhitespace<cr>
" :highlight SpecialKey ctermfg=darkgray
nnoremap <leader>ts :list!

" Line endings
nnoremap <leader>ce :e ++ff=dos<cr>:setlocal ff=unix<cr>

" Copy the current file path
nnoremap <leader>% :let @+ = expand("%")<cr>

" Window navigation
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Save file
nnoremap <c-s> :up<cr>

" Get out of insert mode
inoremap <c-s> <esc>

" Open buffers - MVC emphasis
nnoremap <c-p> :bp<cr>
nnoremap <c-n> :bn<cr>

" Column/table formatting
" nnoremap <leader>fh YpV:s/\v\w+/---/<cr>:set nohlsearch<cr>k
vnoremap <leader>fc :s/\v\s+/ /<cr>gv:!column -t -s \\|<cr>gv:s/\v(  [^ ])/\\|\1<cr>:set nohlsearch<cr>
nnoremap <silent> <leader>fs :SQLUFormatter<CR>

" Git
nnoremap <leader>gb :Gblame<cr>

" GitGutter
nnoremap <leader>gn :GitGutterNextHunk<cr>
nnoremap <leader>gp :GitGutterPrevHunk<cr>

" Insert lines
nmap <S-CR> O<Esc>
"nmap <CR> o<Esc>

" Git diff
nnoremap <leader>cj :colorscheme jellybeans<cr>
nnoremap <leader>ct :colorscheme Tomorrow-Night<cr>

" Highlight coloring
nnoremap <leader>hb :hi Search cterm=NONE ctermfg=none ctermbg=237<cr>
nnoremap <leader>hy :hi Search cterm=NONE ctermfg=black ctermbg=yellow<cr>

" Search text object
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
      \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap / :normal vs<CR>

" Delete double new line characters
nnoremap <leader>dn :%s/\n\n/\r

" Commentary bindings
nmap <leader>c :Commentary<CR>
vmap <leader>c :Commentary<CR>

" Incsearch
" map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)

" Copy visual selection
" vnoremap y "+y

" Split by commas
vnoremap <leader>, :s/\v\s+(\w+)(,\|\n)/\r\1\2/g<cr>
