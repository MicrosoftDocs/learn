In this exercise, you'll investigate Task Groups.

> [!NOTE]
> *Before starting this walkthrough, ensure you've done the steps in the prerequisites section and the previous exercises.*

## Steps

Let's now look at how a release pipeline can reuse groups of tasks.

It's common to reuse a group of tasks in more than one stage within a pipeline or in different pipelines.

1.  In the main menu for the **Parts Unlimited** project, click **Pipelines,** then click **Task groups**.

    :::image type="content" source="../media/07-01-task-groups-menu-item-e4cdb420.png" alt-text="Task Groups menu item.":::


    You'll notice that you don't currently have any task groups defined.

    :::image type="content" source="../media/07-02-import-option-e3a4d75c.png" alt-text="Import option.":::


    There's an option to import task groups, but the most common way to create a task group is directly within the release pipeline, so let's do that.

2.  Click **Pipelines,** click **Releases** and click **Edit** to open the pipeline we worked on in the main menu.

    :::image type="content" source="../media/07-03-release-editor-2beaf055.png" alt-text="Release editor.":::


3.  The **Development** stage currently has a single task. We'll add another task to that stage. Click the **View stage tasks** link to open the stage editor.

    :::image type="content" source="../media/07-04-view-stage-tasks-c7bbcdc3.png" alt-text="View stage tasks.":::


    You can see that there's currently one task.

    :::image type="content" source="../media/07-05-single-task-336c40b8.png" alt-text="Single task.":::


4.  Click the **+** sign to the right of the **Agent job** line to add a new task, in the **Search** box, type **database**.

    :::image type="content" source="../media/07-06-database-tasks-8e69d5cc.png" alt-text="Database tasks.":::


    We'll add a task to deploy an Azure SQL Database.

5.  Hover over the **Azure SQL Database Deployment** option and click **Add**. Click the **Azure SQL DacpacTask** when it appears in the list to open the settings pane.

    :::image type="content" source="../media/07-07-azure-sql-dacpactask-55d53a05.png" alt-text="Azure SQL DacPac Task.":::


6.  Set the **Display name** to **Deploy devopslog database**, and from the **Azure Subscriptions** drop-down list, click **ARM Service Connection**.
    
    > [!NOTE]
    > *We can reuse our service connection here.*
    
    :::image type="content" source="../media/07-08-subscription-setting-7933914a.png" alt-text="Subscription Setting.":::
    

7.  In the **SQL Database** section, set a unique name for the SQL Server, set the **Database** to **devopslog**, set the **Login** to **devopsadmin**, and set any suitable password.

    :::image type="content" source="../media/07-09-database-settings-6a816244.png" alt-text="Database settings.":::


8.  In the **Deployment Package** section, set the **Deploy type** to **Inline SQL Script**, set the **Inline SQL Script** to:
    
    ```SQL
    CREATE TABLE dbo.TrackingLog
    (
        TrackingLogID int IDENTITY(1,1) PRIMARY KEY,
        TrackingDetails nvarchar(max)
    );
    
    ```
    
    :::image type="content" source="../media/07-10-finalized-settings-bc88b5f0.png" alt-text="Finalized settings.":::
    

9.  Click **Save** then **OK** to save the work.

    Now that we have two tasks let's use them to create a task group.

10. Click to select the **Backup website zip file** task and select the **Deploy devopslog database** task, then right-click either task.

    :::image type="content" source="../media/07-11-double-select-8d81b4dc.png" alt-text="Double select.":::


11. Click **Create task group**, then in the **Create task group** window, set **Name** to **Backup website zip file and deploy devopslog**. Click the **Category** drop-down list to see the available options. Ensure that **Deploy** is selected, and click **Create**.

    :::image type="content" source="../media/07-12-create-task-group-4f2218ad.png" alt-text="Create task group.":::


    The individual tasks have now disappeared from the list of tasks, and the new task group appears instead.

    :::image type="content" source="../media/07-13-shows-as-task-group-b36ee69f.png" alt-text="Shows as a task group.":::


12. From the **Task** drop-down list, select the **Test Team A** stage.

    :::image type="content" source="../media/07-14-change-stage-60c7d8c3.png" alt-text="Change stage.":::


    There are currently no tasks on the stage.

    :::image type="content" source="../media/07-15-no-tasks-75d0ee0e.png" alt-text="No tasks.":::


13. Click the **+** sign to the right of the **Agent job** to add a new task. In the **Search** box, type **backup** and notice that the new task group appears like any other task.

    :::image type="content" source="../media/07-16-search-backup-111d236c.png" alt-text="Search backup.":::


14. Hover on the task group and click **Add** when it appears.

    :::image type="content" source="../media/07-17-add-task-group-9f3c9dd3.png" alt-text="Add task group.":::


    Task groups allow for each reuse of a set of tasks and limit the number of places where edits need to occur.

## Walkthrough cleanup

15. Click **Remove** to remove the task group from the **Test Team A** stage.
16. From the **Tasks** drop-down list, select the **Development** stage. Again click **Remove** to remove the task group from the **Development** stage.
17. Click **Save,** then **OK**.
