Lifecycle workflows in Microsoft Entra streamline identity and access management processes by automating user lifecycle tasks. Some common tasks are creating workflows using templates, configuring triggers, managing tasks, and customizing email notifications to meet organizational needs.

## Create lifecycle workflows using templates in Microsoft Entra
Lifecycle workflows allow administrators to automate tasks associated with user lifecycle change. In the Microsoft Entra admin center, workflows must be created using prebuilt templates. You can create a workflow without a template using Microsoft Graph API.

To create a workflow:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a Lifecycle Workflows Administrator.
2. Navigate to **ID Governance** > **Lifecycle workflows** > **Create a workflow**.
3. Select a template from the **Choose a workflow** page.
4. Enter a unique display name and description for the workflow on the **Basics** tab.
5. Configure the scope, including trigger type and execution conditions, on the **Configure scope** tab.
6. Add tasks to the workflow on the **Review tasks** tab.
7. Review and finalize the workflow settings on the **Review and create** tab.

:::image type="content" source="../media/templates-list.png" alt-text="Screenshot of a list of lifecycle workflow templates.":::

> [!NOTE]
> Newly created workflows are disabled by default to allow testing on smaller audiences before full deployment.

## Configure triggers and execution conditions for lifecycle workflows
Triggers and execution conditions define when and for whom a workflow runs. These settings ensure workflows are applied to the correct users at the right time.

### Trigger types
- **Scheduled triggers**: Run workflows at specific intervals.
- **Event-based triggers**: Execute workflows based on specific events, such as a user’s hire date.

### Execution conditions
Execution conditions specify the scope of users affected by the workflow. Administrators can define rules using properties, operators, and values. For example, a rule might target users in the sales department.

:::image type="content" source="../media/template-scope.png" alt-text="Screenshot of scope configuration options for a lifecycle workflow template.":::

> [!TIP]
> Use the **View rule syntax** button to review and copy multiple user property rules.

## Add and manage tasks in lifecycle workflow templates
Tasks are the actions performed by workflows. Microsoft Entra provides preconfigured tasks that can be added, enabled, disabled, or removed from templates.

### Common tasks
- **Send welcome email to new hire**: Automates sending personalized welcome emails.
- **Assign licenses to user**: Assigns licenses based on user attributes.
- **Add user to groups**: Adds users to specified security groups.

To manage tasks:
1. On the **Review tasks** tab, select **Add task** to include a new task.
2. Enable or disable tasks as needed.
3. Remove tasks that aren't required.

:::image type="content" source="../media/template-tasks.png" alt-text="Screenshot of adding tasks to templates.":::

> [!NOTE]
> Tasks can be customized with parameters such as execution sequence and error handling.

## Customize email notifications in lifecycle workflows
Email notifications in workflows can be personalized using dynamic attributes and custom templates.
- **Recipients**: Specify recipients, such as the user, their manager, or selected individuals.
- **Subject and body**: Customize the subject line and message content.
- **Dynamic attributes**: Include attributes like `userDisplayName` or `managerEmail` for personalization.

:::image type="content" source="../media/customize-email-concept.png" alt-text="Screenshot of the customization email options.":::

> [!TIP]
> Use dynamic attributes to embed user-specific details, such as hire dates or manager names, into email content.
