#!/bin/bash
set -e

# Select a default .NET version if one is not specified
if [ -z "$DOTNET_VERSION" ]; then
  DOTNET_VERSION=2.1.505
fi

# Add the Node.js PPA so that we can install the latest version
curl -sL https://deb.nodesource.com/setup_10.x | bash -

# Install Node.js (which includes npm)
apt-get install -y nodejs

# Install gulp
npm install -g gulp

# Change ownership of npm directories to the sudo (non-root) user
chown -R $SUDO_USER ~/.npm
chown -R $SUDO_USER ~/.config

# Install .NET as the sudo (non-root) user
sudo -i -u $SUDO_USER bash << EOF
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin -c Current -v $DOTNET_VERSION
EOF