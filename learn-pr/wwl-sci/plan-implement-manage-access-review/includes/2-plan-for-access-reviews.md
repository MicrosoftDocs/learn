Consider your organizational needs to determine the strategy for deploying access reviews in your environment.

## Engage the right stakeholders

When technology projects fail, they typically do so due to mismatched expectations on impact, outcomes, and responsibilities. To avoid these pitfalls, ensure that you're engaging the right stakeholders and that project roles are clear. For access reviews, you will likely include representatives from the following teams within your organization:

- **IT administration** manages your IT infrastructure and administers your cloud investments and Software as a Service (SaaS) apps.

- **Development teams** build and maintain applications for your organization

- **Business units** manage projects and own applications.

- **Corporate governance** ensures that the organization is following internal policy and complying with regulations.

> [!NOTE]
> For reviews requiring manual evaluations, be sure to plan for adequate reviewers and review cycles that meet your policy and compliance needs. If review cycles are too frequent, or there are too few reviewers, quality may be lost and too many or too few people may have access.

## What is Azure AD Identity Governance?

Azure Active Directory (Azure AD) Identity Governance enables you to balance your organization's need for security and employee productivity with the right processes and visibility. It provides you with capabilities to ensure that the right people have the right access to the right resources. These and related Azure AD and Enterprise Mobility + Security features allows you to mitigate access risk by protecting, monitoring, and auditing access to critical assets—while ensuring employee and business partner productivity.

Identity Governance gives organizations the ability to complete tasks across employees, business partners and vendors, and across services and applications both on-premises and in clouds. Specifically, it is intended to help organizations address these four key questions:

- Which users should have access to which resources?

- What are those users doing with that access?

- Are there effective organizational controls for managing access?

- Can auditors verify that the controls are working?

## Plan a pilot

We encourage customers to initially pilot access reviews with a small group and target non-critical resources. Piloting can help you adjust processes and communications as needed and increase users’ and reviewers’ ability to meet security and compliance requirements.

In your pilot, we recommend that you:

- Start with reviews where the results are not automatically applied, and you can control the implications.

- Ensure that all users have valid email addresses listed in Azure AD and that they receive email communication to take the appropriate action.

- Document any access removed as a part of the pilot in case you need to quickly restore it.

- Monitor audit logs to ensure all events are properly audited.

### What resource types can be reviewed?

Once you integrate your organization’s resources with Azure AD (such as users, applications, and groups), they can be managed and reviewed.

Typical targets for review include:

- User access to applications integrated with Azure AD for single sign-on (such as SaaS, line-of-business).

- Group membership (synchronized to Azure AD, or created in Azure AD or Microsoft 365, including Microsoft Teams).

- Access Package that groups resources (groups, apps, and sites) into a single package to manage access.

- Azure AD roles and Azure Resource roles as defined in Privileged Identity Management (PIM).

### Who will create and manage access reviews?

The administrative role required to create, manage, or read an Access Review depends on the type of resource being reviewed.

|     Resource type                            |     Create and manage access reviews (Creators)                       |     Read Access Review results                                  |
|----------------------------------------------|-----------------------------------------------------------------------|-----------------------------------------------------------------|
|     Group or application                     |     Global Administrator  <br>User Administrator                      |     Creators and Security Administrator                         |
|     Privileged roles in Azure AD             |     Global Administrator  <br>Privileged Role Administrator           |     Creators  <br>Security Reader <br>Security Administrator    |
|     Privileged roles in Azure (resources)    |     Global Administrator <br>User Administrator     Resource Owner    |     Creators                                                    |
|     Access package                           |     Global Administrator <br>Creator of Access Package                |     Global Administrator only                                   |

### Who will review the access to the resource?

The creator of the access review decides at the time of creation who will perform the review. This setting can't be changed once the review is started. Reviewers are represented by three personas:

- Resource Owners, who are the business owners of the resource.

- A set of individually selected delegates, as selected by the access reviews administrator.

- End users who will each self-attest to their need for continued access.

When creating an Access Review, administrators can choose one or more reviewers. All reviewers can start and carry out a review, choosing to grant users continued access to a resource or removing them.

### Components of an Access Review

Before implementing your access reviews, you should plan the types of reviews relevant to your organization. To do so, you will need to make business decisions about what you want to review and the actions to take based on those reviews.

To create an access review policy, you must have the following information.

- What resource(s) must be reviewed?

- Whose access is being reviewed?

- How often should the review occur?

- Who will perform the review?

- How will they be notified to review?

- What are the timelines to be enforced for review?

- What automatic actions should be enforced based on the review?

- What happens if the reviewer doesn't respond in time?

- What manual actions will be taken as a result based on the review?

- What communications should be sent based on actions taken?

