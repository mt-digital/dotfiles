function newloop --wraps='sudo losetup --find --show --partscan image.img' --wraps='sudo losetup --find --show --partscan ~/.cache/siali/images/rpi2w.img' --description 'alias newloop=sudo losetup --find --show --partscan ~/.cache/siali/images/rpi2w.img'
    sudo losetup --find --show --partscan ~/.cache/siali/images/rpi2w.img $argv
end
