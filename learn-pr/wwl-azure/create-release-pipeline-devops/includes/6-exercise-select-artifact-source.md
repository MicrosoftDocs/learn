
In this exercise, you'll investigate Artifact Sources.

## Steps

Let's look at how to work with one or more artifact sources in the release pipeline.

1.  In the Azure DevOps environment, open the **Parts Unlimited** project, then from the main menu, select **Pipelines**, then select **Releases**.

    :::image type="content" source="../media/menu-item-releases-35bc93a6.png" alt-text="Screenshot of the menu item releases under pipelines.":::


2.  In the main screen area, select **New pipeline**.

    :::image type="content" source="../media/new-pipeline-7137986e.png" alt-text="Screenshot of new pipeline creation option.":::


3.  In the **Select a template** pane, see the available templates, but then select the **Empty job** option at the top. It's because we're going to focus on selecting an artifact source.
4.  In the **Artifacts** section, select **+Add an artifact**.
5.  See the available options in the **Add an artifact** pane, and select the option to see **more artifact types**, so that you can see all the available artifact types:

    :::image type="content" source="../media/artifact-types-1e08a53d.png" alt-text="Screenshot of add an artifact with multiple options.":::


While we're in this section, let's briefly look at the available options.

6.  Select **Build** and see the parameters required. This option is used to retrieve artifacts from an Azure DevOps Build pipeline. Using it requires a project name and a build pipeline name. (Projects can have multiple build pipelines). It's the option that we'll use shortly.

    :::image type="content" source="../media/build-parameters-8cca759c.png" alt-text="Screenshot of build parameters with project and source fields.":::


7.  Select **Azure Repository** and see the parameters required. It requires a project name and asks you to select the source repository.

    :::image type="content" source="../media/azure-repository-parameters-fdc7d3fc.png" alt-text="Screenshot of Azure repository parameters with project and source.":::


8.  Select **GitHub** and see the parameters required. The **Service** is a connection to the GitHub repository. It can be authorized by either OAuth or by using a GitHub personal access token. You also need to select the source repository.

    :::image type="content" source="../media/github-parameters-8f3ca1d3.png" alt-text="Screenshot of GitHub service connection configuration.":::


9.  Select **TFVC** and see the parameters required. It also requires a project name and asks you to select the source repository.

    :::image type="content" source="../media/team-foundation-version-control-parameters-e411a888.png" alt-text="Screenshot of Team Foundation Version Control parameters.":::


> [!NOTE]
> *A release pipeline can have more than one set of artifacts as input. A typical example is when you also need to consume a package from a feed and your project source.*

10. Select **Azure Artifacts** and see the parameters required. It requires you to identify the feed, package type, and package.

    :::image type="content" source="../media/azure-artifacts-parameters-b1774ea6.png" alt-text="Screenshot of Azure Artifacts parameters requirement.":::


11. Select **GitHub Release** and see the parameters required. It requires a service connection and the source repository.

    :::image type="content" source="../media/github-release-parameters-29d0ed7e.png" alt-text="Screenshot of GitHub release parameters requirement.":::


> [!NOTE]
> *We'll discuss service connections later in the module.*

12. Select **Azure Container Registry** and see the parameters required. Again, it requires a secure service connection, and the Azure Resource Group details that the container registry is located. It allows you to provide all your Docker containers directly into your release pipeline.

    :::image type="content" source="../media/azure-container-registry-parameters-54548e2f.png" alt-text="Screenshot of service connection and container registry parameters.":::


13. Select **Docker Hub** and see the parameters required. This option would be helpful if your containers are stored in Docker Hub rather than in an Azure Container Registry. After choosing a secure service connection, you need to select the namespace and the repository.

    :::image type="content" source="../media/docker-hub-parameters-dc256028.png" alt-text="Screenshot of Docker Hub parameters requirements.":::


14. Finally, select **Jenkins** and see the parameters required. You don't need to get all your artifacts from Azure. You can retrieve them from a Jenkins build. So, if you have a Jenkins Server in your infrastructure, you can use the build artifacts from there directly in your Azure Pipelines.

    :::image type="content" source="../media/jenkins-parameters-aa10db26.png" alt-text="Screenshot of Jenkins parameters requirements.":::


## Configuring the build artifact

Let's return to adding our Build output as the artifact source.

15. Select the **Build** source type again. See that the Project should show the current project. From the **Source (build pipeline)** drop-down list, select **Parts Unlimited-ASP.NET-CI**. Take a record of the default values for the other options, and then select **Add**.

    :::image type="content" source="../media/build-artifact-configured-009b13b3.png" alt-text="Screenshot of Build artifact configured and ready to run.":::


    We've now added the artifacts that we'll need for later walkthroughs.

    :::image type="content" source="../media/artifact-added-5388057e.png" alt-text="Screenshot of Artifacts added to the pipeline.":::


16. To save the work, select **Save**, then in the Save dialog box, select **OK**.
