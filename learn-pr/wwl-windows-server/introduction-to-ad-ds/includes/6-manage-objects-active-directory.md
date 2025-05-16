Managing the AD DS environment is one of the most common tasks an IT pro performs. There are several tools that you can use to manage AD DS.

## Active Directory Administrative Center

The Active Directory Administrative Center provides a GUI that is based on Windows PowerShell. This enhanced interface allows you to perform AD DS object management by using task-oriented navigation, and it replaces the functionality of Active Directory Users and Computers.

:::image type="content" source="../media/m6-administrative-center-195c7431.png" alt-text="A screenshot of Active Directory Administrative Center. The administrator has selected the IT OU in the Contoso.com domain.":::

Tasks that you can perform by using the Active Directory Administrative Center include:

- Creating and managing user, computer, and group accounts.
- Creating and managing OUs.
- Connecting to and managing multiple domains within a single instance of the Active Directory Administrative Center.
- Searching and filtering AD DS data by building queries.
- Creating and managing fine-grained password policies.
- Recovering objects from the Active Directory Recycle Bin.
- Managing objects that the Dynamic Access Control feature requires.

## Windows Admin Center

Windows Admin Center is a web-based console that you can use to manage server computers and computers that are running Windows 10. Typically, you use Windows Admin Center to manage servers instead of using Remote Server Administration Tools (RSAT).

Windows Admin Center works with any browser that is compliant with modern standards, and you can install it on computers that run Windows 10 and Windows Server with Desktop Experience.

> [!NOTE]
> You shouldn’t install Windows Admin Center on a server computer that is configured as an AD DS domain controller.

With a decreasing number of exceptions, Windows Admin Center supports most current Windows Server and Windows 10 administrative functionality. However, Microsoft intends that Windows Admin Center will eventually support all the administrative functionality that is presently available through RSAT.

:::image type="content" source="../media/m6-windows-admin-center-9057410f.png" alt-text="A screenshot of Windows Admin Center. The administrator has selected Server Manager. The Overview pane for a server called SEA-DC1 is displayed.":::

To use Windows Admin Center, you must first download and install it. You can download Windows Admin Center from the Microsoft download website. After downloading and installing Windows Admin Center, you must enable the appropriate TCP port on the local firewall. On a Windows 10 computer (in standalone mode), this defaults to 6516. On Windows Server (in gateway mode), this defaults to TCP 443. In both cases, you can change it during setup.

> [!NOTE]
> Unless you're using a certificate from a trusted CA, the first time you run Windows Admin Center, it prompts you to select a client certificate. Ensure you select the certificate labeled Windows Admin Center Client.

## Remote Server Administration Tools

RSAT is a collection of tools which enables you to manage Windows Server roles and features remotely.

:::image type="content" source="../media/m6-add-optional-feature-dialog-box-cc4ed1ad.png" alt-text="A screenshot of the Add an optional feature dialog box. Displayed are a list of RSAT tools.":::

> [!NOTE]
> You enable RSAT tools from the Settings app. In **Settings**, search for **Manage optional features**, select **Add a feature**, and then select the appropriate RSAT tools from the returned list. Select **Install** to add the feature.

You can install the consoles available within RSAT on computers running Windows 10 or on server computers that are running the Server with Desktop Experience option of a Windows Server installation. Until the introduction of Windows Admin Center, RSAT consoles were the primary graphical tools for administering the Windows Server operating system.

## Other AD DS management tools

Other management tools that you use to perform AD DS administration are described in the following table.

:::row:::
  :::column:::
    **Management tool**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Active Directory module for Windows PowerShell
  :::column-end:::
  :::column:::
    The Active Directory module for Windows PowerShell supports AD DS administration, and it's one of the most important management components. Server Manager and the Active Directory Administration Center are based on Windows PowerShell and use cmdlets to perform their tasks.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Active Directory Users and Computers
  :::column-end:::
  :::column:::
    Active Directory Users and Computers is a Microsoft Management Console (MMC) snap-in that manages most common resources, including users, groups, and computers. Although many administrators are familiar with this snap-in, the Active Directory Administrative Center replaces it and provides more capabilities.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Active Directory Sites and Services
  :::column-end:::
  :::column:::
    The Active Directory Sites and Services MMC snap-in manages replication, network topology, and related services.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Active Directory Domains and Trusts
  :::column-end:::
  :::column:::
    The Active Directory Domains and Trusts MMC snap-in configures and maintains trust relationships at the domain and forest functional levels.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Active Directory Schema snap-in
  :::column-end:::
  :::column:::
    The Active Directory Schema MMC snap-in examines and modifies the definitions of AD DS attributes and object classes. You don't need to review or change it often. Therefore, by default, the Active Directory Schema snap-in isn't registered.
  :::column-end:::
:::row-end:::

## Demonstration

The following video demonstrates how to manage objects in AD DS by using Active Directory Administrative Center. The main steps in the process are:

1. From Server Manager, open Active Directory Administrative Center.
2. Select Dynamic Access Control in the Contoso domain.
3. Perform a global search and review the results.
4. Reset the password for a user in the Contoso domain.
5. Create a new computer object called SEA-CL4.
6. Open the new computer object and review its properties, including its Extensions.
7. Review the Windows PowerShell history and examine the `New-ADComputer` command.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=caf2f3f8-4a16-471f-80e3-aec1f3016fd3]
