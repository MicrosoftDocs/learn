 Now that you have created a VM, you can retrieve detailed information about it. The common command for getting information from a resource is `show`.

```azurecli
az vm show --name TutorialVM1 --resource-group TutorialResources
```

This command produces a lot of information, which can be difficult to parse visually. For example, you can find information about authentication, network interfaces, and storage. Most importantly, you can find the Azure object IDs for resources that the VM is connected to. Object IDs allow you to access these resources directly to get more information about the VM's configuration and capabilities. 
        
To extract the object ID you want, use the `--query` argument. Write your queries in the [JMESPath query language](http://jmespath.org). Start with getting the network interface controller (NIC) object ID.

```azurecli
az vm show --name TutorialVM1 \
  --resource-group TutorialResources \
  --query 'networkProfile.networkInterfaces[].id' \
  --output tsv
```

There's a lot going on here, just by adding the query. Each part of it references a key in the output JSON, or is a JMESPath operator.

* `networkProfile` is a key of the top-level JSON, which has `networkInterfaces` as a subkey. If a JSON value is a dictionary,
  its keys are referenced from the parent key with the `.` operator.
* The `networkInterfaces` value is an array, so it is flattened with the `[]` operator. This operator runs the remainder
  of the query on each array element. In this case, it gets the `id` value of every array element.

The output format `tsv` (tab-separated values) is guaranteed to include only the result data and whitespace, consisting of tabs and new lines. Because the returned value is a single bare string, it's safe to assign directly to an environment variable.

Go ahead and assign the NIC object ID to an environment variable now.

```bash
NIC_ID=$(az vm show -n TutorialVM1 -g TutorialResources \
  --query 'networkProfile.networkInterfaces[].id' \
  -o tsv)
```

This example also demonstrates the use of short arguments. You may use `-g` instead of `--resource-group`, `-n` instead of `--name`, and `-o` instead of `--output`.
