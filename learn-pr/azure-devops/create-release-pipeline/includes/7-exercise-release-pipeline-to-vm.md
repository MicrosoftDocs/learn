TODO: Change File Name

Just like we did in the (Build LP), we will want a way to easily monitor our deployments. Here you add a release dashboard to Azure DevOps.

Exercise - Add dashboard widgets to monitor the build and release pipeline

Resources:

[ILT Content Link](https://courses.microsoft.com/courses/course-v1:ELMS+AZ-400.3+2019_T1/course/?azure-portal=true)

Course > Set Up a Release Management Workflow > Automate Inspection of Health > Lab

## Add dashboard widgets

### Add a Deployment Status widget

1. Under **Overview** select **Dashboards**.
1. Select **+ New Dashboard**.
1. In the pane on the right search for the **Deployment Status** widget and drag it on to the dashboard.
1. Click the gear icon to configure the widget.
1. Under **Linked release pipelines** select your pipeline and make sure both boxes are checked. TODO: Screenshot
1. Click **Save**

### Add a Release Pipeline Overview and Build History widgets

1. Search for **Release Pipeline Overview** in the Add Widget pane on the right.
1. Drag it on to the dashboard.
1. Click the gear icon to configure the widget.
1. Select your release TODO: get the name
1. Click **Save**
1. Search for **Build History** in the Add Widget pane on the right.
1. Drag it on to the dashboard.
1. Select your build **Tailspin-SpaceGame-web**.
1. Click **Save**

### Add Health Overview and Health Detail widgets

1. At the bottom of the Add Widget pane, click the **Extension Galery** link.
1. When the Marketplace browser window opens, make sure you are on the **Azure DevOps** tab.
1. Search for **Team project Health**.  TODO: Screenshot
1. Install this extension
1. Back in Azure DevOps, refresh this screen to make sure you have the extension installed.
1. Click the **Edit** icon at the top to open the Add Widget pane. TODO: Screenshot
1. Search for **Release Health Overview** and add it to the dashboard.
1. Configure the widget.
1. Search for **Release Health Details** and add it to the dashboard.
1. Configure the widget.
1. Search for and add **Build Health Overview** and **Build Health Details**
1. Configure these widgets.

TODO: Screenshot of entire dashboard.

**Amita:** This is great. And it will make Irwin happy to have something to show management.

**Andy:** Right! But this is just the proof of concept. Now, we need to take this POC and expand on it to create a whole release and deployment workflow.
