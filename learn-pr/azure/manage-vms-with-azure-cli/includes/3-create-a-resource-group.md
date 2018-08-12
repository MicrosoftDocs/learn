Our goal is to create a new Azure Virtual Machine. We will need to supply several pieces of information so that Azure knows where to place the resources, what OS to use, and the hardware configuration we desire. Let's start with the **resource group**.

## Create a resource group

Azure uses _resource groups_ to group related resources such as virtual machines and databases together - this allows us to place them into a specific region and to work with everything in the resource group as a single unit. When creating new virtual machines, you will always need to identify a specific resource group that will own it and you can either use an existing resource group, or create a new one depending on your needs.

Since we are experimenting with Azure, let's start by creating a new resource group named `ExerciseResources` in the `eastus` region. We will be placing our new virtual machine into this group so it will be created in a data center associated with this region.

> [!NOTE]
> Make sure to use this exact name for your new resource group, the Microsoft Learn system will be looking for this resource name later. 

Type the following Azure CLI command in the Cloud Shell. This will create the resource group in your subscription.

```azurecli
az group create --name ExerciseResources --location eastus
```

This will return a JSON block indicating the resource group has been created. It should look something like:

```json
{
  "id": "/subscriptions/abc13b0c-d2c4-64b2-9ac5-2f4cb819b752/resourceGroups/ExerciseResources",
  "location": "eastus",
  "managedBy": null,
  "name": "ExerciseResources",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null
}
```

Notice that it returns the subscription id, location, and name as part of the response - you can use these to verify it got created in the proper subscription and location.

Now that we have a resource group, let's create a new virtual machine.