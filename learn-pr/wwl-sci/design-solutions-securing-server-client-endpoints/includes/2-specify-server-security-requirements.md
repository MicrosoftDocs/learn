This unit summarizes the [Azure security baseline for Windows Virtual Machines](https://learn.microsoft.com/security/benchmark/azure/baselines/virtual-machines-windows-security-baseline) by providing the first five controls in each of the following nine areas:

-   [Network Security](https://learn.microsoft.com/security/benchmark/azure/baselines/virtual-machines-windows-security-baseline#network-security)
-   [Logging and Monitoring](https://learn.microsoft.com/security/benchmark/azure/baselines/virtual-machines-windows-security-baseline#logging-and-monitoring)
-   [Identity and Access Control](https://learn.microsoft.com/security/benchmark/azure/baselines/virtual-machines-windows-security-baseline#identity-and-access-control)
-   [Data Protection](https://learn.microsoft.com/security/benchmark/azure/baselines/virtual-machines-windows-security-baseline#data-protection)
-   [Vulnerability Management](https://learn.microsoft.com/security/benchmark/azure/baselines/virtual-machines-windows-security-baseline#vulnerability-management)
-   [Inventory and Asset Management](https://learn.microsoft.com/security/benchmark/azure/baselines/virtual-machines-windows-security-baseline#inventory-and-asset-management)
-   [Secure Configuration](https://learn.microsoft.com/security/benchmark/azure/baselines/virtual-machines-windows-security-baseline#secure-configuration)
-   [Malware Defense](https://learn.microsoft.com/security/benchmark/azure/baselines/virtual-machines-windows-security-baseline#malware-defense)
-   [Data Recovery](https://learn.microsoft.com/security/benchmark/azure/baselines/virtual-machines-windows-security-baseline#data-recovery)

## Network Security

### 1.1: Protect Azure resources within virtual networks

**Guidance**: When you create an Azure virtual machine (VM), you must create a virtual network (VNet) or use an existing VNet and configure the VM with a subnet. Ensure that all deployed subnets have a Network Security Group applied with network access controls specific to your applications trusted ports and sources.

Alternatively, if you have a specific use case for a centralized firewall, Azure Firewall can also be used to meet those requirements.

**Responsibility**: Customer

### 1.2: Monitor and log the configuration and traffic of virtual networks, subnets, and network interfaces

**Guidance**: Use the Microsoft Defender for Cloud to identify and follow network protection recommendations to help secure your Azure Virtual Machine (VM) resources in Azure. Enable NSG flow logs and send logs into a Storage Account for traffic audit for the VMs for unusual activity.

**Responsibility**: Customer

### 1.3: Protect critical web applications

**Guidance**: If using your virtual machine (VM) to host web applications, use a network security group (NSG) on the VM's subnet to limit what network traffic, ports and protocols are allowed to communicate. Follow a least privileged network approach when configuring your NSGs to only allow required traffic to your application.

You can also deploy Azure Web Application Firewall (WAF) in front of critical web applications for additional inspection of incoming traffic. Enable Diagnostic Setting for WAF and ingest logs into a Storage Account, Event Hub, or Log Analytics Workspace.

**Responsibility**: Customer

### 1.4: Deny communications with known-malicious IP addresses

**Guidance**: Enable Distributed Denial of Service (DDoS) Standard protection on the Virtual Networks to guard against DDoS attacks. Using Microsoft Defender for Cloud Integrated Threat Intelligence, you can monitor communications with known malicious IP addresses. Configure appropriately Azure Firewall on each of your Virtual Network segments, with Threat Intelligence enabled and configured to "Alert and deny" for malicious network traffic.

You can use Microsoft Defender for Cloud's Just In Time Network access to limit exposure of Windows Virtual Machines to the approved IP addresses for a limited period. Also, use Microsoft Defender for Cloud Adaptive Network Hardening to recommend NSG configurations that limit ports and source IPs based on actual traffic and threat intelligence.

**Responsibility**: Customer

### 1.5: Record network packets

**Guidance**: You can record NSG flow logs into a storage account to generate flow records for your Azure Virtual Machines. When investigating anomalous activity, you could enable Network Watcher packet capture so that network traffic can be reviewed for unusual and unexpected activity.

**Responsibility**: Customer

## Logging and Monitoring

### 2.1: Use approved time synchronization sources

**Guidance**: Microsoft maintains time sources for Azure resources, however, you have the option to manage the time synchronization settings for your Windows Virtual Machines.

**Responsibility**: Microsoft

### 2.2: Configure central security log management

**Guidance**: The Microsoft Defender for Cloud provides Security Event log monitoring for windows Virtual Machines. Given the volume of data that the security event log generates, it is not stored by default.

**Responsibility**: Customer

### 2.3: Enable audit logging for Azure resources

**Guidance**: Activity logs can be used to audit operations and actions performed on virtual machine resources. The activity log contains all write operations (PUT, POST, DELETE) for your resources except read operations (GET). Activity logs can be used to find an error when troubleshooting or to monitor how a user in your organization modified a resource.

Enable the collection of guest OS diagnostic data by deploying the diagnostic extension on your Virtual Machines (VM). You can use the diagnostics extension to collect diagnostic data like application logs or performance counters from an Azure virtual machine.

For advanced visibility of the applications and services supported by your virtual machines you can enable both Azure Monitor for VMs and Application insights. With Application Insights, you can monitor your application and capture telemetry such as HTTP requests, exceptions, etc. so you can correlate issues between the VMs and your application.

Additionally, enable Azure Monitor for access to your audit and activity logs which includes event source, date, user, timestamp, source addresses, destination addresses, and other useful elements.

**Responsibility**: Customer

### 2.4: Collect security logs from operating systems

**Guidance**: Use Microsoft Defender for Cloud to provide Security Event log monitoring for Azure Virtual Machines. Given the volume of data that the security event log generates, it is not stored by default.

If your organization would like to retain the security event log data from the virtual machine, it can be stored within a Log Analytics Workspace at the desired data collection tier configured within Microsoft Defender for Cloud.

**Responsibility**: Customer

### 2.5: Configure security log storage retention

**Guidance**: Ensure that any storage accounts or Log Analytics workspaces used for storing virtual machine logs has the log retention period set according to your organization's compliance regulations.

**Responsibility**: Customer

## Identity and Access Control

### 3.1: Maintain an inventory of administrative accounts

**Guidance**: While Azure Active Directory (Azure AD) is the recommended method to administrate user access, Azure Virtual Machines may have local accounts. Both local and domain accounts should be reviewed and managed, normally with a minimum footprint. In addition, leverage Azure Privileged Identity Management for administrative accounts used to access the virtual machines resources.

**Responsibility**: Customer

### 3.2: Change default passwords where applicable

**Guidance**: Windows Virtual Machines and Azure Active Directory (Azure AD) do not have the concept of default passwords. Customer responsible for third-party applications and marketplace services that may use default passwords.

**Responsibility**: Customer

### 3.3: Use dedicated administrative accounts

**Guidance**: Create standard operating procedures around the use of dedicated administrative accounts that have access to your virtual machines. Use Microsoft Defender for Cloud identity and access management to monitor the number of administrative accounts. Any administrator accounts used to access Azure Virtual Machine resources can also be managed by Azure Privileged Identity Management (PIM). Azure Privileged Identity Management provides several options such as Just in Time elevation, requiring multifactor authentication before assuming a role, and delegation options so that permissions are only available for specific time frames and require an approver.

**Responsibility**: Customer

### 3.4: Use Azure Active Directory single sign-on (SSO)

**Guidance**: Wherever possible, customer to use SSO with Azure Active Directory (Azure AD) rather than configuring individual stand-alone credentials per-service. Use Microsoft Defender for Cloud Identity and Access Management recommendations.

**Responsibility**: Customer

### 3.5: Use multi-factor authentication for all Azure Active Directory-based access

**Guidance**: Enable Azure Active Directory (Azure AD) multifactor authentication and follow Microsoft Defender for Cloud Identity and Access Management recommendations.

**Responsibility**: Customer

## Data Protection

### 4.1: Maintain an inventory of sensitive Information

**Guidance**: Use Tags to assist in tracking Azure virtual machines that store or process sensitive information.

**Responsibility**: Customer

### 4.2: Isolate systems storing or processing sensitive information

**Guidance**: Implement separate subscriptions and/or management groups for development, test, and production. Resources should be separated by virtual network/subnet, tagged appropriately, and secured within a network security group (NSG) or by an Azure Firewall. For Virtual Machines storing or processing sensitive data, implement policy and procedure(s) to turn them off when not in use.

**Responsibility**: Customer

### 4.3: Monitor and block unauthorized transfer of sensitive information

**Guidance**: Implement third-party solution on network perimeters that monitors for unauthorized transfer of sensitive information and blocks such transfers while alerting information security professionals.

For the underlying platform which is managed by Microsoft, Microsoft treats all customer content as sensitive to guard against customer data loss and exposure. To ensure customer data within Azure remains secure, Microsoft has implemented and maintains a suite of robust data protection controls and capabilities.

**Responsibility**: Customer

### 4.4: Encrypt all sensitive information in transit

**Guidance**: Data in transit to, from, and between Virtual Machines (VM) that are running Windows is encrypted in a number of ways, depending on the nature of the connection such as when connecting to a VM in an RDP or SSH session.

Microsoft uses the Transport Layer Security (TLS) protocol to protect data when it's traveling between the cloud services and customers.

**Responsibility**: Shared

### 4.5: Use an active discovery tool to identify sensitive data

**Guidance**: Use a third-party active discovery tool to identify all sensitive information stored, processed, or transmitted by the organization's technology systems, including those located onsite or at a remote service provider and update the organization's sensitive information inventory.

**Responsibility**: Customer

## Vulnerability Management

### 5.1: Run automated vulnerability scanning tools

**Guidance**: Follow recommendations from Microsoft Defender for Cloud on performing vulnerability assessments on your Azure Virtual Machines. Use Azure Security recommended or third-party solution for performing vulnerability assessments for your virtual machines.

**Responsibility**: Customer

### 5.2: Deploy automated operating system patch management solution

**Guidance**: Use the Azure Update Management solution to manage updates and patches for your virtual machines. Update Management relies on the locally configured update repository to patch supported Windows systems. Tools like System Center Updates Publisher (Updates Publisher) allow you to publish custom updates into Windows Server Update Services (WSUS). This scenario allows Update Management to patch machines that use Configuration Manager as their update repository with third-party software.

**Responsibility**: Customer

### 5.3: Deploy automated patch management solution for third-party software titles

**Guidance**: You may use a third-party patch management solution. You can use the Azure Update Management solution to manage updates and patches for your virtual machines. Update Management relies on the locally configured update repository to patch supported Windows systems. Tools like System Center Updates Publisher (Updates Publisher) allow you to publish custom updates into Windows Server Update Services (WSUS). This scenario allows Update Management to patch machines that use Configuration Manager as their update repository with third-party software.

**Responsibility**: Customer

### 5.4: Compare back-to-back vulnerability scans

**Guidance**: Export scan results at consistent intervals and compare the results to verify that vulnerabilities have been remediated. When using vulnerability management recommendation suggested by Microsoft Defender for Cloud, customer may pivot into the selected solution's portal to view historical scan data.

**Responsibility**: Customer

### 5.5: Use a risk-rating process to prioritize the remediation of discovered vulnerabilities

**Guidance**: Use the default risk ratings (Secure Score) provided by Microsoft Defender for Cloud.

**Responsibility**: Customer

## Inventory and Asset Management

### 6.1: Use automated asset discovery solution

**Guidance**: Use Azure Resource Graph to query and discover all resources (including Virtual machines) within your subscriptions. Ensure you have appropriate (read) permissions in your tenant and are able to enumerate all Azure subscriptions as well as resources within your subscriptions.

**Responsibility**: Customer

### 6.2: Maintain asset metadata

**Guidance**: Apply tags to Azure resources giving metadata to logically organize them according to a taxonomy.

**Responsibility**: Customer

### 6.3: Delete unauthorized Azure resources

**Guidance**: Use tagging, management groups, and separate subscriptions, where appropriate, to organize and track virtual machines and related resources. Reconcile inventory on a regular basis and ensure unauthorized resources are deleted from the subscription in a timely manner.

**Responsibility**: Customer

### 6.4: Define and maintain inventory of approved Azure resources

**Guidance**: You should create an inventory of approved Azure resources and approved software for your compute resources. You can also use Adaptive application controls, a feature of Microsoft Defender for Cloud to help you define a set of applications that are allowed to run on configured groups of machines. This feature is available for both Azure and non-Azure Windows (all versions, classic, or Azure Resource Manager) and Linux machines.

**Responsibility**: Customer

### 6.5: Monitor for unapproved Azure resources

**Guidance**: Use Azure policy to put restrictions on the type of resources that can be created in customer subscription(s) using the following built-in policy definitions:

-   Not allowed resource types
-   Allowed resource types

In addition, use the Azure Resource Graph to query/discover resources within the subscription(s). This can help in high security-based environments, such as those with Storage accounts.

**Responsibility**: Customer

## Secure Configuration

### 7.1: Establish secure configurations for all Azure resources

**Guidance**: Use Azure Policy or Microsoft Defender for Cloud to maintain security configurations for all Azure Resources. Also, Azure Resource Manager has the ability to export the template in JavaScript Object Notation (JSON), which should be reviewed to ensure that the configurations meet / exceed the security requirements for your company.

**Responsibility**: Customer

### 7.2: Establish secure operating system configurations

**Guidance**: Use Microsoft Defender for Cloud recommendation [Remediate Vulnerabilities in Security Configurations on your Virtual Machines] to maintain security configurations on all compute resources.

**Responsibility**: Customer

### 7.3: Maintain secure Azure resource configurations

**Guidance**: Use Azure Resource Manager templates and Azure Policies to securely configure Azure resources associated with the Virtual machines. Azure Resource Manager templates are JSON-based files used to deploy Virtual machine along with Azure resources and custom template will need to be maintained. Microsoft performs the maintenance on the base templates. Use Azure policy [deny] and [deploy if not exist] to enforce secure settings across your Azure resources.

**Responsibility**: Customer

### 7.4: Maintain secure operating system configurations

**Guidance**: There are several options for maintaining a secure configuration for Azure Virtual Machines(VM) for deployment:

- Azure Resource Manager templates: These are JSON-based files used to deploy a VM from the Azure portal, and custom template will need to be maintained. Microsoft performs the maintenance on the base templates.
- Custom Virtual hard disk (VHD): In some circumstances it may be required to have custom VHD files used such as when dealing with complex environments that cannot be managed through other means.
- Azure Automation State Configuration: Once the base OS is deployed, this can be used for more granular control of the settings, and enforced through the automation framework.

For most scenarios, the Microsoft base VM templates combined with the Azure Automation Desired State Configuration can assist in meeting and maintaining the security requirements.

**Responsibility**: Customer

### 7.5: Securely store configuration of Azure resources

**Guidance**: Use Azure Repos to securely store and manage your code like custom Azure policies, Azure Resource Manager templates, Desired State Configuration scripts etc. To access the resources you manage in Azure DevOps, such as your code, builds, and work tracking, you must have permissions for those specific resources. Most permissions are granted through built-in security groups as described in Permissions and access. You can grant or deny permissions to specific users, built-in security groups, or groups defined in Azure Active Directory (Azure AD) if integrated with Azure DevOps, or Active Directory if integrated with TFS.

**Responsibility**: Customer

## Malware Defense

### 8.1: Use centrally-managed anti-malware software

**Guidance**: Use Microsoft Antimalware for Azure Windows Virtual machines to continuously monitor and defend your resources.

**Responsibility**: Customer

### 8.3: Ensure anti-malware software and signatures are updated

**Guidance**: When deployed, Microsoft Antimalware for Azure will automatically install the latest signature, platform, and engine updates by default. Follow recommendations in Microsoft Defender for Cloud: "Compute & Apps" to ensure all endpoints are up to date with the latest signatures. The Windows OS can be further protected with additional security to limit the risk of virus or malware-based attacks with the Microsoft Defender Advanced Threat Protection service that integrates with Microsoft Defender for Cloud.

**Responsibility**: Customer

## Data Recovery

### 9.1: Ensure regular automated back-ups

**Guidance**: Enable Azure Backup and configure the Azure Virtual machines (VM), as well as the desired frequency and retention period for automatic backups.

**Responsibility**: Customer

### 9.2: Perform complete system backups and backup any customer-managed keys

**Guidance**: Create snapshots of your Azure virtual machines or the managed disks attached to those instances using PowerShell or REST APIs. Back up any customer-managed keys within Azure Key Vault.

Enable Azure Backup and target Azure Virtual Machines (VM), as well as the desired frequency and retention periods. This includes complete system state backup. If you are using Azure disk encryption, Azure VM backup automatically handles the backup of customer-managed keys.

**Responsibility**: Customer

### 9.3: Validate all backups including customer-managed keys

**Guidance**: Ensure ability to periodically perform data restoration of content within Azure Backup. If necessary, test restoring content to an isolated virtual network or subscription. Customer to test restoration of backed up customer-managed keys.

If you are using Azure disk encryption, you can restore the Azure VM with the disk encryption keys. When using disk encryption, you can restore the Azure VM with the disk encryption keys.

**Responsibility**: Customer

### 9.4: Ensure protection of backups and customer-managed keys

**Guidance**: When you back up Azure managed disks with Azure Backup, VMs are encrypted at rest with Storage Service Encryption (SSE). Azure Backup can also back up Azure VMs that are encrypted by using Azure Disk Encryption. Azure Disk Encryption integrates with BitLocker encryption keys (BEKs), which are safeguarded in a key vault as secrets. Azure Disk Encryption also integrates with Azure Key Vault key encryption keys (KEKs). Enable Soft-Delete in Key Vault to protect keys against accidental or malicious deletion.
