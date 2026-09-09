function scst --wraps='sudo systemctl start' --description 'alias scst=sudo systemctl start'
    sudo systemctl start $argv
end
