Azure Active Directory (Azure AD) access reviews enable organizations to efficiently manage group memberships, access to enterprise applications, and role assignments. User's access can be reviewed on a regular basis to make sure only the right people have continued access.

## Why are access reviews important?

Azure AD enables you to collaborate internally within your organization and with users from external organizations, such as partners. Users can join groups, invite guests, connect to cloud apps, and work remotely from their work or personal devices. The convenience of leveraging the power of self-service has led to a need for better access management capabilities.

 -  As new employees join, how do you ensure they have the right access to be productive?
 -  As people move teams or leave the company, how do you ensure their old access is removed, especially when it involves guests?
 -  Excessive access rights can lead to audit findings and compromises as they indicate a lack of control over access.
 -  You must proactively engage with resource owners to ensure they regularly review who has access to their resources.

## Use access reviews in the following cases

 -  **Too many users in privileged roles**: It's a good idea to check how many users have administrative access, how many of them are Global Administrators, and if there are any invited guests or partners that have not been removed after being assigned to do an administrative task. You can recertify the role assignment users in Azure AD roles such as Global Administrators, or Azure resources roles such as User Access Administrator in the Azure AD Privileged Identity Management (PIM) experience.
 -  **When automation is infeasible**: You can create rules for dynamic membership on security groups or Microsoft 365 Groups, but what if the HR data is not in Azure AD or if users still need access after leaving the group to train their replacement? You can then create a review on that group to ensure those who still need access should have continued access.
 -  **When a group is used for a new purpose**: If you have a group that is going to be synced to Azure AD, or if you plan to enable a sales management application for everyone in the Sales team group, it would be useful to ask the group owner to review the group membership prior to the group being used in a different risk content.
 -  **Business critical data access**: for certain resources, it might be required to ask people outside of IT to regularly sign out and give a justification on why they need access for auditing purposes.
 -  **To maintain a policy's exception list**: In an ideal world, all users would follow the access policies to secure access to your organization's resources. However, sometimes there are business cases that require you to make exceptions. As the IT admin, you can manage this task, avoid oversight of policy exceptions, and provide auditors with proof that these exceptions are reviewed regularly.
 -  **Ask group owners to confirm they still need guests in their groups**: Employee access might be automated with some on premises IAM, but not invited guests. If a group gives guests access to business sensitive content, then it's the group owner's responsibility to confirm the guests still have a legitimate business need for access.
 -  **Have reviews recur periodically**: You can set up recurring access reviews of users at set frequencies such as weekly, monthly, quarterly or annually, and the reviewers will be notified at the start of each review. Reviewers can approve or deny access with a friendly interface and with the help of smart recommendations.

Depending on what you want to review, you will create your access review in Azure AD access reviews, Azure AD enterprise apps (**in preview**), or Azure AD PIM. Using this feature requires an Azure AD Premium P2 license.

> [!IMPORTANT]
> Azure AD Premium P2 licenses are **not required** for users with the Global Administrator or User Administrator roles that set up access reviews, configure settings, or apply the decisions from the reviews.
