setlocal omnifunc=necoghc#omnifunc

augroup haskellmode
  autocmd!
  autocmd BufEnter *.hs compiler ghc|set cmdheight=1
augroup end
