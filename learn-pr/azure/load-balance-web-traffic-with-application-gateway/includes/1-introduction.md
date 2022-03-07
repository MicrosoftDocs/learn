Imagine you work for the motor vehicle department of a governmental organization. The department runs several public websites that enable drivers to register their vehicles, and renew their driver's license online.

The vehicle registration website has been running on a single server, and has suffered multiple outages because of server failures. This has resulted in frustrated drivers trying to register their vehicles by month's end before their registrations expire.

The department would like to improve resiliency by adding multiple web servers to its site, and distribute the load across them. They would also like to centralize their site on a single load-balancing service to simplify the URLs for site visitors.

[!include[](../../../includes/azure-subscription-prerequisite.md)]

## Learning objectives

In this module, you'll:

- Identify the load-balancing capabilities of Application Gateway
- Create an Application Gateway and configure load balancing
- Configure an Application Gateway to use URL path-based routing

## Prerequisites

- Knowledge of basic networking concepts
- Familiarity with Azure virtual machines and Azure App Service
- Familiarity with Azure virtual networking
