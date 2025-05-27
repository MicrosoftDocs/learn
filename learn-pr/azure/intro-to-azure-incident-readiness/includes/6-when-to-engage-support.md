## Major incident process

Whenever you notice an issue, the first step is to use the Azure Admin Portal to check the Service Health page to see if there's an active Service Incident for your subscriptions. This approach applies whether it's something your internal monitoring picked up or your users report.

If there's an active incident and it matches the issue you're experiencing, you shouldn't open a support case. You can obtain all the latest information from service health about the incident and next action plan. You should engage support if the issue you're experiencing isn't already represented in Service Health. You should engage support if you read the updates from engineering but require support to respond to the incident, for example, to implement your failover plans. You can open a Support Case from the Admin Portal with a reference to the Service Health ID number for that Service Incident.

If a you don't see any active incidents showing in the Service Health page **OR** the description of incidents showing don't match the issues they're experiencing, you should open a Support Case. In this event, there isn't any Service Health ID number to reference.

In either case, engineers are engaged in resolving the issue. When you open a support case, we inform your Customer Success Account Manager and Incident Manager, for Premier/Unified Support Customer, so that they can assist as needed. Keep checking the Service Health for updates throughout the life of the incident as new information including updates, changes. Solutions are all posted to the Service Health Dashboard.

### Steps in the major incident process

1. **Check Azure Service Health**

    - If there's no mention of the incident, open a new support case
    - If the incident is mentioned, compare the symptoms
    - If your symptoms don't match, open a support case
    - If the symptoms match, but engineering assistance is needed, for instance, failover activities, open a support case referencing the Service Health ID

1. **Support Case is logged**

    - Customer Service & Support (CSS) activated to troubleshoot the issue 
    - Critical Situation Management and Escalation Team (CMET), Incident Manager (IM) and Customer Success Account Manager (CSAM) are notified (applicable to only Premier/Unified support customers)

1. **Engineering Teams engaged**

    - Regular updates posted to Azure Service Health
    - Solution posted to Azure Service Health

    :::image type="content" source="../media/major-incident-process-inline.png" alt-text="Diagram shows the described incident process." lightbox="../media/major-incident-process-expanded.png":::

Ensure that all *case creators* have at least the Service Support admin role.

| Role | Description |
|---|---|
| **Global Administrator**<br><br>**Owner** (Azure RBAC)<br><br>**Contributor** (Azure RBAC) | Accesses all administrative features (per role) in the Azure portal including access to create support requests. |
| **Service Support Admin** | Create and manage Azure support tickets.<br>Read and configure Azure Service Health. |

For more information about role-based access control (RBAC), see [Azure roles, Microsoft Entra roles, and classic subscription administrator roles](/azure/role-based-access-control/rbac-and-directory-admin-roles), and [Service Health portal classic experience overview](/azure/service-health/service-health-overview).

