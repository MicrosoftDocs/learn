You've so far declared resources in a resources list in a template. When deploying, you end up getting one instance of each item specified in the resources list. You might want to create more than one instance of a specific resource. For example, you might want multiple subnets in a virtual network. 

Consider the following questions and points when you're thinking about creating many instances, and iterating over constructs:

- **Do I need more than one copy**: For simpler scenarios, you might not. For more advanced scenarios, like subnets or virtual machines, you might need to consider whether you need more than one copy of something.
- **Am I dependent on a resource**: Normally Azure Resource Manager is good at figuring out what needs to be constructed in what order, so that references within the Azure Resource Manager template work out. There are situations, though, where you might need to specify the order.
- **Define a naming scheme**: You want to give your resources meaningful names. For that reason, you rely on parameters being passed at deploy time. When you have multiple copies, you might want to have more granular control and base the naming on what iteration in the copying sequence you're currently on.
- **Configure and control resource creation**: You might want to limit how many resources are being created in a production environment. It's possible to do so by configuring the resource creation as *serial* or *parallel*.
- **Copy other types**: Resources aren't the only thing you can create multiple copies of and iterate over. You can in fact do the same with properties, variables, and output.
- **Parent-child**: You might need to configure parent-child relationships in your resources.

## Create multiple instances

You can use looping constructs to save you keystrokes. If what you need is repeated over and over, is fairly similar in name and type, and has only slight differences, then you might benefit from using the copy element.

The *copy element* is piece of JSON that you can use on many types of constructs, like resources, properties, variables, and output. The syntax for the copy element consists of the key _copy_, and an array as the value. For example: `"copy": []`.

The array takes a number of elements, and each element is an object `{}` consisting of a set of properties. What these properties are depends on what type of construct they're used on. Typically, all of the `copy` element constructs have one property in common: `count`. This property decides on how many instances you want of a certain type of construct. Most constructs also allow for a `name` property that gives you a reference that you can refer to in other parts of your code. Other properties used are construct-specific.

### What to choose

You might ask: "If I can use the `copy` element on many types of constructs, which one should I choose and when, and can I use more than one type in a template?"

It all depends on your use case. A _resource iteration_ allows you to create many copies of a resource and makes sense to use if you need many storage accounts, for example. A _properties iteration_, on the other hand, allows you to create many properties inside of one resource. It's about saving you keystrokes and time, and you know best where you have repeated parts in your template.

You can use the `copy` element in many places in your template. You can use a `copy` element to create many resources, but also to create many similar variables within the same template.

### How it works

The `copy` element works by your `copy` statement being evaluated and replaced. The replacement is the result of what you define within the `copy` statement repeated as many times as you instructed in the `copy` field. 

The following example shows what a definition using `copy` can look like:

```json
"copy": [
  {
    "name": "dataDisks",
    "count": 2,
    "input": {
      "diskSizeGB": 1023,
      "lun": "[copyIndex('dataDisks')]",
      "createOption": "Empty"
    }
  }
]
```

Note the entry `count: 2`. The value `2` means that you want the above expression to expand to two entries. The following is the result:

```json
"dataDisks": [
{
  "lun": 0,
  "createOption": "Empty",
  "diskSizeGB": 1023
},
{
  "lun": 1,
  "createOption": "Empty",
  "diskSizeGB": 1023
}
```

You can see that the value of the `name` property has become the property name, and the contents of the `input` property have become the part of the JSON that's repeated.

> [!NOTE]
> The copy expression and it's output differs by what type of expression is used. The preceding example does give a good idea of what's going on when an expression is transformed into a series of repeated statements.

There are limits to how much can be copied. Currently the limit is 800 entries.

