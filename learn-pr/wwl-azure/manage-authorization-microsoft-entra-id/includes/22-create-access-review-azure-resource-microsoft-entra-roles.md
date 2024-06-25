The need for access to privileged Azure resource and Microsoft Entra roles by employees changes over time. To reduce the risk associated with stale role assignments, you should regularly review access. You can use Microsoft Entra Privileged Identity Management (PIM) to create access reviews for privileged access to Azure resource and Microsoft Entra roles. You can also configure recurring access reviews that occur automatically.

## Prerequisites

Using Privileged Identity Management requires licenses. For more information on licensing, see [Microsoft Entra ID Governance licensing fundamentals](/entra/id-governance/licensing-fundamentals) .

For more information about licenses for PIM, see [License requirements to use Privileged Identity Management](/entra/id-governance/licensing-fundamentals).

To create access reviews for Azure resources, you must be assigned to the [Owner](/azure/role-based-access-control/built-in-roles#owner) or the [User Access Administrator](/azure/role-based-access-control/built-in-roles#user-access-administrator) role for the Azure resources. To create access reviews for Microsoft Entra roles, you must be assigned to the [Global Administrator](/entra/identity/role-based-access-control/permissions-reference#global-administrator) or the [Privileged Role Administrator](/entra/identity/role-based-access-control/permissions-reference#privileged-role-administrator) role.

Using Access Reviews for Service Principals requires a Microsoft Entra Workload ID Premium plan in addition to a Microsoft Entra ID P2 or Microsoft Entra ID Governance license.

 -  Workload Identities Premium licensing: You can view and acquire licenses on the [Workload Identities blade](https://portal.azure.com/#view/Microsoft_Azure_ManagedServiceIdentity/WorkloadIdentitiesBlade) in the Microsoft Entra admin center.

> [!NOTE]
> Access reviews capture a snapshot of access at the beginning of each review instance. Any changes made during the review process will be reflected in the subsequent review cycle. Essentially, with the commencement of each new recurrence, pertinent data regarding the users, resources under review, and their respective reviewers is retrieved.

## Types of licenses

The following licenses are available for use with Microsoft Entra ID Governance in the commercial cloud. The choice of licenses you need in a tenant depends on the features you're using in that tenant.

 -  Free - Included with Microsoft cloud subscriptions such as Microsoft Azure, Microsoft 365, and others.
 -  Microsoft Entra ID P1 - Microsoft Entra ID P1 is available as a standalone product or included with Microsoft 365 E3 for enterprise customers and Microsoft 365 Business Premium for small to medium businesses.
 -  Microsoft Entra ID P2 - Microsoft Entra ID P2 is available as a standalone product or included with Microsoft 365 E5 for enterprise customers.
 -  Microsoft Entra ID Governance - Microsoft Entra ID Governance is an advanced set of identity governance capabilities available for Microsoft Entra ID P1 and P2 customers, as two products Microsoft Entra ID Governance and Microsoft Entra ID Governance Step Up for Microsoft Entra ID P2. These products contain the basic identity governance capabilities that were in Microsoft Entra ID P2, and additional advanced identity governance capabilities.

Access Reviews for Service Principals require a Microsoft Entra Workload ID Premium plan in addition to Microsoft Entra ID P2 or Microsoft Entra ID Governance licenses.

 -  Workload Identities Premium licensing: You can view and acquire licenses on the Workload Identities blade in the Microsoft Entra admin center.

> [!NOTE]
> Some Microsoft Entra ID Governance scenarios can be configured to depend upon other features that aren't covered by Microsoft Entra ID Governance.

## Create access reviews

1.  Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as a user that is assigned to one of the prerequisite role(s).
2.  Browse to **Identity governance** &gt; **Privileged Identity Management**.<br>
3.  For Microsoft Entra roles, select **Microsoft Entra roles**. For Azure resources, select **Azure resources**.

:::image type="content" source="../media/identity-governance-9ead442a.png" alt-text="Screenshot showing the Microsoft Entra administration centers Privileged Identity Management dashboard.":::


4.  For Microsoft Entra roles, select **Microsoft Entra roles** again under **Manage**. For Azure resources, select the subscription you want to manage.<br>
5.  Under Manage, select **Access reviews**, and then select **New** to create a new access review.
6.  Name the access review. Optionally, give the review a description. The name and description are shown to the reviewers.<br>
7.  Set the **Start date**. By default, an access review occurs once, starts the same time it's created, and it ends in one month. You can change the start and end dates to have an access review start in the future and last however many days you want.<br>
8.  To make the access review recurring, change the Frequency setting from One time to Weekly, Monthly, Quarterly, Annually, or Semi-annually. Use the Duration slider or text box to define how many days each review of the recurring series will be open for input from reviewers. For example, the maximum duration that you can set for a monthly review is 27 days, to avoid overlapping reviews.<br>
9.  Use the End setting to specify how to end the recurring access review series. The series can end in three ways: it runs continuously to start reviews indefinitely, until a specific date, or after a defined number of occurrences has been completed. You, or another administrator who can manage reviews, can stop the series after creation by changing the date in Settings, so that it ends on that date.<br>
10. In the Users Scope section, select the scope of the review. For Microsoft Entra roles, the first scope option is Users and Groups. Directly assigned users and role-assignable groups will be included in this selection. For Azure resource roles, the first scope will be Users. Groups assigned to Azure resource roles are expanded to display transitive user assignments in the review with this selection. You may also select Service Principals to review the machine accounts with direct access to either the Azure resource or Microsoft Entra role.
11. Or, you can create access reviews only for inactive users (preview). In the Users scope section, set the Inactive users (on tenant level) only to true. If the toggle is set to true, the scope of the review will focus on inactive users only. Then, specify Days inactive with a number of days inactive up to 730 days (two years). Users inactive for the specified number of days will be the only users in the review.<br>
12. Under Review role membership, select the privileged Azure resource or Microsoft Entra roles to review.
13. In **assignment type**, scope the review by how the principal was assigned to the role. Choose eligible assignments only to review eligible assignments (regardless of activation status when the review is created) or active assignments only to review active assignments. Choose all active and eligible assignments to review all assignments regardless of type.<br>
14. In the **Reviewers** section, select one or more people to review all the users. Or you can select to have the members review their own access.<br>

 -  **Selected users** \- Use this option to designate a specific user to complete the review. This option is available regardless of the scope of the review, and the selected reviewers can review users, groups and service principals.
 -  **Members (self)** \- Use this option to have the users review their own role assignments. This option is only available if the review is scoped to Users and Groups or Users. For Microsoft Entra roles, role-assignable groups won't be a part of the review when this option is selected.
 -  **Manager** – Use this option to have the user’s manager review their role assignment. This option is only available if the review is scoped to Users and Groups or Users. Upon selecting Manager, you'll also have the option to specify a fallback reviewer. Fallback reviewers are asked to review a user when the user has no manager specified in the directory. For Microsoft Entra roles, role-assignable groups will be reviewed by the fallback reviewer if one is selected.

## Upon completion settings

1.  To specify what happens after a review completes, expand the **Upon completion settings** section.
2.  If you want to automatically remove access for users that were denied, set Auto apply results to resource to Enable. If you want to manually apply the results when the review completes, set the switch to Disable.<br>
3.  Use the If reviewer doesn't respond list to specify what happens for users that aren't reviewed by the reviewer within the review period. This setting doesn't impact users who were reviewed by the reviewers.

 -  No change - Leave user's access unchanged
 -  Remove access - Remove user's access
 -  Approve access - Approve user's access
 -  Take recommendations - Take the system's recommendation on denying or approving the user's continued access

4.  Use the Action to apply on denied guest users list to specify what happens for guest users that are denied. This setting isn't editable for Microsoft Entra ID and Azure resource role reviews at this time; guest users, like all users, will always lose access to the resource if denied.
5.  You can send notifications to additional users or groups to receive review completion updates. This feature allows for stakeholders other than the review creator to be updated on the progress of the review. To use this feature, select Select User(s) or Group(s) and add an additional user or group upon you want to receive the status of completion.<br>

## Advanced settings

1.  To specify additional settings, expand the Advanced settings section.
2.  Set **Show recommendations** to **Enable** to show the reviewers the system recommendations based the user's access information. Recommendations are based on a 30-day interval period where users who have logged in the past 30 days are recommended access, while users who have not are recommended denial of access. These sign-ins are irrespective of whether they were interactive. The last sign-in of the user is also displayed along with the recommendation.<br>
3.  Set **Require reason on approval** to **Enable** to require the reviewer to supply a reason for approval.<br>
4.  Set **Mail notifications** to **Enable** to have Microsoft Entra ID send email notifications to reviewers when an access review starts, and to administrators when a review completes.<br>
5.  Set **Reminders** to **Enable** to have Microsoft Entra ID send reminders of access reviews in progress to reviewers who haven't completed their review.<br>
6.  The content of the email sent to reviewers is auto-generated based on the review details, such as review name, resource name, due date, etc. If you need a way to communicate additional information such as additional instructions or contact information, you can specify these details in the Additional content for reviewer email which will be included in the invitation and reminder emails sent to assigned reviewers. The highlighted section below is where this information will be displayed.

:::image type="content" source="../media/email-information-acaa27c2.png" alt-text="Screenshot showing an access required email notification.":::
