set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "dmac"

"let s:bg = '#111111'
"let s:bg1 = '#151515'
"let s:fg = '#eeeeee'
"let s:lightbg = '#444444'
"let s:darkfg = '#777777'
"let s:comment = 'SeaGreen'
"
"exec 'hi Normal guifg='.s:fg.' guibg='.s:bg
"exec 'hi Visual guibg='.s:lightbg
"exec 'hi LineNr guifg='.s:darkfg.' guibg='.s:bg1
"exec 'hi CursorLineNr guifg='.s:darkfg
"exec 'hi NonText guifg='.s:darkfg
"exec 'hi VertSplit gui=bold guifg='.s:bg.' guibg='.s:bg
"exec 'hi Error guifg='.s:darkfg.' guibg='.s:bg
"exec 'hi Search guifg='.s:fg.' guibg='.s:lightbg
"exec 'hi Pmenu guibg='.s:lightbg
"exec 'hi MatchParen guibg='.s:lightbg
"exec 'hi ColorColumn guibg='.s:bg1
"
"exec 'hi Keyword guifg='.s:fg
"exec 'hi Statement guifg='.s:fg
"exec 'hi Type guifg='.s:fg
"exec 'hi Constant guifg='.s:fg
"exec 'hi Identifier guifg='.s:fg
"exec 'hi PreProc guifg='.s:fg
"exec 'hi Special guifg='.s:fg
"
"exec 'hi Comment guifg='.s:comment
"exec 'hi Todo guifg='.s:fg.' guibg='.s:comment

" ---------------------------------

let s:grey0 = '#111111'
let s:grey1 = '#151515'
let s:grey2 = '#444444'

let s:white0 = '#eeeeee'
let s:white1 = '#777777'

let s:comment = 'SeaGreen'
let s:red = '#eebbbb'
let s:green = '#bbeebb'
let s:blue = '#bbbbee'

exec 'hi Normal guifg='.s:white0.' guibg='.s:grey0
exec 'hi Error guifg='.s:white1.' guibg='.s:grey0
exec 'hi Search guifg='.s:grey0.' guibg='.s:white1
exec 'hi Keyword guifg='.s:blue
exec 'hi Type guifg='.s:red
exec 'hi Identifier guifg='.s:red
exec 'hi Constant guifg='.s:red
exec 'hi String guifg='.s:green
exec 'hi Statement guifg='.s:blue
exec 'hi PreProc guifg='.s:blue
exec 'hi Special guifg='.s:blue

exec 'hi LineNr guifg='.s:white1.' guibg='.s:grey1
exec 'hi CursorLineNr guifg='.s:white1
exec 'hi NonText guifg='.s:white1

exec 'hi Visual guibg='.s:grey2
exec 'hi Pmenu guibg='.s:grey1
exec 'hi MatchParen guibg='.s:grey1
exec 'hi ColorColumn guibg='.s:grey1

exec 'hi Comment guifg='.s:comment
exec 'hi Todo guifg='.s:white0.' guibg='.s:comment

exec 'hi VertSplit gui=bold guifg='.s:grey0.' guibg='.s:grey0
