By default, Global administrators and Identity governance administrators
can create and manage all aspects of Azure AD entitlement management and
easily ensure that users or guests have the appropriate access. You can
ask the users themselves or a decision maker to participate in an access
review and re-certify (or attest) to users' access. However, the users
in these roles may not know all the situations where access packages are
required. The reviewers can give their input on each user's need for
continued access based on suggestions from Azure AD. When an access
review is finished, you can make changes and remove access from users
who no longer need it.

## Azure AD entitlement management

Azure Active Directory (Azure AD) entitlement management is an identity governance feature that enables organizations to manage identity and access lifecycle at scale, by automating access request workflows, access assignments, reviews, and expiration.

Here are some of capabilities of entitlement management:

* Control who can get access to applications, groups, Teams and SharePoint sites, with multi-stage approval, and ensure users don't retain access indefinitely through time-limited assignments and recurring access reviews.
* Give users access automatically to those resources, based on the user's properties like department or cost center, and remove a user's access when those properties change (preview).
* Delegate to non-administrators the ability to create access packages. These access packages contain resources that users can request, and the delegated access package managers can define policies with rules for which users can request, who must approve their access, and when access expires.
* Select connected organizations whose users can request access. When a user who isn't yet in your directory requests access, and is approved, they're automatically invited into your directory and assigned access. When their access expires, if they have no other access package assignments, their B2B account in your directory can be automatically removed.

### Access packages

Entitlement management introduces to Azure AD the concept of an *access package*. An access package is a bundle of all the resources with the access a user needs to work on a project or perform their task. Access packages are used to govern access for your internal employees, and also users outside your organization.

Here are the types of resources you can manage user's access to, with entitlement management:

* Membership of Azure AD security groups
* Membership of Microsoft 365 Groups and Teams
* Assignment to Azure AD enterprise applications, including SaaS applications and custom-integrated applications that support federation/single sign-on and/or provisioning
* Membership of SharePoint Online sites

Access packages also include one or more policies. A policy defines the rules or guardrails for assignment to access package. Each policy can be used to ensure that only the appropriate users are able to have access assignments, and the access is time-limited and will expire if not renewed. You can have policies for users to request access. You can also have policies for users to be assigned access, either by an administrator or automatically.

:::image type="content" source="../media/entitlement-management-overview.png" alt-text="Diagram showing an example of a catalog with two access packages with multiple roles and policies." lightbox="../media/entitlement-management-overview.png":::

### When should I use access packages?

Access packages don't replace other mechanisms for access assignment. They're most appropriate in situations such as:

* Employees need time-limited access for a particular task. For example, you might use group-based licensing and a dynamic group to ensure all employees have an Exchange Online mailbox, and then use access packages for situations in which employees need more access rights. For example, rights to read departmental resources from another department.
* Access that requires the approval of an employee's manager or other designated individuals.
* Departments wish to manage their own access policies for their resources without IT involvement.
* Two or more organizations are collaborating on a project, and as a result, multiple users from one organization will need to be brought in via Azure AD B2B to access another organization's resources.

With applications centrally authenticating and driven from Azure AD, you can now streamline your access request, approval, and re-certification process to make sure that the right people have the right access and that you have a trail of why users in your organization have the access they have.

If deploying Entitlement Management isn't possible for your organization at this time, at least enable self-service paradigms in your organization by deploying [self-service group management](/azure/active-directory/users-groups-roles/groups-self-service-management) and [self-service application access](/azure/active-directory/manage-apps/manage-self-service-access).

## Azure AD access reviews

Azure Active Directory (Azure AD) access reviews enable organizations to efficiently manage group memberships, access to enterprise applications, and role assignments. User's access can be reviewed on a regular basis to make sure only the right people have continued access.

### Importance of access reviews

Azure AD enables you to collaborate with users from inside your organization and with external users. Users can join groups, invite guests, connect to cloud apps, and work remotely from their work or personal devices. The convenience of using self-service has led to a need for better access management capabilities.

- As new employees join, how do you ensure they have the access they need to be productive?
- As people move teams or leave the company, how do you make sure that their old access is removed?
- Excessive access rights can lead to compromises.
- Excessive access right may also lead audit findings as they indicate a lack of control over access.
- You have to proactively engage with resource owners to ensure they regularly review who has access to their resources.

### When to use access reviews

- **Too many users in privileged roles:** It's a good idea to check how many users have administrative access, how many of them are Global Administrators, and if there are any invited guests or partners that have not been removed after being assigned to do an administrative task. You can recertify the role assignment users in Azure AD roles such as Global Administrators, or Azure resources roles such as User Access Administrator in the Azure AD Privileged Identity Management (PIM) experience.
- **When automation is not possible:** You can create rules for dynamic membership on security groups or Microsoft 365 Groups, but what if the HR data is not in Azure AD or if users still need access after leaving the group to train their replacement? You can then create a review on that group to ensure those who still need access should have continued access.
- **When a group is used for a new purpose:** If you have a group that is going to be synced to Azure AD, or if you plan to enable the application Salesforce for everyone in the Sales team group, it would be useful to ask the group owner to review the group membership prior to the group being used in a different risk content.
- **Business critical data access:** for certain resources, such as business critical applications, it might be required as part of compliance processes to ask people to regularly reconfirm and give a justification on why they need continued access.
- **To maintain a policy's exception list:** In an ideal world, all users would follow the access policies to secure access to your organization's resources. However, sometimes there are business cases that require you to make exceptions. As the IT admin, you can manage this task, avoid oversight of policy exceptions, and provide auditors with proof that these exceptions are reviewed regularly.
- **Ask group owners to confirm they still need guests in their groups:** Employee access might be automated with some on premises Identity and Access Management (IAM), but not invited guests. If a group gives guests access to business sensitive content, then it's the group owner's responsibility to confirm the guests still have a legitimate business need for access.
- **Have reviews recur periodically:** You can set up recurring access reviews of users at set frequencies such as weekly, monthly, quarterly or annually, and the reviewers will be notified at the start of each review. Reviewers can approve or deny access with a friendly interface and with the help of smart recommendations.

### Creating access reviews

Depending on what you want to review, you will create your access review in Azure AD access reviews, Azure AD enterprise apps (in preview), Azure AD PIM, or Azure AD entitlement management.

| Access rights of users | Reviewers can be | Review created in | Reviewer experience |
| --- | --- | --- | --- |
| Security group members</br>Office group members | Specified reviewers</br>Group owners</br>Self-review | Azure AD access reviews</br>Azure AD groups | Access panel |
| Assigned to a connected app | Specified reviewers</br>Self-review | Azure AD access reviews</br>Azure AD enterprise apps (in preview) | Access panel |
| Azure AD role | Specified reviewers</br>Self-review | Azure AD PIM | Azure portal |
| Azure resource role | Specified reviewers</br>Self-review | Azure AD PIM | Azure portal |
| Access package assignments | Specified reviewers</br>Group members</br>Self-review | Azure AD entitlement management | Access panel |


### Additional information on entitlement management and access reviews

For more information on entitlement, see the following:

- [What is Azure AD entitlement management?](/azure/active-directory/governance/entitlement-management-overview)
- [What are Azure AD access reviews](/azure/active-directory/governance/access-reviews-overview)
- [Entitlement management roles](/azure/active-directory/governance/entitlement-management-delegate#entitlement-management-roles)
- [Required roles to add resources to a catalog](/azure/active-directory/governance/entitlement-management-delegate#required-roles-to-add-resources-to-a-catalog)