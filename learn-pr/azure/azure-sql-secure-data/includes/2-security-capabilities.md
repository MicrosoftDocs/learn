SQL Server and Azure SQL services have been known for the importance it puts on security, specifically as being enterprise-class. In this unit, you'll learn about the various security capabilities related to network security and identity and access. In the units that follow, you'll get hands on with some of these capabilities.

![Enterprise-class security](../media/enterprisesecurity.png)

## Network security

### Azure SQL Database

There are four main choices you have when you're securing your network for Azure SQL Database:

* Allow access to Azure services
* Firewall rules
* Virtual network rules
* Private Link

In addition to these main choices, you have the opportunity to block all public access (only with Private Link) and the option to force a minimum TLS version.

#### Allow access to Azure services

During deployment of Azure SQL Database, you have the option to set **Allow Azure services and resources access to this server** to **Yes**. If you choose this option, you're allowing any resource from any region or subscription the possibility to access your resource. This makes it very easy to get up and running and get Azure SQL Database connected to other services like Azure VMs or Azure App Services, because you're allowing anything that comes through Azure to have the potential to connect.

![Allow access to Azure services](../media/allowaccess.png)

This does not, however, allow anything outside of Azure (for example, your on-premises environment) to have access.

If you can, switching it to **No** is the most secure configuration of the public endpoint, because it will block all connections/networks apart from ones you've explicitly added with the various options that follow.

#### Firewall rules

The next option you have is to leverage firewall rules. Your results can be similar to those of Allow Azure access, except for each service to connect (in the example below, a VM) you will need to add a unique firewall rule to allow the VM to connect. This also enables your on-premises environment because you can add firewall rules for machines and applications in your on-premises environment.

![Firewall rules](../media/firewallrules.png)

Note that it is possible to Allow access to Azure services so you get connectivity in Azure, and then add firewall rules for just your on-premises connectivity. As previously mentioned, the Allow access to Azure services is not as secure since it allows all Azure traffic, so the recommendation would be to instead use firewall rules exclusively.

Let's take the example above with firewall rules configured. From a tool supporting T-SQL, you could run the following query from your Azure VM in the virtual network "SQLDBVNET-EUS":

```sql
SELECT client_net_address FROM sys.dm_exec_connections WHERE session_id=@@SPID;
```  

The result would be `174.17.218.16`. This is the public IP address of the Azure VM. Even though we're using firewall rules, all the connections being made are public.

#### Virtual network rules

If you wanted to use only firewall rules, setting this up can be complicated, since it means you'll have to specify a range of IP addresses for all your connections (which can sometimes have dynamic IP addresses). A much easier alternative is to use Virtual network (VNet) rules to establish and to manage access from specific networks that contain VMs or other services that need to access the data.

If you configure access from a VNet with a Virtual Network rule, then any resources in that VNet can access the Azure SQL Database logical server, which can simplify the challenge of configuring access to all the IP addresses (static and dynamic) that need to access the data. This could allow you to specify one or multiple virtual networks, encompassing all of the resources within. You can also start to leverage VNet technologies to connect networks across regions in Azure and even to on-premises.  

![VNet Rules](../media/vnetrules.png)

In this example, you could run the same query as in the previous section from your Azure VM in the virtual network "SQLDBVNET-EUS":

```sql
SELECT client_net_address FROM sys.dm_exec_connections WHERE session_id=@@SPID;
```  

The result would now be `10.0.0.2`. This is the private IP address of the Azure VM. This gets you one step closer to making private connections to your Azure SQL Database logical server, since now resources are connecting through the VNet.

Another common strategy for analyzing your connection is to examine the DNS hierarchy. In the same Azure VM, in a command prompt you could run the following command:

```cmd
nslookup aw-server.database.windows.net  
```

This command allows you to understand details related to the DNS infrastructure. Your results would be something similar to the following:  

```cmd
Server: Unknown
Address: 168.63.129.16

Non-authoritative answer:
Name:   cr2.eastus1-a.control.database.windows.net
Address:    174.17.218.16
Aliases:    aw-server.database.windows.net
            dataslice2.eastus.database.windows.net
```

