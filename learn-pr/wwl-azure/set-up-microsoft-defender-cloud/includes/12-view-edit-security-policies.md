Defender for Cloud uses **Azure role-based access control (Azure RBAC)**, which provides built-in roles you can assign to **Azure users**, **groups**, and **services**. When users open Defender for Cloud, they see only information related to the resources they can access. Users are assigned the owner, contributor, or reader role to the resource's subscription.

There are two specific roles for Defender for Cloud:

 -  **Security Administrator**: Has the same view rights as security reader. Can also update the security policy and dismiss alerts.
 -  **Security reader**: Has rights to view Defender for Cloud items such as recommendations, alerts, policy, and health. Can't make changes.

:::image type="content" source="../media/security-roles-viewing-editing-security-policies-ced23899.png" alt-text="Diagram showing which security role can view, update, and dismiss alerts.":::


You can edit security policies through the **Azure Policy portal** via **Representational State Transfer Application Programming Interface (REST API)** or using **Windows PowerShell**.

The Security Policy screen reflects the action taken by the policies assigned to the subscription or management group you selected.

 -  Use the links at the top to open a policy assignment that applies to the subscription or management group. These links let you access the assignment and edit or disable the policy. **For example**, if you see that a particular policy assignment is effectively denying endpoint protection, use the link to edit or disable the policy.
 -  In the list of policies, you can see the effective application of the policy on your subscription or management group. The settings of each policy that apply to the scope are taken into consideration, and the cumulative outcome of actions taken by the policy is shown. **For example**, if one assignment of the policy is disabled, but in another, it's set to **AuditIfNotExist**, then the cumulative effect applies **AuditIfNotExist**. The more active effect always takes precedence.
 -  The policies' effect can be: **Append**, **Audit**, **AuditIfNotExists**, **Deny**, **DeployIfNotExists**, or **Disabled**.
