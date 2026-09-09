function newrepo
    mkdir $argv[1]
    cd $argv[1]

    git init
    echo "# $argv[1]" > README.md
    git add .
    git commit -m "init"

    gh repo create $argv[1] --public --source=. --remote=origin --push
end
