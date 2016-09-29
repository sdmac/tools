call pathogen#runtime_append_all_bundles()

" highlight current line
" set cursorline
set cursorline
set cmdheight=2
set switchbuf=useopen
set showtabline=2

" only highlight in the current window
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" keep more context when scrolling off the end of a buffer
set scrolloff=3

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

set splitright

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

" add include paths
set path+=/usr/include/c++,

" show line numbers
set number

" always show status line
set laststatus=2
set ruler

" syntax highlighting
syntax on

"filetype plugin on set ofu=syntaxcomplete#Complete
filetype plugin indent on
set wildmode=longest,list
set wildmenu
let mapleader=","
:set timeout timeoutlen=1000 ttimeoutlen=100

"retab
function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction
inoremap <S-tab> <c-r>=InsertTabWrapper ("backward")<cr>
inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>


"set textwidth=80
"set fo=cqt
"set wm=0
"autocmd BufRead * set fo+=t tw=73|normal gggqG

set backspace=indent,eol,start

"if has("autocmd") autocmd Filetype java setlocal
"omnifunc=javacomplete#Complete endif 

"setlocal completefunc=javacomplete#CompleteParamsInfo inoremap <buffer>
"<C-X><C-U> <C-X><C-U><C-P> inoremap <buffer> <C-S-Space> <C-X><C-U><C-P> 

" use 'real' perl indentation loads vim's perl indent file
"filetype indent on
"autocmd FileType perl set cindent

" reindent pasted text
"nnoremap p  p'[v']= nnoremap P  P'[v']=
"
"
filetype on

autocmd FileType txt set tw=72 fo=cqt wm=0
autocmd FileType mail set tw=72 fo=cqt wm=0
autocmd FileType cpp set tw=80 fo=cqt wm=0
autocmd FileType java set tw=80 fo=cqt wm=0

" Remember 1000 commands and search history
set history=1000
" Use 1000 levels of undo
set undolevels=1000

let perl_want_scope_in_variables=1
let perl_extended_vars=1
let perl_include_pod=1

"set errorformat=%f:%l:%m
"set autowrite

map !F !Gperl -MText::Autoformat -e'autoformat {right =>65}'<CR>

"map Fx !%xmllint --format --recover -
map X :%!xmllint --format --recover -<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set t_Co=256 " 256 colors
:set background=dark
:color grb256

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass 

  autocmd BufNewFile,BufRead *.pig set filetype=pig syntax=pig

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  autocmd Filetype java compiler mvn
  "autocmd Filetype java makeprg=\"mvn compile -q\"
  "autocmd Filetype pom compiler mvn
  "autocmd Filetype java set errorformat=\[ERROR]\ %f:[%l\\,%v]\ %m
  "set makeprg=mvn\ compile\ -q\ -f\ .\pom.xml
  "set errorformat=\[ERROR]\ %f:[%l\\,%v]\ %m

  " Indent p tags
  " autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off
  "au FileType xml exe ":silent %!xmllint --format --recover - 2>/dev/null"

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()
augroup END

"augroup filetypedetect
"    au BufNewFile,BufRead *.pig set filetype=pig syntax=pig
"augroup END 

let Tlist_Auto_Update = 1
let Tlist_Display_Prototype = 1
let Tlist_Compact_Format = 1
let Tlist_Process_File_Always = 1

vnoremap // y/<C-R>"<CR>
