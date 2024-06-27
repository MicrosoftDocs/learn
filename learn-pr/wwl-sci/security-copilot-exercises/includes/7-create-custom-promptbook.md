In this exercise, you create a custom promptbook from an existing session and then run that promptbook.

> [!NOTE]
> The environment for this exercise is a simulation generated from the product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script may not be supported. A pop-up message will display stating, "This feature is not available within the simulation." When this occurs, select OK and continue the exercise steps.
>:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Image of pop-up screen indicating that this feature is not available within the simulation.":::

### Exercise

For this exercise, you're logged in as Avery Howard and have the Copilot owner role. You'll work in the standalone experience of Microsoft Copilot for Security.

This exercise should take approximately **10** minutes to complete.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it is generally recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.


#### Task: Create the promptbook from an existing session

In this task, you create the promptbook. As part of the process, you templatize one of the prompts by editing the prompt with an input parameter, and then add a new prompt.

1. Open the simulated environment by selecting this link: **[Microsoft Copilot for Security](https://app.highlights.guide/start/2507f304-e91c-4234-bc76-b66ed1d13995?link=0&token=40f793d4-2956-40a4-b11a-6b3d4f92557f&azure-portal=true)**.

1. There’s a session from earlier in the day that identified failed logins that you want to use. Since that session isn't listed on the landing page, select **View all sessions**.

1. Select the session labeled, **what are the last three failed logins**, it's the last session on the My Sessions list.

1. The complete session is displayed. Scroll up/down to verify two prompts are listed.

1. To include a subset of all the prompts, you can select the box next to each individual prompt. Or you can select the box next to the pin icon to include all the prompts. In this case, you want to select all the prompts from the session. Select the **box icon ![box icon](../media/box-icon.png)** next to the pin icon to select all the prompts.

1. Now that you’ve selected the prompts, select the **Create promptbook** ![sources icon](../media/create-promptbook-icon.png) icon. The Create a promptbook window opens. Here you populate the name, tags, and description fields for the promptbook, you configure an input parameter, and add a prompt. For the simulation, we've provided the input values to use. You can use copy/paste to enter those values or type them in as shown.
    1. Name: **Failed logins**
    1. Tags: **Microsoft Entra**
    1. Description: **Find the last failed logins**
    1. The first prompt is to show the last three failed logins. For your custom promptbook, you want to replace the number three with an input parameter. To configure the input parameter, place your mouse over the first prompt, then select the **edit** ![edit icon](../media/edit-icon.png) icon.
        1. Replace the word three with an easily understood parameter that contains no spaces and is delineated with angle brackets. For this simulation, enter **\<number>**.
        1. To confirm the edit, select the checkmark ![checkmark icon](../media/check-mark-icon.png) icon. The number parameter is now listed in the section labeled "Inputs you’ll need." For this promptbook, this is the only input needed, but you can create promptbooks that use multiple inputs.
    1. For your promptbook, you'll add a new prompt. Select **+ Add prompt**.
        1. Select the **edit** ![edit icon](../media/edit-icon.png) icon.
        1. Enter **What are the authentication methods for the failed logins**.
        1. Select the checkmark ![checkmark icon](../media/check-mark-icon.png) icon.
    1. The next step is to select who can use this promptbook. Select the drop-down to view the options. For now, leave the setting to **Just me**.
    1. To create the custom promptbook, select **Create**.
    1. With your promptbook created, you can choose to view the details, share the promptbook, or go to the promptbook library. Select **Promptbook library**.

#### Task: Run the promptbook

In this task, you explore the options available for the newly created promptbook and run the promptbook.

1. Select **My promptbooks**.

1. Place your mouse over the newly created promptbook, until it's highlighted. With the promptbook highlighted select the **ellipses** to view the available options. Select the ellipses again to close the window with the available options.

1. Select the **run ![run icon](../media/run-icon.png)** icon to start a new session.
    1. You want Copilot to return information on the last **two** failed logins.
    1. Select the **Run** button.

1. Review the responses generated by Copilot.

#### Review

In this exercise, you created a custom promptbook from an existing session and ran that promptbook.