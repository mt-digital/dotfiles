function paci --wraps='sudo pacman -i' --wraps='sudo pacman -S' --description 'alias paci=sudo pacman -S'
    sudo pacman -S $argv
end