**Example Access Review plan**

|     Component               |     Value                                                                                                                                                                                               |
|-----------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     **Resources to review** |     Access to Microsoft Dynamics                                                                                                                                                                        |
|     **Review frequency**    |     Monthly                                                                                                                                                                                             |
|     **Who performs review** |     Dynamics business group program managers                                                                                                                                                            |
|     **Notification**        |     Email 24 hours prior to review to alias Dynamics-Pms <br>Include encouraging custom message to reviewers to secure their buy-in                                                                   |
|     **Timeline**            |     48 hours from notification                                                                                                                                                                          |
|     **Automatic actions**   |     Remove access from any account that has no interactive sign-in within 90 days by removing the user from the security group dynamics-access.  <br>*Perform actions if not reviewed within timeline.* |
|     **Manual actions**      |     Reviewers may perform removals approval prior to automated action if desired.                                                                                                                     |
|     **Communications**      |     Send internal (member) users who are removed an email explaining they are removed and how to regain access.                                                                                       |

## Plan access reviews for access packages

Access packages can vastly simplify your governance and Access Review strategy. An Access Package is a bundle of all the resources with the access a user needs to work on a project or perform their task. For example, you may want to create an Access Package that includes all the applications that developers in your organization need, or all applications to which external users should have access. An administrator or delegated Access Package manager then groups the resources (groups or apps) and the roles the users need for those resources.

When creating an Access Package, you can create one or more access policies that set conditions for which users can request an Access Package, what the approval process looks like, and how often a person would have to re-request access. Access reviews are configured while creating or editing an Access Package policy.

## Plan access reviews for groups

Besides Access Packages, reviewing group membership is the most effective way of governing access. We recommend that access to resources is assigned via security groups or Microsoft 365 groups, and that users are added to those groups to gain access.

A single group can be granted access to all appropriate resources. You can assign the group access to individual resources, or to an Access Package that groups applications and other resources. With this method, you can review access to the group rather than an individual’s access to each application.

Group membership can be reviewed by:

- Administrators

- Group owners

- Selected users, delegated review capability when the review is created

- Members of the group, attesting for themselves

### Group ownership

We recommend that group owners review membership, as they're best situated to know who needs access. Ownership of groups differs with the type of group.

- Groups that are created in Microsoft 365 and Azure AD have one or more well-defined owners. In most cases, these owners make perfect reviewers for their own groups as they know who should have access. For example, Microsoft Teams uses Microsoft 365 Groups as the underlying authorization model to grant users access to resources that are in SharePoint, Exchange, OneNote, or other Microsoft 365 services. The creator of the team automatically becomes an owner and should be responsible for attesting to the membership of that group.

- Groups created manually in the Azure AD portal or via scripting through Microsoft Graph may not necessarily have owners defined. We recommend that you define them either through the Azure AD Portal in the group’s “Owners” section or via Graph.

- Groups that are synchronized from on-premises Active Directory cannot have an owner in Azure AD. When creating an Access Review for them, you should select individuals who are best suited to decide on membership in them.

> [!NOTE]
> We recommend defining business policies that define how groups are created to ensure clear group ownership and accountability for regular review of membership.

### Review membership of exclusion groups in CA policies

There are times when Conditional Access (CA) policies designed to keep your network secure shouldn't apply to all users. For example, a CA policy that only allows users to sign in while on the corporate network may not apply to the sales team, which travels extensively. In that case, the sales team members would be put into a group and that group would be excluded from the CA policy.

### Review external users' group memberships

To minimize manual work and associated potential errors, consider using Dynamic Groups to assign group membership based on a user’s attributes. You may want to create one or more Dynamic Groups for external users. The internal sponsor can act as a reviewer for membership in the group.

### Review access to on-premises groups

Access reviews can't change the group membership of groups that you synchronize from on-premises with Azure AD Connect. This is because the source of authority is on-premises. You can still use access reviews to schedule and maintain regular reviews of on-premises groups. Reviewers will then take action in the on-premises group. This strategy keeps access reviews as the tool for all reviews. You can use the results from an Access Review on on-premises groups and process them further. The data is available in a CSV file or from Microsoft Graph.

## Plan access reviews for applications

When you review access to an application, you're reviewing the access for employees and external identities to the information and data within the application. Choose to review an application when you need to know who has access to a specific application, instead of an Access Package or a group.

We recommend you plan reviews for applications in the following scenarios:

- Users are granted direct access to the application (outside of a group or Access Package).

- The application exposes critical or sensitive information.

- The application has specific compliance requirements to which you must attest.

- You suspect inappropriate access.

### Reviewers for an application

Access reviews can be for the members of a group or for users who were assigned to an application. Applications in Azure AD don't necessarily have an owner, which is why the option for selecting the application owner as a reviewer isn't possible. You can further scope a review to review only guest users assigned to the application, rather than reviewing all access.

