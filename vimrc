" ekoecho's .vimrc
"
" Don't use abbreviations!  Spelling things out makes grepping easy.

" Let Pathogen bring in all the plugins
filetype off
" call pathogen#runtime_append_all_bundles()

runtime macros/matchit.vim  " enable vim's built-in matchit script (% bounces between tags, begin/end, etc)

set nocompatible  " tends to make things work better
set showcmd       " show incomplete cmds down the bottom
set showmode      " show current mode down the bottom

set incsearch     " find the next match as we type the search
set hlsearch      " hilight searches by default
set nowrap        " by default, dont wrap lines (see <leader>w)
set rnu
set number

" set rtp+=~/.vim/bundle/vundle/
" call vundle#rc()
call plug#begin('~/.vim/plugged')

Plug 'gmarik/vundle'
Plug 'Shougo/vimproc', { 'do': 'make' }
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
Plug 'Shougo/unite.vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'tpope/vim-surround'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-unimpaired'
Plug 'digitaltoad/vim-jade'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'pangloss/vim-javascript'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/syntastic'
Plug 'klen/python-mode'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'kien/rainbow_parentheses.vim'
Plug 'nsf/gocode', {'rtp': 'vim/'}
Plug 'fatih/vim-go'
Plug 'vimwiki/vimwiki'
Plug 'benmills/vimux'
Plug 'benmills/vimux-golang'
Plug 'shougo/neocomplete.vim'
Plug 'mattn/emmet-vim'
Plug 'racer-rust/vim-racer'
Plug 'severin-lemaignan/vim-minimap'
Plug 'rust-lang/rust.vim'
Plug 'easymotion/vim-easymotion'

call plug#end()

let mapleader="\<Space>"

" make Y yank to the end of the line (like C and D).  Use yy to yank the entire line.
nmap Y y$

set shiftwidth=2
set softtabstop=2
" ruby code tends to use smaller tabs
autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2
autocmd FileType go setlocal ts=4
" ruby includes ! and ? in method names (array.empty?)
autocmd FileType ruby setlocal iskeyword+=!,?

set expandtab         " use spaces instead of tabstops
set smarttab          " use shiftwidth when hitting tab instead of sts (?)
set autoindent        " try to put the right amount of space at the beginning of a new line
set nostartofline     " don't jump to start of line as a side effect (i.e. <<)
set showmatch         " briefly jump to matching }] when typing

set scrolloff=3       " lines to keep visible before and after cursor
set sidescrolloff=7   " columns to keep visible before and after cursor
set sidescroll=1      " continuous horizontal scroll rather than jumpy

set laststatus=2      " always display status line even if only one window is visible.
" set confirm         " prompt user what to do instead of just failing (i.e. unsaved files)
set updatetime=1000   " reduce updatetime so current tag in taglist is highlighted faster
set autoread          " suppress warnings when git,etc. changes files on disk.


filetype indent plugin on
syntax on

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set backspace=indent,eol,start "allow backspacing over everything in insert mode
set history=1000               "store lots of :cmdline history

set hidden " no need to save before hiding, http://items.sjbach.com/319/configuring-vim-right

