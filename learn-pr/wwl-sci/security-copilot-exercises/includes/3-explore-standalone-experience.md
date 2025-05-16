The security administrator for your organization provisioned Copilot. Since you're the senior analyst on the team, the administrator added you as a Copilot owner and asked you to familiarize yourself with the solution.

In this exercise, you explore all the key landmarks in the landing page of the standalone experience of Security Copilot.

> [!NOTE]
> The environment for this exercise is a simulation generated from the product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script may not be supported. A pop-up message will display stating, "This feature is not available within the simulation." When this occurs, select OK and continue the exercise steps.  
>:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature is not available within the simulation.":::
>
> Also, Microsoft Security Copilot was previously referred to as Microsoft Copilot for Security. Throughout this simulation, you'll find that the user interface still reflects the original name.

### Exercise

For this exercise, you're logged in as Avery Howard and have the Copilot owner role. You work in the standalone experience of Microsoft Security Copilot.

This exercise should take approximately **15** minutes to complete.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it is generally recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.

#### Task: Explore the menu options

In this task, you start your exploration in the home menu.

1. Open the simulated environment by selecting this link: **[Microsoft Security Copilot](https://app.highlights.guide/start/2cac767e-42c4-4058-afbb-a9413aac461d?link=0&token=40f793d4-2956-40a4-b11a-6b3d4f92557f&azure-portal=true)**.

1. Select the **Menu** icon ![home menu icon](../media/home-menu-icon.png), which is sometimes referred to as the hamburger icon.

1. Select **My sessions** and note the available options.
    1. Select recent to view the most recent sessions
    1. Select filter and note the available options, then close the filer.
    1. Select the home menu icon to open the home menu.

1. Select **Promptbook library**.
    1. Select My promptbooks. A subsequent task dives deeper into promptbooks.
    1. Select Woodgrove.
    1. Select Microsoft.
    1. Select filter to view the available options, then select the X to close.
    1. Select the home menu icon to open the home menu.

1. Select **Owner settings**. These settings are available to you as a Copilot owner. A Copilot contributor doesn't have access to these menu options.
    1. For plugins for Security Copilot, select the drop-down for Who can add and manage their own custom plugins to view the available options.
    1. Select drop-down for Who can add and manage custom plugins for everyone in the organization to view the available options. Note, this option is greyed out if Who can add and manage their own custom plugins is set to owners only.
    1. Select the information icon next to "Allow Security Copilot to access data from your Microsoft 365 Services."  This setting must be enabled if you want to use the Microsoft Purview plugin. You work with this setting in a later exercise.
    1. Select the drop-down for who can upload files to view the available options.
    1. Select the home menu icon to open the home menu.

1. Select **Role assignment**.
    1. Select Add members, then close.
    1. Expand owner.
    1. Expand contributor.
    1. Select the home menu icon to open the home menu.

1. Select **Usage monitoring**.
    1. Select the date filter and view the available options.
    1. Select the home menu icon to open the home menu.

1. Select **Settings**.
    1. Select preferences. Scroll down to view available options.
    1. Select data and privacy.
    1. Select About.
    1. Select the X to close the preferences window.

1. Select where it says **Woodgrove** at the bottom left of the home menu.
    1. When you select this option, you see your tenants. This option is referred to as the tenant switcher. In this case, Woodgrove is the only available tenant.
    1. Select the **Home** to return to the landing page.

#### Task: Explore access to recent sessions

In the center of the landing page, there are cards representing your most recent sessions.

1. The largest card is your last session. Selecting the title of any session card takes you to that session.
1. Select **View all sessions** to go to the My sessions page.
1. Select **Microsoft Security Copilot**, next to the home menu icon, to return to the landing page.

#### Task: Explore access to promptbooks

The next section of the Copilot landing page revolves around promptbooks. The landing page shows tiles for some Microsoft security promptbooks. Here you explore access to promptbooks and the promptbook library. In a subsequent exercise, you explore creating and running a promptbook.

1. To the right of where it says "Get started with these promptbooks" are a left and right arrow key that allows you to scroll through the tiles for Microsoft security promptbooks. Select the **right arrow >**

1. Each tile shows the title of the promptbook, a brief description, the number of prompts, and a run icon. When you select the title of any of the promptbook tiles, it opens that particular promptbook. Select **Vulnerability impact assessment**, as an example.
    1. The window for the selected promptbook provides information, including who created the promptbook, tags, a brief description, inputs required to run the promptbook, and a listing of the prompts.
    1. Note the information about the promptbook and the available options. For this simulation, you can't start a new session. You do that in a subsequent exercise. 
    1. Select **X** to close the window.

1. Select **View the promptbook library**.
    1. To view promptbooks that you own, select My promptbooks.
    1. Select Woodgrove for a listing of promptbooks owned by Woodgrove, the name of a fictitious organization.
    1. To view built-in, Microsoft owned/developed promptbooks, select Microsoft.
    1. Select the filter icon. Here you can filter based on tags assigned to the workbook. Close the filter window by selecting the X in the New filter tab.
    1. Select **Microsoft Security Copilot**, next to the home menu icon, to return to the landing page.

#### Task: Explore the prompts and sources icon in the prompt bar

At the bottom center of the page is the prompt bar. The prompt bar includes the prompts and sources icon, which you explore in this task. In subsequent exercises, you enter inputs directly in the prompt bar.

1. From the prompt bar, you can select the prompts icon to select a built-in prompt or a promptbook. Select the **prompts icon** ![prompts icon](../media/prompt-icon.png).
    1. Select **See all promptbooks**
        1. Scroll to view all the available promptbooks.
        1. Select the **back-arrow** next to the search bar to go back.
    1. Select **See all system  capabilities**. The list shows all available system capabilities (these capabilities are in effect prompts that you can run). Many system capabilities are associated with specific plugins and as such they're only listed if the corresponding plugin is enabled.
        1. Scroll to view all the available promptbooks.
        1. Select the **back-arrow** next to the search bar to go back.

1. Select the **sources icon** ![sources icon](../media/sources-icon.png).
    1. The **Manage sources** window opens. From here, you can access Plugins or Files. The **Plugins** tab is selected by default.
        1. Select whether you want to view all plugins, the plugins that are enabled (on), or the plugins that are disabled (off).
        1. Expand/collapse list of Microsoft, non-Microsoft, and custom plugins.
        1. Some plugins require configuring parameters. Select the **Set up** button for the Microsoft Sentinel plugin, to view the settings window. Select **cancel** to close the settings window. In a separate exercise, you configure the plugin.
    1. You should still be in the **Manage sources** window. Select **Files**.
        1. Review the description.
        1. Files can be uploaded and used as a knowledge base by Copilot. In a subsequent exercise, you work with file uploads.
        1. Select **X** to close the **Manage sources** window.

#### Task:  Explore the help feature

At the bottom right corner of the window is the help icon where you can easily access documentation and find solutions to common problems. From the help icon, you also submit a support case to the Microsoft support team if you have the appropriate role permissions.

1. Select the **Help (?)** icon.
    1. Select **Documentation**. This selection opens a new browser tab to the Security Copilot documentation. Return to the Microsoft Security Copilot browser tab.
    1. Select **Help**.
        1. Anyone with access to Security Copilot can access the self help widget by selecting the help icon then selecting the Help tab. Here you can find solutions to common problems by entering something about the problem.
        1. Users with a minimum role of Service Support Administrator or Helpdesk Administrator role can submit a support case to the Microsoft support team. If you have this role, a headset icon is displayed. Close the contact support page.

#### Review

In this exercise, you explored Microsoft Security Copilot standalone experience. You explored the key landmarks of Copilot landing page including the owner settings, your past sessions, prompts and promptbooks, and the help option.