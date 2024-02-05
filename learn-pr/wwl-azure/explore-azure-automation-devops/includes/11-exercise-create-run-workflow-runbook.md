> [!NOTE]
> You require an Azure subscription to do the following steps. If you don't have one, you can create one by following the steps outlined on the [Create your Azure free account today](https://azure.microsoft.com/free) webpage.

## Steps

### Create a new runbook

1.  In the **Azure portal**, open your Automation account.
2.  Under **Process Automation**, select **Runbooks** to open the list of runbooks.
3.  Create a new runbook by selecting the **Create a new runbook**.
4.  Give the runbook the name **MyFirstRunbook-Workflow**.
5.  You're going to create a PowerShell Workflow runbook, so for **Runbook type**, select **PowerShell Workflow**.
6.  Select **Create** to create the runbook and open the text editor.

### Add code to a runbook

You have two options when adding code to a runbook.

You can type code directly into the runbook or select cmdlets, runbooks, and assets from the Library control and have them added to the runbook, along with any related parameters.

For this walkthrough, you'll use the type directly into the runbook method, as detailed in the following steps:

1.  Type **Write-Output "Hello World."** between the braces, as per the below:
    
    ```PowerShell
    Workflow MyFirstRunbook-Workflow
    {
    Write-Output "Hello World"
    }
    
    ```

2.  Save the runbook by selecting **Save**.

    :::image type="content" source="../media/workflow1-2f5c612e.png" alt-text="Screenshot of workflow editor containing cmdlets, runbooks, and assets in the left pane, and the sample code on the right for the hello world sample.":::


### Test the runbook

Before you publish the runbook to production, you want to test it to ensure it works properly.

When you test a runbook, you run the draft version and view its output interactively, as demonstrated in the following steps:

1.  Select the **Test** pane.

    :::image type="content" source="../media/workflow1a-34faf19b.png" alt-text="Screenshot of workflow editor highlighting Test Pane button.":::


2.  Select **Start** to start the test. This should be the only enabled option.

    :::image type="content" source="../media/workflow2-023c36aa.png" alt-text="Screenshot of the test pane with the start button called out.":::


    A runbook job is created, and its status is displayed. The job status will start as Queued, indicating that it's waiting for a runbook worker in the cloud to come available. It moves to Starting when a worker claims the job and then Running when the runbook starts running. When the runbook job completes, its output displays. In this case, you should see Hello World.

3.  When the runbook job finishes, close the **Test pane**.

    :::image type="content" source="../media/workflow3-36e5a495.png" alt-text="Screenshot of the test pane with the runbook displaying Completed, and the output Hello World.":::


### Publish and run the runbook

The runbook that you created is still in draft mode. It would be best if you published it before you can run it in production. When you publish a runbook, you overwrite the existing published version with the draft version. In your case, you don't have a published version yet because you just created the runbook.

Use the following steps to publish your runbook:

1.  In the runbook editor, select **Publish** to publish the runbook.
2.  When prompted, select **Yes**.
3.  Scroll left to view the runbook in the Runbooks pane and ensure it shows an **Authoring Status** of **Published**.
4.  Scroll back to the right to view the pane for **MyFirstRunbook-Workflow**. Notice the options across the top:

 -  Start
 -  View
 -  Edit
 -  Link to schedule to start at some time in the future.
 -  Add a webhook.
 -  Delete
 -  Export

    :::image type="content" source="../media/workflow4-152a5f22.png" alt-text="Screenshot of the PowerShell workflow runbook overview pane.":::


5.  You want to start the runbook, so select **Start**, and then when prompted, select **Yes**.
6.  When the job pane opens for the runbook job you created, leave it open to watch the job's progress.
7.  Verify that when the job completes, the job statuses displayed in **Job Summary** match the status you saw when you tested the runbook.

    :::image type="content" source="../media/workflow5-ddc2441a.png" alt-text="Screenshot of the output pane with the runbook job status of completed.":::
