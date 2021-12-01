## How Azure Blueprints works

The Azure Blueprint is backed by the globally distributed Azure Cosmos DB, which means that the blueprint objects are replicated to multiple Azure regions with low latency, high availability and consistent access to your objects.

All of this are available to you at no costs, since the only costs with Azure Blueprints will be associated with the resources deployed through a blueprint, like a virtual machine, storage, database, etc.

The operation of the Azure Blueprints could be divided:

* Composition
* Management
* Scale

### Composition

During the composition, you will be designing your blueprint. The design involves the specification of artifacts (and their related parameters) to be used:

* Role based access controls that will be applied
* The resource groups that will be created to store the Azure resources
* The policies you would like to create to enforce business rules
* The Azure Resource Manager template which you would like to deploy in order to automate resource creation

### Management

Remember that as a package, your blueprint will have a lifecycle. Then the lifecycle of a blueprint consists of:

* Creation of a blueprint
* Publishing of the blueprint
* Assignment of the blueprint
* Versioning of the blueprint
* Deletion of a blueprint or a specific blueprint version
* Track the blueprint assignments

### Scale

The scale is the advantage of use blueprints to multiple subscriptions through the scope of a management group, enforcing the usage of governance as code in your organization among different subscriptions. Besides this, the blueprint package could be used in a repeatable manner to best meet your needs.

## Azure Blueprints workflow

Here is a sample about the Azure Blueprints workflow with the overall process.

:::image type="content" source="../media/3-how-it-works.png" alt-text="Illustration on how Azure Blueprint works.":::
