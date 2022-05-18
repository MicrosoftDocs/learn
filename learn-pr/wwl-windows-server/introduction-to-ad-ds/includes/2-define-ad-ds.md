AD DS and its related services form the foundation for enterprise networks that run Windows operating systems. The AD DS database is the central store of all the domain objects, such as user accounts, computer accounts, and groups. AD DS provides a searchable, hierarchical directory and a method for applying configuration and security settings for objects in an enterprise.

AD DS includes both logical and physical components. You should understand how AD DS components work together so that you can manage your infrastructure efficiently. In addition, you can use AD DS options to perform actions such as:

 -  Installing, configuring, and updating apps.
 -  Managing the security infrastructure.
 -  Enabling Remote Access Service and DirectAccess.
 -  Issuing and managing digital certificates.

## What are the logical components?

AD DS logical components are structures that you use to implement an AD DS design that is appropriate for an organization. The following table describes the types of logical components that an AD DS database contains.

:::row:::
  :::column:::
    **Logical component**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Partition
  :::column-end:::
  :::column:::
    A partition, or naming context, is a portion of the AD DS database. Although the database consists of one file named Ntds.dit, different partitions contain different data. For example, the schema partition contains a copy of the Active Directory schema. The configuration partition contains the configuration objects for the forest, and the domain partition contains the users, computers, groups, and other objects specific to the domain. Active Directory stores copies of partitions on multiple domain controllers and updates them through directory replication.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Schema
  :::column-end:::
  :::column:::
    A schema is the set of definitions of the object types and attributes that you use to define the objects created in AD DS.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Domain
  :::column-end:::
  :::column:::
    A domain is a logical administrative container for objects such as users and computers. A domain maps to a specific partition and you can organize the domain with parent-child relationships to other domains.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Domain tree
  :::column-end:::
  :::column:::
    A domain tree is a hierarchical collection of domains that share a common root domain and a contiguous Domain Name System (DNS) namespace.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Forest
  :::column-end:::
  :::column:::
    A forest is a collection of one or more domains that have a common AD DS root, a common schema, and a common global catalog.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    OU
  :::column-end:::
  :::column:::
    An OU is a container object for users, groups, and computers that provides a framework for delegating administrative rights and administration by linking Group Policy Objects (GPOs).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Container
  :::column-end:::
  :::column:::
    A container is an object that provides an organizational framework for use in AD DS. You can use the default containers, or you can create custom containers. You can't link GPOs to containers.
  :::column-end:::
:::row-end:::


## What are the physical components?

Physical components in AD DS are those objects that are tangible, or that described tangible components in the real world.

:::image type="content" source="../media/m6-physical-7d5ab6d9.png" alt-text="A screenshot of Active Directory Sites and Services. The administrator has selected the Sites node. Displayed are two sites, Seattle and Vancouver. Also displayed are two subnets.":::


The following table describes some of the physical components of AD DS.

:::row:::
  :::column:::
    **Physical component**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Domain controller
  :::column-end:::
  :::column:::
    A domain controller contains a copy of the AD DS database. For most operations, each domain controller can process changes and replicate the changes to all the other domain controllers in the domain.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Data store
  :::column-end:::
  :::column:::
    A copy of the data store exists on each domain controller. The AD DS database uses Microsoft Jet database technology and stores the directory information in the Ntds.dit file and associated log files. The C:\\Windows\\NTDS folder stores these files by default.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Global catalog server
  :::column-end:::
  :::column:::
    A global catalog server is a domain controller that hosts the global catalog, which is a partial, read-only copy of all the objects in a multiple-domain forest. A global catalog speeds up searches for objects that might be stored on domain controllers in a different domain in the forest.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Read-only domain controller (RODC)
  :::column-end:::
  :::column:::
    An RODC is a special, read only installation of AD DS. RODCs are common in branch offices where physical security is not optimal, IT support is less advanced than in the main corporate centers, or line-of-business applications need to run on a domain controller.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Site
  :::column-end:::
  :::column:::
    A site is a container for AD DS objects, such as computers and services that are specific to a physical location. This is in comparison to a domain, which represents the logical structure of objects, such as users and groups, in addition to computers.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Subnet
  :::column-end:::
  :::column:::
    A subnet is a portion of the network IP addresses of an organization assigned to computers in a site. A site can have more than one subnet.
  :::column-end:::
:::row-end:::
