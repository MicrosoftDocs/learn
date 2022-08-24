Azure Arc-enabled data services provides two connectivity mode options for you to connect to Azure: 

- Directly connected
- Indirectly connected 

The right connectivity mode for your Arc-enabled data services will be impacted by several factors, including: 

- Business Policy
- Data Sovereignty requirements
- Government Regulations
- Unavailable Azure region support

Depending on your requirements, you may be obliged to use indirectly connected mode. If you have a requirement, for example, of having an air-gapped environment to the internet, indirectly connected mode should be implemented. 

Understanding your requirements, and your ability to have direct connectivity to your Azure subscription, is paramount in choosing which connectivity mode to use. Once you have deployed your Arc-enabled data services environment, you cannot change the connectivity mode. This requires a re-deployment to be undertaken. 

Usage data for billing purposes is the only data that is required to be uploaded to Azure. All other data may remain on-premises, or in a multicloud environment. Directly connected mode will automatically upload usage data whereas indirectly connected mode requires usage data to be uploaded via a manual process.

Both directly and indirectly connected modes provide the ability to choose to upload metrics and log data to your Azure subscription. 

## Directly connected mode

Aside from the previously mentioned capability differences between an Arc-enabled SQL MI and an Azure SQL MI (elastic / limitless scalability, automatic HA/DR and compliance certification) directly connected mode provides you with the same management capabilities as if you were running Azure SQL MI. 

Directly connected mode allows you to manage and operate your Arc-enabled data services via [Azure Resource Manager APIs](https://docs.microsoft.com/rest/api/resources/), [Azure CLI](https://docs.microsoft.com/cli/azure/), [Azure Data Studio](https://docs.microsoft.com/sql/azure-data-studio/what-is-azure-data-studio?view=sql-server-ver15) or the [Azure portal](https://azure.microsoft.com/features/azure-portal/).

## Indirectly connected mode

Indirectly connected mode provides many of the benefits of Azure SQL MI in scenarios where your data services reside in a secure environment, or in an area that does not have direct connectivity to the internet. This is done by having the built-in management capabilities available to run locally inside the secure/disconnected environment.

Indirectly connected mode allows you to manage and operate your Arc-enabled data services via Kubernetes native tools like [kubectl](https://kubernetes.io/docs/reference/kubectl/), [Azure CLI](https://docs.microsoft.com/cli/azure/) or [Azure Data Studio](https://docs.microsoft.com/sql/azure-data-studio/what-is-azure-data-studio?view=sql-server-ver15) locally in your environment.

In this mode, you still have access to your Arc-enabled data services resources in the Azure portal but in a read-only view. All management actions required for your Arc-enabled data services you must be execute locally. 

Operating in this mode has the following differences from running in directly connected mode:

- Environment Management is undertaken locally.
- Billing requires periodic (at least once a month) exports of the usage data to your Azure subscription.
- Local monitoring using built-in functionality can be periodically exported and manually uploaded to your Azure subscription, taking advantage of the power of Azure Monitor and Log Analytics over your exported data.
- Authentication is via Kubernetes Authentication and Active directory.
- RBAC is via Kubernetes RBAC.
- Inventory in Azure requires periodic (at least once a month) exports to your Azure subscription.