> [!IMPORTANT]
> For more information on the exact limitations, see [Resource iteration in ARM templates](https://docs.microsoft.com/azure/azure-resource-manager/templates/copy-resources).

## Control the iteration

There are helper functions that help you refer to specific indexes in the array. The function `copyIndex()` returns the current index. For example, for the third repeated entry, `copyIndex()` returns the value `2`. The syntax of `copyIndex()` looks like the following:

```json
copyIndex(loopName, offset)
```

The `copyIndex()` function has two different input parameters, `loopName` and `offset`. The `offset` parameter is always optional and is used to offset you from the current index. Whatever you add as the `offset` value is added to the current index. If the current index returns `2`, and you specify `1` as the offset, the `copyIndex()` function returns `3`.

The `loopName` parameter is either optional or mandatory, depending on where it's used. It's mandatory if used inside of a `properties` construct, and optional if used in a `resources` array. Here's an example where it's mandatory:

```json
"properties": {
    "storageProfile": {
      "copy": [
        {
          "name": "dataDisks",
          "count": "[parameters('numberOfDataDisks')]",
          "input": {
            "diskSizeGB": 1023,
            "lun": "[copyIndex('dataDisks')]",
            "createOption": "Empty"
          }
        }
      ]
    }
}
```

Note how the `copy` element is used inside of a `properties` construct, and `copyIndex()` has the `loopName` specified as `copyIndex('dataDisks')`.

Now here's an example where `loopName` isn't mandatory:

  ```json
  {
    "type": "Microsoft.Network/virtualNetworks",
    "apiVersion": "2018-04-01",
    "name": "[concat(parameters('vnetname'), copyIndex())]",
  }
  ```

It shows a resource being declared, and `copyIndex()` is called with no parameters, because it's being used in the context of a resource.
  
## Configure the deployment

When you use the `copy` element for resources, you end up creating numerous similar looking resources.

Sometimes you might want to control how resources are created and in what order. The reasons for controlling the order might be:

- **Environment limitations**. Depending on what environment you deploy to, you might want to limit how much this environment is affected by a deployment. In a production environment, it makes sense to limit how many resources are affected at any one time. You can configure a *deployment mode* to control the number of concurrently deployed resources.
- **Dependencies**. You might be dependent on something to already exist before you venture on to create the resource you need. To express such a dependency, there's a construct called `dependsOn`.

### Deployment modes and `copy`

You might want to ensure that a set of resources created by the `copy` construct is all being created before something else. If that's the case, you need to express this situation. Remember that what comes into play here is the deployment mode that Resource Manager uses. There are two modes supported:

- **Serial**. Setting a resource to this deployment mode means it will be created one after another. In this mode, you're also expected to set the `batchSize` property to determine how many resources are deployed by using this mode. A new batch can't be started before a preview one has completed. You might want to limit things in this way in a production environment, for example, where it might be important to limit the number of affected resources at any one point.
- **Parallel**. This mode is the default deployment mode. The advantage is high throughput, so the template is processed faster. The drawbacks are that you can't guarantee order, and it might not be what you want for a production environment.

### Dependencies

In the context of the `copy` element, you need to tell the resource with the dependency what section it's waiting for. You accomplish this dependency by referring to it by name, with the following JSON:

```json
"resources": [
    {
      "type": "Microsoft.Storage/storageAccounts",
      "apiVersion": "2019-04-01",
      "name": "[concat(copyIndex(),'storage', uniqueString(resourceGroup().id))]",
      "location": "[resourceGroup().location]",
      "sku": {
        "name": "Standard_LRS"
      },
      "kind": "Storage",
      "copy": {
        "name": "storagecopy",
        "count": 3
      },
      "properties": {}
    },
    {
      "type": "Microsoft.Compute/virtualMachines",
      "apiVersion": "2015-06-15",
      "name": "[concat('VM', uniqueString(resourceGroup().id))]",
      "dependsOn": ["storagecopy"],
    }
  ]
```

Note that the `copy` element has a `name` property with the value `storagecopy`. The dependent resource, a storage account, is waiting for the `copy` element operation to finish. This is expressed by `"dependsOn": ["storagecopy"]`.

The ARM template thus switches to a serial deployment mode between these two resources. It might affect the throughput speed of the deployment, but you've expressed that you care about a certain deployment order, which now takes precedence.
