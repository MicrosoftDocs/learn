Azure Virtual Desktop is a managed virtual desktop service that includes many security capabilities for keeping your organization safe. The architecture of Azure Virtual Desktop comprises many components that make up the service connecting users to their desktops and apps.

Azure Virtual Desktop has many built-in advanced security features, such as Reverse Connect where no inbound network ports are required to be open, which reduces the risk involved with having remote desktops accessible from anywhere. The service also benefits from many other security features of Azure, such as multifactor authentication and conditional access. This article describes steps you can take as an administrator to keep your Azure Virtual Desktop deployments secure, whether you provide desktops and apps to users in your organization or to external users.

## Shared security responsibilities

Before Azure Virtual Desktop, on-premises virtualization solutions like Remote Desktop Services require granting users access to roles like Gateway, Broker, Web Access, and so on. These roles had to be fully redundant and able to handle peak capacity. Administrators would install these roles as part of the Windows Server operating system, and they had to be domain-joined with specific ports accessible to public connections. To keep deployments secure, administrators had to constantly make sure everything in the infrastructure was maintained and up-to-date.

In most cloud services, however, there's a [shared set of security responsibilities](/azure/security/fundamentals/shared-responsibility) between Microsoft and the customer or partner. For Azure Virtual Desktop, most components are Microsoft-managed, but session hosts and some supporting services and components are customer-managed or partner-managed. To learn more about the Microsoft-managed components of Azure Virtual Desktop, see [Azure Virtual Desktop service architecture and resilience](/azure/virtual-desktop/service-architecture-resilience).

While some components come already secured for your environment, you'll need to configure other areas yourself to fit your organization's or customer's security needs. Here are the components of which you're responsible for the security in your Azure Virtual Desktop deployment:

| **Component**                 | **Responsibility**  |
| ----------------------------- | ------------------- |
| Identity                      | Customer or partner |
| User devices (mobile and PC)  | Customer or partner |
| App security                  | Customer or partner |
| Session host operating system | Customer or partner |
| Deployment configuration      | Customer or partner |
| Network controls              | Customer or partner |
| Virtualization control plane  | Microsoft           |
| Physical hosts                | Microsoft           |
| Physical network              | Microsoft           |
| Physical datacenter           | Microsoft           |

## Security boundaries

Security boundaries separate the code and data of security domains with different levels of trust. For example, there's usually a security boundary between kernel mode and user mode. Most Microsoft software and services depend on multiple security boundaries to isolate devices on networks, virtual machines (VMs), and applications on devices. The following table lists each security boundary for Windows and what they do for overall security.

| **Security boundary**              | **Description**                                                                                                                                                          |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Network boundary                   | An unauthorized network endpoint can't access or tamper with code and data on a customer’s device.                                                                       |
| Kernel boundary                    | A non-administrative user mode process can't access or tamper with kernel code and data. Administrator-to-kernel is not a security boundary.                             |
| Process boundary                   | An unauthorized user mode process can't access or tamper with the code and data of another process.                                                                      |
| AppContainer sandbox boundary      | An AppContainer-based sandbox process can't access or tamper with code and data outside of the sandbox based on the container capabilities.                              |
| User boundary                      | A user can't access or tamper with the code and data of another user without being authorized.                                                                           |
| Session boundary                   | A user session can't access or tamper with another user session without being authorized.                                                                                |
| Web browser boundary               | An unauthorized website can't violate the same-origin policy, nor can it access or tamper with the native code and data of the Microsoft Edge web browser sandbox.       |
| Virtual machine boundary           | An unauthorized Hyper-V guest virtual machine can't access or tamper with the code and data of another guest virtual machine; this includes Hyper-V isolated containers. |
| Virtual Secure Mode (VSM) boundary | Code running outside of the VSM trusted process or enclave can't access or tamper with data and code within the trusted process.                                         |

### Recommended security boundaries for Azure Virtual Desktop scenarios

You'll also need to make certain choices about security boundaries on a case-by-case basis. For example, if a user in your organization needs local administrator privileges to install apps, you'll need to give them a personal desktop instead of a shared session host. We don't recommend giving users local administrator privileges in multi-session pooled scenarios because these users can cross security boundaries for sessions or NTFS data permissions, shut down multi-session VMs, or do other things that could interrupt service or cause data losses.

Users from the same organization, like knowledge workers with apps that don't require administrator privileges, are great candidates for multi-session session hosts like Windows 11 Enterprise multi-session. These session hosts reduce costs for your organization because multiple users can share a single VM, with only the overhead costs of a VM per user. With user profile management products like FSLogix, users can be assigned any VM in a host pool without noticing any service interruptions. This feature also lets you optimize costs by doing things like shutting down VMs during off-peak hours.

If your situation requires users from different organizations to connect to your deployment, we recommend you have a separate tenant for identity services like Active Directory and Microsoft Entra ID. We also recommend you have a separate subscription for those users for hosting Azure resources like Azure Virtual Desktop and VMs.

In many cases, using multi-session is an acceptable way to reduce costs, but whether we recommend it depends on the trust level between users with simultaneous access to a shared multi-session instance. Typically, users that belong to the same organization have a sufficient and agreed-upon trust relationship. For example, a department or workgroup where people collaborate and can access each other’s personal information is an organization with a high trust level.

Windows uses security boundaries and controls to ensure user processes and data are isolated between sessions. However, Windows still provides access to the instance the user is working on.

Multi-session deployments would benefit from a security in depth strategy that adds more security boundaries that prevent users within and outside of the organization from getting unauthorized access to other users' personal information. Unauthorized data access happens because of an error in the configuration process by the system admin, such as an undisclosed security vulnerability or a known vulnerability that hasn't been patched out yet.

We don't recommend granting users that work for different or competing companies access to the same multi-session environment. These scenarios have several security boundaries that can be attacked or abused, like network, kernel, process, user, or sessions. A single security vulnerability could cause unauthorized data and credential theft, personal information leaks, identity theft, and other issues. Virtualized environment providers are responsible for offering well-designed systems with multiple strong security boundaries and extra safety features enabled wherever possible.

The table summarizes our recommendations for each scenario.

| **Trust level scenario**                             | **Recommended solution**                                              |
| ---------------------------------------------------- | --------------------------------------------------------------------- |
| Users from one organization with standard privileges | Use a Windows Enterprise multi-session operating system (OS).         |
| Users require administrative privileges              | Use a personal host pool and assign each user their own session host. |
| Users from different organizations connecting        | Separate Azure tenant and Azure subscription                          |
