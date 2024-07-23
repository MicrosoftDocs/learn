The Azure Blueprint is backed by the globally distributed Azure Cosmos DB, which means that the blueprint objects are replicated to multiple Azure regions with low latency, high availability, and consistent access to your objects. These benefits are available to you at no cost, because the only costs for Azure Blueprints are associated with the resources deployed through a blueprint, like a virtual machine, storage, database, etc.

There are three main aspects related to how Azure Blueprints works: 

* Composition
* Management
* Scale

These following sections dive into some of the details of each one.

### Composition

A blueprint is composed of different artifacts. When you begin designing your blueprint, you need to specify artifacts and their related parameters. The following are the artifacts from a blueprint:

* The **role-based access control (RBAC)** that's applied
* The **resource groups** that are created to store the Azure resources
* The **Azure policies** that you create to enforce business rules
* The **Azure Resource Manager (ARM) template** you deploy in order to automate resource creation

### Management

Considering a blueprint as a package, keep in mind that a package has a lifecycle. The lifecycle of a blueprint consists of:

* Creating a blueprint
* Publishing the blueprint
* Assigning the blueprint
* Versioning the blueprint
* Deleting a blueprint or a specific blueprint version
* Tracking the blueprint assignments

### Scale

The scale is the advantage of using blueprints on multiple subscriptions, streamlining environment creation. For example, ensuring matching environments across production, development, and QA subscriptions is done through the scope of a management group, enforcing the usage of governance as code in your organization among different subscriptions. 

## Locking a blueprint

In addition to the change controls in place, Azure Blueprints also offers a resource-locking functionality. The resource lock protects new resources from being tampered with, even with accounts that have the Owner role. Resources protected by resource locks have four states:

* *Not Locked*
* *Read Only*
* *Cannot Edit/Delete*
* *Cannot Delete*

These assignments can only be removed by updating the blueprint itself and changing it to a different locking mode. Unlike other resources in Azure that can have locks overridden by users with the appropriate RBAC, Azure Blueprints can't be overridden in this manner. This security measure protects the consistency of the defined blueprint and the environment it was designed to create from accidental or programmatic deletion or alteration.

## How Azure Blueprints and Azure Resource Manager templates work together

There are many options available when it comes to making a decision on Infrastructure as Code (IaC) tooling. Additionally, upon first glance, ARM templates and Azure Blueprints seem to overlap and perform the same tasks, adding yet another layer of confusion when there are two native solutions.

Since you can use both features to package an environment together and deploy Azure Artifacts and resources, what’s the difference?

**ARM templates** are documents that don’t exist natively within Azure. These templates are normally stored locally or in a central code repository. Once these templates are deployed, there's no connection between the template and the resources that are deployed. Issues might arise such as templates not being updated in a timely manner for any changes that are required for the resource (and future resources), or templates being updated without proper documentation as to what changed.

**Azure Blueprints** attempts to resolve the above issues by maintaining the connection between blueprint definition and blueprint assignment. This relationship allows for tracking and auditing of deployments, along with allowing blueprints to update multiple subscriptions at the same time.

:::image type="content" source="../media/3-how-it-works.png" alt-text="Illustration that shows how Azure Blueprint works.":::

ARM templates and Azure Blueprints can also work hand in hand. There’s no need to abandon your existing templates in exchange for blueprints, as Azure Blueprints also offer the functionality to embed existing templates into your blueprint. This has the added benefit of providing a central resource for your templates, along with the extra assurance that they can be utilized to their fullest extent. 

There are also many third-party offerings that have similar features around governance and compliance. These tools offer numerous base infrastructure as code benefits, namely being able to standardize and automate deployments, but they have a similar problem to ARM templates. All of your code base is stored outside of your environment. 

Another layer of management is needed to ensure that your templates are secure and accessible. In addition, it lacks some of the features that Azure Blueprints provides, such as resource protection using resource Locks and having native built-in controls for maintenance.