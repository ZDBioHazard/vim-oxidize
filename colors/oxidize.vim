" Vim color file
" File: oxidize.vim
" Description: A Vim color scheme inspired by the old 'Oblivion' GEdit theme
" Author: Ryan Turner <zdbiohazard2@gmail.com>
" Source: https://github.com/ZDBioHazard/vim-oxidize

set background=dark
highlight clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = "oxidize"

" ----------------------------------------------------------------------------
"  Define some helper functions
" ----------------------------------------------------------------------------

function! s:hi(group, style)
    let l:cmd = ''
    if has_key(a:style, 'fg')
        let l:cmd .= ' guifg='.a:style['fg'][0].' ctermfg='.a:style['fg'][1]
    endif
    if has_key(a:style, 'bg')
        let l:cmd .= ' guibg='.a:style['bg'][0].' ctermbg='.a:style['bg'][1]
    endif
    if has_key(a:style, 'st') && a:style['st'] != 'none'
        let l:cmd .= ' gui='.a:style['st'].' cterm='.a:style['st']
    endif

    execute 'highlight! clear '.a:group
    execute 'highlight! '.a:group.l:cmd
endfunction

function! s:ln(group, target)
    execute 'highlight! clear '.a:group
    execute 'highlight! link '.a:group.' '.a:target
endfunction

function! s:gray(level)
    if a:level <= 0
        return ['#000000', 16]
    elseif a:level >= 25
        return ['#FFFFFF', 231]
    endif

    let l:value = 0x08 + (10 * (a:level - 1)) " Generate the X11 gray value
    return [printf('#%02X%02X%02X', l:value, l:value, l:value), a:level + 231]
endfunction

function! s:config_default(name, value)
    if !exists(a:name)
        execute 'let '.a:name.' = '.a:value
    endif
endfunction

" ----------------------------------------------------------------------------
"  User-defined options
" ----------------------------------------------------------------------------

call s:config_default('g:oxidize_brightness', 2)
call s:config_default('g:oxidize_transparent', 0)
call s:config_default('g:oxidize_use_bold', 1)
call s:config_default('g:oxidize_use_italic', 1)

" ----------------------------------------------------------------------------
"  Define the color palette
" ----------------------------------------------------------------------------

" A Tango-ish palette, adapted to the xterm-256color palette as best I could
let s:butter    = [['#FFFF87', 228], ['#FFD700', 220], ['#D7AF00', 178]]
let s:orange    = [['#FFAF5F', 215], ['#FF8700', 208], ['#D75F00', 166]]
let s:chocolate = [['#D7AF5F', 179], ['#AF875F', 137], ['#875F00',  94]]
let s:scarlet   = [['#D70000', 160], ['#AF0000', 124], ['#870000',  88]]
let s:chameleon = [['#87FF00', 118], ['#87D700', 112], ['#5FAF00',  70]]
let s:skyblue   = [['#5FAFFF',  75], ['#0087AF',  31], ['#005FAF',  25]]
let s:plum      = [['#AF87AF', 139], ['#875F87',  96], ['#5F00AF',  55]]

" Clamp the brightness to a 'reasonable' value
let s:brightness = max([0, min([8, g:oxidize_brightness])])

" Set all the grays that are related to the background brightness
let s:fgcolor  = s:gray(25)
let s:bgcolor  = g:oxidize_transparent ? ['none', 'none'] :
               \ s:gray(s:brightness +  0)
let s:guides = [ s:gray(s:brightness +  1),
               \ s:gray(s:brightness +  2) ]
let s:gutter   = s:gray(s:brightness +  2)
let s:frames   = s:gray(s:brightness +  4)
let s:selected = s:gray(s:brightness +  6)
let s:nontext  = s:gray(s:brightness +  8)
let s:comment  = s:gray(s:brightness + 12)
let s:inactive = s:gray(s:brightness + 14)

" Common color aliases
let s:active   = s:butter[2]
let s:folded   = s:plum[0]

let s:hint     = s:chocolate[0]
let s:info     = s:skyblue[1]
let s:warning  = s:butter[1]
let s:error    = s:scarlet[0]

let s:added    = s:chameleon[1]
let s:changed  = s:butter[1]
let s:deleted  = s:scarlet[0]

