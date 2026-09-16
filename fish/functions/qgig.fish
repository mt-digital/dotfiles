function qgig --wraps='echo "*.html" >> .gitignore && echo "*_files/" >> .gitignore' --description 'alias qgig=echo "*.html" >> .gitignore && echo "*_files/" >> .gitignore'
    echo "*.html" >> .gitignore && echo "*_files/" >> .gitignore $argv
end
