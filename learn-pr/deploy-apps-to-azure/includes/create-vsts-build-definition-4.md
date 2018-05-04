In Team Services, you use a build definition to outline how your application should be built. In this learning scenario, you create a basic definition that uses your source code to build the solution. The definition then creates artifacts to publish to a web app in Azure.

1. In a web browser, open the Team Services project that you created at the beginning of this learning scenario.
2. Select the **Build and Release** hub, and then select **Builds**.
3. Select **+ New definition**.
4. In the list of sources, select **VSTS Git**. Make sure that your *myWebApp* team project and repository are selected, and then select **Continue**.
5. In the list of templates, select **Azure Web App**, and then select **Apply**.
6. Select your Azure subscription from the drop-down menu, and then select **Authorize**. It takes a few seconds to authorize the connection between Team Services and your Azure subscription.
7. When authorization is finished, in the **App service** name drop-down menu, select the Azure App Service name that you created in Visual Studio in an earlier lab, such as *myWebApp*.
8. On the **Triggers** tab, select the **Enable continuous integration** check box.
9. To save the build definition and queue a new build, select **Save & queue**. Select **Save & queue** again. Leave the defaults, and then select **Save & queue**.

Watch as the build is scheduled on a hosted agent and then begins to build and deploy to Azure. The output is similar to the following example:

![Successful build of a Team Services project](../media/successful-build.png)

Congratulations! Your application was deployed to Azure Web Apps by Team Services. Because no changes were made in Visual Studio, if you refresh your browser window, your website should look the same.