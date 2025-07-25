hi clear
syntax reset
let g:colors_name = "retcon-gameboy"

" Main theme colors:
let s:theme0 = "#081820"
let s:theme1 = "#346856"
let s:theme2 = "#88c070"
let s:theme3 = "#e0f8d0"

let s:bg0 = s:theme0
let s:bg1 = "#0c1c24" " lighten +0x04
let s:sec0 = s:theme1
let s:pri0 = "#b2b2b2"
let s:pri1 = s:theme3
let s:pop0 = s:theme2
let s:uired = "#c1121c"
let s:uiyel = "#f7ba0b"
let s:uigre = "#007243"
let s:uiblu = "#00387b"

let s:cterm00	= "Black"
let s:cterm01	= "DarkBlue"
let s:cterm02	= "DarkGreen"
let s:cterm03	= "DarkCyan"
let s:cterm04	= "DarkRed"
let s:cterm05	= "DarkMagenta"
let s:cterm06	= "Brown" " DarkYellow
let s:cterm07	= "Gray" " LightGray
let s:cterm08	= "DarkGrey"
let s:cterm09	= "Blue" " LightBlue
let s:cterm10	= "Green" " LightGreen
let s:cterm11	= "Cyan" " LightCyan
let s:cterm12	= "Red" " LightRed
let s:cterm13	= "Magenta" " LightMagenta
let s:cterm14	= "Yellow" " LightYellow
let s:cterm15	= "White"

