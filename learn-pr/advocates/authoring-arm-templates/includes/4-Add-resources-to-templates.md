

The key here is to find the right properties to use for each resource type. You should use the [ARM template reference](https://docs.microsoft.com/en-us/azure/templates/) to find the resource types you want to deploy.

Every resource you deploy has at least the following three properties:

- **type**: Type of the resource. This value is a combination of the namespace of the resource provider and the resource type, such as Microsoft.Storage/storageAccounts which you will use in this part of the exercise.
- **apiVersion**: Version of the REST API to use for creating the resource. Each resource provider published its own API versions, so this value is specific to the type.  To get the information regarding which apiVersion is the one you should be using the [Define resources in Azure Resource Manager templates](https://docs.microsoft.com/en-us/azure/templates/) page has the information needed to select the right apiVersion.  For the storage account you will deploy in this exercise, the afore mentioned page will provide you with all the properties that [resource requires](https://docs.microsoft.com/en-us/azure/templates/microsoft.storage/2019-06-01/storageaccounts#property-values).
- **name**: Name of the resource.

The majority of resources also require a **location** property, which sets the region where the resource is deployed.

The other properties will vary by resource type and API version. It's important to understand the connection between the API version and the available properties, so let's jump into more detail.

In this exercise, you are adding a storage account to the empty template we created in the last exercise. You can see in the code you copied to your template, that API version for storageAccounts is **2019-04-01** (/azure/templates/microsoft.storage/2019-04-01/storageaccounts). Notice that you didn't add all of the properties to your template. Many of the properties are optional. The Microsoft.Storage resource provider could release a new API version, but the version you're deploying doesn't have to change. You can continue using that version and know that the results of your deployment will be consistent.

If you view an older API version, such as [storageAccounts 2016-05-01](/azure/templates/microsoft.storage/2016-05-01/storageaccounts), you'll see that a smaller set of properties are available.

If you decide to change the API version for a resource, make sure you evaluate the properties for that version and adjust your template appropriately.