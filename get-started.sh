#!/bin/bash
set -u
set -e
sudo -v

# ----------------------------------------
# 1. Introduction
# ----------------------------------------
echo "
----------------------------------------
🎉 Welcome to the team! It's great to have you here.

This script will install everything required to get started at Linktree. If you encounter any problems during the process, please file an Issue here:
https://github.com/linktr-ee/bootstrap.linktr.ee

If you feel confident you can fix the problem, please feel free to submit a Pull Request with your fix.
https://github.com/linktr-ee/bootstrap.linktr.ee/pulls
----------------------------------------
"

# ----------------------------------------
# 2. Install homebrew & zsh.
# ----------------------------------------
if test ! $(which brew)
then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Ensure non-super users can continue.
sudo chown -R $(whoami) $(brew --prefix)/*

# Install ZSH & set as default shell.
brew install zsh || true
chsh -s /bin/zsh || true

# Update $PATH
./path.sh

# ----------------------------------------
# 3. Install Python & Python Dependencies.
# ----------------------------------------
declare pythonVersion=3.7.6
declare ansibleVersion=2.9

brew upgrade pyenv || true
brew install pyenv || true

pyenv install "${pythonVersion}"
pyenv global "${pythonVersion}"

# Ensure pyenv is initialized and set in zsh
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc
source ~/.zshrc
echo "You are now running $(python -V)."

# Install Ansible
pip3 install -q --upgrade --user pip virtualenv virtualenvwrapper
pip3 install -q --user ansible==${ansibleVersion} paramiko wheel

# ----------------------------------------
# 4. Run Playbook
# ----------------------------------------
if test ! $(which ansible-galaxy)
then
    echo "
    Ansible Galaxy cannot be found. Please report this as a bug.
    https://github.com/linktr-ee/bootstrap.linktr.ee/issues3
    "
fi
ansible-galaxy install -r ./requirements.yml
ansible-playbook playbook.yml