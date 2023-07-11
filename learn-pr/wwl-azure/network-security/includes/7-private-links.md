Azure Private Link works on an approval call flow model wherein the Private Link service consumer can request a connection to the service provider for consuming the service. The service provider can then decide whether to allow the consumer to connect or not. Azure Private Link enables the service providers to manage the private endpoint connection on their resources

:::image type="content" source="../media/az500-private-links-f7a3794a.png" alt-text="Image of data flow between tenant and provider on a private endpoint.":::


There are two connection approval methods that a Private Link service consumer can choose from:

 -  **Automatic**: If the service consumer has RBAC permissions on the service provider resource, the consumer can choose the automatic approval method. In this case, when the request reaches the service provider resource, no action is required from the service provider and the connection is automatically approved.
 -  **Manual**: On the contrary, if the service consumer doesn’t have RBAC permissions on the service provider resource, the consumer can choose the manual approval method. In this case, the connection request appears on the service resources as Pending. The service provider has to manually approve the request before connections can be established. In manual cases, service consumer can also specify a message with the request to provide more context to the service provider.

The service provider has following options to choose from for all Private Endpoint connections:

 -  **Approved**
 -  **Reject**
 -  **Remove**

## Manage private endpoint connections on Azure PaaS resources

Portal is the preferred method for managing private endpoint connections on Azure PaaS resources.
