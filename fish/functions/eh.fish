function eh --wraps='nvim ~/.config/hypr/hyprland.conf' --wraps='nvim ~/.config/hypr/hyprland.lua' --description 'alias eh=nvim ~/.config/hypr/hyprland.lua'
    nvim ~/.config/hypr/hyprland.lua $argv
end
