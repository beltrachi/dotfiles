alias gst='git status'
alias gci='git commit'
alias gdiff='git diff --color'
alias glog='git log'
alias gco='git checkout'
alias gbr='git branch'
alias gmm='git merge master'
alias gpush='git push'
alias gp='git pull'

function gh(){
	xdg-open $(git config remote.origin.url | sed "s/git@\(.*\):\(.*\).git/https:\/\/\1\/\2/")
}
