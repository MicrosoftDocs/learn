Alice created her own Azure Board using the Basic process. It shows problems in the build process that she and Bob identified.

![Backlog of tasks](../media/3-all-tasks-board.png)

She's gotten the team together to take a look at them and see if there's a few that they can address.

Carol: Wow, that's a lot of problems. How are we ever going to fix all those? Anyways, there's not much about testing in there.

Ted: This doesn't have much to do with me, either. These are mostly dev problems.

Alice: I know it's not complete. And some of them really need to get broken down into smaller tasks. But DevOps is about everyone on the team working together. Even if you don't see anything that affects you now, that'll change. And we all need to understand the process.

I want to pick just a few items from this list and use Azure Boards to define work items.

Bob: And a work item is?

Alice: Work items help us plan and manage a project. A work item can track all kinds of activities. Maybe it's a task to do, a bug to fix, or some other issue. We can assign them to people and keep track of their progress. I'll show you when we set up an Azure board. We'll use tasks.

So, let's pick three issues we think we can fix in a couple weeks.

There's a lot of arguing, but the team decides to take on these three issues:

* **Issue 12**. Stabilize the build server.
* **Issue 14**. Standardize handoffs to QA.
* **Issue 16**. Increase visibility for all stakeholders.

These seem the easiest issues to take on.

Bob volunteers to set up the Azure Basic board while everyone watches. 

## Set up an Azure board using the Basic process

It these procedures, you'll set up an Azure Board for the Tailspin team.

### Create the project

In this procedure, you create an Azure DevOps project.

1. Sign into your account at [dev.azure.com](https://dev.azure.com).
1. Click **+ Create project**.
1. The **Create new project window** opens.
1. In the **Project name** field, type **Tailspin Build First Steps**.
1. In the **Description** field, type **First steps to fixing the build process!**.
1. Click **Advanced**.
1. From the work item process drop-down box, select **Basic**.
1. Click **Create**.

### Create a team

In this procedure, you create a team for the project.

1. Click **Project settings** in the bottom left-hand corner.
2. The Project details page opens
3. Under **General**, select **Teams**. The Teams page opens.
4. Click **New team**. The **Create new team** window opens.
5. In the **Team name** field, type **Spacegame**.
6. In the **Description** field, type **This team works on the Spacegame project and the build process.**
7. Click **Create team**.

### Add team members

In this procedure, you add members to the team.

1. Click **Project Settings**.
1. Click **Security**.
1. Click **Members**.
1. Click **Add**.
1. Enter **bob@tailspin.com** and click **Save changes**.
1. Do the same for carol@tailspin.com, alice@tailspin.com and ted@tailspin.com.

### Create the board

In this procedure, you add three work items to the board.

1. In the left hand column, click **Boards** and select **Boards** from the menu.
1. Click **Tailspin Build First Steps Team boards**. A Basic board appears.
1. In the To Do column, Click the **green + sign** next to the **New item** field.
1. Enter Stabilize the build server and then return.
1. Click the **ellipses(…)**.
1. Click **Open**.
1. In the Description field, enter: **The build server keeps falling over. The OS (Ubuntu 16.04) requires security patches and updates. It's also a challenge to keep build tools and other software up to date.**
1. Click **Save & Close**. The task appears on the board. 
1. Follow the same steps for the two other items.
    a. Create a work item called **Increase visibility for all stakeholders**. The description is **The product manager is constantly asking for updates. It's difficult to report status on what each member is doing.  Planning documents quickly go out of date**.
    b. Create a work item called **Standardize handoffs to QA**. The description is **QA doesn't always know when a new build is available. The team tries to schedule handoffs up front but things slip (for example, the build is late or QA forgets).**

The board will look something like this (the work item numbers may be different).

[INSERT IMAGE]

Finally, after a lot of discussion, Alice, Carol and Bob each take on one of the work items.

### Assign tasks

In this procedure, you assign tasks to team members.

1. Open the **Standardize handoffs to QA** work item.
1. Click the **ellipses (...)**.
1. Click **Open**.
1. Click **Unassigned**.
1. Enter carol@tailspin.com (or select it from the drop-down box).
1. Click **Save and close**.
1. Do the same for the Increase visibility work item and assign it to Alice.
1. Do the same for the Stabilize build server work item and assign it to Bob.

The board now looks something like this:

[INSERT IMAGE]

Alice: We did it! We created our first Azure Board and we identified the first tasks we'll take on. It's great!

Everyone looks nervous.