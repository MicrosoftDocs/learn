# Install .net core
wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get install apt-transport-https
sudo apt-get update -y
sudo apt-get install dotnet-sdk-2.2 -y
export DOTNET_CLI_HOME=/home/azureuser

# Install nginx
sudo apt-get install nginx -y

# Copy SSL certificates to nginx
sudo mkdir /etc/nginx/ssl
sudo cp /home/azureuser/shippingportal/server-config/shipping-* /etc/nginx/ssl

# Setup nginx reverse proxy for dotnet core
sudo cp /home/azureuser/shippingportal/server-config/default /etc/nginx/sites-available

sudo systemctl restart nginx

# Build the shipping portal application
dotnet new web -n shippingportal
cd shippingportal
dotnet build
dotnet publish -o published -c Release
cd /home/azureuser/shippingportal/ShippingPortal/published/

sudo mkdir /var/www/shippingportal
sudo cp -r * /var/www/shippingportal


# Setup systemd
sudo cp /home/azureuser/shippingportal/server-config/shippingportal.service /etc/systemd/system/
sudo systemctl start shippingportal.service
