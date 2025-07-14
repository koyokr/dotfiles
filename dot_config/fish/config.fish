if status is-interactive
    starship init fish | source
    zoxide init fish | source
    set -gx GPG_TTY (tty)

    alias ls 'ls --color=auto'
    alias ll 'ls -alF'
    alias la 'ls -A'
    alias l 'ls -CF'
end
