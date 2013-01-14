setlocal omnifunc=necoghc#omnifunc
setlocal tabstop=4
let &softtabstop=&tabstop
setlocal shiftwidth=2

" ghc-mod compiler options
function! s:set_ghcmod_options()
  if !exists('b:ghcmod_ghc_options')
    let b:ghcmod_ghc_options = []
  endif
  if isdirectory("cabal-dev")
    call add(b:ghcmod_ghc_options, '-isrc')
    call add(b:ghcmod_ghc_options, '-i-package-conf'.getcwd().'/cabal-dev/packages-7.4.2.conf')
  endif
endfunction
autocmd BufRead,BufNewFile *.hs call s:set_ghcmod_options()
autocmd BufWritePost *.hs GhcModCheckAndLintAsync
