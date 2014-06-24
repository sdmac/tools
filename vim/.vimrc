
" Easily switch between light and dark backgrounds
map <F2> :let &background = ( &background == "dark"? "light" : "dark" )

" Show next match while entering a search
set incsearch
" Highlight all search matches
set hlsearch

" Default is dark background
:let &background = ( &background == "dark"? "light" : "dark" )

" standard of 4 spaces
set shiftwidth=4

" use multiple of shiftwidth when indenting with '<' and '>'
set shiftround 

" copy the previous line indentation
set copyindent

" convert tabs to spaces
set expandtab

set softtabstop=4

" insert shiftwidth spaces on tab, remove on backspace
set smarttab

" automatic C program indenting
set cindent

" indentation rules
set cinoptions=:.5s,=.5s,g.5s,h.5s,t0

" ignore case in search patterns
set ignorecase

" override ignorecase if search pattern contains upper case chars
set smartcase

" adjust case during keyword completion
set infercase

" briefly jump to matching bracket when one inserted
set showmatch

" show line numbers
set number

" always show status line
set laststatus=2
set ruler

" syntax highlighting
syntax on

"filetype plugin on
"set ofu=syntaxcomplete#Complete

"retab
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction

"set textwidth=80

set backspace=indent,eol,start

"if has("autocmd")
"    autocmd Filetype java setlocal omnifunc=javacomplete#Complete
"endif 

"setlocal completefunc=javacomplete#CompleteParamsInfo
"inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>
"inoremap <buffer> <C-S-Space> <C-X><C-U><C-P> 

" use 'real' perl indentation
" loads vim's perl indent file
filetype indent on
autocmd FileType perl :set cindent

" reindent pasted text
"nnoremap p  p'[v']=
"nnoremap P  P'[v']=
"
"
augroup filetypedetect
  au BufNewFile,BufRead *.pig set filetype=pig syntax=pig
augroup END

filetype on
autocmd FileType txt set tw=72 fo=cqt wm=0
autocmd FileType mail set tw=72 fo=cqt wm=0
autocmd FileType cpp set tw=80 fo=cqt wm=0

" Remember 1000 commands and search history
set history=1000
" Use 1000 levels of undo
set undolevels=1000
