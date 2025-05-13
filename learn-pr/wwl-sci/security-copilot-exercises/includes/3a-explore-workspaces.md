A workspace is a scoped, tenant-bound environment where users, automations, and agents operate. All user interaction happens within the context of a workspace. It helps provide a boundary for user access and resource allocation.

As a security administrator for your organization, you have permission to create and manage workspaces in Copilot. In this exercise, you walk through tasks associated with creating and managing a workspace.

> [!NOTE]
> The environment for this exercise is a simulation generated from the product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script may not be supported. A pop-up message displays stating, "This feature is not available within the simulation." When this occurs, select OK and continue the exercise steps. 
>:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature isn't available within the simulation.":::


### Exercise

For this exercise, you're logged in as Avery Howard and have the Security administrator role, which is one of the available roles that grants permission to create and manage workspaces. In this exercise, you start by viewing the settings available in the currently selected workspace, then you create a new workspace. Lastly, you work in the newly created workspace. By comparing the settings in the initially available workspace with the settings of the newly created workspace, you see first-hand how all user interactions happen within the context of a workspace.

This exercise should take approximately **15** minutes to complete.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it's recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.

#### Task: View your interactions for the current workspace

In this task, you view some of your user interactions in the selected workspace, SecurityCopilot_Workspace. The settings and interactions that you set in this workspace serve as a point of comparison against the new workspace that you create in the subsequent task.

1. Open the simulated environment by selecting this link: **[Microsoft Security Copilot](https://app.highlights.guide/start/fa057153-57cc-486f-820b-109a96c15009?token=045faae1-1078-4eac-bf56-e12472eddaf9&azure-portal=true)**.

1. Select the **Menu** icon ![home menu icon](../media/home-menu-icon.png), which is sometimes referred to as the hamburger icon.

    1. Select **My sessions** and note the sessions listed. 
    1. Select **Usage monitoring**.
    1. Select **Owner settings**.
        1. Any changes you make to configurable items in the owner settings apply to the given workspace, except for the setting for Logging audit data in Microsoft Purview.
        1. Review the description under the setting, "Logging audit data in Microsoft Purview." The description states that this setting applies to all workspaces in your organization. If you change the setting, that change applies for all workspaces.
    1. Select **Plugin settings**, then switch the toggle button to on, to manage plugin availability and restrict access. When you do this, all plugins are listed and set to Owners only.
    1. Select **Role assignments**, and select **+Add recommended roles**. The Contributor role now reflects this option.
    1. Select Microsoft Security Copilot from the breadcrumb to return to the main landing page

1. Keep this browser tab open, you'll use it in the next task.

#### Task: Create a new workspace

In this task, you create a new workspace and assign it an available capacity. In this exercise, the capacity that is assigned to the workspace has already been created.

1. Select the **Menu** icon, select **Manage workspaces**. Note the banner shown. This banner indicates that there's a capacity that has been created and is not assigned to a workspace.
1. Select **+ New workspace**
    1. Workspace name
        1. Select the information icon. Once a pick a workspace name, you won't be able to change it.
        1. Enter a name for your workspace, **Test-workspace**.
    1. Capacity: When you create a workspace, you can assign an available capacity or create a new capacity. 
        1. First try to select a capacity that is in-use to view the experience. From the drop-down list, select **SecurtyCopilot_WorkspaceCapacity**. Note the message that appears. Select **Cancel** (in this simulation, you won't be able to disconnect and switch capacities).
        1. From the drop-down list, select **simulation-capacity**.
    1. Data storage location: Your customer data is stored in the location you select. Select your preferred location.
    1. For the two items with toggle switches, select any combination.
    1. Select the box next to the statement, I acknowledge that I have read, understood, and agree to the Terms and Conditions.
    1. Select Create.
1. Select Microsoft Security Copilot from the breadcrumb.
1. Keep this browser tab open, as you'll use it the next task.

#### Task: Select, manage, and use a workspace

In this task, you'll select and manage the workspace you created. You'll also be able to see how the settings and interactions are specific to each workspace by comparing the settings and interactions associated with this workspace with the settings from the SecurityCopilot_Workspace (the first task in this exercise).

1. Select the workspace you created. From the top of the page, select **SecurityCopilot_Workspace**.
1. From the drop-down list, select the workspace you created **Test-workspace**.
1. Select the **Menu** icon.
    1. Select **My sessions**. As expected there are no sessions listed. The sessions that were listed for the SecurityCopilot_Workspace live only in that workspace.
    1. Select **Usage monitoring**. The dashboard shows usage for this workspace only. As expected, there's no usage to show.
    1. Select **Owner settings**. The setting for Logging audit data in Microsoft Purview will be consistent for both workspaces. Other settings may be different based on what was selected in each workspace.
    1. Select **Plugin settings**. Recall that in the SecurityCopilot_Workspace, setting to manage plugin availability and restrict access was enabled. In this new workspace, that setting isn't enabled.
    1. Select **Role assignments**. The Contributor role doesn't include any members. In the first task, you explicitly added the recommended roles.
1. Select Microsoft Security Copilot from the breadcrumb.
1. Now use the workspace, by entering **Who am I**, in the prompt bar.
1. Select the **Menu** icon.
    1. Select **My sessions**. Your session is displayed. As previously mentioned, all user interaction happens within the context of a workspace.
    1. Select **Usage monitoring**. Your usage is displayed. 
1. This concludes the task and the exercise, you can close the browser tab.

#### Review

In this task you went through the process of creating, selecting, and managing a new workspace. You also saw first hand, how all user interaction happens within the context of a workspace and how a workspace helps provide a boundary for user access and resource allocation.