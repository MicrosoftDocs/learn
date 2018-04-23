To see how changes commitd from VSTS are then deployed through CI/CD, edit your app to show an updated H1 in the web page. Commit and push your changes to VSTS as follows:

1. In Visual Studio, open the **Solution Explorer** window.
2. Navigate to and open *myWebApp | Views | Home | Index.cshtml*
3. Edit line 6 to read:

    `<h1>ASP.NET with VSTS and CI/CD!</h1>`

4. Save the file.
5. Open the **Team Explorer** window, select the *myWebApp* project, then choose **Changes**.
6. Enter a commit message, such as *Testing CI/CD pipeline*, then choose **Commit All and Sync** from the drop-down menu.