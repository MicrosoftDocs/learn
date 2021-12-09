To set up a production-ready deployment of Azure App Service on Azure Stack Hub, you must plan for the capacity you expect the system to support.

You can plan your App Service capacity strategy using these guidelines.

:::row:::
  :::column:::
    **App Service server role**
  :::column-end:::
  :::column:::
    **Minimum recommended number of instances**
  :::column-end:::
  :::column:::
    **Recommended compute SKU.**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Controller
  :::column-end:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    A4v2
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Front End
  :::column-end:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    A4\_v2
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Management
  :::column-end:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    D3\_v2
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Publisher
  :::column-end:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    A2\_v2
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Web Workers - shared
  :::column-end:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    A4\_v2
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Web Workers - dedicated - small
  :::column-end:::
  :::column:::
    2 per tier
  :::column-end:::
  :::column:::
    A1\_v2
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Web Workers - dedicated - medium
  :::column-end:::
  :::column:::
    2 per tier
  :::column-end:::
  :::column:::
    A2\_v2
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Web Workers - dedicated - large
  :::column-end:::
  :::column:::
    2 per tier
  :::column-end:::
  :::column:::
    A4\_v2
  :::column-end:::
:::row-end:::


## Controller role

**Recommended minimum**: Two instances of A4v2

The Azure App Service controller typically experiences low consumption of CPU, memory, and network resources. However, for high availability, you must have two controllers. Two controllers are also the maximum number of controllers permitted. You can create the second web sites controller direct from the installer during deployment.

## Front-end role

**Recommended minimum**: Two instances of A4v\_2

The front-end routes requests to web workers depending on web worker availability. For high availability, you should have more than one front end, and you can have more than two. For capacity planning purposes, consider that each core can handle approximately 100 requests per second.

## Management role

**Recommended minimum**: Two instances of D3v2

The Azure App classic deployment model role is responsible for the App Service Azure Resource Manager and API endpoints, portal extensions (admin, tenant, Functions portal), and the data service. The management server role typically requires only about 4-GB RAM in a production environment. However, it may experience high CPU levels when many management tasks (such as web site creation) are performed. For high availability, you should have more than one server assigned to this role, and at least two cores per server.

## Publisher role

**Recommended minimum**: Two instances of A2v2

If many users are publishing simultaneously, the publisher role may experience heavy CPU usage. For high availability, make sure more than one publisher role is available. The publisher only handles FTP/FTPS traffic.

## Web worker role

**Recommended minimum**: Two instances of A4\_v2

For high availability, you should have at least four web worker roles: two for shared web site mode and two for each dedicated worker tier you plan to offer. The shared and dedicated compute modes provide different levels of service to tenants. You might need more web workers if many of your customers are:

 -  Using dedicated compute mode worker tiers (which are resource-intensive).
 -  Running in shared compute mode.

After a user has created an App Service plan for a dedicated compute mode SKU, the number of web worker(s) specified in that App Service plan is no longer available to users.

To provide Azure Functions to users in the consumption plan model, you must deploy shared web workers.

When deciding on the number of shared web worker roles to use, review these considerations:

 -  **Memory**: Memory is the most critical resource for a web worker role. Insufficient memory impacts web site performance when virtual memory is swapped from disk. Each server requires about 1.2 GB of RAM for the operating system. RAM above this threshold can be used to run web sites.
 -  **Percentage of active web sites**: Typically, about 5 percent of apps in an Azure App Service on Azure Stack Hub deployment are active. However, the percentage of apps that are active at any given moment can be higher or lower. With an active app rate of 5 percent, the maximum number of apps to place in an Azure App Service on Azure Stack Hub deployment should be less than 20 times the number of active web sites (5 x 20 = 100).
 -  **Average memory footprint**: The average memory footprint for apps observed in production environments is about 70 MB. Using this footprint, the memory allocated across all web worker role computers or virtual machines is calculated as follows:

## File server role

For the file server role, you can use a standalone file server for development and testing. For production purposes, you should use a pre-configured Windows file server, or a pre-configured non-Windows file server.

In production environments, the file server role experiences intensive disk I/O. Because it contains the content and app files for user web sites, you should preconfigure one of the following resources for this role:

 -  Windows file server
 -  Windows file server cluster
 -  Non-Windows file server
 -  Non-Windows file server cluster
 -  NAS (Network Attached Storage) device
