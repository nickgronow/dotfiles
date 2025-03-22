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

" Reload init
nnoremap <leader>sv :source $MYVIMRC<CR>

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
nnoremap <leader>w <c-w>c<c-w>=
" :highlight SpecialKey ctermfg=darkgray
nnoremap <leader>ts :list!

" Line endings
nnoremap <leader>ce :e ++ff=dos<cr>:setlocal ff=unix<cr>

" Copy the current file path
nnoremap <leader>y :let @+ = expand("%")<cr>

" Window navigation
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Save file
nnoremap <c-s> :w<cr>

" Get out of insert mode
inoremap <c-s> <esc>

" Open buffers - MVC emphasis
nnoremap <c-p> :bp<cr>
nnoremap <c-n> :RG<cr>
nnoremap <leader>fa :call RipgrepFzf(printf('\b%s\b', expand('<cword>')), 0, 'app')<cr>
nnoremap <leader>fs :call RipgrepFzf(printf('\b%s\b', expand('<cword>')), 0, 'spec')<cr>
nnoremap <leader>ff :call RipgrepFzf(printf('\bfactory :%s\b', expand('<cword>')), 0, 'spec/factories')<cr>
nnoremap <leader>fd :call RipgrepFzf(printf('\bdef %s\b', expand('<cword>')), 0)<cr>
nnoremap <leader>fs :call RipgrepFzf(printf('\bscope :%s\b', expand('<cword>')), 0)<cr>

" Column/table formatting
" nnoremap <leader>fh YpV:s/\v\w+/---/<cr>:set nohlsearch<cr>k
" vnoremap <leader>fc :s/\v\s+/ /<cr>gv:!column -t -s \\|<cr>gv:s/\v(  [^ ])/\\|\1<cr>:set nohlsearch<cr>
" nnoremap <silent> <leader>fs :SQLUFormatter<CR>

" Git
nnoremap <leader>gb :Git blame<cr>

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

" COC LSP
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" nmap <leader>r <Plug>(coc-rename)
if has('nvim')
  inoremap <silent><expr> <c-c> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
nmap <leader>aa <Plug>(coc-codeaction)
nmap <leader>af <Plug>(coc-fix-current)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Ctags
" nnoremap <C-]> g<C-]>

" c file toggling
map <leader>sc :e %:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>

" Python ipdb
nmap <leader>i Oimport ipdb; ipdb.set_trace()<esc>j0
