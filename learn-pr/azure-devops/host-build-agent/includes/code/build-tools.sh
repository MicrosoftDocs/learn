#!/bin/bash
set -e

# Select a default .NET version if one is not specified
if [ -z "$DOTNET_VERSION" ]; then
  DOTNET_VERSION=2.1.505
fi

# Install nodejs and npm
apt-get install -y nodejs npm

# Install gulp
npm install -g gulp

# Install .NET
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin -c Current -v $DOTNET_VERSION

# Link the dotnet binary to /usr/bin/dotnet
ln -s $HOME/.dotnet/dotnet /usr/bin/dotnet