" Define the configured bold and italic aliases
let s:bold   = g:oxidize_use_bold   ? 'bold'   : 'none'
let s:italic = g:oxidize_use_italic ? 'italic' : 'none'

" ----------------------------------------------------------------------------
"  Vim user interface
" ----------------------------------------------------------------------------

call s:hi('Normal',       {'fg': s:fgcolor,  'bg': s:bgcolor})
call s:hi('StatusLine',   {'fg': s:active,   'bg': s:frames})
call s:hi('StatusLineNC', {'fg': s:inactive, 'bg': s:frames})
call s:hi('VertSplit',    {'fg': s:frames,   'bg': s:frames})
call s:hi('LineNr',       {'fg': s:inactive, 'bg': s:frames})
call s:hi('SignColumn',   {'fg': s:inactive, 'bg': s:gutter})
call s:hi('CursorLine',   {                  'bg': s:gutter})
call s:hi('CursorLineNr', {'fg': s:active,   'bg': s:gutter, 'st': s:bold})
call s:hi('ModeMsg',      {'fg': s:frames,   'bg': s:active})
call s:hi('Pmenu',        {'fg': s:inactive, 'bg': s:gutter})
call s:hi('PmenuSel',     {'fg': s:active,   'bg': s:frames})
call s:hi('PmenuSbar',    {                  'bg': s:frames})
call s:hi('PmenuThumb',   {                  'bg': s:active})

call s:ln('CursorColumn', 'CursorLine')
call s:ln('ColorColumn',  'CursorLine')
call s:ln('FoldColumn',   'SignColumn')
call s:ln('TabLineFill',  'SignColumn')
call s:ln('TabLineSel',   'StatusLine')
call s:ln('TabLine',      'StatusLineNC')
call s:ln('WildMenu',     'Pmenu')

" Editor features
call s:hi('Directory', {'fg': s:chocolate[0]})
call s:hi('Error',     {'fg': s:fgcolor, 'bg': s:error})
call s:hi('Folded',    {'fg': s:folded})
call s:hi('NonText',   {'fg': s:nontext})
call s:hi('Search',    {'fg': s:fgcolor, 'bg': s:plum[1]})
call s:hi('SpellBad',  {'st': 'underline'})
call s:hi('Todo',      {'fg': s:error, 'bg': s:warning, 'st': s:bold})
call s:hi('Visual',    {'fg': s:fgcolor, 'bg': s:selected})

call s:ln('Conceal',    'NonText')
call s:ln('SpellCap',   'SpellBad')
call s:ln('SpellLocal', 'SpellBad')
call s:ln('SpellRare',  'SpellBad')
call s:ln('IncSearch',  'Search')
call s:ln('MatchParen', 'Search')
call s:ln('VisualNOS',  'Visual')

" Information
call s:hi('MoreMsg',    {'fg': s:hint,    'bg': s:gutter})
call s:hi('Question',   {'fg': s:info,    'bg': s:gutter})
call s:hi('WarningMsg', {'fg': s:warning, 'bg': s:gutter, 'st': s:bold})
call s:hi('ErrorMsg',   {'fg': s:error,   'bg': s:gutter, 'st': s:bold})

call s:hi('DiffAdd',    {'fg': s:added})
call s:hi('DiffChange', {'fg': s:changed})
call s:hi('DiffDelete', {'fg': s:deleted})

call s:hi('DiagnosticHint',  {'fg': s:hint})
call s:hi('DiagnosticInfo',  {'fg': s:info})
call s:hi('DiagnosticWarn',  {'fg': s:warning})
call s:hi('DiagnosticError', {'fg': s:error})

" ----------------------------------------------------------------------------
"  Common syntax
" ----------------------------------------------------------------------------

call s:hi('Brace',      {'fg': s:chocolate[0]})
call s:hi('Comment',    {'fg': s:comment, 'st': s:italic})
call s:hi('Function',   {'fg': s:butter[0]})
call s:hi('Identifier', {'fg': s:skyblue[0]})
call s:hi('Number',     {'fg': s:orange[2]})
call s:hi('Operator',   {'fg': s:chameleon[1]})
call s:hi('PreProc',    {'fg': s:plum[0]})
call s:hi('Statement',  {'fg': s:orange[1]})
call s:hi('String',     {'fg': s:butter[1]})
call s:hi('Variable',   {'fg': s:gray(21)})

