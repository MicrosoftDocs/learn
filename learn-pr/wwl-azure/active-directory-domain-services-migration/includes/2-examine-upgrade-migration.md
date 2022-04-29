The first question that many organizations confront when it comes to transitioning to domain controllers running the newest version of the Windows Server operating system is “should we upgrade our existing forest or should we migrate to a new forest?”.

Rather than perform an in-place upgrade of existing domain controllers, most organizations add domain controllers running the latest version of Windows Server to their existing AD DS forest, transfer Flexible Single Master Operations roles, and then retire existing domain controllers running earlier versions of the Windows Server operating system. When you upgrade an AD DS forest in this manner, there's no downtime for users or resources, and the same AD DS structure is maintained.

Migrating to a new AD DS forest is more complex than upgrading an existing AD DS forest. When you perform an AD DS migration, you create a new AD DS forest with new domain controllers running the latest version of Windows Server. The migration process involves moving users, groups, computers, servers, and applications to the new AD DS forest. During the migration, you need to plan for coexistence and ensure that users maintain access to resources in the source and destination environment.

Migration to a new AD DS forest is typically driven by a need to restructure AD DS rather than a need to use domain controllers running Windows Server 2022 or a need to shift to a higher AD DS functional level if it is not already at the Windows Server 2016 level. Migration is often used to merge multiple domains into a single domain for simplified management.

Common reasons to migrate to a new AD DS forest include:

- An acquisition or merger. Your organization is being acquired and you need to move users and computers to a new or existing forest.

- Divesture of a company or business unit. Your organization is splitting and you need to move users and computers to a separate forest.

- Need to rename the AD forest or domain. Your organization has changed its name and wants the new name reflected in the AD DS forest.

- Active Directory Domain Services compromised by a security event. Attackers have compromised Active Directory to such an extent that a fresh deployment is the only way to ensure they have not maintained persistence.

- Aging Active Directory Domain Services forest that requires rationalization due to buildup of legacy configuration alterations. Some AD DS instances have been used for more than two decades and modifications to the schema and security delegations have been imperfectly documented or forgotten. A new implementation allows an organization to start over from a fresh beginning.

> [!NOTE]
> You can rename a domain by using Rendom.exe without performing an AD DS migration, but this is a risky operation, and many organizations prefer to perform a migration instead. There are also some apps that fail after a domain rename. For example, if you have an existing Exchange Server deployment in the AD DS forest, you can't rename the domain.

