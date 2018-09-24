Now that a virtual machine has been created, we can get information about it through other commands.

Let's start with `vm list`.

```azurecli
az vm list
```

This command will return _all_ virtual machines defined in this subscription. The output can be filtered to a specific resource group through the `--resource-group` parameter. 

## Output types
Notice that the default response type for all the commands we've done so far is JSON. This is great for scripting - but most people find it harder to read. You can change the output style for any response through the `--output` flag. For example, try the following command in Azure Cloud Shell to see the different output style.

```azurecli
az vm list --output table
```

Along with `table`, you can specify `json` (the default), `jsonc` (colorized JSON), or `tsv` (Table-Separated Values). Try a few variations with the above command to see the difference.

## Getting the IP address

Another useful command is `vm list-ip-addresses`, which will list the public and private IP addresses for a VM. If they change, or you didn't capture them during creation, you can retrieve them at any time.

```azurecli
az vm list-ip-addresses -n SampleVM -o table
```

This returns:

```
VirtualMachine    PublicIPAddresses    PrivateIPAddresses
----------------  -------------------  --------------------
SampleVM          168.61.54.62         10.0.0.4
```

> [!TIP]
> Notice that we are using a shorthand syntax for the `--output` flag as `-o`. Most parameters to Azure CLI commands can be shortened to a single dash and letter. For example, `--name` can be shortened to `-n` and `--resource-group` to `-g`. This is handy for typing, but we recommend using the full option name in scripts for clarity. Check the documentation for details on each command.

## Getting VM details

We can get more detailed information about a specific virtual machine by name or ID using the `vm show` command.

```azurecli
az vm show --resource-group <rgn>[sandbox resource group name]</rgn> --name SampleVM
```

This will return a fairly large JSON block with all sorts of information about the VM, including attached storage devices, network interfaces, and all of the object IDs for resources that the VM is connected to. Again, we could change to a table format, but that omits almost all of the interesting data. Instead, we can turn to a built-in query language for JSON called [JMESPath](http://jmespath.org/).

## Adding filters to queries with JMESPath

JMESPath is an industry-standard query language built around JSON objects. The simplest query is to specify an _identifier_ that selects a key in the JSON object.

For example, given the object:

```json
{
  "people": [
    {
      "name": "Fred",
      "age": 28
    },
    {
      "name": "Barney",
      "age": 25
    },
    {
      "name": "Wilma",
      "age": 27
    }
  ]
}
```

We can use the query `people` to return the array of values for the `people` array. If we just want _one_ of the people, we can use an indexer. For example, `people[1]` would return:

```json
{
    "name": "Barney",
    "age": 25
}
```

We can also add specific qualifiers that would return a subset of the objects based on some criteria. For example, adding the qualifier `people[?age > '25']` would return:

```json
[
  {
    "name": "Fred",
    "age": 28
  },
  {
    "name": "Wilma",
    "age": 27
  }
]
```

Finally, we can constrain the results by adding a select: `people[?age > '25'].[name]` that returns just the names:

```json
[
  [
    "Fred"
  ],
  [
    "Wilma"
  ]
]
```

JMESQuery has several other interesting query features. When you have time, check out the [online tutorial](http://jmespath.org/tutorial.html) available on the [JMESPath.org](http://jmespath.org/) site.

## Filtering our Azure CLI queries

With a basic understanding of JMES queries, we can add filers to the data being returned by queries like the `vm show` command. For example, we can retrieve the admin user name:

```azurecli
az vm show --resource-group <rgn>[sandbox resource group name]</rgn> --name SampleVM --query "osProfile.adminUsername"
```

We can get the size assigned to our VM:

```azurecli
az vm show --resource-group <rgn>[sandbox resource group name]</rgn> --name SampleVM --query hardwareProfile.vmSize
```

Or to retrieve all the IDs for your network interfaces, you can use the query:

```azurecli
az vm show --resource-group <rgn>[sandbox resource group name]</rgn> --name SampleVM --query "networkProfile.networkInterfaces[].id"
```

This query technique will work with any Azure CLI command and can be used to pull specific bits of data out on the command line. It is useful for scripting as well - for example, you can pull a value out of your Azure account and store it in an environment or script variable. If you decide to use it this way, a useful flag to add is the `--output tsv` parameter (which can be shortened to `-o tsv`). This will return the results in tab-separated values that only include the actual data values with tab separators.

As an example,

```azurecli
az vm show --resource-group <rgn>[sandbox resource group name]</rgn> --name SampleVM --query "networkProfile.networkInterfaces[].id" -o tsv
```

returns the text: `/subscriptions/20f4b944-fc7a-4d38-b02c-900c8223c3a0/resourceGroups/2568d0d0-efe3-4d04-a08f-df7f009f822a/providers/Microsoft.Network/networkInterfaces/SampleVMVMNic`
