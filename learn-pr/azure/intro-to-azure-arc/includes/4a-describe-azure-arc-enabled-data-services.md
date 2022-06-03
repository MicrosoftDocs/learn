Contoso, a global entity, hosts multiple SQL Server instances with various versions today in their on-premises environment. The IT staff also wants to explore multi-cloud strategy in order to leverage cloud service providers around the world. Azure Arc enabled data services provides a single pane of glass and unified management tools for managing, deploying, and being data sovereign complaint in certain markets.

## What is Azure Arc-enabled data services?

Using Azure Arc-Enabled SQL Managed Instance, you can enroll all of your database instances located anywhere to Azure and then manage these databases in a consistent way. Azure Arc-enabled data services:

- Enables you to be on an evergreen SQL instance
- Provides flexible scaling options - meaning you can easily add or remove CPU and Memory from instances in a heartbeat
- Takes advantage of cloud billing models
- Provides a platform as a service (PaaS)-like  experience on-premises and across multiple clouds
- Comes with high availability, monitoring services, automated upgrades, patching, backup and restore services out of the box

## Management capability comparison between various SQL services

:::image type="content" source="../media/40-management-capabilities-by-deployment-model.png" alt-text="A chart that compares the management capabilities by deployment model." border="false" lightbox="../media/40-management-capabilities-by-deployment-model.png":::

## Connected and disconnected modes

Since Contoso has operational capabilities in countries where data is required to be on-premises due to regulations and low latency needs, Azure Arc enabled Data services is a perfect solution for them. Since the data is stored in country, you can meet regulation compliance or data sovereignty requirements. The underlying latency issues are also resolved by enabling the databases locally or in close proximity to operations.

The disconnected mode of deployments doesn't automatically load any data sets back to Azure. For example billing files, logs, and metrics aren't loaded automatically. Inventory information is only used for billing purposes. Manually export and load the billing file to Azure portal at least monthly. Although disconnected mode doesn't automatically load the file, you still get the scaling, evergreen SQL and other benefits from the solution.

In the direct connected mode, you get the full benefits of Azure monitor, Azure alerting, inventory and management capabilities via Azure portal. In the connected mode, deployment data is still processed on-premises and you can optionally upload logs to Azure cloud. The inventory information is only a metadata representation of assets that you have.

## SKU comparison

Today Azure Arc-enabled SQL Managed instance comes in two different types of SKU offerings.

- Business Critical = Enterprise Edition
- General Purpose = Standard Edition 

:::image type="content" source="../media/40-data-service-tier-comparison.png" alt-text="A chart that compares the service tier models." border="false" lightbox="../media/40-data-service-tier-comparison.png":::

## How does Azure Arc-enabled data service operate

The Azure Arc-enabled SQL Managed Instance operates on any Kubernetes cluster and hardware that you have. See [Deployment requirements](/azure/azure-arc/data/plan-azure-arc-data-services#deployment-requirements).

Azure Arc-enabled data service is deployed and managed via an agent based solution. The agent that gets deployed to the environment is called the data controller. This agent acts as the Kubernetes orchestrator for the solution. To run the services in direct connected mode, you must have:

- Access to a Kubernetes cluster
- The supported [Azure CLI](/cli/azure/install-azure-cli) version (>= 2.16.0 and <= 2.29.0)
- The following `arcdata` and associated k8s CLI extensions:
  - `arcdata`
  - `connectedk8s`
  - `customlocation`
  - `k8s-configuration`
  - `k8s-extension`

    To add any of the above extensions, run:

    ```azurecli
    az extension add --name <extension>
    ```

- [Meet network requirements](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#meet-network-requirements).
- Read write many drives “Required for Business Critical SKU” 
- [Register providers for Azure Arc-enabled Kubernetes](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#register-providers-for-azure-arc-enabled-kubernetes).
  - Microsoft.Kubernetes.
  - Microsoft.KubernetesConfiguration.
  - Microsoft.ExtendedLocation.
- Create destination Resource Group in your Azure subscription.
- Your Kubernetes cluster is sized appropriately for your workload.