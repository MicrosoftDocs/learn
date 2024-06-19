The security administrator for your organization provisioned Copilot. Since you're the senior analyst on the team, the administrator added you as a Copilot owner and asked you to familiarize yourself with the solution.

In this exercise, you explore all the key landmarks in the landing page of the standalone experience of Microsoft Copilot for Security.

> [!NOTE]
> The environment for this exercise is based on a simulation, generated from pre-determined screen captures of the actual product. As a limited simulation, links on a page may not be enabled. This exploration exercise does not accept any user inputs.

### Exercise

For this exercise you're logged in as Avery Howard and have the Copilot owner role. You'll work in the standalone experience of Microsoft Copilot for Security.

This exercise should take approximately **15** minutes to complete.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it is generally recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.

#### Task: Explore the menu options

In this task you start your exploration in the home menu.

1. Open the simulated environment by selecting this link: **[Microsoft Copilot for Security](https://app.highlights.guide/start/2cac767e-42c4-4058-afbb-a9413aac461d?link=0&token=40f793d4-2956-40a4-b11a-6b3d4f92557f&azure-portal=true)**.

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

1. Select **Owner settings**. These settings are available to you as a Copilot owner. A Copilot contributor does have not access to these menu options.
    1. For plugins for Copilot for Security, select the drop-down for Who can add and manage their own custom plugins to view the available options.
    1. Select drop-down for Who can add and manage custom plugins for everyone in the organization to view the available options. Note, this option is greyed out if Who can add and manage their own custom plugins is set to owners only.
    1. Select the information icon next to "Allow Copilot for Security to access data from your Microsoft 365 Services."  This setting must be enabled if you want to use the Microsoft Purview plugin. You'll work with this setting in a later exercise.
    1. Select the drop-down for who can upload files to view the available options.
    1. Select the home menu icon to open the home menu.

1. Select **Role assignment**.
    1. Select Add members, then close.
    1. Expand owner.
    1. Expand contributor.
    1. Select the home menu icon to open the home menu.

1. Select **Usage monitoring**.
    1. Select the date filter to view available options.
    1. Select the home menu icon to open the home menu.

1. Select **Settings**.
    1. Select preferences. Scroll down to view available options.
    1. Select data and privacy.
    1. Select About.
    1. Select the X to close the preferences window.

1. Select where it says **Woodgrove** at the bottom left of the home menu.
    1. When you select this option, you see your tenants. This is referred to as the tenant switcher. In this case, Woodgrove is the only available tenant.
    1. Select the **Home** to return to the landing page.

#### Task: Explore access to recent sessions

In the center of the landing page, there are cards representing your most recent sessions.

1. The largest card is your last session. Selecting the title of any session card takes you to that session.
1. Select **View all sessions** to go to the My sessions page.
1. Select **Microsoft Copilot for Security**, next to the home menu icon, to return to the landing page.

#### Task: Explore access to promptbooks

The next section of the Copilot landing page revolves around promptbooks. The landing page shows tiles for some Microsoft security promptbooks. Here you explore access to promptbooks and the promptbook library. In a subsequent exercise, you explore creating and running a promptbook.

1. To the right of where it says "Get started with these promptbooks" are a left and right arrow key that allows you to scroll through the tiles for Microsoft security promptbooks. Select the **right arrow >**

1. Each tile shows the title of the promptbook, a brief description, the number of prompts, and a run icon. Select the title of any of the promptbook tiles to open that promptbook. Select **Vulnerability impact assessment**, as an example.
    1. The window for the selected promptbook provides information, including who created the promptbook, tags, a brief description, inputs required to run the promptbook, and a listing of the prompts.
    2. You have the option to start a new session. You can also duplicate or share this promptbook (hover over the icons on the top right of the promptbook window).  
    1. Select **X** to close the window.

1. Select **View the promptbook library**.
    1. To view promptbooks that you own, select My promptbooks.
    1. Select Woodgrove for a listing of promptbooks owned by Woodgrove, the name of a fictitious organization.
    1. To view built-in, Microsoft owned/developed promptbooks, select Microsoft.
    1. Select the filter icon. Here you can filter based on tags assigned to the workbook. Close the filter window by selecting the X in the New filter tab.
    1. Select **Microsoft Copilot for Security**, next to the home menu icon, to return to the landing page.

#### Task: Explore the prompts and sources icon in the prompt bar

At the bottom center of the page is the prompt bar. The prompt bar includes the prompts and sources icon, which you explore in this task.  In subsequent exercises you'll enter inputs directly in the prompt bar.

1. From the prompt bar, you can select the prompts icon to select a built-in prompt or a promptbook. Select the **prompt icon** ![prompt icon](../media/prompt-icon.png).
    1. Select **See all promptbooks**
        1. Scroll to view all the available promptbooks.
        1. Select the **back-arrow** next to the search bar to go back.
    1. Select **See all system  capabilities**. The list shows all available system capabilities (these capabilities are in effect prompts that you can run). Many system capabilities are associated with specific plugins and as such will only be listed if the corresponding plugin is enabled.
        1. Scroll to view all the available promptbooks.
        1. Select the **back-arrow** next to the search bar to go back.

1. Select the **sources icon** ![sources icon](../media/sources-icon.png).
    1. The sources icon opens the manage sources window. From here, you can access Plugins or Files. Let's start by selecting **Plugins**.
        1. Select whether you want to view all plugins, those that are enabled (on), or those that are disabled (off).
        1. Expand/collapse list of Microsoft, non-Microsoft, and custom plugins.
        1. Some plugins require configuring parameters. Select the settings icon for the Microsoft Sentinel plugin, to view the settings window. Select **cancel** to close the settings window. In a separate exercise, you configure the plugin.
    1. You should still be in the Manage sources window. Select **Files**.
        1. Review the description.
        1. Files can be deleted by selecting the trash bin icon and the toggle switch enables and disables access to the file.
        1. Select **X** to close the manage sources window.

#### Task:  Explore the help feature

At the bottom right corner of the window is the help icon where you can easily access documentation and find solutions to common problems. From the help icon, you also submit a support case to the Microsoft support team if you have the appropriate role permissions.

1. Select the **Help (?)** icon.
    1. Select **Documentation**. This selection opens a new browser tab to the Microsoft Copilot for Security documentation. Return to the Microsoft Copilot for Security browser tab.
    1. Select **Help**.
        1. Anyone with access to Copilot for Security can access the self help widget by selecting the help icon then selecting the Help tab. Here you can find solutions to common problems by entering something about the problem.
        1. Users with a minimum role of Service Support Administrator or Helpdesk Administrator role can submit a support case to the Microsoft support team. If you have this role, a headset icon is displayed. Close the contact support page.

#### Review

In this exercise, you explored Microsoft Copilot for Security standalone experience. You explored the key landmarks of Copilot landing page including the owner settings, your past sessions, prompts and promptbooks, and the help option.