Azure Resource Manager is the deployment and management service for Azure. It provides a management layer that enables you to create, update, and delete resources in your Azure account. You use management features, like access control, locks, and tags, to secure and organize your resources after deployment.

The cloud management layer is a crucial service connected to all your cloud resources. Because of this, it is also a potential target for attackers. So, we recommend security operations teams monitor the resource management layer closely.

Azure Defender for Resource Manager automatically monitors the resource management operations in your organization, whether they're performed through the Azure portal, Azure REST APIs, Azure CLI, or other Azure programmatic clients. Azure Defender runs advanced security analytics to detect threats and alert you about suspicious activity.

## What are the benefits of Azure Defender for Resource Manager?

Azure Defender for Resource Manager protects against issues including:

- **Suspicious resource management operations**, such as operations from suspicious IP addresses, disabling antimalware and suspicious scripts running in VM extensions

- **Use of exploitation toolkits** like Microburst or PowerZure

- **Lateral movement** from the Azure management layer to the Azure resources data plane

## How to investigate alerts from Azure Defender for Resource Manager

Security alerts from Azure Defender for Resource Manager are based on threats detected by monitoring Azure Resource Manager operations. Azure Defender uses internal log sources of Azure Resource Manager and Azure Activity log, a platform sign in Azure that provides insight into subscription-level events.

To investigate security alerts from Azure Defender for Resource Manager:

1. Open Azure Activity log.

1. Filter the events to:

    - The subscription mentioned in the alert

    - The timeframe of the detected activity

    - The related user account (if relevant)

1. Look for suspicious activities.

