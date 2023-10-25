Users often create passwords that use common local words such as a school, sports team, or famous person. These passwords are easy to guess and weak against dictionary-based attacks. To enforce strong passwords in your organization, Microsoft Entra Password Protection provides a global and custom banned password list. A password change request fails if there's a match in these banned passwords list.

Microsoft Entra Password Protection is designed with the following principles in mind:

 -  Domain controllers (DCs) never have to communicate directly with the internet.
 -  No new network ports are opened on DCs.
 -  No AD DS schema changes are required. The software uses the existing AD DS container and serviceConnectionPoint schema objects.
 -  No minimum AD DS domain or forest functional level (DFL/FFL) is required.
 -  The software doesn't create or require accounts in the AD DS domains that it protects.
 -  User clear-text passwords never leave the DC, either during password validation operations or at any other time.
 -  The software isn't dependent on other Microsoft Entra features. For example, Microsoft Entra password hash sync (PHS) isn't related or required for Microsoft Entra Password Protection.
 -  Incremental deployment is supported, however the password policy is only enforced where the Domain Controller Agent (DC Agent) is installed.

## Create an Azure account and add Microsoft Entra ID Premium P2 trial licenses

The tasks in this exercise and the exercises in this learning path require you to already have and Azure subscription that you can use or to sign up for an Azure trial account. If you already have your own Azure subscription, you might skip this task and continue to the next.

