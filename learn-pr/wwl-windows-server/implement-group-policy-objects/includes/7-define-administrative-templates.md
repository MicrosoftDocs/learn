Administrative template files provide most of the available GPO settings, which modify specific registry keys. The use of administrative templates is known as a registry-based policy, because all the settings you configure in administrative templates result in changes to the registry. For many apps, using a registry-based policy is the simplest and best way to support the centralized management of policy settings.

## Overview of administrative templates

You can use administrative templates to control the environment of an operating system and the user experience. There are two sets of administrative templates:

 -  Computer-related settings
 -  User-related settings

:::image type="content" source="../media/m8-group-policy-8-34180b69.png" alt-text="A screenshot of the Group Policy Management Editor. The administrator has expanded the Administrative Templates node for both the Computer Configuration and User Configuration nodes.":::


When you configure settings in the Administrative Templates node of the GPO, you make modifications to the registry. Administrative templates have the following characteristics:

 -  They have subnodes that correspond to specific areas of the environment, such as network, system, and Windows components.
 -  The settings in the computer section of the Administrative Templates node edit the HKEY\_LOCAL\_MACHINE hive in the registry.
 -  The settings in the user section of the Administrative Templates node edit the HKEY\_CURRENT\_USER hive in the registry.
 -  Some settings exist for both user and computer.

> [!IMPORTANT]
> In the case of conflicting settings, the computer setting prevails.

 -  Some settings are available only to certain versions of Windows operating systems. For example, you can apply several new settings only to Windows 10.

> [!TIP]
> To check which Windows versions are supported, select the setting you want, and then select the Extended tab.

The following table details the organization of the Administrative Templates node.

:::row:::
  :::column:::
    **Administrative template section**
  :::column-end:::
  :::column:::
    **Settings**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Computer configuration
  :::column-end:::
  :::column:::
    Control Panel, Network, Printers, Server, Start Menu and Taskbar, System, Windows Components, All Settings
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    User configuration
  :::column-end:::
  :::column:::
    Control Panel, Desktop, Network, Shared Folders, Start Menu and Taskbar, System, Windows Components, All Settings
  :::column-end:::
:::row-end:::


Most of the nodes contain multiple subfolders that enable you to organize settings into logical groupings. Even with this organization, finding the setting that you need might be a daunting task.

> [!TIP]
> The All Settings node contains an alphabetically sorted list of all settings contained in all the other nodes.

## What are .admx and .adml files?

All the settings in the Administrative Templates node of a GPO are stored in files. All currently supported operating systems store the settings in .admx files.

These settings use a standards-based XML file format known as .admx files. By default, Windows stores .admx files in the Windows\\PolicyDefinitions folder, but you can store them in a central location.

The .admx files are language neutral. The plain language descriptions of the settings are not part of the .admx files. Instead, they're stored in language-specific .adml files. This means that administrators can review the same GPO and observe the policy descriptions in their own language because they can each use their own language-specific .adml files.

The PolicyDefinitions folder stores .adml files subfolders. Each language has its own folder. For example, the en-US folder stores the English files, and the es-ES folder stores the Spanish files. By default, only the .adml language files for the language of the installed operating system are present.

## What is the Central Store?

In domain-based enterprises, you can create a Central Store location for .admx files, which anyone with permissions to create or edit GPOs can access. The Group Policy Management Editor automatically reads and displays administrative templates policy settings from .admx files in the Central Store, and then ignores the .admx files stored locally. If the domain controller or Central Store is not available, the Group Policy Management Editor uses the local store.

The advantages of creating a Central Store are:

 -  You ensure that whenever someone edits a GPO, the settings in the **Administrative Templates** node are always the same.
 -  When Microsoft releases new administrative templates for new operating systems or apps, such as Office, you only need to update the administrative templates files in one location.

You must create the Central Store manually, and then update it manually on a domain controller. The domain controllers then use AD DS replication and DFS-R to replicate the data.

To create a Central Store for .admx and .adml files, create a folder and name it PolicyDefinitions in the `\\FQDN\SYSVOL\FQDN\Policies` location, where FQDN is the domain name for your AD DS domain.

For example, to create a Central Store for the `Seattle.Contoso.com` domain, create a PolicyDefinitions folder in the following location:

```powershell
\\Seattle.Contoso.com\SYSVOL\Seattle.Contoso.com\policies

```

An administrator must copy all files and subfolders of the PolicyDefinitions folder, which on a Windows computer resides in the Windows folder. The PolicyDefinitions folder stores all .admx files, and subfolders store .adml files for all languages enabled on the client computer. For example, on a Windows Server computer that has English enabled, C:\\Windows\\PolicyDefinitions will contain the .admx files and in the subfolder en-US, the .adml files will contain English-based descriptions for the settings defined in the .admx files.

> [!IMPORTANT]
> You must update the PolicyDefinitions folder for each feature update and for other software, such as Windows 10 Version 2004 and Microsoft Office 2019 .admx files.
