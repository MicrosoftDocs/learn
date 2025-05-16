In this exercise, you configure the Microsoft Sentinel plugin and run some test prompts to confirm that Copilot is using the plugin.

> [!NOTE]
> The environment for this exercise is a simulation generated from the product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script may not be supported. A pop-up message displays stating, "This feature is not available within the simulation." When this occurs, select OK and continue the exercise steps.  
>
>
>:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature isn't available within the simulation.":::


### Exercise

For this exercise, you're logged in as Avery Howard and have the Copilot owner role. You work in both the Azure portal and the standalone experience of Microsoft Security Copilot.

This exercise should take approximately **15** minutes to complete.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it's recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.

#### Task: Test a Microsoft Sentinel prompt

When working with technology, it's not  uncommon to try use a feature and then realize, after some trouble-shooting, that you forgot to enable that feature. In this first task, you test a Microsoft Sentinel prompt with the Microsoft Sentinel plugin disabled. You go through this task so that you can get exposure to the information provided in the process log that helps you troubleshoot the issue.

1. Open the simulated environment by selecting this link: **[Microsoft Security Copilot](https://app.highlights.guide/start/f7107adc-8d47-43ae-a7f7-f9e9a35881c4?token=045faae1-1078-4eac-bf56-e12472eddaf9&azure-portal=true)**.

1. From the prompt bar, enter the prompt **Summarize the Microsoft Sentinel incident 30342**. You can copy and paste the prompt into prompt bar. Then select the run icon.

1. The Copilot process log shows that it can't complete your request. Expand the items in the process log for more detailed information.

#### Task: Configure and enable the Microsoft Sentinel plugin

In this task, you configure the Microsoft Sentinel plugin. To do this, you need to access the Azure portal to obtain the necessary information.

1. From prompt bar, select the **sources icon** ![sources icon](../media/sources-icon.png).

1. From the manage sources page, expand the view for the Microsoft plugins by selecting **Show 11 more** and scroll down until Microsoft Sentinel is visible.

1. Select the **Set up** button and note the parameters that need to be configured. Select the information icon next to any of the parameters. Keep this browser tab open, you'll come back to this page for each parameter to be configured.

1. Use your right mouse key to open the link to the Azure portal in a new tab or window: **[Azure portal](https://app.highlights.guide/start/f7107adc-8d47-43ae-a7f7-f9e9a35881c4?token=045faae1-1078-4eac-bf56-e12472eddaf9&link=1&azure-portal=true)**. It's important that access to the Azure portal and access to Security Copilot be available as separate browser tabs, as you'll be accessing both tabs for this task.
    1. Select **Log Analytics workspaces**, it should be displayed as an icon under Azure services.
    1. Select the workspace associated with your Microsoft Sentinel deployment. For this exercise, select **Woodgrove-LogAnalyticsWorkspace**.
    1. You should be on the overview page, if not select it now. From here, you copy the information required to configure the Microsoft Sentinel plugin. 
    1. Recall that the first parameter listed on the Microsoft Sentinel settings page is the Default workspace name. **Hover over the workspace name**, until the clipboard icon is displayed. Select **Copy to clipboard**.
    1. Keep this browser tab open as you'll be referring to the information on this page for each parameter to be configured.

1. Switch back to the Copilot browser tab. Place your mouse cursor in the workspace name field and right-click to paste the contents of the clipboard to the clipboard. The workspace name is added to the field.

1. Repeat the steps until you have configured the remaining two fields. Once the all the fields are populated, select **Save**.

1. Make sure toggle switch for the Microsoft Sentinel plugin is enabled, then close the manage sources window by selecting the **X**.

#### Task: Retest the Microsoft Sentinel prompt

Now that the Microsoft Sentinel plugin is enabled, you run the prompt you tried earlier. With the prompt successfully executed, you save the prompt to the pin board and get a link to the session so you can share it with a colleague.

1. Once you've configured the plugin, you need to create a new session to rerun the Microsoft Sentinel prompt. From the top of the page, select **Microsoft Security Copilot**.
1. In the prompt bar, enter the prompt **Summarize the Microsoft Sentinel incident 30342**. You can copy and paste the prompt into the prompt bar. Then select the run icon.

1. The Copilot process log shows that the prompt executed successfully by displaying green check marks.

1. Select the **box icon ![box icon](../media/box-icon.png)** next to the pin icon to select the response. Selecting the **Pin icon ![pin icon](../media/pin-icon.png)** pins the response to the pin board, which automatically opens. The pin board shows a summary for the pined responses.


#### Review

In this exercise, you ran a prompt that requires the Microsoft Sentinel plugin to be enabled. The first time you ran the prompt, Copilot wasn't able to complete the request. The process log provided the information to help you troubleshoot the issue. You then configured and enabled the plugin. With the plugin enabled you were able successfully run the prompt.
