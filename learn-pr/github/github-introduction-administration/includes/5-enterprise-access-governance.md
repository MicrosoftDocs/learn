In the previous unit, you explored how repository and team permissions work in GitHub and how users are granted access at those levels. In this unit, you'll learn how to manage permissions and access at a broader scale across organizations and enterprises:

- Organization permissions  
- Enterprise permissions  
- Internal vs. external collaborators  
- Least privilege strategies  
- Security and governance best practices  

## Organization permission levels

GitHub organizations provide a centralized way for teams to collaborate on projects while maintaining controlled access to repositories and sensitive data. Organization permissions determine what members and teams can do within the organization, ensuring that each user has the appropriate level of access.

There are multiple levels of permissions at the organizational level:

| **Permission level**  | **Description**                                                                                                                 |
|:----------------------|:--------------------------------------------------------------------------------------------------------------------------------|
| Owner                 | Organization owners can do everything that organization members can do, and they can add or remove other users to and from the organization. This role should be limited to no less than two people in your organization.  |
| Member                | Organization members can create and manage organization repositories and teams.                                                 |
| Moderator       | Organization moderators can block and unblock nonmember contributors, set interaction limits, and hide comments in public repositories that the organization owns.                                                |
| Billing manager       | Organization billing managers can view and edit billing information.                                                        |
| Security managers       | Organization security managers can manage security alerts and settings across your organization. They can also read permissions for all repositories in the organization.                                        |
| Outside collaborator      | Outside collaborators, such as a consultant or temporary employee, can access one or more organization repositories. They aren't explicit members of the organization.                                                |

In addition to these levels, you can also set default permissions for all members of your organization:

:::image type="content" source="../media/org-base-permissions.png" alt-text="Screenshot of the member privileges screen with the base permissions dropdown displayed.":::

For improved management and security, you might also consider giving default read permissions to all members of your organization and adjusting their access to repositories on a case-by-case basis. If you have a relatively small organization with a low number of users, a low number of repositories, or a combination of the two, this level of restriction might be unnecessary. If you trust everyone with pushing changes to any repository, you might prefer to give all members write permissions by default.

## Enterprise permission levels

Recall from earlier that enterprise accounts are collections of organizations. By extension, each individual user account that is a member of an organization is also a member of the enterprise. You can control various settings related to authentication from this higher level.

There are three levels of permission at the enterprise level:

| **Permission level**  | **Description**                                                                                                                    |
|:----------------------|:-----------------------------------------------------------------------------------------------------------------------------------|
| Owner                 | Enterprise owners have complete control over the enterprise and can take every action, including: <br> - Managing administrators. <br> - Adding and removing organizations to and from the enterprise. <br> - Managing enterprise settings. <br> - Enforcing policies across organizations. <br> - Managing billing settings.                |
| Member                | Enterprise members have the same set of abilities as organization members. |
| Billing manager       | Enterprise billing managers can only view and edit your enterprise's billing information and add or remove other billing managers.  |
| Guest collaborator       | Can be granted access to repositories or organizations, but has limited access by default (Enterprise Managed Users only)|

In addition to these three levels, you can also set a policy of default repository permissions across all your organizations:

:::image type="content" source="../media/enterprise-base-permissions.png" alt-text="Screenshot of the policies screen with the default permissions dropdown displayed.":::

For improved management and security, you can give default read permissions to all members of your enterprise and adjust their access to repositories on a case-by-case basis. In a smaller enterprise, such as one with a single, relatively small organization, you might prefer to trust all members with write permissions by default.

To further streamline enterprise-scale access control:

- **Nested Teams:** Enterprise accounts can use nested team structures to reflect departmental hierarchies. A parent team’s permissions cascade down to child teams, simplifying complex access management.
- **Automation & Auditing:** You can use GitHub’s API or GitHub Actions to automate team creation and permission assignments, and audit access via organization or enterprise audit logs.

## Enterprise Permissions and Policies via Ruleset

