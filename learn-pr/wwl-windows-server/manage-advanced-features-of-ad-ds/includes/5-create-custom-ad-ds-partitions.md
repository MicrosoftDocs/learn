Custom applications might need to store their data in the AD DS database. Some of them rely on schema extensions for this purpose, however, there are also others, which require creating custom AD DS partitions. This happens to be the case with the new, Contoso's in-house developed suite of applications that you need to help deploy.

## What are AD DS partitions?

A partition, or naming context, is a portion of the AD DS database. Although the database is one file named NTDS.dit, different partitions contain different data. Each partition is a unit of replication, and each partition has its own replication topology. The default partitions include:

- Configuration partition. The configuration partition is created automatically when you create the first domain controller in a forest. The configuration partition contains information about the forest-wide AD DS structure, including which domains and sites exist and which domain controllers exist in each domain. This partition replicates to all domain controllers in the forest.
- Schema partition. The schema partition contains definitions of all the objects and attributes that you can create in the data store, and the rules for creating and manipulating them. Schema information replicates to all domain controllers in the forest.
- Domain partition. When you create a new domain, AD DS automatically creates an instance of the domain partition. That partition is subsequently automatically replicated to every new domain controller in the same domain. The domain partition contains information about all domain-specific objects, including users, groups, computers, organizational units (OUs), and domain-related system settings.
- Application partition. The application partition stores nondomain, application-related information that tends to be updated at a higher frequency or have a customizable lifetime, such as a Domain Name System (DNS) partition when Active Directory–integrated DNS is enabled. You typically have the flexibility to designate the scope of replication of application partitions, by designating which domain controllers in a forest will host its copies.

> [!NOTE]
> By default, when you configure a domain controller to host Active Directory integrated DNS zones, two separate application partitions, domainDnsZones and forestDnsZones, are created. The domainDnsZones partition contains domain-specific DNS records and its replication scope consists of other AD DS domain controllers that host the DNS Server role.

## Create AD DS partitions

You can create and manage AD DS partitions by using the NtdsUtil.exe command-line tool. NtdsUtil.exe also allows you to perform several other AD DS-related management tasks, such as:

- NTDS database maintenance, including creating snapshots, relocating database, files, and offline defragmentation.
- Cleaning up domain-controller metadata following its unrecoverable failure.
- Resetting the password used to sign in to the Directory Services Restore Mode (DSRM).

## Demonstration

The following video demonstrates how to create a custom AD DS partition. The main steps in the process are:

1. Create AD DS environment. Create a single-domain AD DS forest containing two domain controllers.
1. Create a custom AD DS partition. Use command-line tools to create a custom application partition.
1. Verify that a custom AD DS partition exists. Use command-line tools to verify existence of a custom application partition.
1. Delete a custom AD DS partition. Use command-line tools to delete a custom application partition.

 >[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4McIf]