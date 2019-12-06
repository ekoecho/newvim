" ekoecho's .vimprc
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
set nowrap        " by default, dont wrap lines (see <leader>w)
set rnu
set number

set clipboard=unnamed


call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-endwise'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-salve'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'tpope/vim-surround'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-unimpaired'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'pangloss/vim-javascript'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/syntastic'
"Plug 'ervandew/supertab'
Plug 'kien/rainbow_parentheses.vim'
Plug 'nsf/gocode', {'rtp': 'vim/'}
Plug 'fatih/vim-go'
Plug 'vimwiki/vimwiki'
Plug 'benmills/vimux'
Plug 'benmills/vimux-golang'
Plug 'rust-lang/rust.vim'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'morhetz/gruvbox'
Plug 'hashivim/vim-terraform'
Plug 'francoiscabrol/ranger.vim'
Plug 'davidhalter/jedi'
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'easymotion/vim-easymotion'
Plug 'Olical/conjure', { 'tag': 'v2.1.0', 'do': 'bin/compile' }




call plug#end()

let mapleader="\<Space>"
let g:SuperTabDefaultCompletionType = "<c-n>"

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
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox


" search for a tags file recursively from cwd to /
set tags=.tags,tags;/

" Add a binding to search for the word under the cursor in all files
map <leader>* :execute "noautocmd grep -rw " . expand("<cword>") . " ."<CR>

nmap ¬ :NERDTreeToggle<cr>
map <leader>` :NERDTreeToggle<cr>

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



set grepprg=rg

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

let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

let g:pymode_folding = 0
let g:pymode_lint_write = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'"

"set omnifunc=syntaxcomplete#Complete
au BufWritePost *.go silent! !ctags -R &

let g:go_fmt_command = "goimports"

function! TerragruntPlan()
    call VimuxRunCommand("clear; terragrunt plan --terragrunt-source ../../../../../../terraform-aws-mongodb" )
endfunction

function! TerragruntApply()
    call VimuxRunCommand("clear; terragrunt apply --terragrunt-source ../../../../../../terraform-aws-mongodb" )
endfunction

map <leader>cx :call VimuxInterruptRunner()<cr>
map <Leader>y :call TerragruntPlan()<cr>
map <Leader>Y :call TerragruntApply()<cr>
map <leader>wx :call NoDistractions()<cr>


cmap w!! w !sudo tee % >/dev/null

let g:terraform_fmt_on_save=1
let g:terraform_align=1
set completeopt=longest,menu,menuone  

" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

nmap <C-p> :Files<cr>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>' :Marks<CR>

let g:rustfmt_autosave = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

set fdm=syntax
nnoremap <expr> <f2> &foldlevel ? 'zM' :'zR'
set foldlevelstart=20


