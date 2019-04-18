#!/bin/bash

RgName=`az group list --query '[].name' --output tsv`
Location="westus2"

date
# Create a Virtual Network for the VMs
echo '------------------------------------------'
echo 'Creating a Virtual Network for the VMs'
az network vnet create \
    --resource-group $RgName \
    --location $Location \
    --name bePortalVnet \
    --subnet-name bePortalSubnet 

# Create a Network Security Group
echo '------------------------------------------'
echo 'Creating a Network Security Group'
az network nsg create \
    --resource-group $RgName \
    --name bePortalNSG \
    --location $Location

# Create the NIC
for i in `seq 1 2`; do
  echo '------------------------------------------'
  echo 'Creating webNic'$i
  az network nic create \
    --resource-group $RgName \
    --name webNic$i \
    --vnet-name bePortalVnet \
    --subnet bePortalSubnet \
    --network-security-group bePortalNSG \
    --location $Location
done 

# Create an availability set
echo '------------------------------------------'
echo 'Creating an availability set'
az vm availability-set create \
    --resource-group $RgName \
    --name portalAvailabilitySet

# Create 2 VM's from a template
for i in `seq 1 2`; do
    echo '------------------------------------------'
    echo 'Creating webVM'$i
    az vm create \
        --admin-username azureuser \    
        --resource-group $RgName \
        --name webVM$i \
        --nics webNic$i \
        --location $Location \
        --image UbuntuLTS \
        --availability-set portalAvailabilitySet \
        --generate-ssh-keys \
        --custom-data cloud-init.txt
done

# Done
echo '--------------------------------------------------------'
echo '             VM Setup Script Completed'
echo '--------------------------------------------------------'
echo ' Now visit the Azure portal to setup the Load Balancer' 
echo ' https://portal.azure.com/learn.docs.microsoft.com'
echo '--------------------------------------------------------'
date