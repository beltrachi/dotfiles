alias sc='script/console'
alias ss='script/server'
alias ber='bundle exec rspec'
alias berch="bundle exec rspec \$(git status | grep spec | grep 'modified:' | grep -v spec/support |grep -v spec/factories | cut -d':' -f 2 -)"