The important things to look at are under the Non-authoritative answer:  

* **Name**: The endpoint starting with `cr2` is part of the public DNS hierarchy. Without getting too much into the hierarchy, `cr2` is the Control Ring 2 and then there are multiple data "slices" below it.  
* **Address**: The IP address returned here should match the public IP address of your Azure VM. So even though a tool like SSMS' final hop might be through your VM's private IP address, the public IP address of your VM is still being used to connect in some capacity.  
* **Aliases**: These are just various points within the DNS hierarchy, in this case the specific data "slice" and the endpoint you connect to.  

**Fun fact**: the **Address: 168.63.129.16** is a virtual public IP address used to facilitate a communication channel to Azure platform resources. It's the case for all regions and all national clouds, and it will not change.

Even though the connection through T-SQL is coming through the private IP address of the Azure VM, you are still ultimately connecting through a public endpoint.

### Private Link for Azure SQL Database

You've seen how to configure the most secure network using Azure SQL Database with the public endpoint. This method of securing Azure SQL Database has been used for years. However, in 2019, Azure began moving towards a concept of a Private Link, which is more similar to the way that Azure SQL Managed Instance is deployed. Private Link allows you to connect to Azure SQL Database (and several other PaaS offerings) using a private endpoint, which means it has a private IP address within a specific VNet.  
  
![Private endpoint connection](../media/privateendpoint.png)

In the example above, what you'll notice is that the general networking infrastructure did not change, you can still leverage the VNet connectivity strategies from VNet rules. However, you will not have to create VNet rules. Resources that need to connect to the database server simply have to have access to the VNet where the endpoint resides (in this case "SQLDBVNET-EUS"). Only connections going through the private endpoint will have access, all other connections (for example, from the internet) will be denied.

Continuing with this example, on the Azure VM in VNet "SQLDBVNET-EUS", you could once again run the following TSQL:

```sql
SELECT client_net_address FROM sys.dm_exec_connections WHERE session_id=@@SPID;
```

By adding access from your specific VNet, connections to Azure SQL Database from your VM will appear to come through the private IP address of your VM. This is the same result you saw with virtual network rules.  

However, if you leverage the command prompt to look at the DNS hierarchy, using the follow command:

```cmd
nslookup aw-server.database.windows.net  
```

Your results will be slightly different with the private endpoint configured:  

```cmd
Server: Unknown
Address: 168.63.129.16

Non-authoritative answer:
Name:   aw-server.privatelink.database.windows.net
Address:    10.0.0.5
Aliases:    aw-server.database.windows.net
```

The important things to look at are under the Non-authoritative answer, and let's examine the differences:  

* **Name**: Note that you're no longer pointing to the public DNS hierarchy, only to the Private Link DNS. This means less information is revealed about your database server.  
* **Addresses**: For VNet rules, the address returned was the public IP address of your VM, but it should now be one or more *private* IP addresses within the Private Link hierarchy (one is the private endpoint of your Azure SQL Database).
* **Aliases**: Similar to the Name field, you're not seeing anything related to the DNS hierarchy, except that you can still connect to the server name (e.g. `aw-server.database.windows.net`).  

One thing you might be wondering, is if you are connecting to the private endpoint, **why are you still using the same server name?** In the backend, when you use solely the Private Link method of connecting (i.e. no firewall or virtual network rules), the information is processed as follows:  

* `aw-server.database.windows.net`  
  * Resolved by service to `aw-server.privatelink.database.net`  
    * Resolved by service to `10.0.0.5` (the IP address of your private endpoint)  

Additionally, the service will block you from directly connecting using anything apart from `aw-server.database.windows.net`.  

### Azure SQL Managed Instance

While Azure SQL Managed Instance's deployment is quite different from Azure SQL Database, understanding the networking functionality at a high level is easy to translate from Azure SQL Database to Azure SQL Managed Instance. In Azure SQL Managed Instance, either before or during deployment, you must create a specific subnet (logical grouping within a VNet) with several requirements to host the Azure SQL Managed Instance(s). Once deployed, it is already configured like a private endpoint in Azure SQL Database. Using standard networking practices, you must enable access to the VNet that the managed instance lives. By default, you have a private endpoint and relatively private DNS hierarchy.  

