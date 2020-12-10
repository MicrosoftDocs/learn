Let's say you want to deploy a set of resources to Azure, but only if another resource is already deployed. At that point you need to communicate in the template that one resource depends on another resource.

Here are few aspects to consider:

- **Something needs to exist before something else can be deployed**

    For example, say you need Azure Key Vault in order to fetch secrets that you need to load in a virtual machine (VM). When deploying Key Vault, you can at the same time deploy its secret within the same template. However, the Key Vault needs to be deployed before its secret. Therefore you can say that the secret would _depend_ on the Key Vault to exist. What happens in this case is that the Key Vault and the secret would be deployed serially, one after another, starting with the Key Vault, because of the dependency.

- **Can I rely on how things work on ARM?**

    Your first thought when checking whether another resource exists might be to use something like Azure PowerShell or the Azure CLI to check for a resource's existence. A more automated solution uses a an ARM's built-in idempotency. The idea is that if ARM spots, a resource defined in a template, that already exist in the cloud it would not redeploy it. For this to be a valid approach you need to understand how ARM does the check.

    > [!NOTE]
    > What happens when existing resources identities match something defined in a template is that the resource manager compares the properties - if the properties match exactly, the resource is left alone. If they do not, the engine makes the changes - possibly redeploying the resource.

- **Nested resources**

    In your ARM templates, you can nest resources within another resource. By nesting resources, you define a relationship between the nested resources and the parent resource.

## How can I define dependencies among Azure resources?

Imagine that you want to ensure that a resource, say a storage account, has been deployed before a resource that requires it. How can you check whether the dependent storage account exists?

You might start by inspecting the current state of your deployment by running Azure PowerShell or Azure CLI commands to check for the existence of the storage account. You might also see whether there's an ARM construct that allows you to do the same check.

There's such a construct in ARM, _dependsOn_. Using the _dependsOn_ construct makes resources wait until the pointed out resource has finished deploying.

### What's the dependsOn construct

The _dependsOn_ construct is a key-value pair that enables you to define the deployment order between resources. Sometimes you need to ensure something exist before something else. A concrete example is a database that needs to exists before an app or that a secret resource needs to exist before a Key Vault.

The idea is to place the _dependsOn_ construct on a resource that depends on other resources to be deployed first. A resource can depend on more than one resource, which is why the construct expects a list of dependent resources as its value.

Below is an example of how you might express such a dependency in JSON within your ARM template:

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

In this example, you are using the name of the resource to specify what resource you are dependent on. However, many resources may have the same name. To ensure this comparison does what you want, you can instead use the `resourceId()` construct to get the unique resource identifier, like so:

```json
"dependsOn": [
  "resourceId('Microsoft.Network/loadBalancers', variables('nameOfLoadBalancer')))"
]
```

The above JSON code constructs a unique ID by combining the namespace, the type, and a variable name. This way, you ensure that the correct dependant resource is specified.

### What are child resources?

A child resource is a resource that only exists within the context of another resource. An example of is a virtual machine extension, which can't exist without a virtual machine.  

A typical code for a parent-child relationship in a template looks like this:

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

This parent-child dependency does not automatically create a dependency in which the parent is deployed before it's child. You need to make the dependency explicit.

So when you express such a relationship, be sure to add a _dependsOn_ construct, like the following:

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
