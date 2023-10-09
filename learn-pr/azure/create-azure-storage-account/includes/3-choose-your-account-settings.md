The storage account settings we've already covered apply to the data services in the account. Here, we discuss the three settings that apply to the account itself, rather than to the data stored in the account:

- Name
- Deployment model
- Account kind

These settings affect how you manage your account and the cost of the services within it.

## Name

Each storage account has a name. The name must be globally unique within Azure, use only lowercase letters and digits and be between 3 and 24 characters.

## Deployment model

A _deployment model_ is the system Azure uses to organize your resources. The model defines the API that you use to create, configure, and manage those resources. Azure provides two deployment models:

- **Resource Manager**: the current model that uses the Azure Resource Manager API
- **Classic**: a legacy offering that uses the classic deployment model

Most Azure resources only work with Resource Manager, which makes it easy to decide which model to choose. However, storage accounts, virtual machines, and virtual networks support both, so you must choose one or the other when you create your storage account.

The key feature difference between the two models is their support for grouping. The Resource Manager model adds the concept of a _resource group_, which isn't available in the classic model. A resource group lets you deploy and manage a collection of resources as a single unit.

Microsoft recommends that you use the **Resource Manager** deployment model for all new resources.

## Account kind

Storage account _kind_ is a set of policies that determine which data services you can include in the account and the pricing of those services. There are four kinds of storage accounts:

- **Standard - StorageV2 (general purpose v2)**: the current offering that supports all storage types and all of the latest features
- **Premium - Page blobs**: Premium storage account type for page blobs only
- **Premium - Block blobs**: Premium storage account type for block blobs and append blobs
- **Premium - File shares**: Premium storage account type for file shares only

Microsoft recommends that you use the **Standard - StorageV2 (general purpose v2)** option for new storage accounts.

The core advice is to choose the **Resource Manager** deployment model and the **Standard - StorageV2 (general purpose v2)** account kind for all your storage accounts. For new resources, there are few reasons to consider the other choices.
