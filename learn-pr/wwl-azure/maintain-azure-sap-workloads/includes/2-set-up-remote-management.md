As documented in the Azure virtual machines planning guide, there are three basic methods for connecting into Azure VMs:

* Connect through public endpoints on a Jumpbox VM.

* Connect through a VPN or Azure ExpressRoute.

Site-to-site connectivity via VPN or ExpressRoute is necessary for production scenarios. This type of connection is also needed for non-production scenarios that feed into production scenarios where SAP software is being used. 

## Azure Automation

Azure Automation offers the desired state configuration functionality via a cloud-based, managed DSC Pull Server in the Azure cloud. It provides rich reports that inform you of important events such as when nodes have deviated from their assigned configuration. You can monitor and automatically update machine configuration across physical and virtual machines, Windows or Linux, in the cloud or on-premises. Azure Automation also includes a built-in solution that starts and stops Azure VMs on user-defined schedules.

## SAP Landscape Management (LaMa)

SAP LaMa is used by many customers to operate, monitor, and refresh their SAP landscape. Since SAP LaMa 3.0 SP05, it ships with a connector to Azure by default. You can use this connector to deallocate and start virtual machines, copy and relocate managed disks, and delete managed disks. With these basic operations, you can relocate, copy, clone, and refresh SAP systems using SAP LaMa.

## Set up Azure connector for SAP LaMa

The Azure connector is shipped as of SAP LaMa 3.0 SP05. We recommend always installing the latest support package and patch for SAP LaMa 3.0. The Azure connector uses a Service Principal to authorize against Microsoft Azure. Follow these steps to create a Service Principal for SAP Landscape Management (LaMa).

1. Sign-in to the Azure portal

2. Open the **Azure Active Directory** blade

3. Click on **App registrations**

4. Click on **Add**

5. Enter a Name, select Application Type "**Web app/API**", enter a sign-on URL (for example http://localhost) and click on **Create**

6. The sign-on URL is not used and can be any valid URL

7. Select the **new App** and click on **Keys** in the **Settings** tab

8. Enter a description for a new key, select "**Never expires**" and click on **Save**

9. Write down the Value. It is used as the password for the Service Principal

10. Write down the Application ID. It is used as the username of the Service Principal

The Service Principal does not have permissions to access your Azure resources by default. You need to give the Service Principal permissions to access them.

1. In the Azure portal, open the **Resource groups** blade

2. Select the resource group you want to use

3. Click **Access control (IAM)**

4. Click on **Add role assignment**

5. Select the role **Contributor**

6. Enter the name of the application you created above

7. Click **Save**

8. Repeat step 2 to 7 for all resource groups you want to use in SAP LaMa

Open the SAP LaMa website and navigate to Infrastructure. Go to tab Cloud Managers and click on Add. Select the Microsoft Azure Cloud Adapter and click Next. Enter the following information:

* **Label**: Choose a name for the connector instance

* **User Name**: Service Principal Application ID

* **Password**: Service Principal key/password

* **Monitoring Interval (Seconds)**: Should be at least 300

* **Subscription ID**: Azure subscription ID

* **Azure Active Directory Tenant ID**: ID of the Active Directory tenant

* **Proxy host**: Hostname of the proxy if SAP LaMa needs a proxy to connect to the internet

* **Proxy port**: TCP port of the proxy

Click on **Test Configuration** to validate your input. You should see the message Connection successful: Connection to Microsoft cloud was successful. 

SAP LaMa communicates with the virtual machine using the SAP Host Agent. If you deploy the virtual machines manually or not using the Azure Resource Manager template from the quickstart repository, make sure to install the latest SAP Host Agent and the SAP Adaptive Extensions.

## Access Management

Access management for cloud resources is a critical function for any organization that is using the cloud. Role-based access control (RBAC) helps you manage who has access to Azure resources, what they can do with those resources, and what areas they have access to. RBAC is an authorization system built on Azure Resource Manager that provides fine-grained access management of Azure resources.

The way you control access to resources using RBAC is to create role assignments. This is a key concept to understand – it’s how permissions are enforced. A role assignment consists of three elements: security principal, role definition, and scope.

* **Security principal**: A security principal is an object that represents a user, group, service principal, or managed identity that is requesting access to Azure resources.

    - **User** - An individual who has a profile in Azure Active Directory. 

    - **Group** - A set of users created in Azure Active Directory. 

    - **Service principal** - A security identity used by applications or services to access specific Azure resources. You can think of it as a user identity (username and password or certificate) for an application.

    - **Managed identity** - An identity in Azure Active Directory that is automatically managed by Azure. You typically use managed identities when developing cloud applications to manage the credentials for authenticating to Azure services. For example, you can assign a managed identity to an Azure VM to allow software running within that VM access other Azure resources.

* **Role definition**: A role definition is a collection of permissions. It's sometimes just called a role. A role definition lists the operations that can be performed, such as read, write, and delete. Roles can be high-level, like owner, or specific, like virtual machine reader. Azure includes several built-in roles that you can use. The following lists four fundamental built-in roles. The first three apply to all resource types.

    - **Owner** - Has full access to all resources including the right to delegate access to others.

    - **Contributor** - Can create and manage all types of Azure resources but can’t grant access to others.

    - **Reader** - Can view existing Azure resources.

    - **User Access Administrator** - Lets you manage user access to Azure resources.

    ![Role definition for a role assignment](../media/set-up-remote-management-sap-workloads.png)

The rest of the built-in roles allow management of specific Azure resources. For example, the Virtual Machine Contributor role allows a user to create and manage virtual machines. If the built-in roles don't meet the specific needs of your organization, you can create your own custom roles for Azure resources.

* **Scope**: Scope is the set of resources that the access applies to. When you assign a role, you can further limit the actions allowed by defining a scope. In Azure, you can specify a scope at multiple levels: management group, subscription, resource group, or resource. Scopes are structured in a parent-child relationship.