call s:ln('Delimiter',    'Brace')
call s:ln('Keyword',      'Identifier')
call s:ln('Structure',    'Identifier')
call s:ln('Type',         'Identifier')
call s:ln('Title',        'Normal')
call s:ln('Boolean',      'Number')
call s:ln('Float',        'Number')
call s:ln('Special',      'Number')
call s:ln('SpecialChar',  'Number')
call s:ln('SpecialKey',   'Number')
call s:ln('Constant',     'PreProc')
call s:ln('Define',       'PreProc')
call s:ln('Include',      'PreProc')
call s:ln('Macro',        'PreProc')
call s:ln('PreCondit',    'PreProc')
call s:ln('Conditional',  'Statement')
call s:ln('Exception',    'Statement')
call s:ln('Label',        'Statement')
call s:ln('Repeat',       'Statement')
call s:ln('StorageClass', 'Statement')
call s:ln('Typedef',      'Statement')
call s:ln('Character',    'String')

" ----------------------------------------------------------------------------
"  Colors for specific languages
" ----------------------------------------------------------------------------

" CSS syntax
call s:ln('cssBraces',       'Brace')
call s:ln('cssIdentifier',   'Function')
call s:ln('cssClassName',    'Identifier')
call s:ln('cssColor',        'Number')
call s:ln('cssAttrComma',    'Operator')
call s:ln('cssClassNameDot', 'Operator')
call s:ln('cssNoise',        'Operator')
call s:ln('cssProp',         'Variable')
call s:ln('cssTagName',      'htmlTagName')

" Diff/Patch syntax
call s:ln('diffFile',      'Comment')
call s:ln('diffIndexLine', 'Comment')
call s:ln('diffOldFile',   'Statement')
call s:ln('diffNewFile',   'Statement')
call s:ln('diffSubname',   'Comment')
call s:ln('diffAdded',     'DiffAdd')
call s:ln('diffRemoved',   'DiffDelete')
call s:ln('diffLine',      'Identifier')

" HTML syntax
call s:ln('htmlTag',     'Statement')
call s:ln('htmlTagName', 'htmlTag')
call s:ln('htmlEndTag',  'htmlTag')
call s:ln('htmlEvent',   'Function')
call s:ln('htmlLink',    'Normal')

" Javascript syntax
call s:ln('javaScript',          'Normal')
call s:ln('javaScriptBraces',    'Brace')
call s:ln('javaScriptSemicolon', 'Operator')

" JSON syntax
call s:ln('jsonNull',         'Identifier')
call s:ln('jsonKeywordMatch', 'Operator')
call s:ln('jsonNoise',        'Operator')
call s:ln('jsonQuote',        'Operator')
call s:ln('jsonKeyword',      'Variable')

" Lua syntax
call s:ln('luaFunc', 'Function')

" Python syntax
call s:ln('pythonDot',           'Operator')
call s:ln('pythonColon',         'Operator')
call s:ln('pythonDottedName',    'pythonDecorator')
call s:ln('pythonDecoratorName', 'pythonDecorator')

" Shell syntax
call s:ln('shQuote',     'String')
call s:ln('shCaseEsac',  'Number')
call s:ln('shTestOpr',   'Number')
call s:ln('shVarAssign', 'Operator')
call s:ln('shCaseLabel', 'Variable')

" Vim syntax
call s:ln('vimSep',      'Delimiter')
call s:ln('vimFunc',     'Function')
call s:ln('vimFunction', 'Function')
call s:ln('vimOption',   'Identifier')
call s:ln('vimFuncVar',  'Variable')
call s:ln('vimVar',      'Variable')

" XML syntax
call s:hi('xmlNamespace', {'fg': s:chameleon[1]})

call s:ln('xmlTag',     'htmlTag')
call s:ln('xmlTagName', 'htmlTagName')
call s:ln('xmlEndTag',  'htmlEndTag')

" YAML syntax
call s:ln('yamlBlockMappingKey', 'Variable')

" ----------------------------------------------------------------------------
"  Colors for Vim plugins
" ----------------------------------------------------------------------------

