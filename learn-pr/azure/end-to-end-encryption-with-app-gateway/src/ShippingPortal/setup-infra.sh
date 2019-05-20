# Create the vnet
echo "Creating VNet"
az network vnet create --resource-group $rgName --name shippingportalvnet

# Create the subnet
echo "Creating subnet for App Gateway"
az network vnet subnet create --resource-group $rgName --vnet-name shippingportalvnet  --name appgatewaysubnet --address-prefixes "10.0.0.0/24"

# Create public IP address for the gateway
echo "Creating public IP address"
az network public-ip create --resource-group $rgName --name appgwipaddr --sku Basic

# Create the App gateway
echo "Creating App Gateway"
az network application-gateway create --name gw-shipping --resource-group $rgName --vnet-name shippingportalvnet --subnet appgatewaysubnet --capacity 2 --sku Standard_v2 --http-settings-cookie-based-affinity Disabled --http-settings-protocol Http --frontend-port 80 --routing-rule-type Basic --http-settings-port 80 --public-ip-address appgwipaddr

# Create subnet for VM
echo "Creating subnet for VM"
az network vnet subnet create --resource-group $rgName --vnet-name shippingportalvnet  --name vmsubnet --address-prefixes "10.0.1.0/24"

# Create the virtual machine. 
echo "Creating VM"
az vm create --resource-group $rgName --name webservervm1 --vnet-name shippingportalvnet --subnet vmsubnet --image "Canonical:UbuntuServer:16.04-LTS:latest" --admin-username azureuser --generate-ssh-keys

# Open port 80 to allow web traffic to host.
echo "Opening port 80"
az vm open-port --port 80 --resource-group $rgName --name webservervm1 

# Open port 443 to allow web traffic to host.
echo "Opening port 443"
az vm open-port --port 443 --resource-group $rgName --name webservervm1 --priority 110

# Get the FQDN of the Application Gateway
echo "Retrieving FQDN of App Gateway"
fqdn="$(az network public-ip show \
      --resource-group $rgName \
      --name appgwipaddr \
      --query "dnsSettings.fqdn")"

# Create SSL certificate for termination at Application Gateway
echo "Creating SSL certificate for connection to App Gateway"
openssl req -x509 -subj '/O=RetailCo/C=US/CN='$fqdn -sha256 -nodes -days 365 -newkey "rsa:2048" -keyout server-config/appgateway-privatekey.key -out server-config/appgateway.crt
openssl pkcs12 -export -out server-config/appgateway.pfx -inkey server-config/appgateway-privatekey.key -in server-config/appgateway.crt  -passout pass:somepassword

# Get the private IP address of the VM
echo "Retrieving private IP address of VM"
privateip="$(az vm list-ip-addresses \
      --resource-group $rgName \
      --name webservervm1 \
      --query "[0].virtualMachine.network.privateIpAddresses[0]" \
      --output tsv)"

# Create SSL certificate for the VM
echo "Creating SSL certificate for connection from App Gateway to VM"
openssl req -x509 -subj '/O=RetailCo/C=US/CN='$privateip -sha256 -nodes -days 365 -newkey "rsa:2048" -keyout server-config/shipping-privatekey.key -out server-config/shipping-ssl.crt
openssl pkcs12 -export -out server-config/shipping-ssl.pfx -inkey server-config/shipping-privatekey.key -in server-config/shipping-ssl.crt  -passout pass:somepassword

# Get the public IP address of the VM
echo "Retrieving public IP of VM"
ipaddress="$(az vm show --name webservervm1 --resource-group $rgName --show-details --query [publicIps] --output tsv)"

# Copy the certificate and key files, and create an ssh connection to the VM
echo "Copy app files certificate, and keys to VM"
scp -o StrictHostKeyChecking=no -r $HOME/shippingportal/ azureuser@$ipaddress:/home/azureuser/
echo "Configuring VM"
ssh -o StrictHostKeyChecking=no "azureuser@$ipaddress" "bash /home/azureuser/shippingportal/server-config/setup-vm.sh"
