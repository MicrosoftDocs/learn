If you use Remote Desktop Services (RDS) to provide shared computers to users in your organization, you can install Microsoft 365 Apps on those computers. But, you have to use the Office Deployment Tool and enable [shared computer activation](/deployoffice/overview-shared-computer-activation) to do the installation.

The following are two common RDS scenarios:

 -  Install Microsoft 365 Apps on an RDS server.
 -  Install Microsoft 365 Apps on a shared virtual machine.

The following is a list of prerequisites that you need to deploy Microsoft 365 Apps or the Project and Visio desktop apps with RDS:

 -  One of the following plans:
     -  A Microsoft 365 (or Office 365) plan that includes Microsoft 365 Apps for enterprise.
     -  A Microsoft 365 Business Premium plan that includes Microsoft 365 Apps for business.
     -  For the Project and Visio desktop apps, a subscription plan that includes those products.
 -  The Office Deployment Tool, which is available on the [Microsoft Download Center](https://go.microsoft.com/fwlink/p/?LinkID=626065).
 -  A separate user account for each user who signs in to the shared computer.
 -  An [eligible license assigned](/microsoft-365/admin/manage/assign-licenses-to-users) to each user account.
 -  A version of Windows listed in the [Microsoft 365 plans for business, education, and government system requirements](https://www.microsoft.com/microsoft-365/microsoft-365-and-office-resources#areaheading-oc60f6).
 -  Reliable connectivity between the shared computer and the internet.

## Install Microsoft 365 Apps on an RDS server

In this scenario, you install Microsoft 365 Apps on a computer configured as a Remote Desktop Session Host server, allowing multiple users to connect remotely. Each user can simultaneously run Microsoft 365 programs like Word or Excel. The process is identical for Project and Visio desktop apps.

Here are the basic steps of how to install Microsoft 365 Apps on an RDS server:

1.  Use the [Office Customization Tool](https://config.office.com/deploymentsettings) to create a configuration file. Make sure to tick the **Shared Computer** box in the **Licensing and activation** section. Export the resulting configuration file and save it to the same location as the extracted Office Deployment Tool.
2.  You can also [create a configuration file](/deployoffice/office-deployment-tool-configuration-options) using a text editor. Make sure that it includes the following line:<br>`<Property Name="SharedComputerLicensing" Value="1" />`

You use the SharedComputerLicensing setting to enable [shared computer activation](/deployoffice/overview-shared-computer-activation), which is required to use Microsoft 365 Apps on a shared computer.<br>

Use the [Office Deployment Tool](/deployoffice/overview-office-deployment-tool) and the configuration file to install Microsoft 365 Apps on the RD Session Host server.<br>

At this point, users can connect to the RD Session Host server and use Microsoft 365 Apps. Users can connect to the server by using Remote Desktop Connection, which is available in Windows, or by using other [Remote Desktop clients](/windows-server/remote/remote-desktop-services/clients/remote-desktop-clients).

## Install Microsoft 365 Apps on a shared Make sure that it includes the following line: virtual machine

In this scenario, you install Microsoft 365 Apps as part of a client operating system image, such as one running Windows 10. Then, you use RDS and Hyper-V to create a group of virtual machines based on that image. These virtual machines are shared with multiple users. In RDS, this is known as either a virtual desktop pool or a pooled virtual desktop collection, depending on which version of RDS that you're using.

> [!NOTE]
> You can also use RDS to assign a virtual machine to a specific user. RDS calls that a personal virtual desktop. In that scenario, you don't use shared computer activation, because the virtual machine isn't shared among multiple users.

Here are the basic steps of how to configure RDS to deploy Microsoft 365 Apps on a shared virtual machine:

1.  Create the operating system image:
2.  
     -  Follow the instructions to [Deploy Microsoft 365 Apps as part of an operating system image](/deployoffice/deploy-microsoft-365-apps-operating-system-image). In Step 2 of the instructions, make sure that your *configuration.xml* file also includes the following line to enable shared computer activation:<br>`<Property Name="SharedComputerLicensing" Value="1" />`

2.  Install and configure Windows Server.
3.  Install and configure RDS.
    
    For example, [follow these steps to deploy a virtual desktop collection](/windows-server/remote/remote-desktop-services/rds-create-collection) on Windows Server..

After you complete all the RDS configuration steps, users can connect to any of the virtual machines and run Microsoft 365 Apps.
