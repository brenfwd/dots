PATH="$HOME/.local/bin:$PATH"

alias ..='cd ..'
alias ls='ls --color'
alias l='ls'
alias ll='ls -lh'
alias la='ls -lha'

alias gs='git status'
alias gaa='git add -Av'
alias gcm='git commit -m'
alias gpush='git push'
alias gpull='git pull'

alias py='python3'
alias python='python3'

# https://bash-prompt-generator.org/
PS1='\[\e[38;5;247m\]\u\[\e[0m\] \[\e[38;5;39m\]\h\[\e[0m\] \w\[\e[2m\]\[\e[0m\] \[\e[38;5;39m\]\$\[\e[0m\] '

# Load ssh-agent and add default key
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)" >/dev/null
fi
ssh-add &>/dev/null

# Load ~/.bashrc.local for local overrides
# Things like path overrides for programs should be moved here...
[ -s "$HOME/.bashrc.local" ] && \. "$HOME/.bashrc.local"

