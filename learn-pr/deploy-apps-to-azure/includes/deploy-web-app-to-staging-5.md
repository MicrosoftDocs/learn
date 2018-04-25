As in the previous tutorial, to see your CI/CD pipeline deploy to staging slot, update the H1 in your app in Visual Studio. Commit and push the changes to see your app now deployed to the Web App staging slot in Azure:

1. In Visual Studio, open the **Solution Explorer** window.
2. Navigate to and open *myWebApp | Views | Home | Index.cshtml*
3. Edit line 6 to read:

    `<h1>ASP.NET with staged review in VSTS and CI/CD!</h1>`

4. Save the file.
5. Open the **Team Explorer** window, select the *myWebApp* project, then choose **Changes**.
6. Enter a commit message, such as *Deploying to staging slot*, then choose **Commit All and Sync** from the drop-down menu.
7. In Team Services workspace, a new build is triggered from the code commit.
    - Choose **Build & Release**, then select **Builds**.
    - Choose your build definition, then select the **Queued & running** build to watch as the build progresses.
8. To see your changes applied once the build has successfully completed, refresh your staging web site in a browser, such as *https://mywebapp-staging.azurewebsites.net*:

    ![ASP.NET web app running in Azure Web App staging slot](media/running-web-app-staging.png)

9. To confirm that your production site has not changed, refresh the production web site in a browser.