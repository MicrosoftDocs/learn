You can migrate AD objects to a different, maybe new domain in the same forest, or a new forest. Migrating to a new Active Directory Domain Services (AD DS) domain or forest requires a high level of effort and extensive planning. A key concern during the migration process is ensuring that users retain access to resources in the source AD DS domain or forest and the destination AD DS domain or forest. In a large organization, the planning and migration process can take many months.

Careful planning is required before you can migrate to a new AD DS forest. Planning includes:

- Select new names. Most migration tools require the source and destination AD DS forests to have unique domain names, NetBIOS names, and user principal name (UPN) suffixes. Moving to a new domain in an existing forest may have some of the details answered naturally, for example as UPN suffixes are managed at the forest level.
- Plan organizational unit (OU) structure. You can replicate the OU structure in the source AD DS domain, but this is an opportunity to restructure to better meet organizational needs if you choose to.
- Plan Group Policies. Evaluate which Group Policy settings should be applied in the new AD DS domain and how they are applied in the new OU structure.
- Identify objects to migrate. Depending on the scope of the project, only a subset of users, groups, computers, and servers might be migrated. For these objects, you also need to determine which attributes should be migrated or excluded.
- Identify apps that will be migrated. Apps can have many interdependent components, so you must also identify their components. Only after accurate identification can you plan how each app will be migrated.

After planning is complete, you can create the new AD DS domain by using new domain controllers running Windows Server 2025. For some apps in a new forest, you need to perform schema extensions to prepare the new forest to host those apps. You might also need to install new instances of apps before migrating app data.

To support a phased migration between forests that allows users to access resources in the source and destination, you must configure a forest trust. This allows users in the source forest to access resources migrated to the target forest. It also allows users migrated to the target forest to access resources in the source forest.

After a user or group is migrated to the target domain or forest, the sIDHistory attribute is used to maintain access to resources in the source forest. The sIDHistory attribute on the migrated user or group is updated to include the security identifier (SID) of the source user or group. This allows the migrated user to access resources in the source forest to which the source user had been assigned access. Best practice is to assign permissions to groups rather than users, so ensure the user is a member of the migrated group in the target domain. Populating sIDHistory adds the source user or group's SID to the migrated user's security token, allowing the migrated user to retain access to resources previously granted to the source user.

To use sIDHistory, you must disable SID filtering on the forest trust. SID filtering is a security feature that removes SIDs from an incoming user's authentication token that don't originate from the trusted domain. Because the sIDHistory SIDs originate from the source forest but are carried in the migrated user's token from the target forest, SID filtering would strip them and prevent access to source forest resources.

Password synchronization is another important part of migrating. To simplify the migration process for users, you should migrate passwords along with the user accounts.

> [!NOTE]
> Many organizations choose to engage a Microsoft Partner or third-party vendor to assist with complex migrations. These engagements can provide specialized expertise and tooling to help ensure a successful migration with minimal disruption to business operations.
