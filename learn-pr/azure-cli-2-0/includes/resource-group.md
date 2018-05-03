 In Azure, all resources are allocated in a resource management group. Resource groups provide logical groupings of resources that make them easier to work with as a collection. For this tutorial, all of the created resources will go into a single group named `TutorialResources`. We must also specify the _location_ we want these resources to be physically created in, use **eastus** for this tutorial.

 ```azurecli
  az group create --name TutorialResources --location eastus
 ```
