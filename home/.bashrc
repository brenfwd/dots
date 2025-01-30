export PATH="$HOME/.local/bin:$PATH"

alias ..='cd ..'
alias ls='ls --color=auto'
alias l='ls'
alias ll='ls -lh'
alias la='ls -lha'

alias gs='git status'
alias gaa='git add -Av'
alias gcm='git commit -m'
alias gpush='git push'
alias gpull='git pull'

# https://bash-prompt-generator.org/
export GIT_PS1_SHOWDIRTYSTATE=1
source "$HOME/git-prompt.sh"
export PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")'; PS1='\[\e[38;5;247m\]\u\[\e[0m\] \[\e[38;5;39m\]\h\[\e[0m\] \w\[\e[2m\]${PS1_CMD1}\[\e[0m\] \[\e[38;5;39m\]\$\[\e[0m\] '

# Load ~/.bashrc.local for local overrides
# Things like path overrides for programs should be moved here...
[ -s "$HOME/.bashrc.local" ] && \. "$HOME/.bashrc.local"
