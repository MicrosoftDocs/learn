## Lab exercise 3 - Create VSTS build defintion for CI/CD pipeline

To automatically build and deploy your application, you need to first push your code to VSTS as follows:

1. In the **Team Explorer** window of Visual Studio, choose **Changes**:

    ![Commit local changes to Team Services git repo](media/commit-changes.png)

2. In the commit text box, enter a message such as *Initial commit*. Choose **Commit All and Sync** from the drop-down menu.

### Create a VSTS build definition

In Team Services, you use a build definition to outline how your application should be built. In this learning scenario, you create a basic definition that takes your source code, builds the solution, then creates artifacts to publish to a Web App on Azure

1. In a web browser, open the VSTS project created at the start of this learning scenario.
2. From the banner across the top, select **Build & Release** and then **Builds**.
3. Select **+ New definition**.
4. From the list of sources, select **VSTS Git**, make sure that your *myWebApp* team project and repository are selected, then choose **Continue**.
5. From the list of templates, choose *Azure Web App* and select **Apply**.
6. Choose your **Azure subscription** from the drop-down menu, then select **Authorize**. It takes a few seconds to authorize the connection between VSTS and your Azure subscription.
7. Once authorized, choose the **App service name** from the drop-down menu that you created in Visual Studio in a previous lab, such as *myWebApp*.
8. On the **Triggers** tab, check the box for *Enable continuous integration*
9. Save the build definition and queue a new build by selecting **Save & queue**, then **Save & queue** again. Leave the defaults and select **Save & queue**.

Watch as the build is scheduled on a hosted agent, then begins to build and deploy to Azure. The output is similar to the following example:

![Successful build of Team Services project](media/successful-build.png)

Your application was deployed to Azure Web Apps by VSTS. As there were no changes made in Visual Studio, your web site shows looks the same if you refresh your browser window.