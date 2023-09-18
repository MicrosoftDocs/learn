Azure Automation supports source control integration that enables you to keep your runbooks in your Automation account up to date with your scripts in your GitHub or Azure DevOps source control repository.

Source control allows you to collaborate with your team more efficiently, track changes, and roll back to earlier versions of your runbooks.

For example, source control will enable you to sync different branches in source control to your development, test, or production Automation accounts.

It makes it easier to promote code you've tested in your development environment to your production Automation account.

Azure Automation supports three types of source control:

 -  GitHub.
 -  Azure DevOps (Git).
 -  Azure DevOps (TFVC).

Source control allows you to push code from Azure Automation to source control or pull your runbooks from source control to Azure Automation.

Source control sync jobs run under the user's Automation Account and are billed at the same rate as other Automation jobs.

## Integrate source control with Azure Automation

You integrate source control with Azure Automation using the following steps:

1.  In the Azure portal, access your Automation account.
2.  Under Account Settings, select **Source control**, and then choose **+ Add**.
3.  In the **Source Control Summary** blade, select **GitHub** as source control type and then select **Authenticate**.<br>

    > [!NOTE]
    > Note: You'll require a GitHub account to complete the next step.

4.  When the browser page opens, prompting you to authenticate to [https://www.github.com](https://www.github.com/), select **Authorize azureautomation** and enter your GitHub account password. If successful, you should receive an email notification from GitHub stating that *A third-party OAuth Application (Automation Source Control) with repo scope was recently authorized to access your account.*
5.  After authentication completes, fill in the details based on the following table, and then select **Save**.<br>
    
    | **Property**        | **Description**                                                                                                    |
    | ------------------- | ------------------------------------------------------------------------------------------------------------------ |
    | Name                | Friendly name                                                                                                      |
    | Source control type | GitHub, Azure DevOps Git, or Azure DevOps TFVC                                                                     |
    | Repository          | The name of the repository or project                                                                              |
    | Branch              | The branch from which to pull the source files. Branch targeting isn't available for the TFVC source control type. |
    | Folder Path         | The folder that contains the runbooks to sync.                                                                     |
    | Autosync            | Turns on or off automatic sync when a commit is made in the source control repository.                             |
    | Publish Runbook.    | If set to **On**, after runbooks are synced from source control, they'll be automatically published.               |
    | Description         | A text field to provide more details.                                                                              |
6.  If you set **Autosync** to **Yes**, full sync will start. If you set **Autosync** to **No**, open the **Source Control Summary** blade again by selecting your repository in Azure Automation and then selecting **Start Sync**.<br><br>:::image type="content" source="../media/source-control-summary-4b83dab3.png" alt-text="Screenshot of the Source Control Summary blade containing fields, and details to be filled in.":::
    
7.  Verify that your source control is listed on the **Azure Automation Source control** page for you to use.<br><br>:::image type="content" source="../media/source-control-f1d31c38.png" alt-text="Screenshot of the Azure Automation source control window with the just-created source control account.":::
    
