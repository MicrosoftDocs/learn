In VSTS, you use a build definition to outline how your application should be built. In this learning scenario, you create a basic definition that uses your source code to build the solution, and then creates artifacts to publish to a Web App in Azure.

1. In a web browser, open the VSTS project that you created at the beginning of this learning scenario.
2. In the **Build and Release** hub, select the **Builds** tab.
3. Select **New definition**.
4. In the list of sources, select **VSTS Git**. Make sure that your **myWebApp** team project and repository are selected, and then select **Continue**.
5. In the list of templates, select **Azure Web App**, and then select **Apply**.
6. Select your Azure subscription from the drop-down menu, and then select **Authorize**. It takes a few seconds to authorize the connection between VSTS and your Azure subscription.
7. When authorization is finished, in the **App service** name drop-down menu, select the App service name that you created in Visual Studio in an earlier lab, such as **myWebApp**.
8. On the **Triggers** tab, select the **Enable continuous integration** check box.
9. To save the build definition and queue a new build, select **Save & queue**. Select **Save & queue** again. Leave the defaults and select **Save & queue**.

Watch as the build is scheduled on a hosted agent and then begins to build and deploy to Azure. The output is similar to the following example:

![Successful build of a Team Services project](../media/successful-build.png)

Congratulations! Your application was deployed to Azure Web Apps by VSTS. Because no changes were made in Visual Studio, your website should look the same if you refresh your browser window.