In this exercise, you go through the process of integrating a knowledge base into copilot, using file upload and then you do some basic testing with prompts that pull information from that knowledge base.

> [!NOTE]
> The environment for this exercise is a simulation generated from the product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script may not be supported. A pop-up message displays stating, "This feature is not available within the simulation." When this occurs, select OK and continue the exercise steps.  
>
>
>:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature isn't available within the simulation.":::

### Exercise

For this exercise, you're logged in as Avery Howard and have the Copilot owner role. For all the tasks in this exercise, you work in the Copilot standalone experience.

This exercise should take approximately **10** minutes to complete.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it's recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.

#### Before you start

For this exercise, you are using a sample file, 'Woodgrove Corporate Data Handling Policy.pdf.'

1. Select the link **[Woodgrove Corporate Data Handling Policy.pdf'](https://github.com/MicrosoftLearning/SC-5006-Enhance-security-by-Microsoft-Security-Copilot/blob/master/Sample%20files/Woodgrove%20Corporate%20Data%20Handling%20Policy.pdf?azure-portal=true)** to access the sample file.

1. Select the **Download raw file ![download raw file icon](../media/raw-file-download-icon-v2.png)** icon. Save the file on your local computer, as you'll need it later.

   Alternatively, because this is a simulation, you can create the file named 'Woodgrove Corporate Data Handling Policy.pdf.' Because this is a simulation, the contents of the file you create won't matter. The prompt responses shown in the simulation, however, are based on the actual file.


#### Task: Configure Copilot to support file uploads

In this task, you start by attempting a file upload but realize that there's no way to actually upload a file. This is an indication that the file upload option isn't configured. As a user with the Copilot owner role, you enable file uploads and then test using a file as a knowledge base for Copilot.

1. Open the simulated environment by selecting this link: **[Microsoft Security Copilot](https://app.highlights.guide/start/f7107adc-8d47-43ae-a7f7-f9e9a35881c4?token=045faae1-1078-4eac-bf56-e12472eddaf9&azure-portal=true)**.

1. To access file uploads, select the **sources icon** ![sources icon](../media/sources-icon.png) from the prompt bar.

1. From the manage sources page, select **Files**.
1. If there's no option to actually upload a file, it's because the owner setting that controls this option has been changed from the default. After conferring with the other Copilot owner, you realize this was disabled in error and agree this should be set.
    1. Close the manage source window by selecting the **X** on the top right corner of the window.
    1. Select the **Home** menu icon (hamburger icon).
    1. Select **Owner settings**.
    1. Scroll-down to **Files**. Select the drop-down and set it to **Contributors and owners can upload files**.

1. Return to the landing page. Select **Microsoft Security Copilot** next to the home menu (hamburger) icon.

#### Task: Upload a file and run test prompts

In this task, you upload a file and proceed to run prompts that use that file.

1. From the landing page, select the **Sources** icon located in the prompt bar.

1. From the Manage sources page, select **Files**.

1. Select **Upload file**. Upload the file **Woodgrove Corporate Data Handling Policy.pdf** that you previously downloaded or created. Once the file is uploaded, close the manage sources window.

1. With the files uploaded, you can now try some prompts. In the prompt bar, you need to mention "uploaded files" if you want Copilot to reason over your available files. You can also include the file name if you would like to guide Copilot to reason over a specific file. Enter the following prompts. You can use copy/paste:
    1. Prompt: **Summarize the uploaded file Woodgrove Corporate Data Handling Policy.pdf**. The process log shows that Copilot chose file uploads and successfully processed the prompt.
    1. Prompt: **Based on the uploaded file Woodgrove Corporate Data Handling Policy.pdf what data handling policies should I consider implementing in Microsoft Purview**. The process log shows that Copilot chose Microsoft Purview. The prompt response demonstrates the power of Copilot. Copilot maintains the context of the previous prompt response and integrates that information with the capability of Microsoft Purview. Although not shown in this exercise, Copilot can reason across multiple files.

#### Review

In this task, you configured to allow contributors and owners to upload files, you uploaded a file, and tested prompts that reasoned over the uploaded file.
