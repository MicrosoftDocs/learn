

## Multiple Choice
A system administrator needs to ensure optimal performance for Azure Virtual Desktop users. What load balancing option should they use to fully allocate users on one VM before moving to the next?
( ) Breadth mode load balancing {{Incorrect. Breadth mode load balancing allocates users sequentially across the host pool, not fully on one VM before moving to the next.}}
(x) Depth mode load balancing {{Correct. Depth mode fully allocates users on one VM before moving to the next, ensuring optimal performance.}}
( ) Sequential mode load balancing {{Incorrect. There is no such thing as Sequential mode load balancing in Azure Virtual Desktop.}}

## Multiple Choice
A team needs to establish a multi-session Windows 11 environment that offers a comprehensive Windows experience with scalability. They also need to deploy Microsoft 365 Apps for enterprise and optimize them for multi-user virtual scenarios. Which service should they use?
(x) Azure Virtual Desktop {{Correct. Azure Virtual Desktop is a cloud-based service for desktop and application virtualization, offering users secure and remote access to their desktop environments and applications from various devices and locations.}}
( ) Azure Active Directory {{Incorrect. Azure Active Directory is a cloud-based identity and access management service, not a desktop and application virtualization service.}}
( ) Azure DevOps {{Incorrect. Azure DevOps is a developer service providing tools for planning, collaboration, and code development, not a desktop and application virtualization service.}}

## Multiple Choice
A system administrator is tasked with setting up a Windows 11 Enterprise desktop in Azure Virtual Desktop. They have created a personal host pool, a session host virtual machine, a workspace, and an application group. What should they do next to ensure users can access the desktop?
(x) They should assign users to the application group. {{Correct. After setting up the host pool, session host VM, workspace, and application group, the next step is to assign users to the application group.}}
( ) They should create another session host virtual machine. {{Incorrect. Creating another session host virtual machine is not required unless more resources are needed.}}
( ) They should delete and recreate the host pool. {{Incorrect. Deleting and recreating the host pool is not necessary once it has been properly set up.}}

## Multiple Choice
A system administrator needs to retrieve the object ID of a host pool in Azure Virtual Desktop. Which command should they use?
( ) Get-AzWvdWorkspace -Name <WorkspaceName> -ResourceGroupName <ResourceGroupName>).ObjectID {{Incorrect. This PowerShell command is used to retrieve the object ID of a workspace, not a host pool.}}
( ) az desktopvirtualization workspace show --name <Name> --resource-group <ResourceGroupName> --query objectId --output tsv {{Incorrect. This command is used to retrieve the object ID of a workspace, not a host pool.}}
(x) az desktopvirtualization hostpool show --name <Name> --resource-group <ResourceGroupName> --query objectId --output tsv {{Correct. This command retrieves the object ID of a host pool in Azure Virtual Desktop.}}