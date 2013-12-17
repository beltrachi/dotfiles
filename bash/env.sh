if [ -x ~/.rvm/bin/rvm-prompt ]; then
    RVM_PART='\[\e[0;31m\][$(~/.rvm/bin/rvm-prompt i v p g system)]'
else
    RVM_PART='\[\e[0;31m\][env=$RAILS_ENV]'
fi
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W '$RVM_PART'\[\e[0;32m\] $(__git_ps1 "(%s)")\[\e[0;37m\] \$\[\033[00m\] '

