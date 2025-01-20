The Azure portal provides out-of-the-box continuous integration and deployment with Azure DevOps services, GitHub, Bitbucket, FTP, or a local Git repository on your development machine. You can connect your web app with any of the above sources and App Service handles the rest for you. App Service autosynchronizes your code and any future changes to the code into your web app. With Azure DevOps services, you can also define your own build and release process. Compile your source code, run tests, and build and deploy the release into your web app every time you commit the code. All of the operations happen implicitly without any need for human administration.

:::image type="content" source="../media/continuous-development-a0dfd350.png" alt-text="Illustration that shows two developers sharing a single GitHub source to produce a website built with Azure App Service." border="false":::

### Things to know about continuous and manual deployment

When you create your web app with App Service, you can choose continuous or manual deployment. As you review these options, consider which deployment method to implement for your App Service apps. These options are located in the Deployment Center. 

:::image type="content" source="../media/deployment-center.png" alt-text="Screenshot of the Deployment Center setting options." border="false":::

**Continuous deployment (CI/CD)** is a process used to push out new features and bug fixes in a fast and repetitive pattern with minimal impact on end users. Azure supports automated deployment directly from several sources:

   - **GitHub**: Azure supports automated deployment directly from GitHub. When you connect your GitHub repository to Azure for automated deployment, any changes you push to your production branch on GitHub are automatically deployed for you.

   - **Bitbucket**: With its similarities to GitHub, you can configure an automated deployment with Bitbucket.

   - **Local Git**: The App Service Web Apps feature offers a local URL that you can add as a repository. 

   - **Azure Repos**: Azure Repos is a set of version control tools that you can use to manage your code. Whether your software project is large or small, using version control as soon as possible is a good idea.

**Manual deployment** enables you to manually push your code to Azure. There are several options for manually pushing your code:

   - **Remote Git**: The App Service Web Apps feature offers a Git URL that you can add as a remote repository. Pushing to the remote repository deploys your app.

   - **OneDrive**: OneDrive is a service that lets you store and share files on the internet with a Microsoft account. 

   - **Dropbox**: Dropbox is a file hosting service