function sc --wraps='hyprshot -m region' --wraps='hyprshot -m region ~/.Screenshots' --description 'alias sc=hyprshot -m region ~/.Screenshots'
    hyprshot -m region ~/.Screenshots $argv
end
