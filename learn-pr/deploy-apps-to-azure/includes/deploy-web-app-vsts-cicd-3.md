When you commit and synced your changes in Visual Studio, the build definition in VSTS is triggered. This trigger starts a new build of your code, then deploys the updated to Azure web apps.

1. In Team Services workspace, a new build is triggered from the code commit.
    - Choose **Build & Release**, then select **Builds**.
    - Choose your build definition, then select the **Queued & running** build to watch as the build progresses.
2. To see your changes applied once the build has successfully completed, refresh your web site in a browser:

    ![ASP.NET web app running on Azure Web App from CI/CD pipeline](././media/running-web-app-cicd.png)

Congratulations - you've now updated your live Azure Web App!