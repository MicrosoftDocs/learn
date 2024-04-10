> [!IMPORTANT]
> To do these steps, you need an Azure subscription. If you don't have one already, you can create one by following the steps outlined on the [Create your Azure free](https://azure.microsoft.com/free/).<br>

## Steps

In the following steps, we'll deploy the template and verify the result using Azure CLI:

1.  Create a resource group to deploy your resources to by running the following command:

```azurecli
az group create --name <resource group name> --location  <your nearest datacenter>

```

> [!NOTE]
> Check the available region for you [Choose the Right Azure Region for You](https://azure.microsoft.com/global-infrastructure/geographies). If you can't create in the nearest region, feel free to choose another one.

2.  From Cloud Shell, run the **curl** command to download the template you used previously from GitHub:

```Bash
curl https://raw.githubusercontent.com/Microsoft/PartsUnlimited/master/Labfiles/AZ-400T05_Implementing_Application_Infrastructure/M01/azuredeploy.json > C:\temp\azuredeploy.json

```

3.  Validate the template by running the following command, replacing the values with your own:

```azurecli
az deployment group validate \
  --resource-group <rgn>[sandbox resource group name]</rgn> \
  --template-file C:\temp\azuredeploy.json \
  --parameters adminUsername=$USERNAME \
  --parameters adminPassword=$PASSWORD \
  --parameters dnsLabelPrefix=$DNS_LABEL_PREFIX

```

4.  Deploy the resource by running the following command, replacing the same values as earlier:

```azurecli
az deployment group create \
  --name MyDeployment \
  --resource-group <rgn>[sandbox resource group name]</rgn> \
  --template-file azuredeploy.json \
  --parameters adminUsername=$USERNAME \
  --parameters adminPassword=$PASSWORD \
  --parameters dnsLabelPrefix=$DNS_LABEL_PREFIX

```

5.  Obtain the IP address by running the following command:

```azurecli
    IPADDRESS=$(az vm show \
      --name SimpleWinVM \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --show-details \
      --query [publicIps] \
      --output tsv)

```

6.  Run **curl** to access your web server and verify that the deployment and running of the custom script extension were successful:

```bash
curl $IPADDRESS

```

You'll have the following output:

```Html
<html><body><h2>Welcome to Azure! My name is SimpleWinVM.</h2></body></html>

```

> [!NOTE]
> Don't forget to delete any resources you deployed to avoid incurring extra costs from them.
