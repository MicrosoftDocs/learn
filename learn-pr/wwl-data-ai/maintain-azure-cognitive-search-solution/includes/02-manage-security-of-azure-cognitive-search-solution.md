Organizations need to be able to trust the security of their search solutions. Azure AI Search gives you control over how to secure the data you search.

Here, you'll explore how to secure your search solution. You'll focus on where data is encrypted and how to secure the inbound and outbound data flows. Finally, you'll see how to restrict access to search results for specific users or groups.

## Overview of security approaches

AI Search security builds on Azure's existing network security features. When you think about securing your search solution, you can focus on three areas:

- Inbound search requests made by users to your search solution
- Outbound requests from your search solution to other servers to index documents
- Restricting access at the document level per user search request

## Data encryption

The Azure AI Search service, like all Azure services, encrypts the data it stores at rest with service-managed keys. This encryption includes indexes, data sources, synonym maps, skillsets, and even the indexer definitions.

Data in transit is encrypted using the standard HTTPS TLS 1.3 encryption over port 443.

If you'd like to use your own encryption keys, ACS supports using the Azure Key Vault. A benefit of using your own customer-managed keys is that double encryption will be enabled on all objects you use your custom keys on.

> [!TIP]
> For detailed steps on how to use customer-managed keys for encryption, see [Configure customer-managed keys for data encryption in Azure AI Search](/azure/search/search-security-manage-encryption-keys)

## Secure inbound traffic

If your search solution can be accessed externally from the internet or apps, you can reduce the attack surface. Azure AI Search lets you restrict access to the public endpoint for free using a firewall to allow access from specific IP addresses.

:::image type="content" source="../media/inbound-traffic-through-firewalls-azure-cogntive-search-small.png" lightbox="../media/inbound-traffic-through-firewalls-azure-cogntive-search.png"alt-text="Diagram showing inbound traffic secured using ExpressRoute through a firewall into Azure AI Search." border="false":::

If your search service is only going to be used by on-premises resources, you can harden security with an ExpressRoute circuit, Azure Gateway, and an App service. There's also the option to change the public endpoint to use an Azure private link. You'll also need to set up an Azure virtual network and other resources. Using a private endpoint is the most secure solution, although it does come with the added cost of using those services that need to be hosted on the Azure platform.

> [!TIP]
> For more information about private endpoints, see [Create a Private Endpoint for a secure connection to Azure AI Search](/azure/search/service-create-private-endpoint).

### Authenticate requests to your search solution

With the infrastructure in place to reduce the attack surface of your search solution, your focus can change to how to authenticate search requests from your users and apps.

The default option when you create your ACS is key-based authentication. There are two different kinds of keys:

- **Admin keys** - grant your write permissions and the right to query system information (*maximum of 2 admin keys can be created per search service*)
- **Query keys** - grant read permissions and are used by your users or apps to query indexes (*maximum of 50 query keys can be created per search service*)

> [!IMPORTANT]
> Role-based access control for data plane operations is currently in preview and under a [supplemental terms of use](https://azure.microsoft.com/support/legal/preview-supplemental-terms/). The roles are only available in the Azure public cloud and using them can increase the latency of search requests.
 
Role-based access control (RBAC) is provided by the Azure platform as a global system to control access to resources. You can use RBAC in Azure AI Search in the following ways:

- Roles can be granted access to administer the service
- Define roles with access to create, load, and query indexes

The built-in roles you can assign to manage the Azure AI Search service are:

- **Owner** - Full access to all search resources
- **Contributor** - Same as above, but without the ability to assign roles or change authorizations
- **Reader** - View partial service information

If you need a role that can also manage the data plane for example search indexes or data sources, use one of these roles:

- **Search Service Contributor** - A role for your search service administrators (the same access as the Contributor role above) and the content (indexes, indexers, data sources, and skillsets)
- **Search Index Data Contributor** - A role for developers or index owners who will import, refresh, or query the documents collection of an index
- **Search Index Data Reader** - Read-only access role for apps and users who only need to run queries


> [!TIP]
> For more information about authenticating with RBAC, see [Use Azure role-based access controls (Azure RBAC) in Azure AI Search](/azure/search/search-security-rbac).

## Secure outbound traffic

Typically your outbound traffic indexes source data or enriches it using Artificial Intelligence (AI). The outbound connections support using key-based authentication, database logins, or Microsoft Entra logins if you can use Microsoft Entra ID.

If your data sources are hosted on the Azure platform, you can also secure connections using a system or user-assigned managed identity.

:::image type="content" source="../media/secure-outbound-traffic-small.png" lightbox="../media/secure-outbound-traffic.png" alt-text="Diagram showing Azure AI Search solution accessing data sources through an IP restricted firewall." border="false":::

Azure services can restrict access to them using a firewall. Your firewall can be configured to only allow the IP address of your Azure AI Search service. If you're enriching your indexes with AI, you'll also need to allow all the IP addresses in the **AzureCognitiveSearch** service tag.

You can choose to secure your source data behind a shared private link that your indexers use.

> [!IMPORTANT]
> A shared private link requires either a Basic tier for text-based indexing or a Standard 2 (S2) tier for skills-based indexing. For pricing details, see [Azure Private Link pricing](https://azure.microsoft.com/pricing/details/private-link).

## Secure data at the document-level

You can configure Azure AI Search to restrict the documents someone can search, for example, restrict searching contractual PDFs to people in your legal department.

Controlling who has access at the document level requires you to update each document in your search index. You need to add a new security field to every document that contains the user or group IDs that can access it. The security field needs to be filterable so that you can filter search results on the field. 

With this field in place and populated with the allowed user or groups, you can restrict results by adding the `search.in` filter to all your search queries. If you're using HTTP POST requests, the body should look like this:

```json
{
   "filter":"security_field/any(g:search.in(g, 'user_id1, group_id1, group_id2'))"  
}
```

This would filter the returned search results on the user ID and groups that this user belongs to. If your application can use Microsoft Entra ID, it's possible to use the user's identity and group memberships from there.

> [!TIP]
> For a step-by-step guide on how to use Microsoft Entra ID, see [Security filters for trimming Azure AI Search results using Active Directory identities](/azure/search/search-security-trimming-for-azure-search-with-aad)
