In addition to the challenges that Tailwind Traders has been facing with application scale, your manager has asked you to put together a new development team of remote workers. This task would normally require setting up several new computers with all of the requisite development tools for your new team, and then shipping them to the respective developers across the country. The time to procure, set up, and ship each of these computers would be rather costly, and all of your new developers have their own computing devices that are running a mixture of Windows, Android, and macOS operating systems. You'd like to find a way to expedite the deployment process for your remote workers, and keep your management costs to a minimum. With that in mind, you want to see how Windows Virtual Desktop can help your organization.

## What is Windows Virtual Desktop?

Windows Virtual Desktop on Microsoft Azure is a desktop and application virtualization service that runs on the cloud, which enables your users to use a cloud-hosted version of Windows from any location. Windows Virtual Desktop works across devices - like Windows, Mac, iOS, Android, and Linux - with apps that you can use to access remote desktops and apps. You can also use most modern browsers to access Windows Virtual Desktop-hosted experiences.

The following video gives you an overview of Windows Virtual Desktop.

> [!VIDEO https://channel9.msdn.com/Shows/Learn-Azure/Windows-Virtual-Desktop-Overview/player?format=ny]

## Why should you use Windows Virtual Desktop?

### To provide the best user experience

Users have the freedom to connect to  Windows Virtual Desktop with any device over the internet. They use a Windows Virtual Desktop client to connect to their published Windows desktop and applications. This client could either be a native application on the device or the Windows Virtual Desktop HTML5 web client.

You can make sure your session host virtual machines (VMs) run near apps and services that connect to your datacenter or the cloud. So users stay productive and don't encounter long load times.

User sign-in to Windows Virtual Desktop is extremely fast because user profiles are containerized by using FSLogix. At sign-in, the user profile container is dynamically attached to the computing environment. The user profile is immediately available and appears in the system exactly like a native user profile.

You can provide individual ownership through personal (persistent) desktops. For example, you may want to provide personal remote desktops for members of an engineering team. They'd be able to add or remove programs without impacting other users on that remote desktop.

### To enhance security

Windows Virtual Desktop provides centralized security management for users' desktops with Azure Active Directory (Azure AD). You can enable multi-factor authentication to secure user sign-ins. You can also secure access to data by assigning granular role-based access controls to users.

With Windows Virtual Desktop, the data and apps are separated from the local hardware and runs them instead on a remote server. So the risk of confidential data being left on a personal device is reduced.

User sessions are isolated in both single and multi-session environments.

Windows Virtual Desktop also improves security by using reverse connect technology which is a more secure connection type than the Remote Desktop Protocol. We don't open inbound ports to the session host VMs.

## What are some key features of Windows Virtual Desktop?

### Simplified management

Windows Virtual Desktop is an Azure service which will be familiar to Azure administrators. You use Azure Active Directory and role-based access controls to manage access to resources. Also with Azure, you get  tools to automate VM deployments, manage VM updates, and provide disaster recovery. As with other Azure services, Windows Virtual Desktop uses Azure Monitor for monitoring and alerts. This lets admins identify issues through a single interface.

### Performance management

Windows Virtual Desktop gives you options to load balance users on your VM host pools. **Host pools** are collections of VMs with the same configuration assigned to multiple users. For the best performance, you can configure load balancing to occur as users sign in (breadth mode). With breadth mode, users are sequentially allocated across the host pool for your workload. To save costs, you can configure your VMs for depth mode load balancing where users are fully allocated on one VM before moving to the next. Windows Virtual Desktop provides tools to automatically provision additional VMs when incoming demand exceeds a specified threshold.

### Multi-session Windows 10 deployment

Windows Virtual Desktop lets you use Windows 10 Enterprise multi-session, the only Windows client-based operating system that enables multiple concurrent users on a single virtual machine (VM). Windows Virtual Desktop also provides a more consistent experience with broader application support compared to Windows Server-based operating systems.

## How can you reduce costs with Windows Virtual Desktop?

### Bring your own licenses

Windows Virtual Desktop is available to you at no additional cost if you have an eligible Microsoft 365
license. Just pay for the Azure resources used by Windows Virtual Desktop.

- Bring your eligible Windows or Microsoft 365 license to get Windows 10 Enterprise and Windows 7 Enterprise desktops and apps at no additional cost.

- If you're an eligible Microsoft Remote Desktop Services (RDS) Client Access License (CAL) customer, Windows Server Remote Desktop Services desktops and apps are available at no additional cost.

### Save on compute costs

Buy one-year or three-year Azure Reserved Virtual Machine Instances to save you up to 72 percent versus pay-as-you-go pricing. You can pay for a reservation up front or monthly. Reservations provide a billing discount and don't affect the runtime state of your resources.

