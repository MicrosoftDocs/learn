Let's say you have an example where you want to deploy a set of resources but only if another resource is already deployed. At that point you need to communicate in the deploy that something depends on something else. 

There are few angles to this worth considering:

- **Something needs to exist before something else can be deployed**. What you want to verify is that a critical resource already exist before you venture on and deploy the resources. A typical example is an Azure KeyVault that may hold secrets that a VM needs for it's password. Before you can deploy the VM the Azure KeyVault and its secret needs to be in place.
- **Can I rely on how things work on ARM?**. Your first thought in trying to express a _dependency_ might bbe that you want to look up the state on Azure to see if that resource is already in place. You can solve it that way and it involves mixing in PowerShell in your template. There is a better way, namely relying on how ARM works, more precisely how incremental deployment works. Let's investigate this approach more in this unit.
- **Nested resources**. As part of defining your template you can define nested resources within another resource. Nested resources express that this is something that is related to the top-level resource. It's worth exploring these types of resources closer to ensure how they work with dependencies in mind.

## Dependency

It could be deployed in a previous deployment or it could be part of the specification in your current one. How do you express such logic in your template? It's tempting to approach this logic with the `condition` operator and try do some kind of *lookup* towards your existing state to see if said resource already exists. There's another more elegant way you could be using that relies on how things work by default. The two constructs that can accomplish this logic is *iterative mode* and something called *dependsOn*. *Iterative mode* works in the following way, pre-existing resources in your resources list will not be deployed anew but rather left as is. This is great, you can use that to deploy your KeyVault. For the next part, the *dependsOn* construct makes resources wait until the pointed out resource has finished deploying. Your template might therefore look something like the following JSON:

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

Above you are combining the namespace, the type, and a variable name to look up the unique resource ID.

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

The parent child dependency does not automatically create a dependency in which the parent is deployed before it's child. The default deployment behavior with ARM is to deploy resource in parallel. If you have such a situation where you need the *parent* to exist before the child you should use the *dependsOn, like so:

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
