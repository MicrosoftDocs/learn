Managing hybrid identity environments requires careful planning and implementation of lifecycle workflows, attribute mappings, and governance strategies.

## Plan lifecycle workflows for hybrid identity environments
Lifecycle workflows in hybrid identity environments govern the identity lifecycle for user accounts synchronized from Active Directory Domain Services (AD DS) to Microsoft Entra ID. These workflows ensure that user accounts are managed consistently across on-premises and cloud environments.

- **Workflow triggers:** Lifecycle workflows trigger by events such as attribute changes, group membership updates, or time-based conditions. For example, attributes like `employeeHireDate` or `employeeLeaveDateTime` must be synchronized before they can trigger workflows.
- **Workflow tasks:** Tasks include creating user accounts, assigning licenses, updating attributes, and disabling or deleting accounts. For instance, the *Disable user account* task can deactivate a user on their last day, while the *Delete User* task removes accounts after a set period. This period allows for on-premises access and resources to be deprovisioned.

> [!NOTE]
> Ensure that the Microsoft Entra provisioning agent is installed and configured correctly to enable these tasks for synchronized users.

## Design attribute mapping and scoping filters for hybrid provisioning
Accurate attribute mapping and scoping filters are critical for synchronizing user data between cloud HR apps, AD DS, and Microsoft Entra ID. These configurations ensure that only relevant user data is provisioned and updated.

- **Attribute mapping:** Map attributes like `employeeID` from the source system (for example, Workday) to target systems like AD DS or Microsoft Entra ID. Use functions like `NormalizeDiacritics` to handle special characters in usernames.
- **Scoping filters:** Define rules to include or exclude users based on attributes. For example, filter out inactive employees by using flags in the HR system.
- **Handling null values:** Ensure mandatory attributes like `firstName` or `lastName` are populated. Use expressions to concatenate values if necessary.

> [!TIP]
> Use the "Switch" function to dynamically assign users to specific organizational units (OUs) in AD DS based on attributes like location or department.

## Integration with Logic Apps and other automation tools
To link a Logic App to a Microsoft Entra Lifecycle Workflow, you need to use the extensibility feature called a “custom task extension.” Custom task allows Lifecycle Workflows to call out to external systems—like Logic Apps—during user lifecycle events (Joiner, Mover, Leaver). Here's how to do it:

### Step-by-Step: Link a Logic App to a Lifecycle Workflow
- Make the Logic App Compatible
   - Enable system-assigned managed identity:
- Configure the trigger and callback:
   - Use a manual trigger or HTTP trigger
   - Add a callback action if your workflow expects a response

| Purpose | Code |
| :---    | :--- |
| HTTP code to add to Logic App | "authentication": {"audience": "https://graph.microsoft.com",  "type": "ManagedServiceIdentity"} |
| Callback URI | https://graph.microsoft.com/beta@{triggerBody()?['data']?['callbackUriPath']} |

- Register the Logic App in Lifecycle Workflows
- Test the Integration

## Governance and compliance considerations
Governance and compliance are essential for managing hybrid identity environments. Microsoft Entra ID provides features to address these needs:

- **Auditing and reporting:** Use native provisioning logs to track user provisioning activities and ensure compliance with organizational policies.
- **Risk management:** Automate access updates based on employee status to enhance security. For example, disable accounts immediately upon termination.
- **Data privacy:** Configure the provisioning agent to clear event logs containing personal data within 48 hours to comply with privacy regulations.

> [!NOTE]
> A valid Microsoft Entra ID P1 or P2 license is required to use governance features like Lifecycle Workflows and provisioning logs.
