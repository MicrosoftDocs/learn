When you commit and sync your changes in Visual Studio, the build definition in Team Services is triggered. The trigger starts a new build of your code, and then deploys the updated code to Azure Web Apps.

1. In the Team Services workspace, a new build is triggered from the code commit:
    - Select the **Build and Release** hub, and then select **Builds**.
    - Select your build definition, and then select the **Queued & running** build to watch as the build progresses.
2. To see your changes applied when the build has successfully completed, refresh your website in a browser:

    ![An ASP.NET web app running on Azure Web Apps from a CI/CD pipeline](../media/running-web-app-cicd.png)

Congratulations! You've now updated your live Azure web app.