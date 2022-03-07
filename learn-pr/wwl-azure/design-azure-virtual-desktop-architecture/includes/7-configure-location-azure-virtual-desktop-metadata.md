Azure Virtual Desktop is currently available for all geographical locations. Administrators can choose the location to store user data when they create the host pool virtual machines and associated services, such as file servers. Learn more about Azure geographies at the [Azure datacenter map](https://azuredatacentermap.azurewebsites.net/).

:::image type="content" source="../media/client-access-af6b0cff-3d7e822f.png" alt-text="Graphic of Azure Virtual Desktop is currently available for all geographical locations.":::


Microsoft doesn't control or limit the regions where you or your users can access your user and app-specific data.

Azure Virtual Desktop stores global metadata information like tenant names, host pool names, app group names, and user principal names in a datacenter. Whenever a customer creates a service object, they must enter a location for the service object. The location they enter determines where the metadata for the object will be stored. The customer will choose an Azure region and the metadata will be stored in the related geography.

There is currently support for storing metadata in the following geographies:

 -  United States (US) (Generally available)
 -  Europe (EU) (Public preview)

When you're selecting a region to create Azure Virtual Desktop service objects in, you'll see regions under both US and EU geographies.

To make sure you understand which region would work best for your deployment, take a look at [our Azure global infrastructure map](https://azure.microsoft.com/global-infrastructure/geographies/).

The stored metadata is encrypted at rest, and geo-redundant mirrors are maintained within the geography. All customer data, such as app settings and user data, resides in the location the customer chooses and isn't managed by the service. More geographies will become available as the service grows.
