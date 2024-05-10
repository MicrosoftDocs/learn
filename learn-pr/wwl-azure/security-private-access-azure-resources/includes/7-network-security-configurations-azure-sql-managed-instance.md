This security baseline applies guidance from the Microsoft cloud security benchmark version 1.0 to Azure SQL. The Microsoft cloud security benchmark provides recommendations on how you can secure your cloud solutions on Azure. The content is grouped by the security controls defined by the Microsoft cloud security benchmark and the related guidance applicable to Azure SQL.

You can monitor this security baseline and its recommendations using Microsoft Defender for Cloud. Azure Policy definitions will be listed in the Regulatory Compliance section of the Microsoft Defender for Cloud portal page.<br>

When a feature has relevant Azure Policy Definitions, they are listed in this baseline to help you measure compliance with the Microsoft cloud security benchmark controls and recommendations. Some recommendations may require a paid Microsoft Defender plan to enable certain security scenarios.<br>

> [!NOTE]
> Features not applicable to Azure SQL have been excluded.

## Security profile<br>

The security profile summarizes high-impact behaviors of Azure SQL, which may result in increased security considerations.

| **Service Behavior Attribute**                          | **Value** |
| ------------------------------------------------------- | --------- |
| Product Category                                        | Databases |
| Customer can access HOST / OS                           | No Access |
| Service can be deployed into customer's virtual network | True      |
| Stores customer content at rest                         | True      |

## Network security

### NS-1: Establish network segmentation boundaries

#### **1. Virtual Network Integration**

Description: Service supports deployment into customer's private Virtual Network (VNet).

| **Supported** | **Enabled By Default** | **Configuration Responsibility** |
| ------------- | ---------------------- | -------------------------------- |
| True          | False                  | Customer                         |

Configuration Guidance: Deploy the service into a virtual network. Assign private IPs to the resource (where applicable) unless there is a strong reason to assign public IPs directly to the resource.

#### 2. Network Security Group Support<br>

Description: Service network traffic respects Network Security Groups rule assignment on its subnets.

| **Supported** | **Enabled By Default** | **Configuration Responsibility** |
| ------------- | ---------------------- | -------------------------------- |
| True          | False                  | Customer                         |

**Configuration Guidance**: Use Azure Virtual Network Service Tags to define network access controls on network security groups or Azure Firewall configured for your Azure SQL resources. You can use service tags in place of specific IP addresses when creating security rules. By specifying the service tag name in the appropriate source or destination field of a rule, you can allow or deny the traffic for the corresponding service. Microsoft manages the address prefixes encompassed by the service tag and automatically updates the service tag as addresses change. When using service endpoints for Azure SQL Database, outbound to Azure SQL Database Public IP addresses is required: Network Security Groups (NSGs) must be opened to Azure SQL Database IPs to allow connectivity. You can do this by using NSG service tags for Azure SQL Database.

### NS-2: Secure cloud services with network controls

#### 3. Azure Private Link

Description: Service native IP filtering capability for filtering network traffic (not to be confused with NSG or Azure Firewall).

| **Supported** | **Enabled By Default** | **Configuration Responsibility** |
| ------------- | ---------------------- | -------------------------------- |
| True          | False                  | Customer                         |

Configuration Guidance: Deploy private endpoints for all Azure resources that support the Private Link feature, to establish a private access point for the resources.

#### 4. Disable Public Network Access

Description: Service supports disabling public network access either through using service-level IP Access Control List (ACL) filtering rule (not NSG or Azure Firewall) or using a **Disable Public Network Access** toggle switch.

| **Supported** | **Enabled By Default** | **Configuration Responsibility** |
| ------------- | ---------------------- | -------------------------------- |
| True          | True                   | Microsoft                        |

#### 5. Microsoft Defender for Cloud monitoring

Azure Policy built-in definitions - Microsoft.Sql:

| Name<br>(Azure portal)                                               | **Description**                                                                                                                                                                                                                              | **Effect(s)**         | Version<br>(GitHub) |
| -------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------- | ------------------- |
| Azure SQL Managed Instances should disable public network access     | Disabling public network access (public endpoint) on Azure SQL Managed Instances improves security by ensuring that they can only be accessed from inside their virtual networks or via Private Endpoints.                                   | Audit, Deny, Disabled | 1.0.0               |
| Private endpoint connections on Azure SQL Database should be enabled | Private endpoint connections enforce secure communication by enabling private connectivity to Azure SQL Database.                                                                                                                            | Audit, Disabled       | 1.1.0               |
| Public network access on Azure SQL Database should be disabled       | Disabling the public network access property improves security by ensuring your Azure SQL Database can only be accessed from a private endpoint. This configuration denies all logins that match IP or virtual network based firewall rules. | Audit, Deny, Disabled | 1.1.0               |

#### 6. Follow Azure Policy Recommendations:

 -  Disable public network access on Azure SQL Managed Instances to ensure access is only from within their virtual networks or via Private Endpoints.<br>
 -  Enable private endpoint connections to fortify secure communication with Azure SQL Database.
 -  Turn off the public network access property on Azure SQL Database to enforce access only from a private endpoint.
