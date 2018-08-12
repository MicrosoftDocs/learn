Our goal is to create a new Azure Virtual Machine. We'll need to supply several pieces of information to identify the resource location, OS to use, and the hardware configuration needed for the VM. Let's start with the **resource group**.

## Create a resource group

Azure uses _resource groups_ to group related resources such as virtual machines and databases together. The resource group also identifies a specific location (called a "region") which will decide what data center the resource is placed into.

Since we're experimenting, start by creating a new resource group named `ExerciseResources` and place it into the `eastus` region.

> [!NOTE]
> Make sure to use this exact name for your new resource group, the Microsoft Learn system will be looking for this resource name later. 

Type the following Azure CLI command in the Cloud Shell to create the resource group in your subscription.

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

Notice that it returns the subscription unique identifier, location, and name as part of the response - you can use these to verify it got created in the proper subscription and location.

Now that we have a resource group, let's create a new virtual machine.