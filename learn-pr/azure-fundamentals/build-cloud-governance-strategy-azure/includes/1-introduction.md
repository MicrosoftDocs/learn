The term _governance_ describes the general process of establishing rules and policies and ensuring that those rules and policies are enforced.

When running in the cloud, a good governance strategy helps you maintain control over the applications and resources that you manage in the cloud. Maintaining control over your environment ensures that you stay compliant with:

* Industry standards, like [PCI DSS](https://docs.microsoft.com/microsoft-365/compliance/offering-pci-dss?view=o365-worldwide?azure-portal=true).
* Corporate or organizational standards, such as ensuring that network data is encrypted.

Governance is most beneficial when you have:

* Multiple engineering teams working in Azure.
* Multiple subscriptions to manage.
* Regulatory requirements that must be enforced.
* Standards that must be followed for all cloud resources.

## Meet Tailwind Traders

[!include[](../../shared/includes/tailwind-traders-overview.md)]

## How will Tailwind Traders improve agility while maintaining control?

Tailwind Traders is continuing its migration to the cloud. For its existing datacenter, development and test teams must submit support tickets to request access to virtual machines, storage, and networking components. It can take IT staff anywhere from two weeks to two months to purchase, provision, and configure these components.

By working in the cloud, you essentially have immediate access to compute, storage, and networking components. Many kinds of groups and users, including people from development, test, operations, and security teams, can potentially have direct access to cloud resources.

Going forward, Tailwind Traders could enforce similar processes that prevent teams from directly creating or configuring resources on Azure, similar to its existing approach where central IT provisions infrastructure. But the company knows that these restrictions reduce team agility and the ability to innovate. How can they enable innovation while still maintaining control?

In this module, you'll help the company explore ways it can enforce standards while still enabling teams to create and manage the cloud resources they need.

## Learning objectives

After completing this module, you'll be able to:

* Make organizational decisions about your cloud environment by using the Cloud Adoption Framework for Azure.
* Define who can access cloud resources by using Azure role-based access control.
* Apply a resource lock to prevent accidental deletion of your Azure resources.
* Apply tags to your Azure resources to help describe their purpose.
* Control and audit how your resources are created by using Azure Policy.
* Enable governance at scale across multiple Azure subscriptions by using Azure Blueprints.
