In this exercise, you configure the Microsoft Sentinel plugin and run some test prompts to confirm that Copilot is using the plugin.

> [!NOTE]
> The environment for this exercise is based on a simulation, generated from pre-determined screen captures of the actual product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script are not be supported.

### Exercise

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it is generally recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.
Using the exercise environment, follow the exercise steps that are listed.

[![Button to launch exercise environment.](../media/security-copilot-launch-exercise-button-v2.png)]()

#### Task: Test a Microsoft Sentinel prompt

When working with technology, it's not  uncommon to try use a feature and then realize, after some trouble-shooting, that you forgot to enable that feature. In this first task, you test a Microsoft Sentinel prompt with the Microsoft Sentinel plugin disabled. You go through this task so that you can get exposure to the information provided in the process log that helps you troubleshoot the issue.

1. From the prompt bar, enter the prompt **Summarize the Microsoft Sentinel incident 30342**. You can copy and paste the prompt into prompt bar. Then select the run icon.

1. The Copilot process log shows that it can't complete your request. Expand the items in the process log for more detailed information.

#### Task: Configure and enable the Microsoft Sentinel plugin

In this task, you'll configure the Sentinel plugin. To do this, you need to access the Azure portal to obtain the necessary information.

1. From prompt bar, select the sources icon.

1. From the manage sources page, expand the view for the Microsoft plugins and scroll down until Microsoft Sentinel is visible.

1. Select the settings icon and note the parameters that need to be configured. Select the information icon next to any of the parameters. Keep this browser tab open, you'll come back to this page for each parameter to be configured.

1. Open the browser page for the Azure portal.
    1. Select **Log Analytics workspaces**, it should be displayed as an icon under Azure services.
    1. Select the workspace associated with your Sentinel deployment. For this exercise, select **Woodgrove-LogAnalyticsWorkspace**.
    1. You should be on the overview page, if not select it now. From here you copy the information required to configure the Sentinel plugin. 
    1. Recall that the first parameter listed on the Microsoft Sentinel settings page is the Default workspace name. **Hover over the workspace name**, until the clipboard icon is displayed. Select **Copy to clipboard**.
    1. Keep this browser tab open as you'll be referring to the information on this page for each parameter to be configured.

1. Switch back to the Copilot browser tab. Place your mouse cursor in the workspace name field and right-click to paste the contents of the clipboard to the clipboard. The workspace name is added to the field.

1. Repeat the steps until you have configured the remaining two fields. Once the all the fields are populated, select **Save**.

1. Make sure toggle switch for the Sentinel plugin is enabled, then close the manage sources window.

#### Task: Retest the Microsoft Sentinel prompt

Now that the Sentinel plugin is enabled, you'll run the prompt you tried earlier. With the prompt successfully executed, you'll save the prompt to the pinboard and get a link to the session so you can share it with a colleague.

1. From the prompt bar, enter the prompt **Summarize the Microsoft Sentinel incident 30342**. You can copy and paste the prompt into the prompt bar. Then select the run icon.

1. The Copilot process log shows that the prompt executed successfully by displaying green check marks.
1. Select the box next to the prompt response, then select the pin icon.
1. Select the pin board icon ![prompt icon](../media/pinboard-icon.png) to open the pin board.
1. From the top of the page, select Export to view available options. Exporting to Word or Mail results in a summary document or email that you can immediately send to your stakeholders.

#### Review

In this exercise, you ran a prompt that requires the Microsoft Sentinel plugin to be enabled. The first time you ran the prompt, Copilot wasn't able to complete the request. The process log provided the information to help you troubleshoot the issue. You then configured and enabled the plugin. With the plugin enabled you were able successfully run the prompt.
