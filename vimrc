" ekoecho's .vimprc

" Let Pathogen bring in all the plugins
filetype off

runtime macros/matchit.vim  " enable vim's built-in matchit script (% bounces between tags, begin/end, etc)

set nocompatible  " tends to make things work better
set showcmd       " show incomplete cmds down the bottom
set showmode      " show current mode down the bottom

set incsearch     " find the next match as we type the search
set nowrap        " by default, dont wrap lines (see <leader>w)
set rnu
set number
set undofile
set undodir=~/.vim/undodir
set termguicolors     " enable true colors support


let mapleader="\<Space>"

set shiftwidth=2
set softtabstop=2
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



"set clipboard=unnamed


call plug#begin('~/.vim/plugged')
Plug 'glepnir/dashboard-nvim'
Plug 'glepnir/lspsaga.nvim'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-symbols.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

Plug 'hoob3rt/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'
"Plug 'ryanoasis/vim-devicons'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'Raimondi/delimitMate'
Plug 'nsf/gocode', {'rtp': 'vim/'}
"Plug 'fatih/vim-go'
Plug 'vimwiki/vimwiki'
Plug 'benmills/vimux'
Plug 'benmills/vimux-golang'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'morhetz/gruvbox'
Plug 'hashivim/vim-terraform'

call plug#end()


filetype indent plugin on
syntax on

set wildmode=longest:full,full   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set backspace=indent,eol,start "allow backspacing over everything in insert mode
set history=1000               "store lots of :cmdline history

set hidden " no need to save before hiding, http://items.sjbach.com/319/configuring-vim-right

" make ' jump to saved line & column rather than just line.
" http://items.sjbach.com/319/configuring-vim-right
nnoremap ' `
nnoremap ` '

nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>

noremap <C-6> <C-^>

set visualbell      " don't beep constantly, it's annoying.
set t_vb=           " and don't flash the screen either (terminal anyway...

set guioptions-=T      " hide toolbar
set guioptions-=m    " hide menu bar
set guioptions-=r    " hide menu bar
set t_ut=
"set t_Co=256
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

" The Align plugin declares a TON of maps, few of which are useful.
" Remove the ones which conflict with other uses (like \w for wrapping)
" unmap <leader>w=
" unmap <leader>m=
" hm, that didn't work.  turn them all off.
let g:loaded_AlignMapsPlugin = "v41"

let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

set grepprg=rg

" Store swapfiles in a single directory.
" Upside: makes mass deleting swapfiles easy, doesn't clutter project dirs
" Downside: you won't be notified if you start editing the same file as someone else.
set directory=~/.vim/swap,~/tmp,/var/tmp/,tmp
au BufNewFile,BufRead *.scss set filetype=css


" I'm getting tired of accidentally holding down the shift key...
" Reissue `w` even if I capitalize it...
com W w
com Wq wq
com WQ wq

"set omnifunc=syntaxcomplete#Complete
au BufWritePost *.go silent! !ctags -R &

let g:go_fmt_command = "goimports"

cmap w!! w !sudo tee % >/dev/null

let g:terraform_fmt_on_save=1
let g:terraform_align=1
set completeopt=longest,menu,menuone  

" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction


nmap <C-p> :Telescope find_files<cr>
nmap <Leader>b :Telescope buffers<CR>
nmap <Leader>h :History<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>' :Marks<CR>

let g:rustfmt_autosave = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


set fdm=syntax
nnoremap <expr> <f2> &foldlevel ? 'zM' :'zR'
set foldlevelstart=20

let g:dashboard_default_executive = "telescope"
let g:dashboard_custom_header = [
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
\]

if has('nvim')

  "Let the input go up and the search list go down
  let $FZF_DEFAULT_OPTS = '--layout=reverse'

  "Open FZF and choose floating window
  let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }




  function! OpenFloatingWin()
    let height = &lines - 3
    let width = float2nr(&columns - (&columns * 2 / 10))
    let col = float2nr((&columns - width) / 2)

    "Set the position, size, etc. of the floating window.
    "The size configuration here may not be so flexible, and there's room for further improvement.
    let opts = {
          \ 'relative': 'editor',
          \ 'row': height * 0.3,
          \ 'col': col + 30,
          \ 'width': width * 2 / 3,
          \ 'height': height / 2
          \ }

    let buf = nvim_create_buf(v:false, v:true)
    let win = nvim_open_win(buf, v:true, opts)

    "Set Floating Window Highlighting
    call setwinvar(win, '&winhl', 'Normal:Pmenu')

    setlocal
          \ buftype=nofile
          \ nobuflisted
          \ bufhidden=hide
          \ nonumber
          \ norelativenumber
          \ signcolumn=no
  endfunction
endif

