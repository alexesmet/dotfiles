" Vim syntax file
" Language: Timesheet
" Maintainer: Alexei Miatlitski
" Latest Revision: 17 Aug 2021

if exists("b:current_syntax")
  finish
endif

syn match timeDate     /\v^(\d{2}\.\d{2}\.\d{4}|\d{4}-\d{2}-\d{2})$/
syn match timeLabel    /\v(\w{2}-\d{1,6}|--)/
syn match timeNotation /\v^((\s*(\d{1,6}(h|m)))+)/

let b:current_syntax = "time"

hi def link timeDate       Typedef
hi def link timeLabel      Special
hi def link timeNotation   Number
