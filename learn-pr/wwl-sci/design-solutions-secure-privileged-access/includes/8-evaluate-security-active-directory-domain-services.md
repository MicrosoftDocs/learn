Rather than focusing on and trying to fix all of the things that are "broken," consider an approach in which you prioritize based on what's most important to your business and in your infrastructure. Instead of trying to remediate an environment filled with outdated, misconfigured systems and applications, consider creating a new small, secure environment into which you can safely port the users, systems, and information that is most critical to your business.

In this section, we describe an approach by which you can create a pristine AD DS forest that serves as a "life boat" or "secure cell" for your core business infrastructure. A pristine forest is simply a newly installed Active Directory forest that's typically limited in size and scope, and which is built by using current operating systems, applications, and with the principles described in [Reducing the Active Directory Attack Surface](/windows-server/identity/ad-ds/plan/security-best-practices/reducing-the-active-directory-attack-surface).

By implementing the recommended configuration settings in a newly built forest, you can create an AD DS installation that's built from the ground up with secure settings and practices, and you can reduce the challenges that accompany supporting legacy systems and applications. While detailed instructions for the design and implementation of a pristine AD DS installation are outside the scope of this document, you should follow some general principles and guidelines to create a "secure cell" into which you can house your most critical assets. These guidelines are as follows:

1.  Identify principles for segregating and securing critical assets.
1.  Define a limited, risk-based migration plan.
1.  Leverage "nonmigratory" migrations where necessary.
1.  Implement "creative destruction."
1.  Isolate legacy systems and applications.
1.  Simplify security for end users.

## Identifying principles for segregating and securing critical assets

The characteristics of the pristine environment that you create to house critical assets can vary widely. For example, you may choose to create a pristine forest into which you migrate only VIP users and sensitive data that only those users can access. You may create a pristine forest in which you migrate not only VIP users, but which you implement as an administrative forest, implementing the principles to reduce the attack surface to create secure administrative accounts and hosts that can be used to manage your legacy forests from the pristine forest. You might implement a "purpose-built" forest that houses VIP accounts, privileged accounts, and systems requiring additional security such as servers running Active Directory Certificate Services (AD CS) with the sole goal of segregating them from less-secure forests. Finally, you might implement a pristine forest that becomes the de facto location for all new users, systems, applications and data, allowing you to eventually decommission your legacy forest via attrition.

Regardless of whether your pristine forest contains a handful of users and systems or it forms the basis for a more aggressive migration, you should follow these principles in your planning:

1. Assume that your legacy forests have been compromised.
1. Don't configure a pristine environment to trust a legacy forest, although you can configure a legacy environment to trust a pristine forest.
1. Don't migrate user accounts or groups from a legacy forest to a pristine environment if there's a possibility that the accounts' group memberships, SID history, or other attributes may have been maliciously modified. Instead, use "nonmigratory" approaches to populate a pristine forest. (Nonmigratory approaches are described later in this section.)
1. Don't migrate computers from legacy forests to pristine forests. Implement freshly installed servers in the pristine forest, install applications on the freshly installed servers, and migrate application data to the newly installed systems. For file servers, copy data to freshly installed servers, set ACLs by using users and groups in the new forest, and then create print servers in a similar fashion.
1. Don't permit the installation of legacy operating systems or applications in the pristine forest. If an application can't be updated and freshly installed, leave it in the legacy forest and consider creative destruction to replace the application's functionality.

## Defining a limited, risk-based migration plan

Creating a limited, risk-based migration plan simply means that when deciding which users, applications, and data to migrate into your pristine forest, you should identify migration targets based on the degree of risk to which your organization is exposed if one of the users or systems is compromised. VIP users whose accounts are most likely to be targeted by attackers should be housed in the pristine forest. Applications that provide vital business functions should be installed on freshly built servers in the pristine forest, and highly sensitive data should be moved to secured servers in the pristine forest.

If you don't already have a clear picture of the most business-critical users, systems, applications, and data in your Active Directory environment, work with business units to identify them. Any application required for the business to operate should be identified, as should any servers on which critical applications run or critical data is stored. By identifying the users and resources that are required for your organization to continue to function, you create a naturally prioritized collection of assets on which to focus your efforts.

## Leveraging "nonmigratory" migrations

Whether you know that your environment has been compromised, suspect that it has been compromised, or simply prefer not to migrate legacy data and objects from a legacy Active Directory installation to a new one, consider migration approaches that don't technically "migrate" objects.

