

As part of your planning process, you want to understand the steps that the cross-functional team will need to follow. Here’s an overview.

## Verify deployment prerequisites

You start by organizing the prerequisites across the entire solution into the following categories:

- Azure prerequisites. These mostly involve access to Microsoft Sentinel and the ability to create Azure resources if necessary.
- System prerequisites. There are several areas here where you’ll run the data connector agent container to identify:
  - Versions of Linux that are supported
  - Potential size of virtual machines
  - Network connectivity
  - Software utilities that are deployed by the SAP data connector deployment script.
- SAP prerequisites. These include supported SAP versions, required software, SAP system details, and ensuring that the agent has access to the SAP system.
- SAP notes and change requests (CRs). You might need to deploy CRs depending on the version of SAP you’re accessing. In addition, you’ll need to deploy CRs from the Microsoft Sentinel GitHub repository to enable the SAP data connector.
- New SAP role. You must create an SAP role and assign it the appropriate permission to allow the data connector to connect to the SAP system.

## Prepare the SAP environment

You see that you’ll need to prepare your SAP environment as part of the prerequisites.

### Gather details about your SAP system

- SAP system version
- SID
- System number
- Client number
- IP address
- Administrator user (You’ll sign in by using an SSH connection, so this can be the root user credentials.)

### Deploy required CRs and create a system role

- Download and set up the CR files
- Import the CRs into the SAP system
- Create a user role with the required ABAP authorizations for the data connector

## Deploy the Microsoft Sentinel for SAP solution

You’ve reviewed the prerequisites and understand that you’ll need to modify the SAP system. Now you’re ready to plan the deployment.

### Deploy the data connector agent

The data connector agent runs as a Docker container on a Linux virtual machine. This virtual machine can be hosted in Azure, in a third-party cloud, or on-premises. You can install and configure this container by using a kickstart script (recommended); alternatively, you can [deploy the container manually](/azure/sentinel/sap/deploy-data-connector-agent-container?tabs=deploy-manually#deploy-the-data-connector-agent-container).

In either model, you must transfer the SAP NetWeaver SDK to the virtual machine or operating system where you plan to install the agent.

If you plan to deploy the data connector agent in a virtual machine, these steps need to be part of the planning. Create a virtual machine in Azure or another cloud platform or on-premises, create a key in Azure Key Vault for authentication, and then configure the agent to connect to both SAP and Azure. 

### Consider whether to share an existing workspace

Because you’re already using Microsoft Sentinel to monitor the Contoso environment, you and your team need to determine whether to deploy the Microsoft Sentinel for SAP solution within your existing workspace. An alternative approach is to add a separate workspace only for the SAP team. Your decision will depend on your governance policies and whether Contoso is using the overall Microsoft Sentinel solution to monitor SAP databases and the SAP operation system layer. Because Contoso’s Microsoft Sentinel solution doesn’t currently monitor SAP logs, you decide to create a separate workspace for the SAP team.

### Deploy the security content

Security starter content included with the solution can help you start using it immediately after you install and connect the agent to both SAP and Microsoft Sentinel. This content includes built-in workbooks and analytics rules. You'll also be able to add SAP-related [watchlists](/azure/sentinel/watchlists) to use with detection rules, threat hunting, and response playbooks.

You’ll deploy the [SAP security content](/azure/sentinel/sap/sap-solution-security-content) from the Microsoft Sentinel content hub and **Watchlist** area.

When you deploy the Microsoft Sentinel solution for SAP, the Microsoft Sentinel for SAP data connector is displayed in the Microsoft Sentinel **Data connectors** area.

The solution also deploys the SAP - System Applications and Products workbook and SAP-related analytics rules. These items are built to help you get started with workbooks and analytics on the SAP data that’s ingested into Microsoft Sentinel from the data connector agent.

After the security content is deployed in Microsoft Sentinel, you can see and use the ABAP logs under **Custom Logs** on the Microsoft Sentinel **Logs** in the Azure portal.

### Configure the Microsoft Sentinel solution for SAP

You and your cross-functional team will discuss the watchlists to determine which ones you want to use and how you’ll configure them. These watchlists include:

- **SAP - Systems**. Defines which SAP systems are present in the monitored environment. You can have more than one SAP system provide data to the solution.
- **SAP - Networks**. Outlines all networks used by the organization. This watchlist is primarily used to identify whether user sign-ins originate from within known segments of the network. It also signals when the origin of a user sign-in changes unexpectedly.
- **SAP - Sensitive**. These watchlists identify sensitive actions or data that can be carried out or accessed by users. Several well-known operations, tables, transactions, and authorizations have been preconfigured in the watchlists. However, we recommend that you consult with the SAP BASIS team to be sure you’ve identified all activities that you regard as sensitive in your SAP environment.
- **User master data watchlists**. The Microsoft Sentinel solution for SAP uses user master data gathered from SAP systems to identify which users, profiles, and roles should be considered sensitive. Some sample data is included in the watchlists. We recommend that you consult with your SAP BASIS team to make sure you identify all sensitive users, roles, and profiles, and populate the watchlists accordingly.

For a complete list of watchlists, go to [Microsoft Sentinel Solution for SAP: security content reference](/azure/sentinel/sap/sap-solution-security-content).

After you understand what’s required to deploy the solution, you’re better equipped to understand the range of roles required to deploy it successfully.