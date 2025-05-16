You can use [Azure Private Link](/azure/private-link/private-link-overview) with Azure Virtual Desktop to privately connect to your remote resources. By creating a [private endpoint](/azure/private-link/private-endpoint-overview), traffic between your virtual network and the service remains on the Microsoft network, so you no longer need to expose your service to the public internet. You also use a VPN or ExpressRoute for your users with the Remote Desktop client to connect to the virtual network. Keeping traffic within the Microsoft network improves security and keeps your data safe.

This unit describes how Private Link can help you secure your Azure Virtual Desktop environment.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=315ebcbb-1a39-45a6-9de8-911a3f7ffe80]

## How does Private Link work with Azure Virtual Desktop?

Azure Virtual Desktop has three workflows with three corresponding resource types to use with private endpoints. These workflows are:

 -  Initial feed discovery: lets the client discover all workspaces assigned to a user. To enable this process, you must create a single private endpoint to the *global* sub-resource to any workspace. However, you can only create one private endpoint in your entire Azure Virtual Desktop deployment. This endpoint creates Domain Name System (DNS) entries and private IP routes for the global fully qualified domain name (FQDN) needed for initial feed discovery. This connection becomes a single, shared route for all clients to use.
 -  Feed download: the client downloads all connection details for a specific user for the workspaces that host their application groups. You create a private endpoint for the *feed* sub-resource for each workspace you want to use with Private Link.
 -  Connections to host pools: every connection to a host pool has two sides - clients and session hosts. You need to create a private endpoint for the *connection* sub-resource for each host pool you want to use with Private Link.

The following high-level diagram shows how Private Link securely connects a local client to the Azure Virtual Desktop service. For more detailed information about client connections, see [Client connection sequence](/azure/virtual-desktop/private-link-overview#client-connection-sequence).

:::image type="content" source="../media/private-link-diagram-f447ae5e.png" alt-text="A high-level diagram that shows Private Link connecting a local client to the Azure Virtual Desktop service.":::


## Supported scenarios

When adding Private Link with Azure Virtual Desktop, you have the following supported scenarios to connect to Azure Virtual Desktop. Which scenario you choose depends on your requirements. You can either share these private endpoints across your network topology or you can isolate your virtual networks so that each has their own private endpoint to the host pool or workspace.

 -  All parts of the connection - initial feed discovery, feed download, and remote session connections for clients and session hosts - use private routes. You need the following private endpoints:
    
    | **Purpose**               | **Resource type**                          | **Target sub-resource** | **Endpoint quantity**                                   |
    | ------------------------- | ------------------------------------------ | ----------------------- | ------------------------------------------------------- |
    | Connections to host pools | Microsoft.DesktopVirtualization/hostpools  | connection              | One per host pool                                       |
    | Feed download             | Microsoft.DesktopVirtualization/workspaces | feed                    | One per workspace                                       |
    | Initial feed discovery    | Microsoft.DesktopVirtualization/workspaces | global                  | Only one for all your Azure Virtual Desktop deployments |
 -  Feed download and remote session connections for clients and session hosts use private routes, but initial feed discovery uses public routes. You need the following private endpoints. The endpoint for initial feed discovery isn't required.
    
    | **Purpose**               | **Resource type**                          | **Target sub-resource** | **Endpoint quantity** |
    | ------------------------- | ------------------------------------------ | ----------------------- | --------------------- |
    | Connections to host pools | Microsoft.DesktopVirtualization/hostpools  | connection              | One per host pool     |
    | Feed download             | Microsoft.DesktopVirtualization/workspaces | feed                    | One per workspace     |
 -  Only remote session connections for clients and session hosts use private routes, but initial feed discovery and feed download use public routes. You need the following private endpoint(s). Endpoints to workspaces aren't required.
    
    | **Purpose**               | **Resource type**                         | **Target sub-resource** | **Endpoint quantity** |
    | ------------------------- | ----------------------------------------- | ----------------------- | --------------------- |
    | Connections to host pools | Microsoft.DesktopVirtualization/hostpools | connection              | One per host pool     |
 -  Both clients and session host VMs use public routes. Private Link isn't used in this scenario.

### Important considerations

 -  If you create a private endpoint for initial feed discovery, the workspace used for the global sub-resource governs the shared Fully Qualified Domain Name (FQDN), facilitating the initial discovery of feeds across all workspaces. You should create a separate workspace that is only used for this purpose and doesn't have any application groups registered to it. Deleting this workspace will cause all feed discovery processes to stop working.
 -  You can't control access to the workspace used for the initial feed discovery (global sub-resource). If you configure this workspace to only allow private access, the setting is ignored. This workspace is always accessible from public routes.
