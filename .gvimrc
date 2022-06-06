if has('mac')
  set guifont=Inconsolata:h14
elseif has('win32')
  set guifont=Source\ Code\ Pro:h11
else
  set guifont=Inconsolata-dz\ 10
  " set guifont=Source\ Code\ Pro\ 10
  " set guifont=Fixedsys\ Excelsior\ 12
  " set guifont=Terminus\ (TTF)\ 12

  " set guifont=Inconsolata\ for\ Powerline\ 12
  " set guifont=Inconsolata\ 10
  " set guifont=DejaVu\ Sans\ Mono\ 10
  " set guifont=RobotoMono\ 10
  " set guifont=Fira\ Code\ 10
  " set guifont=Noto\ Mono\ 10
  " set guifont=Iosevka\ Fixed\ Regular\ 10
  " set guifont=ProggyCleanTT\ 12
  " set guifont=ProggySquareTT\ 12
  " set guifont=Monoid\ 9
  " set guifont=Press\ Start\ 2P\ 6
endif
set guioptions-=T       " hide gui toolbar
set guioptions-=m       " hide gui menu
set guioptions-=l       " hide left scrollbar
set guioptions-=L       " hide left scrollbar when split
set guioptions-=r       " hide right scrollbar
set guioptions-=R       " hide right scrollbar when split
set visualbell t_vb=    " no flash or beep

" ABCDEFGHIJKLMNOPQRSTUVWXYZ
" abcdefghijklmnopqrstuvwxyz
" 0123456789.,""[](){}/!?~+->
