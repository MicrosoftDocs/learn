Let's say you have an example where you want to deploy a set of resources but only if another resource is already deployed. At that point you need to communicate in the template that something depends on something else. 

There are few angles to this worth considering:

- **Something needs to exist before something else can be deployed**. What you want to verify is that a critical resource already exist before you venture on and deploy the resources. A typical example is an Azure KeyVault that may hold secrets that a VM needs for it's password. Before you can deploy the VM the Azure KeyVault and its secret needs to be in place.
- **Can I rely on how things work on ARM?**. Your first thought in trying to express a _dependency_ might be that you want to look up the state on Azure to see if that resource is already in place. You can solve it that way and it involves mixing in PowerShell in your template. There is a better way, namely relying on how ARM works, more precisely how incremental deployment works. Let's investigate this approach more in this unit.
- **Nested resources**. As part of defining your template you can define nested resources within another resource. Nested resources express that this is something that is related to the top-level resource. It's worth exploring these types of resources closer to ensure how they work with dependencies in mind.

## Dependency

Imagine you have the following situation, you want to ensure that a dependant resource has been deployed, let's say a storage account. There's another resource that relies on the storage account to exist, so how do you check that the storage account exist?

It's tempting to approach this scenario and think that you need to check the current state in the cloud and run a PowerShell/Azure CLI script and check for the existence of the storage account. Another approach could be to see if there's an ARM construct that allows you to do the same check.

There's another more elegant way you could be using that relies on how things work by default. The two constructs that can accomplish this logic is _incremental mode_ and an ARM construct  called _dependsOn_. This approach leads you to a two step solution:

- **Take advantage of the incremental mode**. By using how ARM works when in _incremental mode_ you are safe placing your storage account definition in the resources list knowing that it will either deploy it or leave it be, if it already exist.
- **Use the _dependsOn_ construct**. For the next part, the _dependsOn_ construct makes resources wait until the pointed out resource has finished deploying.

### _dependsOn_ construct

The _dependsOn_ construct is a key-value property you can set and define a that there's a dependency between one to many resources. The idea is to place the construct on a resource that depends on other resources to be deployed first. A resource can depend on more than one resource which is why the construct expects a list of dependent resources as its value.

Below is an example of how you might express such a dependency in JSON in your template:

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

The above JSON constructs a unique ID by combining the namespace, the type, and a variable name. This way you ensure that the correct dependant resource is being pointed out.

### Child resources

A child resource is a resource existing within another resource definition. The idea with a child definition is to express that this is resource that belongs to the parent resource. Worth noting is that ARM tries to deploy things in parallel by default. By using such an approach, resources are deployed as fast as possible. It's easy to think that just because you have a parent-child relationship this decides deployment order, that's not the case.

The parent child dependency does not automatically create a dependency in which the parent is deployed before it's child. If you have such a situation where you need the _parent_ to exist before the child you should use the _dependsOn_ construct, like the below JSON:

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
> Ensure you use the _dependsOn_ construct for the right reason. Using it to express a parent-child dependency is not a good case, unless the parent needs to exist before the child.
