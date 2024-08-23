Managing sites and subnets is a critical part of managing any corporate domain. Anytime a company expands or alters its footprint, sites may need to be created or adjusted. Imagine that a new location is getting launched soon – What steps might be necessary to hit the ground running?

Creating a new site allows for grouping objects by their physical location. Adding a subnet keeps all of the resources at the new site on the same network (or parts of the network). Finally, migrating a domain controller to the new site helps reduce internet traffic and lag associated with reaching out to a distant site for authentication and authorization queries.

## Create a new site

The first step of setting up the new location is creating a new site, so all of the computer, user, and other objects may be associated to the new location.

To create a new site in the Active Directory Sites and Services console:

1.  Open the **Active Directory Sites and Services** console.
2.  In the console tree, right-click Sites, and then select **New Site**.
3.  Name the new site, associate it with the appropriate site link, and then click **OK**.

Alternatively, you can create a new site using the PowerShell command as follows.

```powershell
New-ADReplicationSite -Name "Ludington" -Description "Site for new facility in Ludington MI."
```

## Map the new site to a subnet

To assign the newly created site to a subnet:

1.  In the **Active Directory Sites and Services** console, expand the **Sites** folder to see the list of sites.
2.  Right-click **Subnets** and select **New Subnet**.
3.  Enter the subnet address and mask, and then select the site you created from the drop-down list.
4.  Select **OK** to associate the subnet with your new site.

To use PowerShell to map a new site to a subnet, you can use the following command.

```powershell
New-ADReplicationSubnet -Name "192.168.1.0/24" -Site "Ludington"
```

## Move a domain controller to a new site

To move a domain controller to the new site:

1.  In the **Active Directory Sites and Services** console, expand the site that currently contains the domain controller you want to move.
2.  Expand the **Servers** folder, and then expand the server that represents the domain controller.
3.  Right-click the domain controller's **NTDS Settings** object, and then select **Move**.
4.  In the **Move Server** dialog box, select the new site to which you want to move the domain controller, and then select **OK**.

Just as you can use PowerShell to create a new site and map it to a subnet, you can use PowerShell to move a domain controller.

```powershell
Move-ADDirectoryServer -Identity "DC2.WestMI" -Site "Ludington"
```