## Plan review of Azure AD and Azure resource roles

Privileged Identity Management (PIM) simplifies how enterprises manage privileged access to resources in Azure AD. This keeps the list of privileged roles, both in Azure AD and Azure resources, much smaller and increases the overall security of the directory.

Access reviews allow reviewers to attest whether users still need to be in a role. Just like access reviews for Access Packages, reviews for Azure AD roles and Azure resource are integrated into the PIM admin user experience. We recommend you review the following role assignments regularly:

- Global Administrator

- User Administrator

- Privileged Authentication Administrator

- Conditional Access Administrator

- Security Administrator

- All Microsoft 365 and Dynamics Service Administration roles

## Deploy access reviews

After you've prepared a strategy and a plan to review access for resources integrated with Azure AD, deploy and manage reviews by using the resources below.

### Review access packages

To reduce the risk of stale access, administrators can enable periodic reviews of users who have active assignments to an access package. You can create access reviews, perform access reviews for others that are assigned to an Access Package, or perform a self-review of assigned Access Package(s).

### Review groups and apps

Employees' and guests' access needs to groups and applications likely change over time. To reduce the risk associated with stale access assignments, administrators can create access reviews for group members or application access.

You can create access reviews for group members or application access, perform access reviews for members of a group or users with access to an application, allow members to review their own access to a group or an application, view access reviews, and take action for on-premises groups with PowerShell.

### Review Azure AD roles

To reduce the risk associated with stale role assignments, you should regularly review access of privileged Azure AD roles.

### Review Azure resource roles

To reduce the risk associated with stale role assignments, you should regularly review access of privileged Azure resource roles.

## Use the access reviews API

The access reviews methods in the Microsoft Graph API are available for both application and user contexts. When running scripts in the application context, the account used to run the API (the service principle) must be granted the “AccessReview.Read.All” permission to query access reviews information.

Popular access reviews tasks to automate using the Graph API for access reviews are:

- Create and start an Access Review.

- Manually end an Access Review before its scheduled end.

- List all running Access Reviews and their status.

- See the history of a review series and the decisions and actions taken in each review.

- Collect decisions from an Access Review.

- Collect decisions from completed reviews where the reviewer took a different decision than what the system recommended.

> [!NOTE]
> When creating new Graph API queries for automation, we recommend using the Graph Explorer. You can build and explore your Graph queries before putting them into scripts and code. This can help you quickly iterate your query so that you get exactly the results you're looking for, without changing the code of your script.

## Monitor access reviews

Access reviews activities are recorded and available from the Azure AD’s audit logs. You can filter the audit data on the category, activity type, and date range. Here is a sample query:

|     Category         |     Policy                  |
|----------------------|-----------------------------|
|     Activity type    |     Create access review    |
|                      |     Update access review    |
|                      |     Access Review ended     |
|                      |     Delete access review    |
|                      |     Approve decision        |
|                      |     Deny decision           |
|                      |     Reset decision          |
|                      |     Apply decision          |
|     Date range       |     Seven days              |

For more advanced queries and analysis of access reviews, and to track changes and completion of reviews, we recommend you export your Azure AD Audit Logs to Azure Log Analytics or Azure Event Hub. When logs are stored in Azure Log Analytics, you can use the powerful analytics language and build your own dashboards.

## Plan communications

Communication is critical to the success of any new business process. Proactively communicate to users how and when their experience will change and how to gain support if they experience issues.

**Communicate changes in accountability:** Access Reviews support shifting responsibility of reviewing and acting on continued access to business owners. Decoupling access decisions from IT drives more accurate access decisions. This is a cultural change in resource owners' accountability and responsibility. Proactively communicate this change and ensure resource owners are trained and able to use the insights to make good decisions.

Clearly, IT will want to stay in control for all infrastructure-related access decisions and privileged role assignments.

**Customize email communication:** When you schedule a review, you nominate users who will perform this review. These reviewers then receive an email notification of new reviews assigned to them, as well as reminders before a review assigned to them expires.

Administrators can choose to send this notification either halfway before the review expires or a day before it expires.

The email sent to reviewers can be customized to include a custom short message that encourages them to act on the review. We recommend you use the additional text to:

- Include a personal message to reviewers, so they understand it is sent by your Compliance or IT department.

- Include a hyperlink or reference to internal information on what the expectations of the review are and additional reference or training material.

- Include a link to instructions on how to perform a self-review of access.

Upon selecting Start review, reviewers will be directed to the MyAccess portal for group and application Access Reviews. The portal gives them an overview of all users who have access to the resource they're reviewing and system recommendations based on last sign-in and access information.

