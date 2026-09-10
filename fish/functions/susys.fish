function susys --wraps='sudo systemctl' --description 'alias susys=sudo systemctl'
    sudo systemctl $argv
end
