The Azure portal provides out-of-the-box continuous integration and deployment with Azure DevOps, GitHub, Bitbucket, FTP, or a local Git repository on your development machine. You can connect your web app with any of the above sources and App Service handles the rest for you. App Service auto-synchronizes your code and any future changes to the code into your web app. With Azure DevOps, you can also define your own build and release process. Compile your source code, run tests, and build and deploy the release into your web app every time you commit the code. All of the operations happen implicitly without any need for human administration.

:::image type="content" source="../media/continuous-development-a0dfd350.png" alt-text="Illustration that shows two developers sharing a single GitHub source to produce a website built with Azure App Service." border="false":::

### Things to know about continuous deployment

When you create your web app with App Service, you can choose automated or manual deployment. As you review these options, consider which deployment method to implement for your App Service apps.

- **Automated deployment** (continuous integration) is a process used to push out new features and bug fixes in a fast and repetitive pattern with minimal impact on end users. Azure supports automated deployment directly from several sources:

   - **Azure DevOps**: Push your code to Azure DevOps (previously known as Visual Studio Team Services), build your code in the cloud, run the tests, generate a release from the code, and finally, push your code to an Azure web app.
   
   - **GitHub**: Azure supports automated deployment directly from GitHub. When you connect your GitHub repository to Azure for automated deployment, any changes you push to your production branch on GitHub are automatically deployed for you.
 
   - **Bitbucket**: With its similarities to GitHub, you can configure an automated deployment with Bitbucket.

- **Manual deployment** enables you to manually push your code to Azure. There are several options for manually pushing your code:

   - **Git**: The App Service Web Apps feature offers a Git URL that you can add as a remote repository. Pushing to the remote repository deploys your app.

   - **CLI**: The `webapp up` command is a feature of the command-line interface that packages your app and deploys it. Deployment can include creating a new App Service web app.

   - **Visual Studio**: Visual Studio features an App Service deployment wizard that can walk you through the deployment process.

   - **FTP/S**: FTP or FTPS is a traditional way of pushing your code to many hosting environments, including App Service.