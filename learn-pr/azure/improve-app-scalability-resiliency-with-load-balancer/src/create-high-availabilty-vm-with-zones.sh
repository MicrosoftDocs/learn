#!/bin/bash

RgName=`az group list --query '[].name' --output tsv`
Location=`az group list --query '[].location' --output tsv`

date
# Create a Virtual Network for the VMs
echo '------------------------------------------'
echo 'Creating a Virtual Network for the VMs'
az network vnet create \
    --resource-group $RgName \
    --location $Location \
    --name portalBEVnet \
    --subnet-name portalBESubnet 

# Create a public IP for the load balancer
echo '------------------------------------------'
echo 'Creating a public IP for the load balancer'
az network public-ip create --resource-group $RgName \
   --name azPatientPortalPublicIP --sku Standard

# Create the load balancer
echo '------------------------------------------'
echo 'Creating the internal load balancer'
az network lb create \
    --resource-group $RgName \
    --name azPatientBELoadBalancer \
    --sku standard \
    --public-ip-address azPatientPortalPublicIP \
    --private-ip-address 10.0.0.9 \
    --frontend-ip-name azFrontEndPool  \
    --backend-pool-name azBackEndPool  

# Create a probe for the load balancer
echo '------------------------------------------'
echo 'Creating a probe for the load balancer'
az network lb probe create \
    --resource-group $RgName \
    --lb-name azPatientBELoadBalancer \
    --name azBEHealthProbe \
    --protocol tcp \
    --port 80

# Create a rule for the load balancer
echo '------------------------------------------'
echo 'Creating a rule for the load balancer'
az network lb rule create \
    --resource-group $RgName \
    --lb-name azPatientBELoadBalancer \
    --name azPatientHTTPRule \
    --protocol tcp \
    --frontend-port 80 \
    --backend-port 80 \
    --frontend-ip-name azFrontEndPool \
    --backend-pool-name azBackEndPool \
    --probe-name azBEHealthProbe 

# Create a Network Security Group
echo '------------------------------------------'
echo 'Creating a Network Security Group'
az network nsg create \
    --resource-group $RgName \
    --name portalNetworkSecurityGroup \

# Create a network security group rule for port 22.
echo '------------------------------------------'
echo 'Creating a SSH rule'
az network nsg rule create \
    --resource-group $RgName \
    --nsg-name portalNetworkSecurityGroup \
    --name portalNetworkSecurityGroupRuleSSH \
    --protocol tcp \
    --direction inbound \
    --source-address-prefix '*' \
    --source-port-range '*'  \
    --destination-address-prefix '*' \
    --destination-port-range 22 \
    --access allow \
    --priority 1000

# Create a HTTP rule
echo '------------------------------------------'
echo 'Creating a HTTP rule'
az network nsg rule create \
    --resource-group $RgName \
    --nsg-name portalNetworkSecurityGroup \
    --name portalNetworkSecurityGroupRuleHTTP \
    --protocol tcp \
    --direction inbound \
    --source-address-prefix '*' \
    --source-port-range '*' \
    --destination-address-prefix '*' \
    --destination-port-range 80 \
    --access allow \
    --priority 200

# Create the NIC
for i in `seq 1 2`; do
  echo '------------------------------------------'
  echo 'Creating dbNic'$i
  az network nic create \
    --resource-group $RgName \
    --name dbNic$i \
    --vnet-name portalBEVnet \
    --subnet portalBESubnet \
    --network-security-group portalNetworkSecurityGroup \
    --lb-name azPatientBELoadBalancer \
    --lb-address-pools azBackEndPool 
done 

# Create 2 VM's from a template
for i in `seq 1 2`; do
  echo '------------------------------------------'
  echo 'Creating webVM'$i
  az vm create \
    --admin-username azureuser \
    --admin-password Pa55w.rd1234! \
    --authentication-type all \
    --resource-group $RgName \
    --name dbVM$i \
    --nics dbNic$i \
    --image UbuntuLTS \
    --zone $i \
    --generate-ssh-keys \
    --custom-data backend-init.txt
done

# Done
echo '---------------------------------------------------'
echo '             Setup Script Completed'
echo '---------------------------------------------------'
strCommand="az network public-ip show -n azPatientPortalPublicIP --query ipAddress -o tsv -g "$RgName
publicIP=`${strCommand}`
echo ' Visit the Patient Portal at: http://'$publicIP
echo '---------------------------------------------------'
date