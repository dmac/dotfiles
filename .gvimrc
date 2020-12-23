if has('mac')
  set guifont=Inconsolata:h14
elseif has('win32')
  set guifont=DejaVu\ Sans\ Mono:h8
else
  set guifont=Inconsolata\ 12
endif
set guioptions-=T       " hide gui toolbar
set guioptions-=m       " hide gui menu
set visualbell t_vb=    " no flash or beep
