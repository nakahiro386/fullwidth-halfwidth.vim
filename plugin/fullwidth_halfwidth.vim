"=============================================================================
" File: fullwidth-halfwidth.vim
" Author: nakahiro386
" Created: 2021-03-20
"=============================================================================

scriptencoding utf-8

if exists('g:loaded_fullwidth_halfwidth')
    finish
endif
let g:loaded_fullwidth_halfwidth = 1

let s:save_cpo = &cpo
set cpo&vim


command! -nargs=0 -range FullwidthAscii <line1>,<line2>call fullwidth_halfwidth#convertRange('FullwidthAscii')
command! -nargs=0 -range HalfwidthAscii <line1>,<line2>call fullwidth_halfwidth#convertRange('HalfwidthAscii')

let &cpo = s:save_cpo
unlet s:save_cpo
