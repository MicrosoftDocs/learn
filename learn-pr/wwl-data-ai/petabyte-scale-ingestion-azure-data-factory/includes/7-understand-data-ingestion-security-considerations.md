Data integration requires the secure handling of data that is both at rest and in transit. Prior to the creation of a data integration solution, the design stage must consider the security requirements. This will initially provide coverage of the source systems and how the data from them are ingested. However, there is a need for a holistic approach, that also encapsulates the security of intermediary data stores in the following areas

## Network
There are a number of issues that you should be aware of pertaining to setting up network security. You may have to work with the Azure Administrator in your organization to manage some of these areas. 

### Use virtual networks to secure Azure resources
Virtual networks allow secure communication between Azure services, or with servers that exist in on-premises network. Virtual networks or VNets are the fundamental building block for configuring private networks. It enables the secure communication between Azure resources, services on the internet, and with server on on-premises networks.
Azure Data Factory may ingest data from an on-premises server, or a virtual machine that is hosted within Azure. To achieve this, a self-hosted integration runtime can be deployed on a server inside a virtual network. To restrict access, you should configure a Network Security Group (NSG) to only allow administrative access.
When using Azure-SSIS Integration runtime, you are given the option to join a virtual network. Accepting this option enables Azure Data Factory to create network resources, an example of which is that a Network Security Group is automatically created by Azure Data Factory, and port 3389 is open to all traffic by default. Lock this down to ensure that only your administrators have access.

### Use services to detect and prevent intrusions
You can deny communication with known IP addresses by enabling the distributed denial of service (DDoS) protection standard on the virtual networks on which the integration runtime in hosted. In addition, you can use the Azure Security Center Integrated Threat Intelligence to deny communications with known malicious or unused Internet IP addresses.
Azure Firewall with Threat Intelligence can be used to control network access. If intrusion detection and/or prevention based on payload inspection is required, you can redirect traffic to a firewall appliance via Azure ExpressRoute force tunneling or to a Network Virtual Appliance that supports this capability

### Simplify the management of security rules using network service tags
Virtual networks can be configured with service tags. Service tags enables you to group together IP address prefixes from a given Azure service for administrative purposes.  Using Service tags, you can create network security rules in Network Security Groups based on service tags to reduce the administrative overheads. By specifying the service tag name (e.g., DataFactoryManagement) in the appropriate source or destination field of a rule, you can allow or deny inbound traffic for the corresponding service.

## Identity and access control
Managing access to your data is an important area to consider. Here are some areas to be aware of.

### Administrative accounts
The administrative accounts that are used to work and manage Azure Data Factory should be dedicated, known accounts that are monitored and managed on a regular basis to ensure they are not compromised. To create Data Factory instances, the user account that you use to sign in to Azure must be a member of the contributor or owner role, or an administrator of the Azure subscription. For high security environments, consider using dedicated machines for administrative access for any ADF administrative tasks

### Use Active Directory to make use of single sign-on
Register service principals within Azure Active Directory to take advantage of token management so that your Azure Data Factory service streamline its authentication across Azure resources. A data factory can be associated with a managed identity for Azure resources that represents the specific data factory. You can use this managed identity for Azure SQL Database authentication. The designated factory can access and copy data from or to your database by using this identity.

## Data protection
You may have to place special considerations for specific types of data, such as medical data, or financial data in the following areas.

### Use Role Based Access Control (RBAC) to control access to the resources
Use RBAC on the data sources to control access to the data to Azure Data Factory service principal.

### Sensitive data
There are a number of considerations that you should account for when working with sensitive data, including:
-	Maintaining a list of the data stores that contain sensitive information
-	Isolate the systems that store or process sensitive information
-	Monitor and block unauthorized transfer of sensitive information
-	Encrypt any sensitive information that goes in transit
-	Encrypt any sensitive information in rest

## Logging and monitoring
It is also just as important to understand who is accessing your data, and your security considerations should involve the following areas.

### Configure central security log management
Use Azure Monitor to centralize the storage of ingestion logs that are generated by Azure Data Factory, and query them using Log Analytics. In addition, set up a strategy to store the logs long term in Azure Storage Accounts so that you have the data to establish baselines for ADF ingestion activities 

### Monitor and log the configuration and network packet traffic of virtual networks, subnets, and NICs
Enable network security group (NSG) flow logs for the NSG protecting your Integration Runtime deployment and send logs into an Azure Storage Account for traffic auditing. ou may also send NSG flow logs to a Log Analytics workspace and use Traffic Analytics to provide insights into traffic flow in your Azure cloud.

### Enable audit logging
You can use Azure Data Factory diagnostic settings to configure diagnostic logs to track pipeline-run data, which is retained for 45 days. You can save the diagnostic logs to Azure Storage accounts for future analysis.

### Enable alerts on activities
Diagnostic setting for Azure Data Factory that send logs to Log Analytics can have alerts configured for a set of pre-defined set of conditions that can alert an administrator to activities

### Follow standard logging and monitoring standard within your organization
Check your organizations standards for logging and monitoring and snap to the standard including:
- Audit logging 
- Security logs
- Anti-malware logging
- Log retention policies





