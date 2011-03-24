if exists("b:did_ftplugin_php")
  finish
endif
let b:did_ftplugin_php = 1

nmap <buffer>,l :call PHPLint()<CR>

function! PHPLint()
  echo system('php -l '.bufname(""))
endfunction

setlocal ts=4 sts=4 sw=4
