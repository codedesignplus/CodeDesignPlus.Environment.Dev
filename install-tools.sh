#!/bin/bash

set -e # Exit immediately if a command fails

echo "---------------------------------"
echo "STARTING INSTALLATION SCRIPT"
echo "---------------------------------"

# ---------------------------------
# 1 - Installing Node.js
# ---------------------------------
echo "1 - Installing Node.js"
if ! command -v nvm &> /dev/null; then
    echo "NVM is not installed. Installing..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
else
    echo "NVM is already installed."
fi

if ! nvm ls 22 &> /dev/null; then
  echo "Node.js v22 is not installed. Installing..."
  nvm install 22
else
  echo "Node.js v22 is already installed."
fi

echo "Verifying versions..."
node -v
nvm current
npm -v

# ---------------------------------
# 2 - Installing .NET SDK
# ---------------------------------
echo "2 - Installing .NET SDK"
if ! command -v dotnet &> /dev/null; then
    echo ".NET SDK is not installed. Installing..."
    wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
    chmod +x ./dotnet-install.sh
    ./dotnet-install.sh --channel 9.0
    export DOTNET_ROOT=$HOME/.dotnet
    export PATH=$PATH:$DOTNET_ROOT
else
    echo ".NET SDK is already installed."
fi

dotnet --version

# ---------------------------------
# 3 - Installing Visual Studio Code
# ---------------------------------
echo "3 - Installing Visual Studio Code"
if ! command -v code &> /dev/null; then
    echo "Visual Studio Code is not installed. Installing..."
    sudo snap install code --classic
else
    echo "Visual Studio Code is already installed."
fi

# ---------------------------------
# 4 - Installing Draw.io
# ---------------------------------
echo "4 - Installing Draw.io"
if ! command -v drawio &> /dev/null; then
    echo "Draw.io is not installed. Installing..."
    sudo snap install drawio
else
    echo "Draw.io is already installed."
fi


# ---------------------------------
# 5 - Installing MongoDB Compass
# ---------------------------------
echo "5 - Installing MongoDB Compass"
if ! command -v mongosh &> /dev/null; then
  echo "MongoDB Compass is not installed. Installing..."
  wget https://downloads.mongodb.com/compass/mongodb-compass_1.45.0_amd64.deb
  sudo dpkg -i mongodb-compass_1.45.0_amd64.deb
else
  echo "MongoDB Compass is already installed."
fi

# ---------------------------------
# 6 - Installing k6
# ---------------------------------
echo "6 - Installing k6"
if ! command -v k6 &> /dev/null; then
    echo "k6 is not installed. Installing..."
    sudo gpg -k
    sudo gpg --no-default-keyring --keyring /usr/share/keyrings/k6-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
    echo "deb [signed-by=/usr/share/keyrings/k6-archive-keyring.gpg] https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list
    sudo apt-get update
    sudo apt-get install k6
else
    echo "k6 is already installed."
fi

# ---------------------------------
# 7 - Installing Docker
# ---------------------------------
echo "7 - Installing Docker"
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
else
  echo "Docker is already installed."
fi

# ---------------------------------
# 8 - Installing HashiCorp Vault
# ---------------------------------
echo "8 - Installing HashiCorp Vault"
if ! command -v vault &> /dev/null; then
  echo "HashiCorp Vault is not installed. Installing..."
  wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update && sudo apt install vault
else
  echo "HashiCorp Vault is already installed."
fi

# ---------------------------------
# 9 - Installing pnpm
# ---------------------------------
echo "9 - Installing pnpm"
if ! command -v pnpm &> /dev/null; then
  echo "pnpm is not installed. Installing..."
  npm install -g pnpm
else
  echo "pnpm is already installed."
fi

# ---------------------------------
# 10 - Installing Yeoman
# ---------------------------------
echo "10 - Installing Yeoman"
if ! command -v yo &> /dev/null; then
  echo "Yeoman is not installed. Installing..."
  npm install -g yo
else
  echo "Yeoman is already installed."
fi

echo "---------------------------------"
echo "INSTALLATION SCRIPT FINISHED"
echo "---------------------------------"