" Highlighting function
fun <sid>hi(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
  if a:guifg != ""
    exec "hi " . a:group . " guifg=" . a:guifg
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=" . a:guibg
  endif
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . a:ctermfg
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . a:ctermbg
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  else
    exec "hi " . a:group . " gui=NONE cterm=NONE"
  endif
  if a:guisp != ""
    exec "hi " . a:group . " guisp=" . a:guisp
  endif
endfun

call <sid>hi("Normal",          s:pri0, s:bg0, "", "", "", "")
call <sid>hi("LineNr",          s:sec0, s:bg0, s:cterm08, "", "", "")
call <sid>hi("Cursor",          s:bg0, s:pri0, "", "", "", "")
call <sid>hi("CursorColumn",    "",    s:bg1, "", "", "", "")
call <sid>hi("CursorLine",      "",    s:bg1, "", "", "", "")
call <sid>hi("CursorLineNr",    s:pri0,s:bg1, "", "", "", "")
call <sid>hi("IncSearch",       s:bg0, s:pri1, "", "", "", "")
call <sid>hi("Search",          s:bg0, s:pri1, "", "", "", "")
call <sid>hi("CurSearch",       s:bg0, s:uiyel, "", "", "", "")
call <sid>hi("VertSplit",       s:bg1, s:bg0, "", "", "", "")
call <sid>hi("WinSeparator",    s:bg1, s:bg0, "", "", "", "")
call <sid>hi("SignColumn",      s:bg0, s:bg0, "", "", "", "")
call <sid>hi("Directory",       s:pop0,s:bg0, "", "", "", "")
call <sid>hi("Visual",          "",    s:bg1, "", "", "", "")
call <sid>hi("ColorColumn",     "",    s:bg1, "", s:cterm00, "", "")
call <sid>hi("Conceal",         s:pri0,s:bg0, "", "", "", "")
call <sid>hi("NonText",         s:sec0, s:bg0, "", "", "", "")
call <sid>hi("EndOfBuffer",     s:bg0, s:bg0, "", "", "", "")
call <sid>hi("ErrorMsg",        s:uired, s:bg0, "", "", "", "")
call <sid>hi("PMenu",           s:pri0, s:bg1, "", "", "", "")
call <sid>hi("PMenuSel",        s:bg1, s:pri0, "", "", "", "")
call <sid>hi("PMenuSbar",       s:bg1, s:bg1, "", "", "", "")
call <sid>hi("PMenuThumb",      s:bg1, s:pop0, "", "", "", "")
call <sid>hi("Folded",          s:pop0, s:bg1, "", "", "", "")
call <sid>hi("Question",        s:pop0, "", "", "", "", "")
call <sid>hi("QuickFixLine",    s:pop0, s:bg1, "", "", "", "")
call <sid>hi("SpecialKey",      s:pri1, "", "", "", "", "")
call <sid>hi("ModeMsg",         s:pri1, s:sec0, "", "", "", "")
call <sid>hi("MoreMsg",         s:pop0, "", "", "", "", "")
call <sid>hi("StatusLine",      s:pri1, s:bg1, "", "", "", "")
call <sid>hi("StatusLineNC",    s:sec0, s:bg0, "", "", "", "")
call <sid>hi("Title",           s:pop0, "", "", "", "", "")
call <sid>hi("MatchParen",      s:pri1, s:bg1, "", "", "", "")
call <sid>hi("WarningMsg",      s:uiyel, "", "", "", "", "")
call <sid>hi("WildMenu",        s:bg0, s:uiyel, "", "", "", "")
call <sid>hi("TabLine",         s:pri0, s:bg1, "", "", "", "")
call <sid>hi("TabLineSel",      s:pri1, s:bg0, "", "", "", "")
call <sid>hi("Added",           s:uigre, s:bg0, "", "", "", "")
call <sid>hi("Changed",         s:pri0, s:bg0, "", "", "", "")
call <sid>hi("Removed",         s:uired, s:bg0, "", "", "", "")
call <sid>hi("DiagnosticError", s:uired, s:bg0, "", "", "", "")
call <sid>hi("DiagnosticWarn",  s:uiyel, s:bg0, "", "", "", "")
call <sid>hi("DiffAdd",         s:uigre, s:bg0, "", "", "", "")
call <sid>hi("DiffChange",      s:pri1, s:bg0, "", "", "", "")
call <sid>hi("DiffDelete",      s:uired, s:bg0, "", "", "", "")
call <sid>hi("DiffText",        s:pri1, s:bg0, "", "", "", "")
call <sid>hi("DiffText",        s:pri1, s:bg0, "", "", "", "")

call <sid>hi("Comment",       s:pop0, "", s:cterm13, "", "", "")
call <sid>hi("Constant",      s:pri0, "", "", "", "", "")
call <sid>hi("String",        s:sec0, "", s:cterm08, "", "", "")
call <sid>hi("Character",     s:pri0, "", "", "", "", "")
call <sid>hi("Number",        s:pri0, "", "", "", "", "")
call <sid>hi("Boolean",       s:pri0, "", "", "", "", "")
call <sid>hi("Float",         s:pri0, "", "", "", "", "")
call <sid>hi("Identifier",    s:pri0, "", s:cterm07, "", "", "")
call <sid>hi("Function",      s:pri0, "", "", "", "", "")
call <sid>hi("Statement",     s:pri0, "", s:cterm07, "", "", "")
call <sid>hi("Conditional",   s:pri0, "", "", "", "", "")
call <sid>hi("Repeat",        s:pri0, "", "", "", "", "")
call <sid>hi("Label",         s:pri0, "", "", "", "", "")
call <sid>hi("Operator",      s:pri0, "", "", "", "", "")
call <sid>hi("Keyword",       s:pri0, "", s:cterm07, "", "", "")
call <sid>hi("Exception",     s:pri0, "", "", "", "", "")
call <sid>hi("PreProc",       s:pri0, "", s:cterm07, "", "", "")
call <sid>hi("Include",       s:pri0, "", "", "", "", "")
call <sid>hi("Define",        s:pri0, "", "", "", "", "")
call <sid>hi("Macro",         s:pri0, "", "", "", "", "")
call <sid>hi("PreCondit",     s:pri0, "", "", "", "", "")
call <sid>hi("Type",          s:pri0, "", s:cterm07, "", "", "")
call <sid>hi("StorageClass",  s:pri0, "", "", "", "", "")
call <sid>hi("Structure",     s:pri0, "", "", "", "", "")
call <sid>hi("Typedef",       s:pri0, "", "", "", "", "")
call <sid>hi("Special",       s:pri0, "", s:cterm07, "", "", "")
call <sid>hi("SpecialChar",   s:pri0, "", "", "", "", "")
call <sid>hi("Tag",           s:pop0, "", "", "", "", "")
call <sid>hi("Delimiter",     s:pri0, "", "", "", "", "")
call <sid>hi("Debug",         s:pri0, "", "", "", "", "")
call <sid>hi("Todo",          s:uiyel, s:bg0, s:cterm13, "none", "", "")
call <sid>hi("Underlined",    s:pri0, "", "", "", "underline", "")
call <sid>hi("Error",         s:uired, s:bg0, "", "", "", "")

delf <sid>hi
unlet s:bg0 s:bg1 s:sec0 s:pri0 s:pri1 s:pop0 s:uired s:uiyel s:uigre s:uiblu
unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03 s:cterm04 s:cterm05 s:cterm06 s:cterm07 s:cterm08 s:cterm09 s:cterm10 s:cterm11 s:cterm12 s:cterm13 s:cterm14 s:cterm15
