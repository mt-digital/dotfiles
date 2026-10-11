function detloop --wraps='losetup -D' --wraps='sudo losetup -D' --description 'alias detloop=sudo losetup -D'
    sudo losetup -D $argv
end
