set guifont=あくあフォント:h12
set guifontwide=あくあフォント:h12
colorscheme twilight
set transparency=2
"set antialias
set cmdheight=1
set guioptions-=T 
set guioptions-=r
set guioptions-=l
set guioptions-=L
set guioptions-=R
set fuopt+=maxhorz

function! ToggleFont()
    if &guifont=~"あくあフォント"
        set guifont=
        set guifontwide=
    else
        set guifont=あくあフォント:h12
        set guifontwide=あくあフォント:h12
    endif
endfunction
command! ToggleFont :call ToggleFont()

