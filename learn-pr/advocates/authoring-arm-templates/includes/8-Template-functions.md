 The brackets indicate that the syntax inside the brackets is a template expression. Resource Manager resolves the syntax rather than treating it as a literal value.

Functions add flexibility to your template by dynamically getting values during deployment. In this tutorial, you use a function to get the location of the resource group you're using for deployment.


The parameter default value calls the resourceGroup function. This function returns an object with information about the resource group being used for deployment. One of the properties on the object is a location property. When you use the default value, the storage account location has the same location as the resource group. The resources inside a resource group don't have to share the same location. You can also provide a different location when needed.

##### Function types
1. Array and object functions
1. Comparison functions
1. Date functions
1. Deployment value functions
1. Logical functions
1. Numeric functions
1. Resource functions
1. String functions


[ARM template functions](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-functions)

