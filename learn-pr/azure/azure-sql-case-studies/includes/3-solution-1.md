In the previous unit, you worked through a scenario involving global scale for a content delivery network. In this unit, you'll review one potential solution and some items to consider.

As you review, you should compare the solution provided to the one you developed in the previous unit. There is often more than one correct solution to any problem, but there are always tradeoffs. Which items in your solution differ from the proposed? Is there anything in your solution you might rethink? Is there anything in the provided solution that you think is addressed more thoroughly in your solution?  

## Deployment option and configuration

The first decision to consider is which deployment option of Azure SQL should be selected. While SQL Server in an Azure virtual machine would work, a PaaS offering may provide a better fit with less management overhead. However, the customer is leveraging CLR, which is an instance-scoped feature. Recall, Azure SQL Managed Instance is the only PaaS deployment option, which supports instance-scoped features like CLR, Service Broker, Database Mail, etc. For this reason, Azure SQL Managed Instance can allow them to move to a PaaS offering without having to rewrite their CLR applications into an Azure SQL Database compatible solution (like Elastic Jobs).

The next decision to make involves the service tier. Since they want to isolate their read and write workloads, using the Business critical service tier will be the simplest way to achieve that. Recall, the Business critical service tier has an Always On Availability Group running behind the scenes, and one of those secondary replicas can be used for read-only workloads.

Business critical is only one half of the configuration here to separate read and write workloads. The scenario states that they need to be able to scale over multiple regions with multiple queries happening at the same time, while isolating read and write workloads. The two options that could potentially address this challenge are geo-replication and auto-failover groups. However, geo-replication is not currently supported in Azure SQL Managed Instance. Using an auto-failover group is therefore the only option that can help this scenario in getting global read-scale. Now, since they're using auto-failover groups, whether or not they need the Business critical service tier will depend on how many read-only endpoints their analytics workload requires. With an auto-failover group in the Business critical service tier, they would get three readable endpoints, one secondary replica from the primary region's AG, the secondary of the failover group (which is the primary replica of the database in the secondary region), and the secondary replica from the secondary region's AG. If the analytics workload does not need all these readable replicas, using General purpose may be a more cost effective solution.

## Selecting the most appropriate authentication methods

The other piece of this scenario involved determining how best for each application/person to connect to the solution, given the need to create and leverage the most secure technologies possible. If you break down the scenario, there are four separate clients that will need access to the Azure SQL Managed Instance:

- Application running on an Azure VM
- Application running on a non-Azure machine
- DBAs or other users leveraging SQL admin tools (SSMS, ADS, PowerShell) from a non-Azure machine
- Legacy applications running on a non-Azure machine where you can't change the driver/connection string

Let's break each of them down on how you might choose the authentication method and some additional considerations and constraints.

### Application running on an Azure VM

Managed identities for Azure resources are, in general, the recommended form of password-less authentication for applications running on Azure virtual machines.

### Application running on a non-Azure machine

For non-Azure machines, using managed identities is not an option. Integrated authentication via Azure Active Directory is the recommended authentication method for apps running on domain-joined machines outside of Azure, assuming the domain has been federated with Azure Active Directory. Alternatively, you could create an application identity for your application in Azure Active Directory, associate a certificate with the application identity, and modify your application to acquire a token for Azure SQL Database by providing a client ID and a certificate. Although the certificate must contain a private key and it must be deployed on the machine hosting your application, you at least avoid hardcoding an application secret in the application code or configuration (you will need to configure the app with the certificate thumbprint).

### DBAs or other users leveraging SQL admin tools (SSMS, ADS, PowerShell) from a non-Azure machine

For users outside of Azure, eliminating the use of passwords is advised if possible. You can eliminate the use passwords with SQL tools by using Azure AD integrated authentication, providing the tools run on a domain-joined machine and the domain has been federated with Azure Active Directory. If your environment does not meet the above pre-requisites for integrated authentication, it is recommended you use Azure AD interactive authentication with MFA, which most SQL tools support.

### Legacy applications running on a non-Azure machine where you can't change the driver/connection string

Unfortunately, in scenarios where the driver or connection string cannot be changed, there isn't an option that exists today for eliminating passwords. These legacy applications must continue to use SQL authentication. However, you might consider diving deeper into the restrictions and how they can be lifted in order to put in place a more secure and safe-guarded approach for applications to authenticate.
