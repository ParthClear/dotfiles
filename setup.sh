# download and install sdk man
curl -s "https://get.sdkman.io" | bash
# download and install brew and packages
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install tmux mysql redis rabbitmq postgresql nvm nvim zoxide ripgrep iterm2 wget 
#mvn
wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz 
tar xvzf apache-maven-3.9.9-bin.tar.gz -C /opt
echo 'export PATH="/opt/apache-maven-3.9.9/bin:$PATH"' >> ~/.zshrc
