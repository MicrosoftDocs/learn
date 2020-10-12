There might be situations where you need to optionally deploy a resource. The reason could be if the resource already exist or there exist some other pre conditions that says to deploy one resource over another.

Picture the following situations:

- **Pre existing resource**. You might for example have an Azure KeyVault already deployed. If it exist there's no need to create a new one. Being able to express that in a template can save you time when deploying.
- **Dependency**. Another useful thing to express is to only deploy a set of resources if a specific resource already exists.
- **Branching logic**. Depending on what parameters you pass to a template, at deployment time, you might want to deploy a very different set of resources. Think of this is *branching logic*. If the parameter has a certain type of value then select the first branch otherwise select the second or third branch to deploy and so on.

## Conditional deployment

There's a construct called `condition`. It's a property with a value that needs to evaluate to either `true` or `false`. By attaching it to a resource element you are instructing ARM to evaluate whether this resource should be deployed or not.

### Evaluation

There are two ways in which the condition can be evaluated. Knowing about these two ways might affect how you choose to express your *conditional* logic. The two different ways are:

- **The value is either true/false**. An example of this case is for example the following construct **"condition": "[parameters('deployAccount')]"**. Note how the value is the value of the parameter `deployAccount`. Looking close at the parameter we define it like so:

   ```json
   "parameters": {
    "deployAccount": {
      "type": "bool",
      "defaultValue": true,
      "metadata": {
        "description": "deploy account or not"
      }
    }
   }
   ```

- **There's an expression evaluating to true/false**. How's this version different from the first one? You can for example use the built-in template function `equals(arg1, arg2)` where `arg1` needs to be equal to `arg2`. Then your `condition` construct might be expressed like this instead "condition": **"[equals(parameters('newOrExisting'),'new')]"**. Using this construct the value you pass into a parameter no longer needs to be `true` or `false` but anything you like as long as you use it in combination with the `equals()` function.

## Dependency

Let's say you have an example where you want to deploy a set of resources but only if a resource like a KeyVault is already deployed. It could be deployed in a previous deployment or it could be part of the specification in your current one. How do you express such logic in your template? It's tempting to approach this logic with the `condition` operator and try do some kind of *lookup* towards your existing state to see if said resource already exist. There's another more elegant way you could be using that relies on how things work by default. The two constructs that can accomplish this logic is *iterative mode* and something called *dependsOn*. *Iterative mode* works in the following way, pre existing resources in your resources list will not be deployed anew but rather left as is. This is great, you can use that to deploy your KeyVault. For the next part the *dependsOn* construct makes resources wait until the pointed out resource has finished deploying. Your template might therefore look something like the following:

```json
"resources": [
  {
    "name": "<name of resource that needs to exist first>"
  },
  {
    "name": "someResource",
    "dependsOn": [
      "<name of resource that needs to exist first>"
   ]
  }
]
```

Above you are using the name of the resource to specify what resource you are dependent on. However, many resources may have the same name. To ensure this comparison does what you want, you can instead use the `resourceId()` construct to get the unique resourceId, like so:

```json
"dependsOn": [
      "resourceId('Microsoft.Network/loadBalancers', variables('nameOfLoadBalancer')))"
   ]
```

Above you are combining the namespace, the type and a variable name to look up the unique resource id.

### Child resources

A child resource is a resource existing within another resource definition like so:

```json
{
  "name" : "parent",
  "resources": [{
    "name": "child"
  }]
}
```

The parent child dependency does not automatically create a dependency in which the parent is deployed before it's child. The default deployment behavior with ARM is to deploy resource in parallel. If you have such a situation where you need the *parent* to exist before the child you should use the *dependsOn* , like so:

```json
{
  "name" : "parent",
  "resources": [{
    "name": "child",
    "dependsOn": ["parent"]
  }]
}
```

> [!NOTE]
> Ensure you use the `dependsOn` construct for the right reason. Using it to express a parent-child dependency is not a good case, unless the parent needs to exist before the child.


Teach how to figure out who is parent and child for the sake of deployment order. 

Concept https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/conditional-resource-deployment 

Conditions - https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-use-conditions 

Deployment order - https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/define-resource-dependency  

  

https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-create-templates-with-dependent-resources?tabs=CLI   