" Plugin - kyazdani42/nvim-tree.lua
call s:hi('NvimTreeExecFile',     {'fg': s:fgcolor, 'st': s:italic})
call s:hi('NvimTreeFolderIcon',   {'fg': s:skyblue[0]})
call s:hi('NvimTreeIndentMarker', {'fg': s:folded})
call s:hi('NvimTreeNormal',       {'fg': s:fgcolor})
call s:hi('NvimTreeRootFolder',   {'fg': s:orange[1]})
call s:hi('NvimTreeSymlink',      {'fg': s:chameleon[1], 'st': s:italic})
call s:hi('NvimTreeWindowPicker', {'fg': s:gutter, 'bg': s:info, 'st': s:bold})

call s:ln('NvimTreeFolderName',       'Directory')
call s:ln('NvimTreeEmptyFolderName',  'NvimTreeFolderName')
call s:ln('NvimTreeOpenedFolderName', 'NvimTreeFolderName')
call s:ln('NvimTreeFileIcon',         'NvimTreeNormal')
call s:ln('NvimTreeImageFile',        'NvimTreeFileIcon')
call s:ln('NvimTreeOpenedFile',       'NvimTreeFileIcon')
call s:ln('NvimTreeSpecialFile',      'NvimTreeFileIcon')

call s:hi('NvimTreeGitDeleted', {'fg': s:deleted, 'st': s:bold})
call s:hi('NvimTreeGitDirty',   {'fg': s:changed, 'st': s:bold})
call s:hi('NvimTreeGitStaged',  {'fg': s:added,   'st': s:bold})

call s:ln('NvimTreeGitMerge',   'NvimTreeGitDeleted')
call s:ln('NvimTreeGitNew',     'NvimTreeGitStaged')
call s:ln('NvimTreeGitRenamed', 'NvimTreeGitStaged')

" Plugin - preservim/nerdtree
call s:ln('NERDTreeDir',       'NvimTreeFolderName')
call s:ln('NERDTreeDirSlash',  'NvimTreeFolderName')
call s:ln('NERDTreeOpenable',  'NvimTreeFolderName')
call s:ln('NERDTreeClosable',  'NvimTreeFolderName')
call s:ln('NERDTreeUp',        'NvimTreeFolderName')
call s:ln('NERDTreeCWD',       'NvimTreeRootFolder')
call s:ln('NERDTreeFile',      'NvimTreeNormal')
call s:ln('NERDTreeHelp',      'NvimTreeNormal')
call s:ln('NERDTreeExecFile',  'NvimTreeExecFile')
call s:ln('NERDTreeToggleOn',  'DiffAdded')
call s:ln('NERDTreeToggleOff', 'DiffRemoved')

" Plugin - airblade/vim-gitgutter
call s:hi('GitGutterAdd',          {'fg': s:added,     'bg': s:gutter})
call s:hi('GitGutterChange',       {'fg': s:changed,   'bg': s:gutter})
call s:hi('GitGutterDelete',       {'fg': s:deleted,   'bg': s:gutter})
call s:hi('GitGutterChangeDelete', {'fg': s:orange[2], 'bg': s:gutter})

" Plugin - dense-analysis/ale
call s:hi('ALEInfoSign',    {'fg': s:bgcolor, 'bg': s:info,    'st': s:bold})
call s:hi('ALEWarningSign', {'fg': s:error,   'bg': s:warning, 'st': s:bold})
call s:hi('ALEErrorSign',   {'fg': s:fgcolor, 'bg': s:error,   'st': s:bold})

call s:ln('ALEInfo',    'SpellBad')
call s:ln('ALEWarning', 'SpellBad')
call s:ln('ALEError',   'SpellBad')

" Plugin - vim-syntastic/syntastic
call s:ln('SyntasticWarning',     'ALEWarning')
call s:ln('SyntasticError',       'ALEError')
call s:ln('SyntasticWarningSign', 'ALEWarningSign')
call s:ln('SyntasticErrorSign',   'ALEErrorSign')

" Plugin - nathanaelkane/vim-indent-guides
if !exists('g:indent_guides_auto_colors')
    let g:indent_guides_auto_colors = 0 " Don't let the plugin guess
endif
call s:hi('IndentGuidesOdd',  {'fg': s:nontext, 'bg': s:guides[0]})
call s:hi('IndentGuidesEven', {'fg': s:nontext, 'bg': s:guides[1]})
