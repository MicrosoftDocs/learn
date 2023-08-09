

Managing Cloud PCs is just like managing any other device. You apply configuration profiles and assign apps. You apply quality and feature updates using update rings. You apply security policies in the same manor as physical devices. While you might specify separate policies just for Cloud PCs, the method is no different.

### Remote actions

Most of the same remote actions available on physical devices, are available for Cloud PCs as well. They include:

 -  Restart
 -  Sync
 -  Rename
 -  Quick Scan
 -  Full Scan
 -  Update Windows Defender

There are three remote actions that are unique to Cloud PCs and are available if a Cloud PC is selected.

 -  Reprovisioning
 -  Resize
 -  Collect diagnostics
### Reprovisioning

The Reprovision remote action allows admins to reprovision Cloud PCs. When this action is initiated, the Cloud PC is reset to its initial state. Note, that user data, applications, and customizations aren't automatically deleted - this depends on the specific configuration of the Cloud PC and the policies in place to handle user data during reprovisioning. It's recommended to always ensure data backup before initiating a reprovision.

 -  You're testing different Cloud PC configurations.
 -  Your provisioned Cloud PC is misbehaving.
 -  The user simply wants to start from a fresh Cloud PC.

To reprovision a Cloud PC, perform the following steps:

1.  Sign in to the **Microsoft Endpoint Manager admin center**, select **Devices** > **All Devices** > choose a Cloud PC device > **Reprovision**.
    
    :::image type="content" source="../media/reprovision-5de0ba6b.png" alt-text="Screenshot of Endpoint Manager admin center showing a device selected and highlighting the Reprovision button.":::
    
2.  In the Reprovision box, select **Yes**. The reprovision process begins.

3.  After the new Cloud PC is created, Windows 365 sends access information to the new user.

### Resize a Cloud PC

The Resize remote action lets you upgrade a Cloud PC’s RAM, CPU, and storage size. This action is useful if the requirements of a user change over time, such as running more CPU intensive applications or need more disk storage. When choosing an initial size, keep in mind that resizing only allows increasing storage; you won't be able to resize to a lower storage allocation.

To resize a Cloud PC, the following are required:

 -  The admin must have either Global Admin or the Intune Service Admin Azure AD role
 -  The Cloud PC must have a status of provisioned.
 -  The user must be signed out with all work saved as resizing disconnects their session.

Resizing a Cloud PC involves the following steps:

1.  Sign in to the Microsoft Endpoint Manager admin center, select **Devices** > **All Devices** > choose a device > **Resize**.
    
    :::image type="content" source="../media/resize-6b7faa89.png" alt-text="Screenshot of the Microsoft Intune Admin center resize pc option.":::
    
2.  You see a list with all the possible SKUs that you can upgrade to. You increase and decrease a Cloud PC’s specs (RAM/vCPU). You can only increase the OS disk storage. You can't decrease the OS disk storage. If you're downsizing a user’s Cloud PC, options with lower storage will be grayed out. Select one of the available options.
3.  Select **Resize**. 
    -  When triggering a resize, the Cloud PC will be rebooted and the user is immediately disconnected from their current session. Make sure the user saves all their work to avoid any potential data loss.
    -  If there are available licenses, the upgrade/downgrade takes place.
    -  The resize feature prioritizes your paid licenses when you have a mix of paid and trial licenses. Once your paid licenses are exhausted, the resize operation utilizes your trial licenses.
    -  The resizing process is unsuccessful if your inventory lacks the necessary licenses. To rectify this error, contact your procurement administrator to acquire more licenses. Once extra licenses have been purchased and incorporated into the inventory via the Microsoft Admin Center, you can attempt the resizing operation again.

### Learn More
-  [Device management overview for Cloud PCs](/windows-365/enterprise/device-management-overview?azure-portal=true)