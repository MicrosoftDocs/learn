# Create the vnet
az network vnet create --resource-group $rgName --name shippingportalvnet

# Create the subnet
az network vnet subnet create --resource-group $rgName --vnet-name shippingportalvnet  --name appgatewaysubnet --address-prefixes "10.0.0.0/24"

# Create public IP address for the gateway
az network public-ip create --resource-group $rgName --name appgwipaddr --sku Basic

# Create the App gateway
az network application-gateway create --name gw-shipping --resource-group $rgName --vnet-name shippingportalvnet --subnet appgatewaysubnet --capacity 2 --sku Standard_Small --http-settings-cookie-based-affinity Disabled --http-settings-protocol Http --frontend-port 80 --routing-rule-type Basic --http-settings-port 80 --public-ip-address appgwipaddr --no-wait

# Create subnet for VM
az network vnet subnet create --resource-group $rgName --vnet-name shippingportalvnet  --name vmsubnet --address-prefixes "10.0.1.0/24"

# Create the virtual machine. 
az vm create --resource-group $rgName --name webservervm1 --vnet-name shippingportalvnet --subnet vmsubnet --image "Canonical:UbuntuServer:16.04-LTS:latest" --admin-username azureuser --generate-ssh-keys

# Open port 80 to allow web traffic to host.
az vm open-port --port 80 --resource-group $rgName --name webservervm1 

# Open port 443 to allow web traffic to host.
az vm open-port --port 443 --resource-group $rgName --name webservervm1 --priority 110

# Get the private IP address of the VM
privateip="$(az vm list-ip-addresses \
      --resource-group $rgName \
      --name webservervm1 \
      --query "[0].virtualMachine.network.privateIpAddresses[0]" \
      --output tsv)"

# Create SSL certificate
openssl req -x509 -subj '/O=RetailCo/C=US/CN='$privateip -sha256 -nodes -days 365 -newkey "rsa:2048" -keyout server-config/shipping-privatekey.key -out server-config/shipping-ssl.crt
openssl pkcs12 -export -out server-config/shipping-ssl.pfx -inkey server-config/shipping-privatekey.key -in server-config/shipping-ssl.crt  -passout pass:somepassword

# Get the public IP address of the VM
ipaddress="$(az vm show --name webservervm1 --resource-group $rgName --show-details --query [publicIps] --output tsv)"

# Copy the certificate and key files, and create an ssh connection to the VM
scp -o StrictHostKeyChecking=no -r $HOME/shippingportal/ azureuser@$ipaddress:/home/azureuser/
ssh -o StrictHostKeyChecking=no "azureuser@$ipaddress" "bash /home/azureuser/shippingportal/server-config/setup-vm.sh"
