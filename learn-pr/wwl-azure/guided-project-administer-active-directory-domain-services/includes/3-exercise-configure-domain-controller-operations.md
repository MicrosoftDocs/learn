n this exercise, you will promote a server to domain controller, transfer a FSMO role to the new domain controller, create a site, and add a subnet to the site,

## Install Active Directory Domain Services (AD DS) and promote to Domain Controller

In this task, you will promote member server TAILWIND-MBR1 to become a domain controller in the TAILWINDTRADERS domain. To complete this task, perform the following steps:

1.  Sign in to TAILWIND-MBR1 as TAILWINDTRADERS\\Administrator with the password: **Pa55w.rdPa55w.rd**.
2.  In Server Manager, select the Manage menu and then select **Add Roles and Features**.
3.  On the Before you begin page of the Add Roles and Features wizard, click **Next**.
4.  On the Select installation type page select **Role-based or feature-based installation** and click **Next**.
5.  On the Select destination server page, choose **Select a server from the server pool**, ensure TAILWIND-MBR1 is selected and click **Next**.
6.  On the Select server roles page, select the **Active Directory Domain Services** checkbox. This will open the Add features page. Select **Add Features**. On the Select server roles page click **Next**.
7.  On the Select features page click **Next**.
8.  On the Active Directory Domain Services page click **Next**.
9.  On the Confirm installation selections page, click **Install**. Depending on the speed of the computer, installation may take several minutes. When the installation completes, click **Close**.
10. On the Server manager menu, select the notification icon next to the flag in the top right corner shown in the screenshot.
    
    :::image type="content" source="../media/server-manager-menu.png" alt-text="Screenshot of the server manager menu with the alert icon displayed.":::
    
11. On the menu that opens when you select the notification icon, select **Promote this server to a domain controller**. This will start the Active Directory Domain Services Configuration Wizard.
12. On the Deployment Configuration page, select **Add a domain controller to an existing domain** and ensure that the domain name is set to **tailwindtraders.internal**. Click **Next**.
13. On the Domain Controller options page, accept the default settings and provide the Directory Services Restore Mode (DSRM) password. To do this, enter the following password twice: **Pa55w.rdPa55w.rd**. Click **Next**.
14. On the DNS Options page, click **Next**.
15. On the Additional Options page, click **Next**.
16. On the Paths page, click **Next**.
17. On the Review Options page, click **Next**.
18. On the Prerequisites Check page, click **Install**. The installation will take several minutes depending on the speed of the virtual machine. The virtual machine will restart.
19. When the virtual machine restarts, sign in as **tailwindtraders\\administrator** with the password you configured for the default administrator account (Pa55w.rdPa55w.rd)

## Transfer Flexible Single Master Operations Roles<br>

In this task, you will transfer the RID Master role from TAILWIND-DC1 to TAILWIND-MBR1. To complete this task, perform the following steps:

1.  On TAILWIND-MBR1, open Active Directory Users and Computers.<br>
2.  In the navigation pane, right-click Active Directory Users, point to **All Tasks**, and then select **Operations Masters**.
3.  On the RID tab, select **Change**, select **Yes**, and then click **OK**.
4.  Close the Operations Masters dialog box.

### Create an Active Directory site and configure a subnet for that site<br>

In this task, you will create an Active Directory site and configure a subnet associated with that site. To complete this task, perform the following steps:

1.  On TAILWIND-DC1, Open Active Directory Sites and Services from the Tools menu.
2.  Right-click Sites, select **New site**, and type **Sydney** as the site name.
3.  Select DEFAULTIPSITELINK and click **OK** twice.
4.  Right-click **Subnets** and select **New Subnet**.
5.  As the Prefix, type **172.16.1.0/24**, select **Sydney** as site name and click **OK**.
6.  Close Active Directory Sites and Services.
