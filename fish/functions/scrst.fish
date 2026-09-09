function scrst --wraps='sudo systemctl restart' --description 'alias scrst=sudo systemctl restart'
    sudo systemctl restart $argv
end
