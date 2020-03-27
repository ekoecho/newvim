function! CargoRun()
  call VimuxRunCommand("clear ; cd ".getcwd()."; cargo run")
endfunction


function! CargoTest()
  call VimuxRunCommand("clear ; cd ".getcwd()."; cargo test")
endfunction

function! CargoTestIgnored()
  call VimuxRunCommand("clear ; cd ".getcwd()."; cargo test -- --ignored")
endfunction

map <Leader>rr :wa<CR> :call CargoRun()<CR>
map <Leader>rt :wa<CR> :call CargoTest()<CR>
map <f5> :wa<CR> :call CargoRun()<CR> 
map <f6> :wa<CR> :call CargoTest()<CR> 
map <f7> :wa<CR> :call CargoTestIgnored()<CR> 
