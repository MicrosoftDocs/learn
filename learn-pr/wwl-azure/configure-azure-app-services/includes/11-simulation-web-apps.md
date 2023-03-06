## Lab scenario

Your organization is migrating on-premises web apps to Azure. As the Azure Administrator you need to:
+ Host web sites running on Windows servers by using the PHP runtime stack. 
+ Implement Azure DevOps practices by using Azure Web Apps deployment slots.

## Architecture diagram

:::image type="content" source="../media/lab-09a.png" alt-text="Architecture diagram as explained in the text." border="false":::

## Objectives

+ **Task 1**: Create an Azure web app.
    + Create a web app by using the Azure portal. 
    + The web app should run on Windows and use the PHP runtime stack. 
+ **Task 2**: Create a staging deployment slot.
    + Verify there's a production deployment slot.
    + Create a new staging deployment slot. 
+ **Task 3**: Configure Web App deployment settings.
    + Deploy your web app from a local Git session.
    + Provide the authentication credentials. 
+ **Task 4**: Deploy code to the staging deployment slot.
    + Use Azure PowerShell to clone the remote repository and set the local path.
    + Add the remote Git session by using the authentication credentials.
    + Display the default web page in a new browser tab.
    + Push the sample web app code from the local repository to the Azure Web App staging deployment slot.
+ **Task 5**: Swap the staging slots.
    + Swap the deployment slots.
    + Verify the default web page is replaced with the Hello World page.
+ **Task 6**: Configure and test autoscaling of your Azure web app.
    + Configure a custom autoscale rule on the production deployment slot.
    + The scale rule should use the CPU percentage to increase the resource count.
    + Use Azure PowerShell to start an infinite loop that sends the HTTP requests to your web app.
    + Confirm the resource count automatically scales. 

> [!NOTE]
> Select the thumbnail image to start the lab simulation. When you're done, be sure to return to this page so you can continue learning. 

> [!NOTE]
>You may find slight differences between the interactive simulation and the hosted lab, but the core concepts and ideas being demonstrated are the same.

[![Screenshot of the simulation page.](../media/simulation-web-apps-thumbnail.jpg)](https://mslabs.cloudguides.com/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%2013?azure-portal=true)

