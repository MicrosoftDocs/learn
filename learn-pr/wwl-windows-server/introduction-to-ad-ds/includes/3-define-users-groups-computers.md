In addition to the high-level components and objects, AD DS contains other objects such as users, groups, and computers.

## Create user objects

In AD DS, you must provide all users that require access to network resources with a user account. With this user account, users can authenticate to the AD DS domain and access network resources.

In Windows Server, a user account is an object that contains all the information that defines a user. A user account includes:

- The username.
- A user password.
- Group memberships.

A user account also contains settings that you can configure based on your organizational requirements.

:::image type="content" source="../media/m6-user-89703b1f.png" alt-text="A screenshot of the Jane Dow user account in Active Directory Administrative Center.":::

The username and password of a user account serve as the user’s sign-in credentials. A user object also includes several other attributes that describe and manage the user. You can use the following to create and manage user objects in AD DS:

- Active Directory Administrative Center.
- Active Directory Users and Computers.
- Windows Admin Center.
- Windows PowerShell.
- The `dsadd` command-line tool.

### What are managed service accounts?

Many apps contain services that you install on the server that hosts the program. These services typically run at server startup or are triggered by other events. Services often run in the background and don't require any user interaction. For a service to start up and authenticate, you use a service account. A service account might be an account that is local to the computer, such as the built-in Local Service, Network Service, or Local System accounts. You also can configure a service account to use a domain-based account located in AD DS.

To help centralize administration and to meet program requirements, many organizations choose to use a domain-based account to run program services. While this does provide some benefit over using a local account, there are a number of associated challenges, such as the following:

- Extra administration effort might be necessary to manage the service account password securely.
- It can be difficult to determine where a domain-based account is being used as a service account.
- Extra administration effort might be necessary to manage the service principal name (SPN).

Windows Server supports an AD DS object, named a managed service account, which you use to facilitate service-account management. A managed service account is an AD DS object class that enables:

- Simplified password management.
- Simplified SPN management.

### What are group managed service accounts?

Group Managed Service Accounts (gMSA) enable you to extend the capabilities of standard managed service accounts to more than one server in your domain. In server farm scenarios with Network Load Balancing (NLB) clusters or IIS servers, there often is a need to run system or program services under the same service account. Standard managed service accounts can't provide managed service account functionality to services that are running on more than one server. By gMSA, you can configure multiple servers to use the same managed service account and still retain the benefits that managed service accounts provide, like automatic password maintenance and simplified SPN management.

To support group managed service account functionality, your environment must meet the following requirement:

- You must create a KDS root key on a domain controller in the domain.

To create the KDS root key, run the following command from the Active Directory Module for Windows PowerShell on a Windows Server domain controller

```PowerShell
Add-KdsRootKey –EffectiveImmediately

```

You create group managed service accounts by using `New-ADServiceAccount` Windows PowerShell cmdlet with the `–PrinicipalsAllowedToRetrieveManagedPassword` parameter.

For example:

```PowerShell
New-ADServiceAccount -Name LondonSQLFarm -PrincipalsAllowedToRetrieveManagedPassword SEA-SQL1, SEA-SQL2, SEA-SQL3

```

### What are delegated managed service accounts?

Windows Server 2025 introduces a new type of service account called the Delegated Managed Service Account (dMSA). The dMSA account type enables users to transition from traditional service accounts to machine accounts that have managed and fully randomized keys, while also disabling the original service account passwords. Authentication for dMSA is linked to the device identity, which means that only specified machine identities mapped in AD can access the account. By using dMSA, users can prevent the common issue of credential harvesting using a compromised account that is associated with traditional service accounts.

dMSAs and gMSAs are two types of managed service accounts that are used to run services and applications in Windows Server. A dMSA is managed by an administrator and is used to run a service or application on a specific server. A gMSA is managed by AD and is used to run a service or application on multiple servers. Other differences include:

- Utilizing gMSA concepts to limit scope of usage using Credential Guard to bind machine authentication.
- Credential Guard can be used to enhance security in dMSA by automatically rotating passwords and binding all service account tickets. Legacy accounts are then disabled to further improve security.
- Although gMSAs are secured with machine generate and autorotated passwords, the passwords are still not machine bound and can be stolen.

