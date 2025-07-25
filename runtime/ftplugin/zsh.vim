" Vim filetype plugin file
" Language:             Zsh shell script
" Maintainer:           Christian Brabandt <cb@256bit.org>
" Previous Maintainer:  Nikolai Weibull <now@bitwi.se>
" Latest Revision:      2024 Sep 19
" License:              Vim (see :h license)
" Repository:           https://github.com/chrisbra/vim-zsh
" Last Change:
" 2025 Jul 23 by Vim Project (use :hor term #17822)

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal comments=:# commentstring=#\ %s formatoptions-=t formatoptions+=croql

let b:undo_ftplugin = "setl com< cms< fo< "

if executable('zsh') && &shell !~# '/\%(nologin\|false\)$'
  if exists(':terminal') == 2
    command! -buffer -nargs=1 ZshKeywordPrg silent exe ':hor term zsh -c "autoload -Uz run-help; run-help <args>"'
  else
    command! -buffer -nargs=1 ZshKeywordPrg echo system('MANPAGER= zsh -c "autoload -Uz run-help; run-help <args> 2>/dev/null"')
  endif
  setlocal keywordprg=:ZshKeywordPrg
  let b:undo_ftplugin .= '| setl keywordprg< | sil! delc -buffer ZshKeywordPrg'

  if !exists('current_compiler')
    compiler zsh
  endif
  let b:undo_ftplugin .= ' | compiler make'
endif

let b:match_words = '\<if\>:\<elif\>:\<else\>:\<fi\>'
      \ . ',\<case\>:^\s*([^)]*):\<esac\>'
      \ . ',\<\%(select\|while\|until\|repeat\|for\%(each\)\=\)\>:\<done\>'
let b:match_skip = 's:comment\|string\|heredoc\|subst'

let &cpo = s:cpo_save
unlet s:cpo_save
