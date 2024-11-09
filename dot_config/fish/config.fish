if status is-interactive
    starship init fish | source
    set -gx GPG_TTY (tty)

    alias ls 'lsd'
    alias l  'lsd'
    alias la 'lsd -a'
    alias ll 'lsd -al --date +"%Y-%m-%d %H:%M"'

    alias ghcs  'gh copilot suggest -t shell'
    alias ghce 'gh copilot suggest -t git'
end
