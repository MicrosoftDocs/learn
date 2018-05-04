 In Azure, all resources are allocated in a resource management group. Resource groups provide logical groupings of resources that make them easier to work with as a collection. For this tutorial, all of the created resources go into a single group named `TutorialResources`. To  specify the physical _location_ you want these resources to be created in, use **eastus** for this tutorial.

 ```azurecli
  az group create --name TutorialResources --location eastus
 ```
