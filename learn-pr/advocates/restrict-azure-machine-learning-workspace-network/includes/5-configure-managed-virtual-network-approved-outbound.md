To configure a managed virtual network that allows only approved outbound communications, perform the following steps:

1. On Azure Cloud Shell, run the following command to update an existing Azure Machine Learning workspace: 

    ```azurecli
        az ml workspace update --name ws --resource-group rg --managed-network allow_only_approved_outbound
    ```

1. Next, you need a YAML file to configure the rules for the approved destinations. An example with sample rules for service tag, FQDN, and private endpoint is as follows:

     ```yaml
    name: myworkspace_dep
    managed_network:
      isolation_mode: allow_only_approved_outbound
      outbound_rules:
        - name: added-servicetagrule
          destination:
            port_ranges: [80, 8080]
            protocol: TCP
            service_tag: DataFactory
          type: service_tag
        - name: add-fqdnrule
          destination: 'pypi.org'
          type: fqdn
        - name: added-perule
          destination:
            service_resource_id: /subscriptions/<SUBSCRIPTION_ID>/resourceGroups/<RESOURCE_GROUP>/providers/Microsoft.Storage/storageAccounts/<STORAGE_ACCOUNT_NAME>
            spark_enabled: true
            subresource_target: blob
          type: private_endpoint
    ```

1. After configuring the file, you can update the workspace with the command: 

    ```azurecli
         az ml workspace update --file workspace.yaml --name ws --resource-group MyGroup
    ```

When the isolation mode of a managed virtual network is set to *Allow internet outbound*, Azure automatically creates private endpoint outbound rules. These rules are required for the workspace and its associated resources, such as Key Vault, Storage Account, Container Registry, and Azure Machine Learning workspace, when public network access is disabled.

When the isolation mode is set to *Allow only approved outbound*, Azure also automatically creates private endpoint outbound rules for the workspace and its associated resources. However, in this case, the rules are created regardless of whether public network access is enabled or disabled for those resources. These rules are added only to managed virtual networks, not to custom networks.

To ensure Azure Machine Learning functions properly, certain required service tags must be configured in both managed and custom virtual network setups. These service tags are essential and can't be substituted. The following table outlines each required service tag and its role in Azure Machine Learning.

| **Service tag rule** | **Inbound or Outbound** | **Purpose** |
|---|---|---|
| **AzureMachineLearning** | Inbound | Create, update, and delete of Azure Machine Learning compute instance/cluster. |
| **AzureMachineLearning** | Outbound | Using Azure Machine Learning services. Python intellisense in notebooks uses port 18881. Creating, updating, and deleting an Azure Machine Learning compute instance uses port 5831. |
| **AzureActiveDirectory** | Outbound | Authentication using Microsoft Entra ID. |
| **BatchNodeManagement.region** | Outbound | Communication with Azure Batch back-end for Azure Machine Learning compute instances/clusters. |
| **AzureResourceManager** | Outbound | Creation of Azure resources with Azure Machine Learning, Azure CLI, and Azure Machine Learning SDK. |
| **AzureFrontDoor.FirstParty** | Outbound | Access docker images provided by Microsoft. |
| **MicrosoftContainerRegistry** | Outbound | Access docker images provided by Microsoft. Setup of the Azure Machine Learning router for Azure Kubernetes Service. |
| **AzureMonitor** | Outbound | Used to log monitoring and metrics to Azure Monitor. Only needed if the Azure Monitor for the workspace isn't secured. This outbound is also used to log information for support incidents. |
| **VirtualNetwork** | Outbound | Required when private endpoints are present in the virtual network or peered virtual networks. |
