function ta --wraps='tmux a' --wraps='tmux -L' --description 'alias ta=tmux -L'
    tmux -L $argv
end
