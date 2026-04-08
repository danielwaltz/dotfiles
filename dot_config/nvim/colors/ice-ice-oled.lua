local palette = {
  bg = "#000000",
  bg_float = "#050a0d",
  bg_panel = "#05222c",
  bg_line = "#070e12",
  bg_visual = "#1a2530",
  bg_menu = "#1a3038",
  bg_search = "#004f6f",
  bg_incsearch = "#00a2cf",
  bg_tab = "#112a36",
  fg = "#b5d0df",
  fg_alt = "#b0c4d0",
  fg_bright = "#d3e6ef",
  white = "#f9fdff",
  comment = "#5b6266",
  inactive = "#485b66",
  line_nr = "#395466",
  line_nr_active = "#6c9dbe",
  border = "#112a36",
  blue = "#71c7eb",
  cyan = "#67c5ed",
  teal = "#56c5c5",
  aqua = "#46afff",
  type = "#abbfce",
  number = "#a3cae0",
  variable = "#e6f1f6",
  property = "#d3e6ef",
  muted = "#5c7688",
  warn = "#e6df7e",
  error = "#b25757",
  hint = "#3b9267",
  add = "#026f73",
  delete = "#8e015a",
}

vim.o.termguicolors = true
vim.cmd("hi clear")

if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "ice-ice-oled"

local set = vim.api.nvim_set_hl
local function hi(group, spec)
  set(0, group, spec)
end

local function link(from, to)
  hi(from, { link = to })
end

hi("Normal", { fg = palette.fg, bg = palette.bg })
hi("NormalFloat", { fg = palette.fg_alt, bg = palette.bg_float })
hi("FloatBorder", { fg = palette.border, bg = palette.bg_float })
hi("ColorColumn", { bg = palette.bg_line })
hi("CursorLine", { bg = palette.bg_line })
hi("CursorLineNr", { fg = palette.line_nr_active, bg = palette.bg_line, bold = true })
hi("LineNr", { fg = palette.line_nr, bg = palette.bg })
hi("SignColumn", { fg = palette.line_nr, bg = palette.bg })
hi("WinSeparator", { fg = palette.border, bg = palette.bg })
hi("VertSplit", { fg = palette.border, bg = palette.bg })
hi("EndOfBuffer", { fg = palette.bg, bg = palette.bg })
hi("Visual", { bg = palette.bg_visual })
hi("Search", { fg = palette.white, bg = palette.bg_search })
hi("IncSearch", { fg = palette.white, bg = palette.bg_incsearch, bold = true })
hi("MatchParen", { fg = palette.white, bg = "#10312a", bold = true })
hi("Pmenu", { fg = palette.fg_alt, bg = palette.bg_float })
hi("PmenuSel", { fg = "#d0e0e8", bg = palette.bg_menu })
hi("PmenuSbar", { bg = "#0a1218" })
hi("PmenuThumb", { bg = "#537aa2" })
hi("StatusLine", { fg = palette.fg_alt, bg = palette.bg_tab })
hi("StatusLineNC", { fg = "#5a6a75", bg = palette.bg })
hi("TabLine", { fg = palette.inactive, bg = palette.bg })
hi("TabLineFill", { fg = palette.inactive, bg = palette.bg })
hi("TabLineSel", { fg = "#c8d8e4", bg = palette.bg_tab })
hi("Directory", { fg = "#93bdea" })
hi("Title", { fg = palette.aqua, bold = true })
hi("Comment", { fg = palette.comment })
hi("Constant", { fg = "#b0c8d8" })
hi("String", { fg = "#7ec5e4" })
hi("Character", { fg = "#b0c8d8" })
hi("Number", { fg = palette.number })
hi("Boolean", { fg = "#b0c8d8" })
hi("Float", { fg = palette.number })
hi("Identifier", { fg = palette.variable })
hi("Function", { fg = palette.blue })
hi("Statement", { fg = "#92a4ae" })
hi("Conditional", { fg = "#92a4ae" })
hi("Repeat", { fg = "#92a4ae" })
hi("Label", { fg = "#93bdea" })
hi("Operator", { fg = "#92a4ae" })
hi("Keyword", { fg = palette.cyan })
hi("Exception", { fg = palette.cyan })
hi("PreProc", { fg = "#477d96" })
hi("Include", { fg = palette.cyan })
hi("Define", { fg = palette.cyan })
hi("Macro", { fg = palette.blue })
hi("PreCondit", { fg = "#477d96" })
hi("Type", { fg = palette.type })
hi("StorageClass", { fg = "#a1cae1" })
hi("Structure", { fg = palette.type })
hi("Typedef", { fg = "#a1cae1" })
hi("Special", { fg = palette.teal })
hi("SpecialChar", { fg = palette.teal })
hi("Tag", { fg = "#93bdea" })
hi("Delimiter", { fg = palette.muted })
hi("SpecialComment", { fg = palette.comment, italic = true })
hi("Underlined", { fg = palette.aqua, underline = true })
hi("Todo", { fg = palette.bg, bg = "#eccc3e", bold = true })
hi("Error", { fg = "#a57575", bold = true })
hi("ErrorMsg", { fg = "#a57575", bg = palette.bg, bold = true })
hi("WarningMsg", { fg = palette.warn, bg = palette.bg, bold = true })
hi("DiagnosticError", { fg = palette.error })
hi("DiagnosticWarn", { fg = palette.warn })
hi("DiagnosticInfo", { fg = palette.teal })
hi("DiagnosticHint", { fg = palette.hint })
hi("DiffAdd", { fg = palette.fg, bg = palette.add })
hi("DiffChange", { fg = palette.fg, bg = "#112734" })
hi("DiffDelete", { fg = palette.error, bg = palette.delete })
hi("DiffText", { fg = palette.white, bg = palette.bg_search })
hi("GitSignsAdd", { fg = "#1bc74c" })
hi("GitSignsChange", { fg = "#0c9bdd" })
hi("GitSignsDelete", { fg = "#fc5252" })

link("@comment", "Comment")
link("@constant", "Constant")
link("@string", "String")
link("@string.escape", "SpecialChar")
link("@character", "Character")
link("@number", "Number")
link("@boolean", "Boolean")
link("@float", "Float")
link("@function", "Function")
link("@function.builtin", "Function")
link("@method", "Function")
link("@constructor", "Type")
link("@parameter", "Identifier")
link("@parameter.reference", "Identifier")
link("@variable", "Identifier")
link("@variable.builtin", "Identifier")
link("@property", "Identifier")
link("@field", "Identifier")
link("@keyword", "Keyword")
link("@keyword.function", "Keyword")
link("@keyword.operator", "Operator")
link("@operator", "Operator")
link("@punctuation", "Delimiter")
link("@punctuation.bracket", "Delimiter")
link("@type", "Type")
link("@type.builtin", "Type")
link("@type.definition", "Type")
link("@namespace", "Type")
link("@tag", "Tag")
link("@tag.attribute", "Identifier")
link("@attribute", "Identifier")