" make ' jump to saved line & column rather than just line.
" http://items.sjbach.com/319/configuring-vim-right
nnoremap ' `
nnoremap ` '

set visualbell      " don't beep constantly, it's annoying.
set t_vb=           " and don't flash the screen either (terminal anyway...

set guioptions-=T      " hide toolbar
set guioptions-=m    " hide menu bar
set guioptions-=r    " hide menu bar
set t_ut=
set t_Co=256
set background=dark
colorscheme mustang


" search for a tags file recursively from cwd to /
set tags=.tags,tags;/

" Add a binding to search for the word under the cursor in all files
map <leader>* :execute "noautocmd grep -rw " . expand("<cword>") . " ."<CR>

nmap ¬ :NERDTreeToggle<cr>

" Use Control-/ to toggle comments
nmap <C-/> :call NERDComment(0, "toggle")<CR>
vmap <C-/> <ESC>:call NERDComment(1, "toggle")<CR>
" but most vim implementations produce Control-_ instead of Control-/:
" Mapping C-_ may surprise Hebrew and Farsi programmers...?
nmap <C-_> :call NERDComment(0, "toggle")<CR>
vmap <C-_> <ESC>:call NERDComment(1, "toggle")<CR>
" and vim-gtk and vim-gnome are broken (:help vimsy-control-/)
" you can use <leader>/ to do the same things.
nmap <leader>/ :call NERDComment(0, "toggle")<CR>
vmap <leader>/ <ESC>:call NERDComment(1, "toggle")<CR>
" but maybe <leader>C is nicer to type?
nmap <leader>C  :call NERDComment(0, "toggle")<CR>

" add a space between the comment delimiter and text
let NERDSpaceDelims=1

" Make the quickfix window wrap no matter the setting of nowrap
au BufWinEnter * if &buftype == 'quickfix' | setl wrap | endif

" Press F4 to toggle highlighting on/off, and show current value.
:noremap <F4> :set hlsearch! hlsearch?<CR>

" tell surround not to break the visual s keystroke (:help vs)
xmap S <Plug>Vsurround


" -------

" Make \w toggle through the three wrapping modes.

:function ToggleWrap()
: if (&wrap == 1)
:   if (&linebreak == 0)
:     set linebreak
:   else
:     set nowrap
:   endif
: else
:   set wrap
:   set nolinebreak
: endif
:endfunction

map <leader>w :call ToggleWrap()<CR>
map <leader>t :TagbarToggle <CR>

" The Align plugin declares a TON of maps, few of which are useful.
" Remove the ones which conflict with other uses (like \w for wrapping)
    " unmap <leader>w=
    " unmap <leader>m=
" hm, that didn't work.  turn them all off.
let g:loaded_AlignMapsPlugin = "v41"

let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

let g:pymode_rope = 0


" ------- replace vim's grep with ack
" Disabled by default because it's too different from stock vim behavior.
" Embed ack since most distros haven't caught up to the --column option.

set grepprg=ack-grep
" set grepformat=%f:%l:%c:%m



" Store swapfiles in a single directory.
" Upside: makes mass deleting swapfiles easy, doesn't clutter project dirs
" Downside: you won't be notified if you start editing the same file as someone else.
set directory=~/.vim/swap,~/tmp,/var/tmp/,tmp
au BufNewFile,BufRead *.scss set filetype=css


let g:notes_directory = '~/Dropbox/Notes'

" I'm getting tired of accidentally holding down the shift key...
" Reissue `w` even if I capitalize it...
com W w
com Wq wq
com WQ wq

" Unite
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
" nnoremap <C-p> :Unite file_rec/async<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Unite
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_enable_start_insert = 1
let g:unite_split_rule = "botright"
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 10

call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ ], '\|'))

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <C-P> :<C-u>Unite  -buffer-name=files   -start-insert buffer file_rec/async:!<cr>

autocmd FileType unite call s:unite_settings()

function! s:unite_settings()
  let b:SuperTabDisabled=1
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <silent><buffer><expr> <C-x> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction

nnoremap <space>/ :Unite grep:.<cr>

let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

let g:pymode_folding = 0
let g:pymode_lint_write = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'"

set omnifunc=syntaxcomplete#Complete
au BufWritePost *.go silent! !ctags -R &

let g:go_fmt_command = "goimports"

nnoremap <leader>ft :Unite file_rec/async -default-action=tabopen<cr>
nnoremap <leader>fs :Unite file_rec/async -default-action=split<cr>
nnoremap <leader>fv :Unite file_rec/async -default-action=vsplit<cr>
nnoremap <leader>fc :Unite file_rec/async<cr>
"nnoremap <leader>r !./%<cr>
"
function! GolangRunAll()
    call VimuxRunCommand("cd " . GolangCwd() . "; clear; go run *.go" )
endfunction

function! GolangTestCurrentPackageWithColor()
    call VimuxRunCommand("cd " . GolangCwd() . "; clear; gotest" )
endfunction

map <Leader>r :call VimuxRunCommand("./" . bufname("%"))
map <Leader>gr :call GolangRunAll()<cr>
map <Leader>gg :call GolangRun()<cr>
map <Leader>gt :call GolangTestCurrentPackageWithColor()<cr>
map <leader>cx :call VimuxInterruptRunner()<cr>

let g:neocomplete#enable_at_startup = 1
let g:racer_cmd = "$HOME/.cargo/bin/racer"
let $RUST_SRC_PATH="$HOME/rust/src"


cmap w!! w !sudo tee % >/dev/null
