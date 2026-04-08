set background=dark
if has("termguicolors")
  set termguicolors
endif

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "ice-ice-oled"

hi Normal guifg=#B5D0DF guibg=#000000 gui=NONE cterm=NONE
hi NormalFloat guifg=#B0C4D0 guibg=#050A0D gui=NONE cterm=NONE
hi FloatBorder guifg=#112A36 guibg=#050A0D gui=NONE cterm=NONE
hi ColorColumn guibg=#070E12 gui=NONE cterm=NONE
hi CursorLine guibg=#070E12 gui=NONE cterm=NONE
hi CursorLineNr guifg=#6C9DBE guibg=#070E12 gui=bold cterm=bold
hi LineNr guifg=#395466 guibg=#000000 gui=NONE cterm=NONE
hi SignColumn guifg=#395466 guibg=#000000 gui=NONE cterm=NONE
hi VertSplit guifg=#112A36 guibg=#000000 gui=NONE cterm=NONE
hi WinSeparator guifg=#112A36 guibg=#000000 gui=NONE cterm=NONE
hi EndOfBuffer guifg=#000000 guibg=#000000 gui=NONE cterm=NONE
hi Visual guibg=#1A2530 gui=NONE cterm=NONE
hi Search guifg=#FFFFFF guibg=#004F6F gui=NONE cterm=NONE
hi IncSearch guifg=#FFFFFF guibg=#00A2CF gui=bold cterm=bold
hi MatchParen guifg=#FFFFFF guibg=#10312A gui=bold cterm=bold
hi Pmenu guifg=#B0C4D0 guibg=#050A0D gui=NONE cterm=NONE
hi PmenuSel guifg=#D0E0E8 guibg=#1A3038 gui=NONE cterm=NONE
hi PmenuSbar guibg=#0A1218 gui=NONE cterm=NONE
hi PmenuThumb guibg=#537AA2 gui=NONE cterm=NONE
hi StatusLine guifg=#B0C4D0 guibg=#112A36 gui=NONE cterm=NONE
hi StatusLineNC guifg=#5A6A75 guibg=#000000 gui=NONE cterm=NONE
hi TabLine guifg=#485B66 guibg=#000000 gui=NONE cterm=NONE
hi TabLineFill guifg=#485B66 guibg=#000000 gui=NONE cterm=NONE
hi TabLineSel guifg=#C8D8E4 guibg=#112A36 gui=NONE cterm=NONE
hi Directory guifg=#93BDEA guibg=NONE gui=NONE cterm=NONE
hi Title guifg=#46AFFF guibg=NONE gui=bold cterm=bold
hi Comment guifg=#5B6266 guibg=NONE gui=NONE cterm=NONE
hi Constant guifg=#B0C8D8 guibg=NONE gui=NONE cterm=NONE
hi String guifg=#7EC5E4 guibg=NONE gui=NONE cterm=NONE
hi Character guifg=#B0C8D8 guibg=NONE gui=NONE cterm=NONE
hi Number guifg=#A3CAE0 guibg=NONE gui=NONE cterm=NONE
hi Boolean guifg=#B0C8D8 guibg=NONE gui=NONE cterm=NONE
hi Float guifg=#A3CAE0 guibg=NONE gui=NONE cterm=NONE
hi Identifier guifg=#E6F1F6 guibg=NONE gui=NONE cterm=NONE
hi Function guifg=#71C7EB guibg=NONE gui=NONE cterm=NONE
hi Statement guifg=#92A4AE guibg=NONE gui=NONE cterm=NONE
hi Conditional guifg=#92A4AE guibg=NONE gui=NONE cterm=NONE
hi Repeat guifg=#92A4AE guibg=NONE gui=NONE cterm=NONE
hi Label guifg=#93BDEA guibg=NONE gui=NONE cterm=NONE
hi Operator guifg=#92A4AE guibg=NONE gui=NONE cterm=NONE
hi Keyword guifg=#67C5ED guibg=NONE gui=NONE cterm=NONE
hi Exception guifg=#67C5ED guibg=NONE gui=NONE cterm=NONE
hi PreProc guifg=#477D96 guibg=NONE gui=NONE cterm=NONE
hi Include guifg=#67C5ED guibg=NONE gui=NONE cterm=NONE
hi Define guifg=#67C5ED guibg=NONE gui=NONE cterm=NONE
hi Macro guifg=#71C7EB guibg=NONE gui=NONE cterm=NONE
hi PreCondit guifg=#477D96 guibg=NONE gui=NONE cterm=NONE
hi Type guifg=#ABBFCE guibg=NONE gui=NONE cterm=NONE
hi StorageClass guifg=#A1CAE1 guibg=NONE gui=NONE cterm=NONE
hi Structure guifg=#ABBFCE guibg=NONE gui=NONE cterm=NONE
hi Typedef guifg=#A1CAE1 guibg=NONE gui=NONE cterm=NONE
hi Special guifg=#56C5C5 guibg=NONE gui=NONE cterm=NONE
hi SpecialChar guifg=#56C5C5 guibg=NONE gui=NONE cterm=NONE
hi Tag guifg=#93BDEA guibg=NONE gui=NONE cterm=NONE
hi Delimiter guifg=#5C7688 guibg=NONE gui=NONE cterm=NONE
hi SpecialComment guifg=#5B6266 guibg=NONE gui=italic cterm=italic
hi Underlined guifg=#46AFFF guibg=NONE gui=underline cterm=underline
hi Todo guifg=#000000 guibg=#ECCC3E gui=bold cterm=bold
hi Error guifg=#A57575 guibg=NONE gui=bold cterm=bold
hi ErrorMsg guifg=#A57575 guibg=#000000 gui=bold cterm=bold
hi WarningMsg guifg=#E6DF7E guibg=#000000 gui=bold cterm=bold
hi DiagnosticError guifg=#B25757 guibg=NONE gui=NONE cterm=NONE
hi DiagnosticWarn guifg=#E6DF7E guibg=NONE gui=NONE cterm=NONE
hi DiagnosticInfo guifg=#56C5C5 guibg=NONE gui=NONE cterm=NONE
hi DiagnosticHint guifg=#3B9267 guibg=NONE gui=NONE cterm=NONE
hi DiffAdd guifg=#B5D0DF guibg=#026F73 gui=NONE cterm=NONE
hi DiffChange guifg=#B5D0DF guibg=#112734 gui=NONE cterm=NONE
hi DiffDelete guifg=#B25757 guibg=#8E015A gui=NONE cterm=NONE
hi DiffText guifg=#FFFFFF guibg=#004F6F gui=NONE cterm=NONE
