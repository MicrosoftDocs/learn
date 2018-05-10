As in the preceding tutorial, to see your CI/CD pipeline deploy to a staging slot, update the H1 in your app in Visual Studio. Commit and push the changes to see your app deployed to the Web App staging slot in Azure:

1. In Visual Studio, open the Solution Explorer window.
2. Go to **myWebApp** > **Views** > **Home** > **Index.cshtml**.
3. In *Index.cshtml*, edit line 6 to read as follows:

    `<h1>ASP.NET with staged review in Team Services and CI/CD!</h1>`

4. Save the file.
5. Open the Team Explorer window, and then select the *myWebApp* project. Select **Changes**.
6. Enter a commit message, such as *Deploying to staging slot*, and then select **Commit All and Sync** from the drop-down menu.
7. In the Team Services workspace, a new build is triggered from the code commit:
    - Select **Build and Release**, and then select **Builds**.  
    - Select your build definition, and then select the **Queued & running** build to watch as the build progresses.  
8. To see your changes applied when the build has successfully completed, refresh your staging website in a browser, such as *https://mywebapp-staging.azurewebsites.net*:

    ![ASP.NET web app running in an Azure Web App staging slot](../media/running-web-app-staging.png)

9. To confirm that your production site hasn't changed, refresh the production website in a browser.
