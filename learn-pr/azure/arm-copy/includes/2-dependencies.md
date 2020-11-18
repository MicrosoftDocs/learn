Let's say you have an example where you want to deploy a set of resources but only if another resource is already deployed. At that point you need to communicate in the template that something depends on something else. 

There are few angles to this worth considering:

- **Something needs to exist before something else can be deployed**. What you want to express is that a critical resource must exist before you venture on and deploy a specific resource. A typical example is an Azure Key Vault that may hold secrets that, for example,  can be used by a VM to set its password. When deploying a Key Vault you can at the same time deploy its secret, within the same template. However the Key Vault would need to be deployed before its secret. Therefore you can say that the secret would _depend_ on the Key Vault to exist. What happens in this case is that the Key Vault and the secret would be serially deployed, one after another, starting with the KeyVault, because of their dependency.

- **Can I rely on how things work on ARM**. Your first thought, in trying to check if another resource exists, is to use something like PowerShell or Azure CLI and run a command to check for a resource's existence. There is a better way, namely relying on how ARM works, more precisely how incremental deployment works. Let's investigate this approach more in this unit.

- **Nested resources**. As part of defining your template, you can define nested resources within a resource. Having the resources nested express that these resources is something that is related to the top-level resource. It's worth exploring these types of resources closer to ensure how they work with dependencies in mind.

## Dependency

Imagine you have the following situation, you want to ensure that a dependant resource has been deployed, let's say a storage account. There's another resource that relies on the storage account to exist, so how do you check that the storage account exists?

It's tempting to approach this scenario and think that you need to check the current state in the cloud and run a PowerShell or Azure CLI script or command and check for the existence of the storage account. Another approach could be to see if there's an ARM construct that allows you to do the same check.

There's another more elegant way you could be using that relies on how things work by default. The two constructs that can accomplish this logic is _incremental mode_ and an ARM construct  called _dependsOn_. This approach leads you to a two-step solution:

- **Take advantage of the incremental mode**. By using how ARM works when in _incremental mode_ you are safe placing your storage account definition in the resources list knowing that it will either deploy it or leave it be, if it already exists.
- **Use the _dependsOn_ construct**. For the next part, the _dependsOn_ construct makes resources wait until the pointed out resource has finished deploying.

### _dependsOn_ construct

The _dependsOn_ construct is a key-value construct that enables you to decide the deployment order between resources. Sometimes you need to ensure something exist before something else. A concrete example is a database that needs to exists before an app or that a secret resource needs to exist before a KeyVault.

The idea is to place the _dependsOn_ construct on a resource that depends on other resources to be deployed first. A resource can depend on more than one resource, which is why the construct expects a list of dependent resources as its value.

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

In this example, you are using the name of the resource to specify what resource you are dependent on. However, many resources may have the same name. To ensure this comparison does what you want, you can instead use the `resourceId()` construct to get the unique `resourceId`, like so:

```json
"dependsOn": [
  "resourceId('Microsoft.Network/loadBalancers', variables('nameOfLoadBalancer')))"
]
```

The above JSON constructs a unique ID by combining the namespace, the type, and a variable name. This way you ensure that the correct dependant resource is being pointed out.

### Child resources

A child resource is a resource that only exists within the context of another resource. An example of that is virtual machine extension that can't exist without a virtual machine.  

A typical encoding for a parent-child relationship in a template looks like the following JSON:

```json
"resources": [
  {
    "name": "parent-resource",
    "resources": [{
      "name": "child-resource"
    }]
  }
]
```

The parent child dependency does not automatically create a dependency in which the parent is deployed before it's child, you need to add such a dependency.

So when you express such a relationship, be sure to add a _dependsOn_ construct, like the following JSON:

```json
"resources": [
  {
    "name": "parent-resource",
    "resources": [{
      "dependsOn": ["parent-resource"],
      "name": "child resource"
    }]
  }
]
```
