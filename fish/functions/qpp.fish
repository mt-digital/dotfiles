function qpp --wraps='quarto preview --port=3434' --wraps='quarto preview --port=' --wraps='quarto preview --port' --description 'alias qpp=quarto preview --port'
    quarto preview --port $argv
end
