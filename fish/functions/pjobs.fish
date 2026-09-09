function pjobs --wraps='sudo systemctl restart cups && firefox http://localhost:631/jobs?' --wraps='firefox http://localhost:631/jobs?' --description 'alias pjobs=firefox http://localhost:631/jobs?'
    firefox http://localhost:631/jobs? $argv
end