This section covers how to manage enterprise permissions and policies through rulesets. We'll explore best practices for structuring organizations, setting default permissions, synchronizing teams via Active Directory (AD), automating multi-org scripting, and aligning policies with your company’s trust and control positions.

### Weighing the pros and cons of deploying a single versus multiple organizations

When structuring your enterprise, one of the key decisions is whether to use a single organization or multiple organizations. Each approach has unique benefits and trade-offs.

#### Single Organization

| Pros                        | Cons                                      |
|-----------------------------|-------------------------------------------|
| **Simplified Management:** Centralized control of permissions and policies. | **Limited Flexibility:** One-size-fits-all policies might not suit all teams. |
| **Consistency:** Uniform application of rules and streamlined collaboration. | **Security Risks:** A single breach could impact the entire organization. |
| **Resource Sharing:** Easier asset sharing across teams. | **Scalability Issues:** Managing permissions can become complex as the organization grows. |
| **Cost Efficiency:** Reduced overhead in administrative tooling and licensing. | |

#### Multiple Organizations

| Pros                        | Cons                                      |
|-----------------------------|-------------------------------------------|
| **Tailored Policies:** Customize permissions to fit the specific needs of each team. | **Increased Complexity:** More organizations mean more administrative overhead. |
| **Enhanced Isolation:** Limits the impact of a security breach to a single organization. | **Redundancy:** Potential duplication of settings and management efforts. |
| **Decentralized Administration:** Teams can manage their own policies and permissions. | **Inter-Org Collaboration:** May require extra tools or processes for cross-organization projects. |

### Setting default read versus default write across organizations

Deciding on the default permission level is critical to balancing security and collaboration within your enterprise.

#### Default Read vs Default Write

| Default Read                                    | Default Write                                    |
|-------------------------------------------------|-------------------------------------------------|
| **Enhanced Security:** Minimizes the risk of unintended modifications. | **Improved Collaboration:** Empowers users to contribute and modify content directly. |
| **Control:** Easier to audit and monitor changes. | **Efficiency:** Reduces bottlenecks in content creation and updates. |
| **Best For:** Environments where the majority of users only need to view resources. | **Risks:** Increases the chance of accidental changes or misconfigurations if not carefully managed. |

**Recommendation:**  
Use a default read permission model and grant write access selectively, ensuring adherence to the principle of least privilege.

### Team synchronization through Active Directory (AD)

Using Active Directory (AD) for team synchronization makes user management and access control easier and more efficient.

#### Why use AD sync?

- **Single source of truth:** Keeps user identities consistent across your organization.  
- **Automated access management:** Streamlines onboarding, offboarding, and role updates.  
- **Seamless role alignment:** Ensures AD groups match enterprise roles and permissions.  

#### Things to consider before implementing

- **Role mapping:** Clearly define how AD groups align with your organization's roles.  
- **Sync frequency:** Set a schedule that balances performance and security.  
- **Compliance & auditing:** Log all changes to meet compliance requirements.  

By planning ahead, you can ensure a smooth integration that keeps your organization secure and well-organized.

### Maintainability: scripting for multiple organizations and access rights

As your enterprise scales, automating the management of permissions across multiple organizations is essential for maintainability.

#### Key Practices:

Automating the management of permissions across multiple organizations is crucial for maintaining efficiency and security as your enterprise grows. This section provides key practices for scripting and automation to ensure consistent and scalable permission management. By following these practices, you can streamline administrative tasks, reduce manual errors, and maintain a secure and well-organized environment.

- **Modularity:** Develop scripts in modular components to handle different organizations with minimal changes.
- **Reusability:** Create reusable functions or modules to perform common permission tasks.
- **Testing:** Thoroughly test scripts in a controlled environment before deployment.
- **Logging:** Implement detailed logging to track changes and facilitate troubleshooting.
- **Version Control:** Use version control systems (like Git) to manage script revisions and collaborate with team members.

