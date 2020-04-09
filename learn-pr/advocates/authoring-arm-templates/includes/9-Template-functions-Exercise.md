#### Add template functions to your ARM template

At the end of the previous tutorial, your template had the following JSON:

:::code language="JSON" source="../samples/exercise3-parameter-sku.json":::

In this exercise you will update your template to remove the hard coded **Location** from **East US** (or **eastus**).  The location of the storage account is hard-coded to East US. However, you may need to deploy the storage account to other regions. You're again facing an issue of your template lacking flexibility. You could add a parameter for location, but it would be great if its default value made more sense than just a hard-coded value.