## What are group objects?

Although it might be practical to assign permissions and rights to individual user accounts in small networks, this becomes impractical and inefficient in large enterprise networks.

For example, if several users need the same level of access to a folder, it's more efficient to create a group that contains the required user accounts, and then assign the required permissions to the group.

> [!TIP]
> As an added benefit, you can change users’ file permissions by adding or removing them from groups rather than editing the file permissions directly.

Before you implement groups in your organization, you must understand the scope of various AD DS group types. In addition, you must understand how to use group types to manage access to resources or to assign management rights and responsibilities.

:::image type="content" source="../media/m6-group-39cc1f7d.png" alt-text="A screenshot of Create Group: Sales Managers dialog box in Windows Administrative Center.":::

### Group types

In a Windows Server enterprise network, there are two types of groups, described in the following table.

:::row:::
  :::column:::
    **Group type**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Security
  :::column-end:::
  :::column:::
    Security groups are security-enabled, and you use them to assign permissions to various resources. You can use security groups in permission entries in access control lists (ACLs) to help control security for resource access. If you want to use a group to manage security, it must be a security group.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Distribution
  :::column-end:::
  :::column:::
    Email applications typically use distribution groups, which aren't security-enabled. You also can use security groups as a means of distribution for email applications.
  :::column-end:::
:::row-end:::

> [!NOTE]
> When you create a group, you choose the group type and scope. The group type determines the capabilities of the group.

### Group scopes

Windows Server supports group scoping. The scope of a group determines both the range of a group’s abilities or permissions and the group membership. There are four group scopes.

- **Local**. You use this type of group for standalone servers or workstations, on domain-member servers that aren't domain controllers, or on domain-member workstations. Local groups are available only on the computer where they exist. The important characteristics of a local group are:

  - You can assign abilities and permissions on local resources only, meaning on the local computer.
  - Members can be from anywhere in the AD DS forest.

- **Domain-local**. You use this type of group primarily to manage access to resources or to assign management rights and responsibilities. Domain-local groups exist on domain controllers in an AD DS domain, and so, the group’s scope is local to the domain in which it resides. The important characteristics of domain-local groups are:

  - You can assign abilities and permissions on domain-local resources only, which means on all computers in the local domain.
  - Members can be from anywhere in the AD DS forest.

- **Global**. You use this type of group primarily to consolidate users who have similar characteristics. For example, you might use global groups to join users who are part of a department or a geographic location. The important characteristics of global groups are:

  - You can assign abilities and permissions anywhere in the forest.
  - Members can be from the local domain only and can include users, computers, and global groups from the local domain.

- **Universal**. You use this type of group most often in multidomain networks because it combines the characteristics of both domain-local groups and global groups. Specifically, the important characteristics of universal groups are:

  - You can assign abilities and permissions anywhere in the forest similar to how you assign them for global groups.
  - Members can be from anywhere in the AD DS forest.

## What are computer objects?

Computers, like users, are security principals, in that:

- They have an account with a sign-in name and password that Windows changes automatically on a periodic basis.
- They authenticate with the domain.
- They can belong to groups and have access to resources, and you can configure them by using Group Policy.

A computer account begins its lifecycle when you create the computer object and join it to your domain. After you join the computer account to your domain, day-to-day administrative tasks include:

- Configuring computer properties.
- Moving the computer between OUs.
- Managing the computer itself.
- Renaming, resetting, disabling, enabling, and eventually deleting the computer object.

:::image type="content" source="../media/m6-computer-c09654bd.png" alt-text="A screenshot of the Create Computer: SEA-CL5 dialog box in Active Directory Administrative Center.":::

### Computers container

Before you create a computer object in AD DS, you must have a place to put it. The Computers container is a built-in container in an AD DS domain. This container is the default location for the computer accounts when a computer joins the domain.

This container isn't an OU. Instead, it's an object of the Container class. Its common name is CN=Computers. There are subtle but important differences between a container and an OU. You can't create an OU within a container, so you can't subdivide the Computers container. You also can't link a Group Policy Object to a container. Therefore, we recommend that you create custom OUs to host computer objects, instead of using the Computers container.