## User accounts

In a traditional Active Directory migration from one forest to another, the SIDHistory (SID history) attribute on user objects is used to store users' SID and the SIDs of groups that users were members of in the legacy forest. If users accounts are migrated to a new forest, and they access resources in the legacy forest, the SIDs in the SID history are used to create an access token that allows the users to access resources to which they had access before the accounts were migrated.

Rather than migrating users from a legacy environment (particularly one in which group memberships and SID histories may be compromised) by using SID history, consider leveraging metadirectory applications to "migrate" users, without carrying SID histories into the new forest. When user accounts are created in the new forest, you can use a metadirectory application to map the accounts to their corresponding accounts in the legacy forest.

To provide the new user accounts access to resources in the legacy forest, you can use the metadirectory tooling to identify resource groups into which the users' legacy accounts were granted access, and then add the users' new accounts to those groups. Depending on your group strategy in the legacy forest, you may need to create domain local groups for resource access or convert existing groups to domain local groups to allow the new accounts to be added to resource groups. By focusing first on the most critical applications and data and migrating them to the new environment (with or without SID history), you can limit the amount of effort expended in the legacy environment.

## Servers and workstations

In a traditional migration from one Active Directory forest to another, migrating computers is often relatively simple compared to migrating users, groups, and applications. Depending on the computer role, migrating to a new forest can be as simple as disjoining an old domain and joining a new one. However, migrating computer accounts intact into a pristine forest defeats the purpose of creating a fresh environment. Rather than migrating (potentially compromised, misconfigured, or outdated) computer accounts to a new forest, you should freshly install servers and workstations in the new environment. You can migrate data from systems in the legacy forest to systems in the pristine forest, but not the systems that house the data.

## Applications

Applications can present the most significant challenge in any migration from one forest to another, but in the case of a "nonmigratory" migration, one of the most basic principles you should apply is that applications in the pristine forest should be current, supported, and freshly installed. Data can be migrated from application instances in the old forest where possible. In situations in which an application can't be "recreated" in the pristine forest, you should consider approaches such as creative destruction or isolation of legacy applications as described in the following section.

## Implementing creative destruction

In creative destruction, rather than maintaining outdated or redundant applications, you implement entirely new applications to replace the old, migrate data into the new applications, and decommission the old applications and the systems on which they run. In some cases, you can implement creative destruction of legacy applications by deploying a new application in your own infrastructure, but wherever possible, you should consider porting the application to a cloud-based solution instead.

By deploying cloud-based applications to replace legacy in-house applications, you not only reduce maintenance efforts and costs, but you reduce your organization's attack surface by eliminating legacy systems and applications that present vulnerabilities for attackers to leverage. This approach provides a faster way for an organization to obtain desired functionality while simultaneously eliminating legacy targets in the infrastructure. Although the principle of creative destruction doesn't apply to all IT assets, it provides an often viable option to eliminating legacy systems and applications while simultaneously deploying robust, secure, cloud-based applications.

## Isolating legacy systems and applications

A natural outgrowth of migrating your business-critical users and systems to a pristine, secure environment is that your legacy forest will contain less valuable information and systems. Although the legacy systems and applications that remain in the less secure environment may present elevated risk of compromise, they also represent a reduced severity of compromise. By re-homing and modernizing your critical business assets, you can focus on deploying effective management and monitoring while not needing to accommodate legacy settings and protocols.

By removing these systems from domains where they forced implementation of legacy settings, you can subsequently increase the security of the domains by configuring them to support only current operating systems and applications. Although, it's preferable to decommission legacy systems and applications whenever possible. If decommissioning is simply not feasible for a small segment of your legacy population, segregating it into a separate domain (or forest) allows you to perform incremental improvements in the rest of the legacy installation.

## Simplifying security for end users

In most organizations, users who have access to the most sensitive information due to the nature of their roles in the organization often have the least amount of time to devote to learning complex access restrictions and controls. Although you should have a comprehensive security education program for all users in your organization, you should also focus on making security as simple to use as possible by implementing controls that are transparent and simplifying principles to which users adhere.

For example, you may define a policy in which executives and other VIPs are required to use secure workstations to access sensitive data and systems, allowing them to use their other devices to access less sensitive data. This is a simple principle for users to remember, but you can implement a number of backend controls to help to enforce the approach.