You've so far declared resources in a resources list in a template. When deploying you end up getting one instance of each item specified in the resources list. There are however scenarios where you want to create more than one instance of a specific resource. It could for example be that you want multiple subnets in a virtual network. 

There are different aspects to creating many instances, and iterating over constructs, that you might want to consider:

- **Do I need more than one copy**, for simpler scenarios this answer might be a no. For more advanced scenarios around for example Subnets or Virtual Machines or maybe storage accounts you might need to consider this option.
- **Am I dependent on a resource**. Normally Azure Resource Manager, ARM is pretty good at figuring out what needs to be constructed in what order so that references within the ARM template works out. There are situations though where you might need to specify this explicitly.
- **Define a naming scheme**. You want to give your resources meaningful names. For that reason you rely parameters being passed at deploy time. When you have multiple copies you might want to have more granular control and base the naming on what iteration in the copying sequence you are currently on
- **Configure and control resource creation**. You might want to limit how many resources are being created in a production environment. It's possible to do so by configuring the resource creation as *serial* or *parallel*.
- **Copy other types**. Resources aren't the only thing you can create multiple copies of and iterate over. You can in fact do the same with properties, variables and output.
- **Parent-Child**. What about parent-child relationships in your resources, is that something that works? This too can be configured to work.

## Creating multiple instances

One of the general benefits of using looping constructs is saving you keystrokes. If what you need is repeated over and over, fairly similar in name and type and so on and there are only slight differences, then it's a good use case for something called the *copy element*. 

The *copy element* is piece of JSON that can be used on many types of constructs like resources, properties, variables and output. The syntax for the *copy element* consists of the key `copy` and with an array as value, like so **"copy": []**.  The array takes a number of elements and each element is an object `{}` consisting of set of properties. What these properties are depends on what type of construct they are used on. Typically all of the *copy element* constructs have one property in common `count`. This property decides on how many instances you want of a certain type of construct. Most constructs also allow for a `name` property which gives you a references that you can refer to in other parts of your code. Other properties used are usually construct specific.

### What to choose

If I can use the *copy element* on many types of constructs, which one should I choose and when, and can I use more than one type in a template?

It all depends on your use case. A *resource iteration* allows you to create many copies of a resource and makes sense if you need many storage accounts for example. A *properties iteration* on the other hand allows you to create many properties inside of one resource. It's about saving you keystrokes and time and you know best where you have repeated parts in your template. The answer is also *yes* to be able to use the *copy element* in many places in your template. You could be using a *copy element* to create many resources but also to create many  similar variables within the same template.

### How does it work

Ok, say I elect to use the is *copy element* how does it work, what's the end result?

Let's have a look at a use case:

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

The above *copy element* expression has an entry where `count: 2`, this means that you want the above expression to *expand* to two entries. When this is run it will therefore be turned into the below JSON:

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

From the above expression you can see that the value of the `name` property have become the property name and the content of the `input` property have become the part of the JSON that's actually repeated.

> [!NOTE]
> The copy expression and it's output differs by what type of expression is used. The above does give a good idea of what's going on when an expression is transformed into a series of repeated statements.

There are limits to how much can be copied. Currently the limit is at 800 entries.

> [!IMPORTANT]
>  Be sure to check this [Copy element page](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/copy-resources) to know the exact limitations. 

## Controlling the iteration

There are helper functions that helps you refer to specific indexes in the array. The function `copyIndex()` helps you do just that. The syntax of `copyIndex()` looks like the following:

```json
copyIndex(loopName, offset)
```

The function has two different input parameters `loopName` and `offset`. The `offset` is always optional and is used to *offset* you from the current index. The `loopName` parameter is either optional or mandatory depending on where it's used. It's mandatory if used inside of a properties construct and optional if used in a resources array. Below is an example where it's mandatory:

  ```json
  "properties": {
      "storageProfile": {
        ...
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

The above JSON shows how the *copy element* is used inside of a `properties` construct and `copyIndex()` has the `loopName` specified like so **copyIndex('dataDisks')**.

Let's look at the other case where `loopName` is not mandatory:

  ```json
  {
    "type": "Microsoft.Network/virtualNetworks",
    "apiVersion": "2018-04-01",
    "name": "[concat(parameters('vnetname'), copyIndex())]",
    ...
  }
  ```

Note above how a resource is being declared and `copyIndex()` is called with no parameters.
  
## Configure the deployment

When you use the *copy element* for resources you end up creating a lot of similar looking resources.

Sometimes you might want to control how resources are created and in what order. The reasons for controlling the order might be the below:

- **Environment limitations**. Depending on what environment you deploy to you might want to limit how much this environment is affected by a deployment. In a production environment it makes sense to limit how many resource are affected at any one time. For this you can can configure somethings called *deployment mode*. More on that in a subsection.
- **Dependencies**. You could be dependent on something to already exist before you venture on to create the resource you need. To express such a dependency there's a construct called `dependsOn`. 

### Deployment modes

For this, ARM has the concept of deployment mode. Below are the modes currently available:

- **Serial**. Setting a resource to this deployment mode means it will be created one after another. In this mode you are also expected to set a property `batchSize` to determine how many resources are deployed using this mode. A new *batch* can't be started before a preview one has completed. This ability to limit things this way is something you might want to use in a production environment for example where it might be important to limit the number of affected resources at any one point.
- **parallel**. This is the default deployment mode. The advantages is high throughput so the template ends up being processed faster. The drawbacks are that you can't guarantee order and it might not, as mentioned in the above bullet, be what you want for production environment.

### Dependencies

In the context of the *copy element* you need to tell the resource, with the dependency, what *copy element* section it's waiting for. You accomplish that by referring to it by name. The below JSON expresses such a dependency:

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
      ...
    }
  ]
```

Not above how the *copy element* has a `name` property with the value `storagecopy` and how the dependent resource, a storage account is *waiting* for the *copy element* operation to finish with this expression **"dependsOn": ["storagecopy"]**.

  

> TODO Remove below once done

Keypoints: 

Walk through 

Not straight forward, relationships are hard 

https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-create-multiple-instances?tabs=CLI%2Cazure-cli 
