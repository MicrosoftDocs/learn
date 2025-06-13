In this exercise, you explore the Threat Intelligence Briefing Agent in Security Copilot.

> [!NOTE]
>The environment for this exercise is a simulation generated from the product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script may not be supported. A pop-up message displays stating, "This feature is not available within the simulation." When this occurs, select OK and continue the exercise steps.
>
>
>:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature isn't available within the simulation.":::

### Exercise

For this exercise, you're logged in as Avery Howard and you have an owner role in Security Copilot. You start by enabling and configuring the plugins necessary to use the Threat Intelligence Briefing agent and set up the agent parameters.  Once configured, you'll run the agent. You also walk through editing the parameters used for a manual run of the agent.

This exercise should take approximately **15** minutes to complete.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it's recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.

### Task: Set up the agent plugins

Before you start setting up the agent, let’s go to the plugins page and make sure the plugins that are used by the Threat Intelligence Briefing Agent are enabled and configured.

1. Open the simulated environment by selecting **[Microsoft Security Copilot](https://app.highlights.guide/start/081bcf08-f466-4dce-aee0-dfe5cae60c07?token=16d48b6c-eace-4a1f-8050-098d29d23a89&azure-portal=true)**.
1. From the main landing page, select the **sources icon** in the prompt bar.
1. Expand the list of Microsoft plugins, select **Show 17 more**.
    1. Make sure the **Agents** plugin is enabled.
    1. Make sure the **Microsoft Threat Intelligence** plugin is enabled.
    1. Make sure the **Microsoft Threat Intelligence Agents** plugin is enabled
    1. Now set up the optional **Microsoft Defender External Attack Surface Management** plugin. To do this, you'll need to copy the values from Microsoft Defender EASM overview page in the Azure portal.  Select the link ########### the  set up the plugin you can enable that more context to the output, let’s enable those:
        1. Resource name: wgDEASM
        1. Subscription ID: ab48f397-fc82-4634-aa52-62dd91b3ebaa
        1. Resource group name: Woodgrove-RG
1. Exit out of the Manage sources page, but keep the browser tab with Security Copilot open.  You need it for the next task.

### Task: Set up the agent

In this task, you setup the Threat Intelligence Briefing Agent.

1. Select the **Menu icon** which is sometimes referred to as the hamburger icon and select **Agents**.
1. Look for the tile that says, **Threat Intelligence Briefing Agent**, then select **View details**.
1. Review the information on the agent’s page that provides a brief description of the agent, the Trigger, Permissions, Identity, Plugins, and Role-based access, then select **Set up**.
1. The Set up agent window provides information on the permissions needed to run the agent and the identity used with the agent. To Connect your user account (recall that you are logged in as Avery Howard) to the agent, select **Next** to open a new window where you can select the user account. Select **Avery Howard**.
1. Once you've connected your account to the agent, you complete the agent set up by specifying the parameters used to customize the threat intelligence report. This information will be used each time the agent runs, unless it is changed (you explore that in a subsequent task).
    1. Insights: **3**
    1. Look back days: **14**
    1. Email: **avery.howard@woodgrove.ms**
    1. Region: **US**
    1. Industry: **Healthcare**
    1. Select **Finish**.
1. After the agent is created, you’re redirected to the activity page where you can get the agent to work on your first results, as part of the first run experience.  Here you can run it with the automatic trigger or run it without the trigger. Since the trigger is set to run every 7 days, select **Run it one time without the trigger**.
1. A window opens to review inputs before running.  Expand **Optional fields** to view the settings. As expected, these are the setting you just configured. Leave them as is and select **Submit**.  On the top-right corner of the screen the message **Agent Trigger Run started** is displayed. After a few seconds the message will disappear or you can close it by selecting the **X**.
1. The activity dashboard shows a line item for that initial run with status “In progress” and the method shows as Manual.  If you had run the agent on the trigger, the method would show as Automated.  
1. Keep this browser tab open for the next task.

#### Task: Run the agent on a manual trigger with different parameters

There will be times where you may want to manually run the agent, with different parameters but not change the setting configured during setup that are used for automatically triggered runs.

In this task you will run the threat intelligence briefing agent on a manual trigger with different parameters, view the details of the previous run, and the associated activity map.

1. You should still be on the activity page that shows a line item for the report you ran after you completed the agent setup, which still shows as In progress.  
1. This time you will manually run the agent, but you will change the parameters. The updated parameters will impact only this manual run. Future runs of the agent will use the parameters configured at start-up.
1. Select **Run** on the top right corner of the page, then from the dropdown menu, select **One time**.  In this case, you will run the agent manually, but with different parameters. Any updates to the parameters will impact only this manual run.
1. A window opens to review inputs before running. Select the down-arrow to view the Optional fields.  For this run, you will change the parameters as follows:
    1. Insights: **2**
    1. Look back days: **7**
    1. Email: **avery.howard@woodgrove.ms**
    1. Region: **Europe**
    1. Industry: **Finance**
1. Select **Submit**. The changes you enter here impact only this specific, manual run of the agent.  Any future runs are done with the parameters defined during the setup.
1. At this point, this new run will show in progress, but the previous run should show as completed. Select the line item that shows **Completed**.
1. The first section of the report is the Input. Expand the down arrow next to confirm the inputs you entered are shown.
1. The next section of the report shows the Result.
    1. Scroll down to view the report.
    1. Next to where it says results are several icons. Hover over each one to see its function.  Let's explore the feedback options:
        1. Select the **thumbs-up** icon to view the available options, then select **Cancel**.
        1. Select the **thumbs-down** icon.
            1. Select **Needs improvement** to view the options then select **Inappropriate**.  
            1. Select **Cancel** to exit the feedback window.
1. Now select View activity from the top right corner of the window to view the Activity map.  
    1. Using your mouse (hand icon displays) you can move the map around the page. You can zoom in/out by selecting the slider or **+** or the **-** on the bottom right corner of the window.
    1. Exit out of the activity map and return to the Threat Intelligence Briefing Agent, by selecting the trigger ID (the alpha-numeric string) in the breadcrumb at the top of the page.
1. You should now be back on the Threat Intelligence Briefing Agent page.  Keep the browser tab open, you will need it for the next task.

### Task:  Edit the Threat Intelligence Briefing Agent

When you ran the agent in previous task, you modified the parameters, but those parameters effect only that specific run. All subsequent runs are done using the parameters entered during the set up of the agent. In this task, you modify the parameters entered at setup that control all automatically triggered runs and any manual runs where you don't explicitly change the parameters for that run.

1. You should still be on the activity page for the Threat Intelligence Briefing Agent, which shows two lines items for the runs executed in the previous tasks. Select the ellipses on the top-right corner of the page and select **Edit**
1. On the Edit agent page, you have the option to another identity, but for this task you will not change the identity. Select **Next**.
1. Here you select the parameters to use when the agent runs on the automatic trigger or for manual runs where you don't explicitly change the parameters for that run.
1. Set the parameters as listed below and select Finish (or Select Cancel).
    1. Insights: 3
    1. Look back days: 30
    1. Email: user’s email
    1. Region: US
    1. Industry: Finance.
1. You should be back at the Threat Intelligence Briefing Agent page.

Review: In this exercise you went through the set up of the Threat Intelligence agent, including verifying the plugin settings.  You ran the agent manually with the parameters configured at startup and then again on a manual trigger, changing the parameters for that specific run.  Lastly, walked through the process of editing the agent.
