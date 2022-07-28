Active Directory Domain Services (AD DS) and its related services form the core of Windows Server–based networks. The AD DS database stores information about the objects that are part of the network environment, such as accounts for users, computers, and groups. The AD DS database is searchable and provides a mechanism for applying configuration and security settings for all of those objects.

You can use the Active Directory module for Windows PowerShell to automate AD DS administration. By using Windows PowerShell for AD DS administration tasks, you can speed them up by making bulk updates instead of updating AD DS objects individually. If you don't have the Active Directory module installed on your machine, you'll need to download the correct Remote Server Administration Tools (RSAT) package for your operating system. RSAT is included as a set of Features on Demand, starting with the Windows 10 October 2018 Update. To install an RSAT package, you can refer to **Optional features** in **Settings** and select **Add a feature** to review the list of available RSAT tools. For AD DS administration, you'll need to select the **RSAT: Active Directory Domain Services and Lightweight Directory Services Tools** option.

> [!NOTE]
> The Active Directory module for Windows PowerShell works for both Windows PowerShell and PowerShell.

In this module, you'll learn about the cmdlets used for administering AD DS. To find Active Directory cmdlets, search for the prefix “AD,” which most Active Directory cmdlets have in the noun part of the cmdlet name.

## Learning objectives

After completing this module, you'll be able to:

- Identify user management cmdlets.
- List group management cmdlets.
- Describe the cmdlets for managing computer objects.
- Describe the cmdlets for managing organizational units (OUs) and Active Directory objects.


## Prerequisites

Familiarity with:

- Windows networking technologies and implementation.
- Windows Server administration, maintenance, and troubleshooting.
- Windows PowerShell and its commands to perform specific tasks.