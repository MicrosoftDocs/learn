Copilot workspaces are separate work environments within the tenant in which your Copilot instance is operating.

To help you better understand the concept of workspaces, we'll use the analogy of house with multiple rooms. Each room is configured to be optimized for its function and the people that will use that room. When someone enters the house, they may have access to some rooms but not others.

You can think of Copilot Workspaces fitting into this analogy. A Copilot workspace is analogous to a room in a house. You can also think of the house as analogous to a tenant. In the same way that a house has multiple rooms, the tenant in which Copilot is operating can have multiple workspaces.

Through the tenant-switching capability in Security Copilot, a user can select in which tenant they'll be working. In our analogy, this is a Copilot user getting access to the house. Once the tenant is selected, a Copilot user can access and work in any workspace (room in the house) to which they have access, within the context of their role permissions in that workspace.

:::image type="content" source="../media/workspace-overview.png" lightbox="../media/workspace-overview.png" alt-text="Illustration of city as an organization, tenant as a house, and workspace as a room in a house.":::

There are many benefits to Copilot workspaces.  

- Set up individual workspaces to address specific team needs.
- Manage and map costs based on team needs and budgets.
- Ensure critical workflows aren't disrupted by throttling.
- Store session data according to geo-specific regulations.
- Set up and manage specific plugins, promptbooks, and files for specific team needs.
- Experiment with custom plugins and promptbooks before organization-wide deployment.

### Create a workspace

You need to be at least a Security Administrator to create new workspaces for your organization. A workspace is powered by a capacity resource (SCUs). To attach capacity to a workspace, you also need to be an Azure subscription owner or contributor.

There are several entry points for you to create a new workspace:

- From the breadcrumb of the portal
- From the Manage workspaces section of the Owner settings page

# [From the breadcrumb](#tab/breadcrumb)
:::image type="content" source="../media/workspace-create.png" lightbox="../media/workspace-create.png" alt-text="A screenshot showing the new workspace option from the breadcrumb.":::

# [Owner settings page](#tab/owner-settings-page)
:::image type="content" source="../media/workspace-owner-settings.png" lightbox="../media/workspace-owner-settings.png" alt-text="A screenshot showing the new workspace option from the owner settings page.":::

---

1. From any of entry points, select **New Workspace**.
1. To Set up the workspace, specify a name for the workspace, create or select an existing capacity, select the data storage location, and define your data sharing preferences. These choices are all specific to this workspace and can be different from the selections made at the time Security Copilot was initially set up (the first run experience).
1. Confirm that you acknowledge and agree to the terms and conditions, then select Create.

# [Create a workspace](#tab/create-workspace)
:::image type="content" source="../media/workspace-create-page.png" lightbox="../media/workspace-create-page.png" alt-text="A screenshot of the page to Create a new workspace.":::

# [Create capacity](#tab/create-capacity)
:::image type="content" source="../media/create-security-capacity.png" lightbox="../media/create-security-capacity.png" alt-text="A screenshot of the page to Create a new security capacity.":::

---

### Configure workspaces

Once the workspace is created and selected, it can be configured with unique settings and permissions, allowing you to tailor the environment to meet the specific needs of your team. This includes assigning roles, managing access, and setting up plugins and promptbooks that are relevant to the workspace.

Decisions and configuration made in plugin settings and role permissions apply specifically to the workspace in which they're being configured.

Decisions and configurations within "owner settings" apply specifically to the workspace that is being configured, with one exception: Audit Logging enablement can only be changed by Security Admins and applies to all workspaces.

:::image type="content" source="../media/workspace-audit-logging.png" lightbox="../media/workspace-audit-logging.png" alt-text="Screenshot of owner settings page with logging audit data highlighted.":::

### Manage workspaces

Owners can view, navigate between, manage capacity allocations, and delete workspaces that they own from the Manage Workspaces page.

# [Manage workspaces](#tab/manage-workspaces)
:::image type="content" source="../media/workspace-manage-v2.png" lightbox="../media/workspace-manage-v2.png" alt-text="A screenshot of the manage workspaces page that lists the available workspaces.":::

# [Assign and switch capacity](#tab/capacity)
:::image type="content" source="../media/workspace-assign-capacity-v2.png" lightbox="../media/workspace-assign-capacity-v2.png" alt-text="A screenshot of the drop-down menu from which owners can view and select from availability capacity options.":::

---

### Use workspaces

From the main landing page, users can select the current workspace, which opens the drop-down menu where users can select available workspaces to which they have access and set their preferred workspace in cases where they have access to multiple workspaces. Owners will also have the option to manage workspaces, manage capacity usage, and create a new workspace.

Once in a workspace, can start using promptbooks, enter prompts directly in the prompt bar, and al the features of Copilot for which they have permissions.

# [Workspace](#tab/workspace)
:::image type="content" source="../media/landing-page-workspace-small.png" lightbox="../media/landing-page-workspace-small.png" alt-text="A screenshot highlighting the current workspace, on the Copilot landing page.":::

# [Workspace menu option](#tab/workspace-menu)
:::image type="content" source="../media/landing-page-workspace-drop-down-small.png" lightbox="../media/landing-page-workspace-drop-down-small.png" alt-text="A screenshot of the workspace drop-down menu options, available from the Copilot landing page.":::

---