## Get an access key

If you haven't done so already, run the following command in Azure Cloud Shell to store the API access key in a variable called `key`. We'll use this variable in subsequent calls.

```azurecli
key=$(az cognitiveservices account keys list \
--name ComputerVisionService \
--resource-group <rgn>[sandbox resource group name]</rgn> \
--query key1 -o tsv)
```