1.  In a web browser, go to the [Azure portal](https://azure.microsoft.com/free/).
2.  Scroll down through the page to learn more about the benefits and free services available.
3.  Select **Start free**.
4.  Use the wizard to sign up for your Azure trial subscription.
5.  You'll need to a Microsoft Entra P2 license to complete some of the exercises. In the organization you created, search for and then select **Microsoft Entra ID**.
6.  In the left navigation menu, select **Getting started**.
7.  Under Getting started with Microsoft Entra, select **Get a free trial for Microsoft Entra Premium**.
8.  In the Activate pane, under **Microsoft Entra Premium P2**, select **Free trial** and then select **Activate**.
9.  In the navigation menu on the left, select **Overview**.
10. Refresh the browser until you see Microsoft Entra Premium P2 under the organization name. It might take a couple of minutes.
11. You might need to sign out and sign back into Microsoft Azure if you encounter any problems with expected features not being available.

## How Microsoft Entra Password Protection works

The on-premises Microsoft Entra Password Protection components work as follows:

1.  Each Microsoft Entra Password Protection proxy-service-instance advertises itself to the DCs in the forest by creating a *serviceConnectionPoint* object in Active Directory.
2.  Each DC Agent service for Microsoft Entra Password Protection also creates a *serviceConnectionPoint* object in Active Directory. This object is used primarily for reporting and diagnostics.
3.  The DC Agent service is responsible for initiating the download of a new password policy from Microsoft Entra. The first step is to locate a Microsoft Entra Password Protection proxy-service by querying the forest for proxy *serviceConnectionPoint* objects.
4.  When an available proxy service is found, the DC Agent sends a password policy download request to the proxy service. The proxy service in turn sends the request to Microsoft Entra, and then returns the response to the DC Agent service.
5.  After the DC Agent service receives a new password policy from Microsoft Entra, the service stores the policy in a dedicated folder at the root of its domain *sysvol* folder share. The DC Agent service also monitors this folder in case newer policies replicate in from other DC Agent services in the domain.
6.  The DC Agent service always requests a new policy at service startup. After the DC Agent service is started, it checks the age of the current locally available policy hourly. If the policy is older than one hour, the DC Agent requests a new policy from Microsoft Entra via the proxy service, as described previously. If the current policy isn't older than one hour, the DC Agent continues to use that policy.
7.  When password change events are received by a DC, the cached policy is used to determine if the new password is accepted or rejected.

To protect your on-premises Active Directory Domain Services (AD DS) environment, you can install and configure Microsoft Entra Password Protection to work with your on-premises DC. This unit shows you how to install and register the Microsoft Entra Password Protection proxy-service and Microsoft Entra Password Protection DC agent in your on-premises environment.

## Deployment strategy

The following diagram shows how the basic components of Microsoft Entra Password Protection work together in an on-premises Active Directory environment:

:::image type="content" source="../media/azure-active-directory-password-protection-e783cbb6.png" alt-text="Diagram of How Microsoft Entra Password Protection components work together.":::


We recommend that you start deployments in *audit* mode. Audit mode is the default initial setting, where passwords can continue to be set. Passwords that would be blocked are recorded in the event log. After you deploy the proxy-servers and DC agents in audit mode, monitor the change the password policy will have on users when the policy is enforced.

During the audit stage, many organizations find that the following situations apply:

 -  They need to improve existing operational processes to use more secure passwords.
 -  Users often use unsecure passwords.
 -  They need to inform users about the upcoming change in security enforcement, and how to choose more secure passwords.

It's also possible for stronger password validation to affect your existing Active Directory domain controller deployment automation. We recommend that at least one DC promotion and one DC demotion happen during the audit period evaluation to help uncover issues such as weak passwords preventing promotion and demotion.

After the feature has been running in audit mode for a reasonable period, you can switch the configuration from *Audit* to *Enforce* to require more secure passwords. Additional monitoring during this time is a good idea.

> [!IMPORTANT]
> Microsoft Entra Password Protection can only validate passwords during password change or set operations. Passwords that were accepted and stored in Active Directory prior to the deployment of Microsoft Entra Password Protection will never be validated and will continue working as is. Over time, all users and accounts will eventually start using Microsoft Entra Password Protection-validated passwords as their existing passwords expire. Accounts configured with "password never expires" are exempt from this.

### Multiple forest considerations

There are no additional requirements to deploy Microsoft Entra Password Protection across multiple forests.

Each forest is independently configured. Each Microsoft Entra Password Protection proxy can only support domain controllers from the forest that it's joined to.

The Microsoft Entra Password Protection software in any forest is unaware of password protection software that's deployed in other forests, regardless of Active Directory trust configurations.

### Read-only domain controller considerations

Password change or set events aren't processed and persisted on read-only domain controllers (RODCs). Instead, they're forwarded to writable domain controllers. You don't have to install the Microsoft Entra Password Protection DC agent software on RODCs.

Further, it's not supported to run the Microsoft Entra Password Protection proxy-service on a read-only domain controller.

### High availability considerations

The main concern for password protection is the availability of Microsoft Entra Password Protection proxy servers when the DCs in a forest try to download new policies or other data from Azure. Each Microsoft Entra Password Protection DC agent uses a simple round-robin-style algorithm when deciding which proxy server to call. The agent skips proxy servers that aren't responding.

For most fully connected Active Directory deployments that have healthy replication of both directory and sysvol folder state, two Microsoft Entra Password Protection proxy servers is enough to ensure availability. This configuration results in timely download of new policies and other data. You can deploy additional Microsoft Entra Password Protection proxy servers if desired.

The design of the Microsoft Entra Password Protection DC agent software mitigates the usual problems that are associated with high availability. The Microsoft Entra Password Protection DC agent maintains a local cache of the most recently downloaded password policy. Even if all registered proxy servers become unavailable, the Microsoft Entra Password Protection DC agents continue to enforce their cached password policy.

A reasonable update frequency for password policies in a large deployment is usually days, not hours or less. So, brief outages of the proxy servers don't cause problems for Microsoft Entra Password Protection.

## Deployment requirements

Licensing requirements for AD Password Protection are as follows:

| **Users**                                 | **Microsoft Entra Password Protection with global banned password list** | **Microsoft Entra Password Protection with custom banned password list** |
| ----------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------------------------------------------ |
| Cloud-only users                          | Microsoft Entra Free                                                     | Microsoft Entra Premium P1 or P2                                         |
| Users synchronized from on-premises AD DS | Microsoft Entra Premium P1 or P2                                         | Microsoft Entra Premium P1 or P2                                         |

The following core requirements apply:

 -  You need an account that has Active Directory domain administrator privileges in the forest root domain to register the Windows Server Active Directory forest with Microsoft Entra.
 -  The Key Distribution Service must be enabled on all domain controllers in the domain that run Windows Server 2012. By default, this service is enabled via manual trigger start.
 -  Network connectivity must exist between at least one domain controller in each domain and at least one server that hosts the proxy service for Microsoft Entra Password Protection. This connectivity must allow the domain controller to access RPC endpoint mapper port 135 and the RPC server port on the proxy service.
    
    
     -  By default, the RPC server port is a dynamic RPC port, but it can be configured to use a static port.
 -  All machines where the Microsoft Entra Password Protection proxy-service will be installed must have network access to the following endpoints:

| **Endpoint**                                 | **Purpose**                                       |
| -------------------------------------------- | ------------------------------------------------- |
| `https://login.microsoftonline.com`          | Authentication requests                           |
| `https://enterpriseregistration.windows.net` | Microsoft Entra Password Protection functionality |

### Microsoft Entra Password Protection DC agent

The following requirements apply to the Microsoft Entra Password Protection DC agent:

 -  All machines where the Microsoft Entra Password Protection DC agent software will be installed must run Windows Server 2012 or later.
    
    
     -  The Active Directory domain or forest doesn't need to be at Windows Server 2012 domain functional level (DFL) or forest functional level (FFL). There's no minimum DFL or FFL required for either the DC agent or proxy software to run.
 -  All machines that run the Microsoft Entra Password Protection DC agent must have .NET 4.5 installed.
 -  Any Active Directory domain that runs the Microsoft Entra Password Protection DC agent service must use Distributed File System Replication (DFSR) for sysvol replication.

### Microsoft Entra Password Protection proxy service

The following requirements apply to the Microsoft Entra Password Protection proxy-service:

 -  All machines where the Microsoft Entra Password Protection proxy-service will be installed must run Windows Server 2012 R2 or later.
    
    > [!NOTE]
    > The Microsoft Entra Password Protection proxy-service deployment is a mandatory requirement for deploying Microsoft Entra Password Protection even though the domain controller may have outbound direct internet connectivity.
 -  All machines where the Microsoft Entra Password Protection proxy-service will be installed must have .NET 4.7 installed.
 -  All machines that host the Microsoft Entra Password Protection proxy-service must be configured to grant domain controllers the ability to sign into the proxy service. This ability is controlled via the "Access this computer from the network" privilege assignment.
 -  All machines that host the Microsoft Entra Password Protection proxy-service must be configured to allow outbound TLS 1.2 HTTP traffic.
 -  A *Global Administrator* or *Security Administrator* account is required to register the Microsoft Entra Password Protection proxy-service and forest with Microsoft Entra.
 -  Network access must be enabled for the set of ports and URLs specified in the Application Proxy environment setup procedures.
    
    > [!WARNING]
    > Microsoft Entra Password Protection proxy and Microsoft Entra Application Proxy install different versions of the Microsoft Entra Connect Agent Updater service, which is why the instructions refer to Application Proxy content. These different versions are incompatible when installed side by side. Doing so will prevent the Agent Updater service from contacting Azure for software updates, so you should never install Microsoft Entra Password Protection Proxy and Application Proxy on the same machine.

## Download required software

Two installers are required for an on-premises Microsoft Entra Password Protection deployment:

 -  Microsoft Entra Password Protection DC agent (*AzureADPasswordProtectionDCAgentSetup.msi*)
 -  Microsoft Entra Password Protection proxy (*AzureADPasswordProtectionProxySetup.exe*)

## Install and configure the proxy service

The Microsoft Entra Password Protection proxy-service is typically on a member server in your on-premises AD DS environment. Once installed, the Microsoft Entra Password Protection proxy-service communicates with Microsoft Entra to maintain a copy of the global and customer banned password lists for your Microsoft Entra tenant.

## Install the DC agent service

To install the Microsoft Entra Password Protection DC agent service, run the `AzureADPasswordProtectionDCAgentSetup.msi` package.

You can automate the software installation by using standard MSI procedures, as shown in the following example:

```console

msiexec.exe /i AzureADPasswordProtectionDCAgentSetup.msi /quiet /qn /norestart



```

The `/norestart` flag can be omitted if you prefer to have the installer automatically reboot the machine.

The software installation, or uninstallation, requires a restart. This requirement is because password filter DLLs are only loaded or unloaded by a restart.

The installation of on-premises Microsoft Entra Password Protection is complete after the DC agent software is installed on a domain controller and that computer is rebooted. No other configuration is required or possible. Password change events against the on-premises DCs use the configured banned password lists from Microsoft Entra.

> [!TIP]
> You can install the Microsoft Entra Password Protection DC agent on a machine that's not yet a domain controller. In this case, the service starts and runs but remains inactive until the machine is promoted to be a domain controller.

## Upgrading the proxy service

The Microsoft Entra Password Protection proxy-service supports automatic upgrade. Automatic upgrade uses the Microsoft Entra Connect Agent Updater service, which is installed side by side with the proxy service. Automatic upgrade is on by default and might be enabled or disabled using the `Set-AzureADPasswordProtectionProxyConfiguration` cmdlet.

The current setting can be queried using the `Get-AzureADPasswordProtectionProxyConfiguration` cmdlet. We recommend that the automatic upgrade setting always is enabled.

The `Get-AzureADPasswordProtectionProxy` cmdlet might be used to query the software version of all currently installed Microsoft Entra Password Protection proxy-servers in a forest.

### Manual upgrade process

A manual upgrade is accomplished by running the latest version of the `AzureADPasswordProtectionProxySetup.exe` software installer. The latest version of the software is available on the Microsoft Download Center.

It's not required to uninstall the current version of the Microsoft Entra Password Protection proxy-service—the installer performs an in-place upgrade. No reboot should be required when upgrading the proxy service. The software upgrade might be automated using standard MSI procedures, such as `AzureADPasswordProtectionProxySetup.exe /quiet`.

## Upgrading the DC agent

When a newer version of the Microsoft Entra Password Protection DC agent software is available, the upgrade is accomplished by running the latest version of the `AzureADPasswordProtectionDCAgentSetup.msi` software package. The latest version of the software is available on the Microsoft Download Center.

It's not required to uninstall the current version of the DC agent software—the installer performs an in-place upgrade. A reboot is always required when upgrading the DC agent software. This requirement is caused by core Windows behavior.

The software upgrade might be automated using standard MSI procedures, such as `msiexec.exe /i AzureADPasswordProtectionDCAgentSetup.msi /quiet /qn /norestart`.

You might omit the `/norestart` flag if you prefer to have the installer automatically reboot the machine.

The `Get-AzureADPasswordProtectionDCAgent` cmdlet might be used to query the software version of all currently installed Microsoft Entra Password Protection DC agents in a forest.
