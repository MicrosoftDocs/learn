Microsoft Entra ID Governance provides tools to automate and streamline these use lifecycle management, ensuring security and productivity. Let's explore the Joiner, Mover, and Leaver (JML) scenarios, maps them to built-in Lifecycle Workflow templates, and examines their real-world applications.

## Definition and example of Joiner, Mover, and Leaver scenarios

Joiner, Mover, and Leaver scenarios represent key stages in the identity lifecycle of users within an organization:

- **Joiner**: Refers to onboarding new employees or external collaborators. For example, when a new hire joins, their identity is created, and they're granted access to necessary resources.
- **Mover**: Covers changes in roles or responsibilities. For instance, when an employee is promoted, their access rights need to be updated to reflect their new position.
- **Leaver**: Involves offboarding users who leave the organization. Includes revoking access and removing accounts to maintain security.

These scenarios ensure that users have appropriate access throughout their lifecycle while minimizing risks associated with over-provisioning or outdated permissions.

:::image type="content" source="../media/identity-lifecycle.png" alt-text="Diagram illustrating the identity lifecycle, including Joiner, Mover, and Leaver stages.":::

> [!NOTE]
> Automating these scenarios helps organizations balance security and productivity effectively.

## Map the scenarios to the built-in Lifecycle Workflow templates

Microsoft Entra ID Governance offers built-in Lifecycle Workflow templates tailored to JML scenarios. These templates simplify the automation of common tasks:

- **Joiner Templates**:
  - *Onboard pre-hire employee*: Configures tasks before an employee's start date, such as generating a temporary access pass.
  - *Onboard new hire employee*: Automates tasks on the start date, like enabling user accounts and sending welcome emails.
  - *Post-Onboarding of an employee*: Handles tasks after the start date, such as adding users to specific teams.

- **Mover Templates**:
  - *Real-time employee change*: Executes tasks immediately when an employee changes roles, such as running custom task extensions.
  - *Employee group membership changes*: Updates group memberships based on attribute or role changes.
  - *Employee job profile change*: Adjusts access and notifies managers when job titles change.

- **Leaver Templates**:
  - *Pre-Offboarding of an employee*: Prepares for offboarding by removing users from selected groups and teams.
  - *Offboard an employee*: Executes tasks on the last working day, such as disabling accounts and removing group memberships.
  - *Post-Offboarding of an employee*: Finalizes offboarding by deleting accounts and removing licenses.

## Explore the real-world application and common decision points for each scenario

### Real-world application

Organizations use JML scenarios to:

- Ensure new hires are productive from day one by automating account creation and resource access.
- Maintain compliance by updating access rights promptly when roles change.
- Protect sensitive data by revoking access immediately when users leave.

### Common decision points

When implementing JML scenarios, administrators often face the following decisions:

- **Joiner**: What resources should a new hire access immediately? Should access be granted before the official start date?
- **Mover**: How should access policies adapt to role changes? Are there separation-of-duties requirements?
- **Leaver**: When should access be revoked—on the last working day or after a grace period? Should data retention policies apply?

By using Microsoft Entra ID Governance's automation capabilities, administrators can address these decision points efficiently, reducing manual effort, and enhancing security.
