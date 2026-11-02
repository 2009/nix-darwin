# Only source this once.
if [ -n "${__HM_SESS_VARS_SOURCED-}" ]; then return; fi
export __HM_SESS_VARS_SOURCED=1

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range=:500 {} 2>/dev/null || ls {}'"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

