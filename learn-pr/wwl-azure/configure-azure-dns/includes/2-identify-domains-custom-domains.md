## Initial domain name

When you create an Azure subscription, an Azure AD domain is automatically created. This instance of the domain has an *initial domain name* in the form *domainname.onmicrosoft.com*. The initial domain name is intended to be used until a custom domain name is verified.

## Custom domain name

The initial domain name can't be changed or deleted. You can however add a routable custom domain name you control. A custom domain name simplifies the user sign-on experience. Users can use credentials they are familiar with. For example, a contosogold.onmicrosoft.com, could be assigned to contosogold.com.

:::image type="content" source="../media/custom-domain-names-8dae9b45.png" alt-text="Screenshot of the Create directory page.":::


## Practical information about domain names

 -  You must be a global administrator to perform domain management tasks. The global administrator is the user who created the subscription.
 -  Domain names in Azure AD are globally unique. When one Azure AD directory has verified a domain name, other directories can't use that name.
 -  Before a custom domain name can be used by Azure AD, the custom domain name must be added to your directory and verified.