[Service Support Administrator](/azure/active-directory/roles/permissions-reference#service-support-administrator) - This role can open support requests with Microsoft for Azure and Microsoft 365 services. It views the service dashboard and message center in the Azure portal and Microsoft 365 admin center.

To create a support request, you must be an **Owner**, **Contributor**, or be assigned to the **Service Support Admin** role at the subscription level. To create a support request without a subscription, for example, a Microsoft Entra scenario, you must be an **Admin**.

**Account Administrator**, **Service Administrator**, and **Co-Administrator** are the three classic subscription administrator roles in Azure. Classic subscription administrators have full access to the Azure subscription. They can manage resources using the Azure portal, Azure Resource Manager APIs, and the classic deployment model APIs. The account that is used to sign up for Azure is automatically set as both the **Account Administrator** and **Service Administrator**. Then, more **Co-Administrators** can be added. The **Service Administrator** and the **Co-Administrators** have the equivalent access of users who have been assigned the **Owner** role, which is an Azure RBAC role, at the subscription scope.

Azure RBAC is an authorization system built on Azure Resource Manager that provides fine-grained access management to Azure resources, such as compute and storage. Azure RBAC includes over 70 built-in roles. There are four fundamental RBAC roles. The first three apply to all resource types:

| Role | Description | Scope |
|---|---|---|
| **[Owner](/azure/role-based-access-control/built-in-roles#owner)** | Full access to all resources.<br>Delegate access to others.<br>The **Service Administrator** and **Co-Administrators** are assigned the **Owner** role at the subscription scope. | Applies to all resource types. |
| **[Contributor](/azure/role-based-access-control/built-in-roles#contributor)** | Create and manage all of types of Azure resources.<br>Can't grant access to others. | Applies to all resource types. |
| **[Reader](/azure/role-based-access-control/built-in-roles#reader)** | View Azure resources. | Applies to all resource types. |
| **[User Access Administrator](/azure/role-based-access-control/built-in-roles#user-access-administrator)** | Manage user access to Azure resources. | n/a |

The rest of the built-in roles allow management of specific Azure resources. For example, the Virtual Machine Contributor role allows the user to create and manage virtual machines. For a list of all the built-in roles, see [Built-in roles for Azure resources](/azure/role-based-access-control/built-in-roles).

Only the Azure portal and the Azure Resource Manager APIs support RBAC. Users, groups, and applications that are assigned RBAC roles can't use the Azure classic deployment model APIs.

> [!NOTE]
>
> The following two sections, **Critical Situation Communication** and **Manage Support Requests Via Services Hub**, are only applicable to customers with Unified or Premier Support agreement.

## Critical situation (Severity A support case) communications

When a Severity A support case is logged with Microsoft, we notify the customer and the *Support Engineer* provides all ongoing support case updates.

Microsoft Premier/Unified support customers also get notification at the start of a Severity A case from the *Critical Situation and Escalation Management Team* (CMET) ([Global Critical Situation Management](mailto:crit-365@microsoft.com)). The role of the Critical Situation and Escalation Management team is to provide oversight and monitoring of all Severity A cases and intervene on behalf of customer if needed. If you need assistance regarding a Severity A case, contact CMET by using your local support number and request to speak to a Critical Situation Manager.

Here are two examples of the Initial Communications and the Update Communications emails that are sent.

- Initial communications email from CMET for Severity A case.

  :::image type="content" source="../media/critsit-communication-first-contact-inline.png" alt-text="Screenshot of an initial communications email for a Severity A case." lightbox="../media/critsit-communication-first-contact-expanded.png":::

- Update communications email when Critical Situation Manager is engaged.

  :::image type="content" source="../media/critsit-communication-update-inline.png" alt-text="Screenshot of an update email for a Severity A case." lightbox="../media/critsit-communication-update-expanded.png":::
  
## Manage Support Requests via Services Hub

### Support request status in the Services Hub

Customers can view all the support cases including Azure, Microsoft 365, and Dynamics 365 along with on-premises support requests centrally at Service Hub. It provides more information at-a-glance for each Support Request including status, and specifications. This information is available without the need to go through or expand the selection for a more intuitive and simplified experience.

:::image type="content" source="../media/action-center-inline.png" alt-text="Screenshot of Azure Action Center." lightbox="../media/action-center-expanded.png":::

:::image type="content" source="../media/manage-support-requests.png" alt-text="Screenshot of Manage Support Requests by using Services Hub.":::

### Cloud Support Case Visibility dashboard

The Services Hub Case Visibility dashboard helps you provide consent for your cloud assets. Customers must provide consent individually for each Azure subscription. If consent is enabled and you have the required permissions, you can see cloud cases and their details within their respective workspaces.

In the Cloud Support Request Visibility dashboard, you can:

- Add or remove subscriptions and tenants
- Toggle case visibility on and off for individual cloud assets
- View each cloud asset's visibility status history
- Use the filters on the Cloud Support Request Visibility dashboard to refine your list and search results

For more information and step-by-step instructions, see [Cloud Support Request Visibility dashboard](/services-hub/unified/support/case-visibility).

:::image type="content" source="../media/cloud-support-case-visibility-dashboard-inline.png" alt-text="Screenshot shows the Cloud Support Request Visibility Dashboard." lightbox="../media/cloud-support-case-visibility-dashboard-expanded.png":::
