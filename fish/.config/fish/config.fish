set fish_greeting

if status is-interactive
    fish_vi_key_bindings

    if type -q eza
        alias ls 'eza --icons --group-directories-first'
    end
end

if test -d ~/.cargo/bin
    fish_add_path ~/.cargo/bin
end

if type -q zoxide
    zoxide init fish --cmd cd | source
end

if type -q fzf
    fzf --fish | source
end

# abbrs

abbr -a l ls
abbr -a ll ls -lh
abbr -a la ls -lha

abbr -a gs git status
abbr -a gaa git add -Av
abbr -a gcm git commit -m
abbr -a gpush git push
abbr -a gpull git pull

abbr -a py python3
abbr -a python python3

abbr -a vim nvim
abbr -a vi nvim

abbr -a :q exit
abbr -a :e nvim

# local overrides

set local_conf_dir ~/.config/fish.local.d
if test -d $local_conf_dir
    for file in $local_conf_dir/*.fish
        source $file
    end
end

