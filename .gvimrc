if has('mac')
  set guifont=Inconsolata\ for\ Powerline:h14
elseif has('win32')
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h8
else
  set guifont=Inconsolata\ for\ Powerline\ 10
endif
set guioptions-=T       " hide gui toolbar
set guioptions-=m       " hide gui menu
set visualbell t_vb=    " no flash or beep
