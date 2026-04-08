let s:bg = '#000000'
let s:bg_tab = '#112A36'
let s:bg_line = '#070E12'
let s:fg = '#B5D0DF'
let s:fg_alt = '#B0C4D0'
let s:inactive = '#5A6A75'
let s:blue = '#71C7EB'
let s:cyan = '#67C5ED'
let s:teal = '#56C5C5'
let s:warn = '#E6DF7E'
let s:error = '#B25757'

let g:airline#themes#ice_ice_oled#palette = {}

let s:N1 = [s:bg, s:blue, 16, 81]
let s:N2 = [s:fg_alt, s:bg_tab, 252, 24]
let s:N3 = [s:fg, s:bg_line, 254, 233]
let g:airline#themes#ice_ice_oled#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#ice_ice_oled#palette.normal_modified = {
      \ 'airline_c': [s:warn, s:bg_line, 228, 233, 'bold']
      \ }

let s:I1 = [s:bg, s:cyan, 16, 45]
let s:I2 = [s:fg_alt, s:bg_tab, 252, 24]
let s:I3 = [s:fg, s:bg_line, 254, 233]
let g:airline#themes#ice_ice_oled#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)

let s:R1 = [s:bg, s:error, 16, 131]
let s:R2 = [s:fg_alt, s:bg_tab, 252, 24]
let s:R3 = [s:fg, s:bg_line, 254, 233]
let g:airline#themes#ice_ice_oled#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)

let s:V1 = [s:bg, s:teal, 16, 80]
let s:V2 = [s:fg_alt, s:bg_tab, 252, 24]
let s:V3 = [s:fg, s:bg_line, 254, 233]
let g:airline#themes#ice_ice_oled#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)

let s:IA1 = [s:inactive, s:bg_line, 245, 233]
let s:IA2 = [s:inactive, s:bg, 245, 16]
let s:IA3 = [s:inactive, s:bg, 245, 16]
let g:airline#themes#ice_ice_oled#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)

let g:airline#themes#ice_ice_oled#palette.accents = {
      \ 'red': [s:error, '', 131, '', 'bold']
      \ }
