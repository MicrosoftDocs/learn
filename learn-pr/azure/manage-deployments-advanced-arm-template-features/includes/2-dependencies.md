Let's say you want to deploy a set of resources to Azure, but only if another resource is already deployed. At that point you need to communicate in the template that one resource depends on another resource.

Here are few aspects to consider:

- **Something needs to exist before something else can be deployed.**

    For example, say you need a key vault in Azure Key Vault in order to fetch secrets that you need to load in a virtual machine (VM). When deploying the key vault, you can at the same time deploy its secret within the same template. However, the key vault needs to be deployed before its secret. Therefore, the secret _depends_ on the key vault to exist. The key vault and the secret are deployed serially, one after another, starting with the key vault, because of the dependency.

- **Can I rely on how things work on Azure Resource Manager?**

    Your first thought when checking whether another resource exists might be to use Azure PowerShell or the Azure CLI to check for a resource's existence. A more automated solution uses Resource Manager's built-in idempotency. If Resource Manager spots a resource defined in a template that already exists in the cloud, it doesn't redeploy it. For this to be a valid approach, you need to understand how Resource Manager does the check.

    > [!NOTE]
    > When existing resources identities match something defined in a template, Azure Resource Manager compares the properties. If the properties match exactly, the resource is left alone. If they don't, the engine makes the changes, possibly redeploying the resource.

- **You can nest resources within another resource.**

    In your Azure Resource Manager templates, you can nest resources within another resource. By nesting resources, you define a relationship between the nested resources and the parent resource.

## How can I define dependencies among Azure resources?

Imagine that you want to ensure that a resource (for example, a storage account) has been deployed before a resource that requires it. How can you check whether the dependent storage account exists?

You might start by inspecting the current state of your deployment, by running Azure PowerShell or Azure CLI commands to check for the existence of the storage account. You might also see whether there's a Resource Manager construct that allows you to do the same check.

There's such a construct in Resource Manager templates, called `dependsOn`. Using this construct makes resources wait until the pointed out resource has finished deploying.

### What's the dependsOn construct?

It's a key-value pair that enables you to define the deployment order between resources. Sometimes you need to ensure something exists before something else. For example, you might need a database to exist before an app, or a secret resource to exist before a key vault.

Place the `dependsOn` construct on a resource that depends on other resources to be deployed first. A resource can depend on more than one resource, which is why the construct expects a list of dependent resources as its value.

The following example shows how you might express such a dependency in JSON within your ARM template:

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

In this example, you're using the name of the resource to specify what resource you are dependent on. However, many resources might have the same name. To ensure this comparison does what you want, you can instead use the `resourceId()` construct to get the unique resource identifier:

```json
"dependsOn": [
  "resourceId('Microsoft.Network/loadBalancers', variables('nameOfLoadBalancer')))"
]
```

The above JSON code constructs a unique ID by combining the namespace, the type, and a variable name. This way, you ensure that the correct dependent resource is specified.

### What are child resources?

A child resource is a resource that only exists within the context of another resource. An example of this is a virtual machine extension, which can't exist without a virtual machine.  

Typical code for a parent-child relationship in a template looks like this:

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

This parent-child dependency doesn't automatically create a dependency in which the parent is deployed before its child. You need to make the dependency explicit.

So when you express such a relationship, be sure to add a `dependsOn` construct, like the following:

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
