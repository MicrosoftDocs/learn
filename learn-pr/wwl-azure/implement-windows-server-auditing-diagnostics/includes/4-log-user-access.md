User Access Logging (UAL) helps you quantify the number of unique client requests of the roles and services on a local server.

  > [!IMPORTANT]
  > UAL is installed and enabled by default. You can stop and disable UAL by using Windows PowerShell, the Net Start command, or with Netsh.exe.

Using UAL, you can:

- Quantify the following for local servers (physical or virtual):

  - Client user requests

  - Client user requests for installed software products

- Retrieve data on a local server running Hyper-V to identify periods of high and low demand on a Hyper-V VM.

- Retrieve data from multiple remote servers (physical or virtual).

> [!TIP]
> You can retrieve UAL data by using WMI or Windows PowerShell interfaces.

## What server roles and services are supported?

UAL supports the following server roles and services:

- Active Directory Certificate Services (AD CS)

- Active Directory Rights Management Services (AD RMS)

- BranchCache

- Domain Name System (DNS)

- Dynamic Host Configuration Protocol (DHCP)

- Fax Server

- File Services

- File Transfer Protocol (FTP) Server

- Hyper-V

- Web Server (IIS)

- Microsoft Message Queue (MSMQ) Services

- Network Policy and Access Services

- Print and Document Services

- Routing and Remote Access Service (RRAS)

- Windows Deployment Services (WDS)

- Windows Server Update Services (WSUS)

## What data is logged?

UAL can log both user and device-related data. The following table describes the user-related data logged by UAL.

| Data| Description|
| :--- | :--- |
| UserName| The user name on the client that accompanies the UAL entries from installed roles and products, if applicable.|
| ActivityCount| The number of times a particular user accessed a role or service.|
| FirstSeen| The date and time when a user first accesses a role or service.|
| LastSeen| The date and time when a user last accessed a role or service.|
| ProductName| The name of the software parent product, such as Windows, that is providing UAL data.|
| RoleGUID| The UAL assigned or registered GUID that represents the server role or installed product.|
| RoleName| The name of the role, component, or subproduct that is providing UAL data. This is also associated with a ProductName and a RoleGUID.|
| TenantIdentifier| A unique GUID for a tenant client of an installed role or product that accompanies the UAL data, if applicable.|

The following table describes the device-related data logged by UAL.

| Data| Description|
| :--- | :--- |
| IPAddress| The IP address of a client device that is used to access a role or service.|
| ActivityCount| The number of times a particular device accessed the role or service.|
| FirstSeen| The date and time when an IP address was first used to access a role or service.|
| LastSeen| The date and time when an IP address was last used to access a role or service.|
| ProductName| The name of the software parent product, such as Windows, that is providing UAL data.|
| RoleGUID| The UAL-assigned or registered GUID that represents the server role or installed product.|
| RoleName| The name of the role, component, or subproduct that is providing UAL data. This is also associated with a ProductName and a RoleGUID.|
| TenantIdentifier| A unique GUID for a tenant client of an installed role or product that accompanies the UAL data, if applicable.|

> [!NOTE]
> UAL data is stored in C:\Windows\System32\LogFiles\Sum.

> [!TIP]
> Because UAL logs the username, the source IP address and details of the service being accessed, it can help you identify unusual or suspicious activity. 

## Collect UAL data

You can use Windows PowerShell to collect UAL data. The following table describes the available cmdlets.

| Cmdlet| Description|
| :--- | :--- |
| Get-UalOverview| Provides UAL related details and history of installed products and roles.|
| Get-UalServerUser| Provides client user access data for the local or targeted server.|
| Get-UalServerDevice| Provides client device access data for the local or targeted server.|
| Get-UalUserAccess| Provides client user access data for each role or product installed on the local or targeted server.|
| Get-UalDeviceAccess| Provides client device access data for each role or product installed on the local or targeted server.|
| Get-UalDailyUserAccess| Provides client user access data for each day of the year.|
| Get-UalDailyDeviceAccess| Provides client device access data for each day of the year.|
| Get-UalDailyAccess| Provides both client device and user access data for each day of the year.|
| Get-UalHyperV| Provides virtual machine data relevant to the local or targeted server.|
| Get-UalDns| Provides DNS client specific data of the local or targeted DNS server.|
| Get-UalSystemId| Provides system specific data to uniquely identify the local or targeted server.|

