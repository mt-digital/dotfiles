function ct --wraps='cargo test' --wraps='cargo nextest r' --description 'alias ct=cargo nextest r'
    cargo nextest r $argv
end
