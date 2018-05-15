To see how changes committed from Team Services are deployed through CI/CD, edit your app to show an updated H1 in the webpage. To commit and push your changes to Team Services:

1. In Visual Studio, open the Solution Explorer window.
2. Go to **myWebApp** > **Views** > **Home** > **Index.cshtml**.
3. In *Index.cshtml*, edit line 6 to read:

    `<h1>ASP.NET with Team Services and CI/CD!</h1>`

4. Save the file.
5. Open the Team Explorer window, and then select the *myWebApp* project. Select **Changes**.
6. Enter a commit message, such as *Testing CI/CD pipeline*, and then select **Commit All and Sync** from the drop-down menu.

Now, review the build process and update the running app. Select **Next**.