![SQL Managed Instance Network](../media/sqlminetwork.png)

There are references in the summary on how exactly your subnet must be deployed.

## Identity and access

Once you've worked out the networking access, the next layer to consider is identity and access.

### Azure Role-Based Access Control (RBAC)

All Azure types of operations for Azure SQL are controlled through RBAC. This is currently decoupled from SQL Security today, but you can think of it as security rights outside of the SQL Database or SQL Managed Instance with a scope including subscription, resource group, and resource. This will apply to operations in the Azure portal, Azure CLI, and Azure PowerShell. Azure RBAC allows for separation of duties between deployment, management and usage.

There are built-in roles available to reduce need for higher level Azure RBAC roles like Owner or Contributor. Effectively, you can use these roles to have certain individuals deploy Azure SQL resources (or manage security polices) but grant other users actual access to user or manage the instance or database.  For example, a SQL Server contributor could deploy a server but assign an Azure SQL Database user to be the admin of the server and databases. The built-in roles include:  

* SQL DB Contributor: Can create and manage databases but not access the database (for example, cannot connect and read data)
* SQL Managed Instance Contributor: Can create and manage managed instances but not access them
* SQL Security Manager:  Can manage security policies for databases and instances (like auditing) but not access them
* SQL Server Contributor: Can manage servers and databases but not access them.

### Authentication

For both Azure SQL Database and Azure SQL Managed Instance, SQL authentication is used for deployment, and this is referred to as the **server admin**. In Azure SQL Database, the server admin is a server-level principal for the Azure SQL Database logical server, but for Azure SQL Managed Instance it is a member of the sysadmin server role. In addition, "Mixed Mode" authentication is force for both deployment options.

If you are migrating a workload that needs Windows Authentication or your organization leverages Azure Active Directory (Azure AD), you can use Azure AD. For both Azure SQL Managed Instance and Azure SQL Database, you can assign an Azure AD server admin using the portal or command-line tools.

![Set the AD admin](../media/aadadmin.png)  

Depending on how your organization has configured Azure AD, there are three methods of connecting (for example, in SSMS) with Azure AD: 

* *Azure Active Directory - Integrated*: A non-interactive method, which you can use if you are logged in to Windows using your Azure AD credentials from a federated domain.  
* *Azure Active Directory - Password*: A non-interactive method that allows you to connect with an Azure AD principal name using the Azure AD managed domain. From the documentation: *This can apply to native or federated Azure AD users. A native user is one explicitly created in Azure AD and being authenticated using user name and password, while a federated user is a Windows user whose domain is federated with Azure AD. The latter method (using user & password) can be used when a user wants to use their windows credential, but their local machine is not joined with the domain (for example, using a remote access). In this case, a Windows user can indicate their domain account and password and can authenticate to SQL DB/DW using federated credentials.*  
* *Azure Active Directory - Universal with MFA*: An interactive method that will safeguard access to data while meeting demand for a single sign-in process with Multi-factor Authentication (MFA).

For Azure SQL Managed Instance, it is very similar to SQL Server in that you can have SQL or Azure AD logins, database users, and contained database users. In Azure SQL Database, their are a few nuances. You can have SQL logins, database users, and even contained database users for Azure AD (recommended). While the server admin for Azure SQL Database essentially has sysadmin rights, you can create more limited admins using database level roles in the master of the Azure SQL Database logical server. There are two roles available:

* **loginmanager** is a database-level role that allows members to create logins for the database server
* **dbmanager** is a database-level role that allows members to create and delete databases for the database server.

At the end of the day, when you set up and configure authentication and authorization, there are four guidelines you can follow:  

1. Deploy with a server admin
1. Create other admins as necessary
1. Admins can create users
1. Grant access just like you would in SQL Server

## Other capabilities

After getting hands on with some of the network and authentication capabilities, later in the module you will examine other capabilities (and their related tasks) for data protection, monitoring, logging, and auditing.
