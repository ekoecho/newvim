set makeprg=go\ run\ *.go
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

