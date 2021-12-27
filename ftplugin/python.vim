setlocal makeprg=python3\ %


map <Leader>r :call VimuxRunCommand("python3 " . bufname("%"))<CR>
