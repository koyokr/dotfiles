set -gx EDITOR helix
set -gx VISUAL helix
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx MANROFFOPT -c

set -g FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
set -g FZF_CTRL_T_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git $dir'
set -g FZF_ALT_C_COMMAND 'fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'

if status is-interactive
    starship init fish | source
    fzf --fish | source
    zoxide init --cmd cd fish | source

    set -gx GPG_TTY (tty)
    set -g fish_greeting

    alias ls 'ls --color=auto -h --group-directories-first'
    alias ll 'ls -alF'
    alias la 'ls -A'
    alias l 'ls -CF'
end
