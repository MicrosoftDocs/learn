In this exercise, you go through the process of integrating a knowledge base into copilot, using file upload and then you do some basic testing with prompts that pull information from that knowledge base.

> [!NOTE]
> The environment for this exercise is based on a simulation, generated from pre-determined screen captures of the actual product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script are not be supported.

### Exercise

> [!NOTE]
> It is recommended that you open the exercise environment in a separate browser window so that you can simultaneously view the instructions and the exercise environment.

Using the exercise environment, follow the exercise steps that are listed.

[![Button to launch exercise environment.](../media/security-copilot-launch-exercise-button-v2.png)]()

#### Task: Configure Copilot to support file uploads

In this task, you start by attempting a file upload but realize that there's no way to actually upload a file. This is an indication that the file upload option isn't configured. As a user with the Copilot owner role, you enable file uploads and then test using a file as a knowledge base for Copilot.

1. To access file uploads, select the sources icon from the prompt bar.

1. From the manage sources page, select Files.
1. You review the information in the files upload window, but there's no option to actually upload files. This is an indication that the owner setting that controls this option has been changed from the default. After conferring with the other Copilot owner, you realize this was disabled in error and agree this should be set.
    1. Select the home menu (hamburger icon).
    1. Select owner settings.
    1. Scroll-down to Files. Select the drop-down and set it to owners and contributors can upload files.

#### Task: Upload a file and run test prompts

In this task, you upload a file and proceed to run prompts that use that file.

1. Now that file upload is enabled, return to the files upload window. Select the sources icon, then select Files.

1. Upload the file Woodgrove Corporate Data Handling Policy.docx
1. With the files uploaded, you can now try some prompts.
1. In the prompt bar, you need to mention "uploaded files" if you want Copilot to reason over your available files. You can also include the file name if you would like to guide Copilot to reason over a specific file. Enter the following prompts:
    1. Prompt: Summarize the uploaded file Woodgrove Corporate Data Handling Policy.docx. The process log shows that Copilot chose file uploads and successfully processed the prompt.
    1. Prompt: Based on the uploaded file Woodgrove Corporate Data Handling Policy.docx what data handling policies should I consider implementing in Microsoft Purview. The process log shows that Copilot chose Microsoft Purview. The prompt response demonstrates the power of Copilot. Copilot maintains the context of the previous prompt response and integrates that information with the capability of Microsoft Purview. Although not shown in this exercise, Copilot can reason across multiple files.

#### Review

In this task, you configured to allow contributors and owners to upload files, you uploaded a file, and tested prompts that reasoned over the uploaded file.
