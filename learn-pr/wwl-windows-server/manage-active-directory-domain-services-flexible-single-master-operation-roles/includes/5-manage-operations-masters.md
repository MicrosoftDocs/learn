AD DS uses a multiple-master process to copy data between domain controllers, and automatically implements a conflict resolution algorithm that remediates simultaneous, conflicting updates. These provisions allow for a distributed management model, where multiple users and applications can concurrently apply changes to AD DS objects on different domain controllers. Such a model is necessary to support any AD DS environment with two or more domain controllers. However, it's particularly critical for larger, distributed environments such as Contoso's. It's important to remember though, that certain operations can be performed only by a specific role, on a specific domain controller.

## What are AD DS operations masters?

AD DS operation master roles are responsible for performing operations that are not suitable for a multiple-master model. A domain controller that has one of these roles is an operations master. An operations master role is also known as a *Flexible Single Master Operation (FSMO)* role. There are five operations master roles:

- Schema master
- Domain-naming master
- Infrastructure master
- RID master
- PDC emulator master

By default, the first domain controller installed in a forest hosts all five roles. However, you can transfer these roles after deploying additional domain controllers. When performing operations master-specific changes, you must connect to the domain controller with the role. The five operations master roles have the following distribution:

- Each forest has one schema master and one domain naming master.
- Each AD DS domain has one relative ID (RID) master, one infrastructure master, and one primary domain controller (PDC) emulator.

You can place all five on a single domain controller, or distribute them across several domain controllers.

By default, the first domain controller installed in a forest hosts all five roles. However, you can transfer these roles after deploying additional domain controllers. When performing operations master-specific changes, you must connect to the domain controller with the role. The five operations master roles have the following distribution:

### Forest operations masters

A forest has the following operations master roles:

- Domain naming master. This is the domain controller that you must contact when you add or remove a domain or make domain name changes.

> [!IMPORTANT]
> If the domain naming master is unavailable, you will not be able to add domains to the forest.

- Schema master. This is the domain controller in which you make all schema changes.

> [!IMPORTANT]
> If the schema master is unavailable, you will not be able to make changes to the schema.

> [!NOTE]
> The Windows PowerShell command ```Get-ADForest```, from the Active Directory module for Windows PowerShell, displays the forest properties, including the current domain naming master and schema master.

### Domain operations masters

A domain has the following operations master roles:

- RID master. Whenever you create a security principal such as a user, computer, or group in AD DS, the domain controller where you created the object assigns the object a unique identifying number known as a *security ID (SID)*. To ensure that no two domain controllers assign the same SID to two different objects, the RID master allocates blocks of RIDs to each domain controller within the domain to use when building SIDs.

> [!IMPORTANT]
> If the RID master is unavailable, you might experience difficulties adding security principals to the domain. Also, as domain controllers use their existing RIDs, they eventually run out of them and are unable to create new objects.

- Infrastructure master. This role maintains interdomain object references, such as when a group in one domain has a member from another domain. In this situation, the infrastructure master manages maintaining the integrity of this reference. For example, when you review an object's **Security** tab, the system references the listed SIDs and translates them into names. In a multiple-domain forest, the infrastructure master updates references to SIDs from other domains with the corresponding security principal names.

> [!IMPORTANT]
> If the infrastructure master is unavailable, domain controllers that are not global catalogs will not be able to perform translation of SIDs security principal names.

> [!IMPORTANT]
> The infrastructure master role should not reside on the domain controller that's hosting the global catalog role unless every domain controller in the forest is configured to serve as a global catalog. In this case, the infrastructure master role is not necessary because every domain controller knows about every object in the forest.

- PDC emulator master. The domain controller that is the PDC emulator master serves as the time source for the domain. The PDC emulator master in each domain in a forest synchronizes their time with the PDC emulator master in the forest root domain. You set the PDC emulator master in the forest root domain to synchronize with a reliable external time source. Additionally, by default, changes to Group Policy Objects (GPOs) are by default written to the PDC Emulator master.

    The PDC emulator master is also the domain controller that receives urgent password changes. If a user's password changes, the domain controller with the PDC emulator master role receives this information immediately. This means that if the user tries to sign in, the domain controller in the user's current location will contact the domain controller with the PDC emulator master role to check for recent changes. This will occur even if a domain controller in a different location that had not yet received the new password information authenticated the user.

> [!IMPORTANT]
> If the PDC emulator master is unavailable, users might have trouble signing in until their password changes have replicated to all the domain controllers.

> [!NOTE]
> The Windows PowerShell command ```Get-ADDomain```, from the Active Directory module for Windows PowerShell, displays the domain properties, including the current RID master, infrastructure master, and PDC emulator master.

## Manage AD DS operations masters

In an AD DS environment where you distribute operations master roles among domain controllers, you might need to move a role from one domain controller to another. When you perform a move in a planned manner between two online domain controllers, the move is known as *transferring the role*. In emergencies, if the current role holder is not available, the move is known as *seizing the role*. When you transfer a role, the latest data from the domain controller in that role replicates to the target server.

> [!IMPORTANT]
> You should seize a role only as a last resort when there is no chance for recovering the current role holder.

### Transfer operations master roles

You can transfer operations master roles by using the AD DS snap-ins that the following table lists.

|Role|Snap-in|
||--|
|Schema master|Active Directory Schema|
|Domain-naming master|Active Directory Domains and Trusts|
|Infrastructure master|Active Directory Users and Computers|
|RID master|Active Directory Users and Computers|
|PDC emulator master|Active Directory Users and Computers|

### Seize operations master roles

You cannot use AD DS snap-ins to seize operations master roles. Instead, you must use either the **ntdsutil.exe** command-line tool or Windows PowerShell to seize roles.

> [!NOTE]
> You can also use these tools to transfer roles.

The syntax for transferring a role and seizing a role is similar within Windows PowerShell, as the following syntax line demonstrates:

```powershell
Move-ADDirectoryServerOperationsMasterRole -Identity "<servername>" -OperationsMasterRole "<rolenamelist>" -Force
```

For the preceding syntax, the noteworthy definitions are as follows:

- **servername**. The name of the target domain controller to which you are transferring one or more roles.
- **rolenamelist**. A comma-separated list of AD DS role names to move to the target server.
- **-Force**. An optional parameter that you include to seize a role instead of transferring it.

## Demonstration

The following video demonstrates how to:

- Identify placement of operations master roles.
- Transfer operations master roles between domain controllers.

The main steps in the process are:

1. Create AD DS environment. Create a single domain AD DS forest containing two domain controllers.
1. Check the placement of operations master roles. Identify which of the two domain controllers hosts the operations master roles.
1. Transfer operations master roles between domain controllers by using the GUI tools. Use the GUI tools to transfer the operations masters roles from the domain controller you identified in the previous step to the other one.
1. Transfer operations master roles between domain controllers by using command-line tools. Use the command-line tools to transfer the operations masters roles back to the first domain controller.

 >[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4McId]