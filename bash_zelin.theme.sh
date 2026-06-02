#! bash oh-my-bash.module

FRIDAY_GREEN='\[\e[1;32m\]'
FRIDAY_BLUE='\[\e[1;34m\]'
FRIDAY_YELLOW='\[\e[1;33m\]'
FRIDAY_RED='\[\e[1;31m\]'
FRIDAY_BOLD='\[\e[1m\]'
FRIDAY_RESET='\[\e[0m\]'

PROMPT_DIRTRIM=0

OMB_PROMPT_VIRTUALENV_FORMAT='(%s) '
OMB_PROMPT_CONDAENV_FORMAT='(%s) '
OMB_PROMPT_SHOW_PYTHON_VENV=${OMB_PROMPT_SHOW_PYTHON_VENV:=true}

function _friday_path() {
  local path="$PWD"
  path="${path/#$HOME/~}"
  printf '%s' "$path"
}

function _friday_git_status() {
  local line untracked added modified renamed deleted unmerged

  while IFS= read -r line; do
    case "${line:0:2}" in
      '??') untracked=1 ;;
      *U*|AA|DD) unmerged=1 ;;
    esac

    [[ ${line:0:1} == A || ${line:1:1} == A ]] && added=1
    [[ ${line:0:1} == M || ${line:1:1} == M ]] && modified=1
    [[ ${line:0:1} == R || ${line:1:1} == R ]] && renamed=1
    [[ ${line:0:1} == D || ${line:1:1} == D ]] && deleted=1
  done < <(git status --porcelain 2>/dev/null)

  [[ $untracked ]] && printf '%%'
  [[ $added ]] && printf '+'
  [[ $modified ]] && printf '*'
  [[ $renamed ]] && printf '~'
  [[ $deleted ]] && printf '!'
  [[ $unmerged ]] && printf '?'
}

function _friday_git_prompt_info() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

  local ref status
  ref=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null) || return
  status=$(_friday_git_status)
  [[ -n $status ]] && status=" $status"

  printf '%s(%s%s)%s ' "$FRIDAY_YELLOW" "$ref" "$status" "$FRIDAY_RESET"
}

function _omb_theme_PROMPT_COMMAND() {
  local rc="$?"

  local short_host="${HOSTNAME%%.*}"
  [[ -z "$short_host" ]] && short_host="$(hostname -s 2>/dev/null || hostname)"
  short_host="${short_host%%.*}"

  local python_venv
  _omb_prompt_get_python_venv 2>/dev/null

  local return_code=''
  if (( rc != 0 )); then
    return_code=" ${FRIDAY_RED}${rc} ↵${FRIDAY_RESET}"
  fi

  history -a

  PS1="${python_venv}${FRIDAY_GREEN}╭─${FRIDAY_RESET} ${FRIDAY_GREEN}\u@${short_host}${FRIDAY_RESET} ${FRIDAY_BLUE}$(_friday_path)${FRIDAY_RESET} $(_friday_git_prompt_info)${return_code}\n${FRIDAY_GREEN}╰─➜${FRIDAY_RESET} ${FRIDAY_BOLD}\$${FRIDAY_RESET} "
}

_omb_util_add_prompt_command _omb_theme_PROMPT_COMMAND
