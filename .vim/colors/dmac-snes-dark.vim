hi clear
syntax reset
let g:colors_name = "dmac-snes-dark"

" AirlineTheme base16_ashes
" AirlineTheme base16_grayscale
" AirlineTheme distinguished
" AirlineTheme jellybeans
" AirlineTheme murmur
" AirlineTheme lucius
" AirlineTheme onedark
" AirlineTheme raven
" AirlineTheme ravenpower
" AirlineTheme tomorrow
" AirlineTheme understated

let s:gui00 = "181818" " #181818
let s:gui01 = "242424" " #242424
let s:gui02 = "54585a" " #54585a
let s:gui03 = "707372" " #707372
let s:gui04 = "b2b4b2" " #b2b4b2
let s:gui05 = "dae0f0" " #dae0f0
let s:gui06 = "514689" " #514689
let s:gui07 = "a7a4e0" " #a7a4e0
let s:gui08 = "c1121c" " #c1121c
let s:gui09 = "f7ba0b" " #f7ba0b
let s:gui10 = "007243" " #007243
let s:gui11 = "00387b" " #00387b

" Highlighting function
" Optional variables are attributes and guisp
fun <sid>hi(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
  let l:attr = get(a:, 1, "")
  let l:guisp = get(a:, 2, "")

  if a:guifg != ""
    exec "hi " . a:group . " guifg=#" . a:guifg
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=#" . a:guibg
  endif
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . a:ctermfg
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . a:ctermbg
  endif
  if l:attr != ""
    exec "hi " . a:group . " gui=" . l:attr . " cterm=" . l:attr
  else
    exec "hi " . a:group . " gui=none cterm=none"
  endif
  if l:guisp != ""
    exec "hi " . a:group . " guisp=#" . l:guisp
  endif
endfun

call <sid>hi("Cursor",        s:gui00, s:gui04, "", "", "", "")
call <sid>hi("CursorColumn",  "", s:gui01, "", "", "", "")
call <sid>hi("CursorLine",    "", s:gui01, "", "", "", "")
call <sid>hi("Normal",        s:gui04, s:gui00, "", "", "", "")
call <sid>hi("IncSearch",     s:gui00, s:gui09, "", "", "", "")
call <sid>hi("LineNr",        s:gui03, s:gui01, "", "", "", "")
call <sid>hi("VertSplit",     s:gui01, s:gui01, "", "", "", "")
call <sid>hi("Directory",     s:gui07, s:gui00, "", "", "", "")
call <sid>hi("Visual",        "",      s:gui01, "", "", "", "")
call <sid>hi("ColorColumn",   "",      s:gui01, "", "", "", "")
call <sid>hi("Conceal",       s:gui07, s:gui00, "", "", "", "")
call <sid>hi("NonText",       s:gui03, s:gui00, "", "", "", "")
call <sid>hi("Error",         s:gui00, s:gui07, "", "", "", "")
call <sid>hi("ErrorMsg",      s:gui05, s:gui06, "", "", "", "")
call <sid>hi("PMenu",         s:gui04, s:gui01, "", "", "", "")
call <sid>hi("PMenuSel",      s:gui01, s:gui04, "", "", "", "")
call <sid>hi("PMenuSbar",     s:gui06, s:gui06, "", "", "", "")
call <sid>hi("PMenuThumb",    s:gui07, s:gui07, "", "", "", "")
call <sid>hi("Folded",        s:gui07, s:gui01, "", "", "", "")
call <sid>hi("Question",      s:gui07, "", "", "", "", "")
call <sid>hi("QuickFixLine",  "", s:gui01, "", "", "", "")
call <sid>hi("Search",        s:gui00, s:gui09, "", "", "", "")
call <sid>hi("SpecialKey",    s:gui05, "", "", "", "", "")
call <sid>hi("ModeMsg",       s:gui05, s:gui06, "", "", "", "")
call <sid>hi("MoreMsg",       s:gui07, "", "", "", "", "")
call <sid>hi("StatusLine",    s:gui05, s:gui04, "", "", "", "")
call <sid>hi("StatusLineNC",  s:gui00, s:gui02, "", "", "", "")
call <sid>hi("Title",         s:gui07, "", "", "", "", "")
call <sid>hi("WarningMsg",    s:gui09, "", "", "", "", "")
call <sid>hi("WildMenu",      s:gui00, s:gui09, "", "", "", "")
"DiffAdd
"DiffChange
"DiffDelete
"DiffText
"SpellBad
"SpellLocal
"SpellCap
"SpellRare
"TabLine
"TabLineFill
"TabLineSel

call <sid>hi("Comment",       s:gui07, s:gui00, "", "", "", "")
call <sid>hi("Constant",      s:gui04, s:gui00, "", "", "", "")
call <sid>hi("String",        s:gui03, s:gui00, "", "", "", "")
call <sid>hi("Character",     s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Number",        s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Boolean",       s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Float",         s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Identifier",    s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Function",      s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Statement",     s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Conditional",   s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Repeat",        s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Label",         s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Operator",      s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Keyword",       s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Exception",     s:gui04, s:gui00, "", "", "", "")
call <sid>hi("PreProc",       s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Include",       s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Define",        s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Macro",         s:gui04, s:gui00, "", "", "", "")
call <sid>hi("PreCondit",     s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Type",          s:gui04, s:gui00, "", "", "", "")
call <sid>hi("StorageClass",  s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Structure",     s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Typedef",       s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Special",       s:gui04, s:gui00, "", "", "", "")
call <sid>hi("SpecialChar",   s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Tag",           s:gui07, s:gui00, "", "", "", "")
call <sid>hi("Delimiter",     s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Debug",         s:gui04, s:gui00, "", "", "", "")
call <sid>hi("Todo",          s:gui06, s:gui07, "", "", "", "")
call <sid>hi("Underlined",    s:gui11, s:gui00, "", "", "", "")

delf <sid>hi
unlet s:gui00 s:gui01 s:gui02 s:gui03 s:gui04 s:gui05 s:gui06 s:gui07 s:gui08 s:gui09 s:gui10 s:gui11
