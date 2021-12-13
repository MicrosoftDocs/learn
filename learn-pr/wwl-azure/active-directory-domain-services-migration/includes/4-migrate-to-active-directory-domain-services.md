Migrating to a new Active Directory Domain Services (AD DS) forest requires a high level of effort and extensive planning. A key concern during the migration process is ensuring that users retain access to resources in the source AD DS forest and the destination AD DS forest. In a large organization, the planning and migration process can take many months.

Careful planning is required before you can migrate to a new AD DS forest. Planning includes:

- Select new names. Most migration tools require the source and destination AD DS forests to have unique domain names, NetBIOS names, and user principal name (UPN) suffixes.

- Plan organizational unit (OU) structure. You can replicate the OU structure in the source AD DS forest, but this is an opportunity to restructure to better meet organizational needs if you choose to.

- Plan Group Policies. Evaluate which Group Policy settings should be applied in the new AD DS forest and how they'll be applied in the new OU structure.

- Identify objects to migrate. Depending on the scope of the project, only a subset of users, groups, computers, and servers might be migrated. For these objects, you also need to determine which attributes should be migrated or excluded.

- Identify apps that will be migrated. Apps can have many interdependent components, so you must also identify their components. Only after accurate identification can you plan how each app will be migrated.

After planning is complete, you can create the new AD DS forest by using new domain controllers running Windows Server 2019. For some apps, you'll need to perform schema extensions to prepare the new forest to host those apps. You might also need to install new instances of apps before migrating app data.

To support a phased migration that allows users to access resources in the source and destination, you must configure a forest trust. This allows users in the source forest to access resources migrated to the target forest. It also allows users migrated to the target forest to access resources in the source forest.

After a user is migrated to the target forest, the sIDHistory attribute is used to maintain access to resources in the source forest. The sIDHistory attribute on the migrated user is updated to include the security identifier (SID) of the source user. This allows the migrated user to access resources in the source forest to which the source user had been assigned access. Populating sIDHistory allows the new migrated user to impersonate the source user for security purposes.

To use sIDHistory, you must disable SID filtering on the forest trust. SID filtering removes SIDs from the local domain that weren't issued by a domain controller in the local AD DS forest.

Password synchronization is another important part of migrating. To simplify the migration process for users, you should migrate passwords along with the user accounts.

