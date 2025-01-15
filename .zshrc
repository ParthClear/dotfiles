# Alias
alias l=ls
alias la="ls -a"
# java related
alias j8="export JAVA_HOME=/usr/local/opt/openjdk@8 ; java -version"
alias j11="export JAVA_HOME=/usr/local/opt/openjdk@11 ; java -version"
alias j17="export JAVA_HOME=/usr/local/opt/openjdk@17 ; java -version"
alias mvn="mvn -T 4"
# ssh tunnelling
alias bastion="ssh -L 9999:<redacted>:3306 -p 22 ParthClear@bastion.internal.cleartax.co"
alias mbastion="ssh -L 9997:<redacted>:27017 -p 22 ParthClear@bastion.internal.cleartax.co"
alias rbastion="ssh -L 9998:<redacted>:6379 -p 22 ParthClear@bastion.internal.cleartax.co"
# git related
alias gs="git status"
alias gcam="git commit -am"
## Recent branches 
grcb(){
	git for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(authorname) %(refname:short)'
}
## stage,commit all changes and push
gcamp () {
	gcam $1;
	git push
}
## stash all changes and go to latest default branch
gm (){
	git stash
	( git rev-parse --abbrev-ref origin/HEAD | cut -c8-) | xargs git checkout
	git pull
}

# meta
alias vi="nvim"
alias shut="sudo shutdown -h now"
alias f="fuck"

## reload config after editor exit
zshrc () {
	vi ~/.zshrc;
	source ~/.zshrc;
}
bashrc () {
	vi ~/.bashrc;
	source ~/.bashrc;
}
nvimrc () {
	vi ~/.config/nvim/init.lua;
}
