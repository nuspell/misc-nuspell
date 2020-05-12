" Vim syntax file
" Language:		Affix file for Nuspell and Hunspell
" Filenames:		*.aff
" Current Maintainer:	Pander <pander@users.sourceforge.net>
" URL:			https://raw.githubusercontent.com/nuspell/misc-nuspell/master/vim-syntax/aff.vim
" Repository:		https://github.com/nuspell/misc-nuspell
" Bugs/requests:	https://github.com/nuspell/misc-nuspell/issues
" Last Change:		2018 Nov 07
" PLEASE, DO NOT CHANGE THE ORDER OF THIS FILE, FOR MAINTENANCE IT IS KEPT
" IDENTICAL TO OTHER SYNTAX HIGHLIGHTING FILES. SEE ALSO THE REPOSITORY.

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case ignore
" set value
syn keyword affSetVal	utf-8 iso8859-1 iso8859-2 iso8859-3 iso8859-4 iso8859-5 iso8859-6 iso8859-7 iso8859-8 iso8859-9 iso8859-10 iso8859-11 iso8859-12 iso8859-13 iso8859-14 iso8859-15 cp1251 koi8-r tis-620

" flag type value
syn keyword affFlagVal	double long num utf-8

syn case match
" no arguments
syn keyword affArgNone	CHECKCOMPOUNDDUP CHECKCOMPOUNDREP CHECKCOMPOUNDCASE CHECKCOMPOUNDTRIPLE NOSPLITSUGS ONLYMAXDIFF CHECKSHARPS FULLSTRIP SIMPLIFIEDTRIPLE

" numeric argument
syn keyword affArgNum	MAXNGRAMSUGS COMPOUNDMIN MAXCPDSUGS MAXDIFF COMPOUNDWORDMAX

" string argument
syn keyword affArgStr	SET TRY LANG IGNORE

" flag type argument
syn keyword affArgFlagT	FLAG

" one flag argument
syn keyword affArgFlag	WARN NOSUGGEST COMPOUNDFLAG COMPOUNDBEGIN COMPOUNDMIDDLE COMPOUNDEND ONLYINCOMPOUND COMPOUNDPERMITFLAG COMPOUNDFORBIDFLAG COMPOUNDROOT KEEPCASE FORCEUCASE FORBIDDENWORD NEEDAFFIX CIRCUMFIX

" one or more flags arguments
syn keyword affArgFlags	SYLLABLENUM

" spanning multiple lines
syn keyword affConv	ICONV OCONV
syn keyword affBreak	BREAK
syn keyword affRep	REP
syn keyword affKey	KEY
syn keyword affMap	MAP
syn keyword affAm	AM
syn keyword affAf	AF
syn keyword affPhone	PHONE
syn keyword affComRul	COMPOUNDRULE
syn keyword affComPat	CHECKCOMPOUNDPATTERN
syn keyword affFx	PFX SFX
syn keyword affComSyl	COMPOUNDSYLLABLE

" Engine specific or completely deprecated, hence and could be ignored
syn keyword affSpecStr	WORDCHARS HOME VERSION SUBSTANDARD ONLYROOT LANGCODE COMPOUNDFIRST COMPOUNDLAST COMPOUNDMORESUFFIXES GENERATE HU_KOTOHANGZO LEFTHYPHENMIN

" Deprecated by all engines but functionality moved to other keyword
syn keyword affDepFlag	PSEUDOROOT LEMMA_PRESENT

syn match affComment	"#.*$"
syn match affNum	"[0-9]*"
syn case match

" Default highlighting
hi def link affComment	Comment
hi def link affNum	Number
hi def link affSetVal	Type
hi def link affFlagVal	Type

hi def link affConv	Statement
hi def link affBreak	Statement
hi def link affRep	Statement
hi def link affKey	Statement
hi def link affMap	Statement
hi def link affAm	Statement
hi def link affAf	Statement
hi def link affPhone	Statement
hi def link affComRul	Statement
hi def link affComPat	Statement
hi def link affFx	Statement
hi def link affComSyl	Statement

hi def link affArgNone	Statement
hi def link affArgNum	Statement
hi def link affArgStr	Statement
hi def link affArgFlag	Statement
hi def link affArgFlags	Statement
hi def link affArgFlagT	Statement

hi def link affSpecStr	Todo
hi def link affDepFlag	Error

let b:current_syntax = "aff"

" vim: ts=8
