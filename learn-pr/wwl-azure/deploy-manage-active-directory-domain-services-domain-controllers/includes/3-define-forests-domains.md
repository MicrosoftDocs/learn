An Active Directory Domain Services (AD DS) forest is a collection of one or more AD DS trees that contain one or more AD DS domains. Domains in a forest share:

 -  A common root.
 -  A common schema.
 -  A global catalog.

An AD DS domain is a logical administrative container for objects such as:

 -  Users
 -  Groups
 -  Computers

The following diagram depicts the relationship between forests, domains, and domain trees.

:::image type="content" source="../media/forests-domain-trees-7b35ff29.jpg" alt-text="Illustration showing the relationship between forests, domains, and domain trees.":::


## What is an AD DS forest?

A forest is a top-level container in AD DS. Each forest is a collection of one or more domain trees that share a common directory schema and a global catalog. A domain tree is a collection of one or more domains that share a contiguous namespace. The forest root domain is the first domain that you create in the forest.

The forest root domain contains objects that don't exist in other domains in the forest. Because you always create these objects on the first domain controller, a forest can consist of as few as one domain with a single domain controller, or it can consist of several domains across multiple domain trees.

The following graphic displays Contoso.com as the forest root domain. Beneath are two domains, Adatum.com in a separate tree, and Seattle.Contoso.com as a child of Contoso.com.

:::image type="content" source="../media/forests-ee54e583.png" alt-text="Diagram that displays a hierarchy of domains as described in the preceding text.":::


The following objects exist in the forest root domain:

 -  The schema master role.
 -  The domain naming master role.
 -  The Enterprise Admins group.
 -  The Schema Admins group.

> [!NOTE]
> Although the schema and domain naming master roles are assigned initially in the root domain on the first domain controller you create, you can move them to other domain controllers anywhere in the forest.

An AD DS forest is often described as:

 -  A security boundary. By default, no users from outside the forest can access any resources inside the forest. In addition, all the domains in a forest automatically trust the other domains in the forest. This makes it easy to enable access to resources for all the users in a forest, regardless of the domain to which they belong.
 -  A replication boundary. An AD DS forest is the replication boundary for the configuration and schema partitions in the AD DS database. Therefore, organizations that want to deploy applications with incompatible schemas must deploy additional forests. The forest is also the replication boundary for the global catalog. The global catalog makes it possible to find objects from any domain in the forest.

> [!TIP]
> Typically, an organization creates only one forest.

The following objects exist in each domain (including the forest root):

 -  Relative ID (RID) master role.
 -  Infrastructure master role.
 -  Primary domain controller (PDC) emulator master role.
 -  Domain Admins group.

## What is an AD DS domain?

An AD DS domain is a logical container for managing user, computer, group, and other objects. The AD DS database stores all domain objects, and each domain controller stores a copy of the database.

The following graphic displays an AD DS domain. It contains users, computers, and groups.

:::image type="content" source="../media/domain-9e029d0c.png" alt-text="Diagram that displays an AD DS domain containing users, computers, and groups.":::


The most commonly used objects are described in the following table:

| **Object**        | **Description**                                                                                                                                                        |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| User accounts     | User accounts contain information about users, including the information required to authenticate a user during the sign-in process and build the user's access token. |
| Computer accounts | Each domain-joined computer has an account in AD DS. You can use computer accounts for domain-joined computers in the same way that you use user accounts for users.   |
| Groups            | Groups organize users or computers to simplify the management of permissions and Group Policy Objects in the domain.                                                   |

An AD DS domain is often described as:

 -  A replication boundary. When you make changes to any object in the domain, the domain controller where the change occurred replicates that change to all other domain controllers in the domain. If multiple domains exist in the forest, only subsets of the changes replicate to other domains. AD DS uses a multiple-master replication model that allows every domain controller to make changes to objects in the domain.
 -  An administrative unit. The AD DS domain contains an Administrator account and a Domain Admins group. By default, the Administrator account is a member of the Domain Admins group, and the Domain Admins group is a member of every local Administrators group of domain-joined computers. Also, by default, the Domain Admins group members have full control over every object in the domain.

> [!NOTE]
> The Administrator account in the forest root domain has additional rights.

An AD DS domain provides:

 -  Authentication. Whenever a domain-joined computer starts or a user signs in to a domain-joined computer, AD DS authenticates it. Authentication verifies that computer or user has the proper identity in AD DS by verifying its credentials.
 -  Authorization. Windows uses authorization and access control technologies to determine whether to allow authenticated users to access resources.

> [!TIP]
> Organizations with decentralized administrative structures or multiple locations might consider implementing multiple domains in the same forest to accommodate their administrative needs.

## What are trust relationships?

AD DS trusts enable access to resources in a complex AD DS environment. When you deploy a single domain, you can easily grant access to resources within the domain to users and groups from the domain. When you implement multiple domains or forests, you should ensure that the appropriate trusts are in place to enable the same access to resources.

In a multiple-domain AD DS forest, two-way transitive trust relationships generate automatically between AD DS domains so that a path of trust exists between all the AD DS domains.

> [!NOTE]
> The trusts that create automatically in the forest are all transitive trusts, which means that if domain A trusts domain B, and domain B trusts domain C, then domain A trusts domain C.

You can deploy other types of trusts. The following table describes the main trust types.

| **Trust type**                 | **Description**             | **Direction**      | **Description**                                                                                                                                                                                                                           |
| ------------------------------ | --------------------------- | ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Parent and child               | Transitive                  | Two-way            | When you add a new AD DS domain to an existing AD DS tree, you create new parent and child trusts.                                                                                                                                        |
| Tree-root                      | Transitive                  | Two-way            | When you create a new AD DS tree in an existing AD DS forest, you automatically create a new tree-root trust.                                                                                                                             |
| External                       | Nontransitive               | One-way or two-way | External trusts enable resource access with a Windows NT 4.0 domain or an AD DS domain in another forest. You also can set these up to provide a framework for a migration.                                                               |
| Realm                          | Transitive or nontransitive | One-way or two-way | Realm trusts establish an authentication path between a Windows Server AD DS domain and a Kerberos version 5 (v5) protocol realm that implements by using a directory service other than AD DS.                                           |
| Forest (complete or selective) | Transitive                  | One-way or two-way | Trusts between AD DS forests allow two forests to share resources.                                                                                                                                                                        |
| Shortcut                       | Nontransitive               | One-way or two-way | Configure shortcut trusts to reduce the time taken to authenticate between AD DS domains that are in different parts of an AD DS forest. No shortcut trusts exist by default, and an administrator must create them if they are required. |
