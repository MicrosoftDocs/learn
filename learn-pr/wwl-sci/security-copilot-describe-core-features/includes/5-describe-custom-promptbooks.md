Promptbooks in Copilot for Security are collections of prompts put together to accomplish specific security-related tasks. They run one prompt after another, building on previous responses.

You can create your own promptbook with the promptbook builder to automate investigation flows and optimize repetitive steps in Copilot that are customized to your needs and requirements. You can also share the promptbooks you created with other users so they can also benefit from your work.

### Create a promptbook from an existing session

To create your own promptbook, you can start with an existing session that contains the prompts you want to work with. For this example, the session titled, "Show the last three failed login attempts," is used.

:::image type="content" source="../media/select-session.png" lightbox="../media/select-session.png" alt-text="Screen capture showing the session to use as the basis for your custom promptbook.":::

After selecting the desired session, select the boxes beside the prompts to include them or select the top box to include all prompts in the session. Selecting any or all of the prompts light up the Create promptbook button.

:::image type="content" source="../media/select-create-promptbook-v4.png" lightbox="../media/select-create-promptbook-v4.png" alt-text="Screen capture of the create promptbook icon.":::

Once you select the create promptbook icon, the Create a promptbook page opens. Here you name the promptbook, add a tag and a description, add more prompts, and remove or edit existing prompts. If any of the prompts require an input parameter, you would need to specify an easily understood parameter name within angle brackets and no spaces. For example, if one of the prompts requires an incident ID number, you can specify \<IncidentID>. Similarly, if a prompt requires that you enter a threat actor name, you could specify the input parameter as \<threatactorname> or \<ThreatActor>. You can include more than one input parameter. You can also select to share the promptbook with others in your organization or have it for your own personal use.

In the screenshot that follows, the promptbook is named Failed-Login-Attempts and it includes two prompts. The first prompt was originally to show the last three failed logins. To configure the number as an input parameter, select the ellipses next to the prompt to edit it by replacing the number 3 and entering \<number>.

:::image type="content" source="../media/create-promptbook-options-v3.png" lightbox="../media/create-promptbook-options-v3.png" alt-text="Screen capture of the parameters to create a custom promptbook.":::

A pop-up window appears once your promptbook is created. From this window, you can select to view the promptbook you just created and then run it or edit it, share your promptbook via link, or go to the promptbook library.

:::image type="content" source="../media/promptbook-created.png" lightbox="../media/promptbook-created.png" alt-text="Screen capture of pop-up window for the newly created promptbook including the copy icon next to the name.":::

From then on, you can run your promptbook like you would any other promptbook. You can select the prompts icon from the prompt bar and start typing in the name of the promptbook in the search bar then selecting it from the list that appears.

:::image type="content" source="../media/create-promptbook-run-from-prompt-bar-v3.png" lightbox="../media/create-promptbook-run-from-prompt-bar-v3.png" alt-text="Screen capture of the prompt bar showing the list of promptbooks.":::

Selecting the promptbook opens it. From here, you enter the required input parameter and then select run.

:::image type="content" source="../media/create-promptbook-run-v3.png" lightbox="../media/create-promptbook-run-v3.png" alt-text="Screen capture promptbook, including the input parameter.":::

### Edit a promptbook

To edit your existing promptbook, select the home menu (hamburger icon) and select Promptbook library.

:::image type="content" source="../media/select-promptbook-library-v2.png" lightbox="../media/select-promptbook-library-v2.png" alt-text="Screen capture of the home menu options including the promptbook library option.":::

Select the ellipses for the promptbook you want to edit then select Edit from the options. You can only edit existing promptbooks if you're the owner of the promptbook.

:::image type="content" source="../media/my-promptbooks-library-edit.png" lightbox="../media/my-promptbooks-library-edit.png" alt-text="Screen capture of the edit option for your custom promptbook.":::

In addition to editing, you can also choose to view the details of the promptbook, duplicate it, or delete it. You can also choose to run the promptbook by selecting the run icon.
