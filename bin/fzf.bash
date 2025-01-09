export FZF_DEFAULT_COMMAND='find ~ -type d -name waydroid -prune -o -name node_modules -prune -o -type d -name backup -prune -o -type d -name "?git" -prune -o -name "*"'
export FZF_DEFAULT_OPTS="--height 40% --reverse --border --preview='less {}'\
        --bind ctrl-u:preview-page-up,ctrl-d:preview-page-down"
# for ctrl T 

export FZF_CTRL_T_COMMAND='find ~ -type d -name waydroid -prune -o -name node_modules -prune -o -type d -name backup -prune -o -type d -name "?git" -prune -o -name "*"'
export FZF_CTRL_T_OPTS="--height 40% --reverse --border --preview='less {}'\
        --bind ctrl-u:preview-page-up,ctrl-d:preview-page-down"
# 
# for alt C 

export FZF_ALT_C_COMMAND='find ~ -type d -name waydroid -prune -o -name node_modules -prune -o -type d -name backup -prune -o -type d -name "?git" -prune -o -name "*"'
export FZF_ALT_C_OPTS="--height 40% --reverse --border --preview='less {}'\
        --bind ctrl-u:preview-page-up,ctrl-d:preview-page-down"
# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
