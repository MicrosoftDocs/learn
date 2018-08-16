# Five steps to more interactive deep learning (this section requires the azure shell)

## Introduction to Jupyter for more interactive deep learning
Jupyter Notebook is an open-source web application that allows you to create and share documents that contain live code, equations, visualizations and narrative text. Uses include: data cleaning and transformation, numerical simulation, statistical modeling, data visualization, machine learning, and much more.

# Serving Jupyter Notebooks with Nvidia Docker on an Azure DSVM


## Step 1 Create Linux a DSVM  
Login to your azure subscription
```
az login
```

Use call code from the Azure Cli  
```
code .
```

Fill in the  the following deployment schema and save it as parameter_file.json
```
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
     "adminUsername": { "value" : "YOURUSERNAME FOR NEW DSVM"},
     "adminPassword": { "value" : "PASSWORD FOR NEW DSVM"},
     "vmName": { "value" : "HOSTNAME OF DSVM"},
     "vmSize": { "value" : "VM SIZE For eg: Standard_DS2_v2"},
     "fileUris": { "value" : "PUBLIC URL CONTAINING YOUR POST INSTALL BASH SCRIPT PACKAGE"},
     "commandToExecute": { "value" : "SCRIPT FILE <any arguments to script>"},
     "numberOfInstances": { "value" : "NUMBER OF VM INSTANCES TO CREATE"}	      
  }
}
```

```
az group create --name [[NAME OF RESOURCE GROUP]] --location [[ Data center. For eg: "West US 2"]
```
```
az group deployment create --resource-group  [[NAME OF RESOURCE GROUP ABOVE]]  --template-uri https://raw.githubusercontent.com/Azure/DataScienceVM/master/Scripts/CreateDSVM/Ubuntu/azuredeploy.json --parameters parameter_file.json
```

## Step 2 Open the Port 8888 on the DLVM

```
$ az vm open-port -g MyResourceGroup -n MyVm --port 8888
```

Port 8888 is the default port for Jupyter Notebooks For detailed steps on opening a port click here

## Step 3 Connect to the DLVM with the Azure Shell

```
ssh myuser@dlvm_domain
```

## Step 4 Run Docker Container & link 8888 port to the VM Host

Link port 8888 between the VM and the docker container Ex. 

``` 
sudo nvidia-docker run -it -p 8888:8888 pytorch/pytorch
```

## Step 5 Navigate to the Jupyter Notebook in the Browser

Now that your Jupyter notebook is running to access it in the browser :

Copy the link to the local notebook http://cd3cdb8ea05f:8888/?token=66dc6919e8762c8136006cffd90b7b16f3fa7fd1fa591637&token=66dc6919e8762c8136006cffd90b7b16f3fa7fd1fa591637

Replace the http://cd3cdb8ea05f or http://localhost part of the jupyter url with your VMs DNS name
