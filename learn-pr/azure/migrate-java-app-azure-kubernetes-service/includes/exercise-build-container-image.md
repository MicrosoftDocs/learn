For this exercise, we will use Azure Container Registry and its features to build and store the container images. 

Azure Container Registry allows you to build, store, and manage container images and artifacts in a private registry for all types of container deployments. Azure Migrate: App Containerization uses Azure Container Registry Tasks to build container images in Azure on-demand and then store those images.

## Build container image

1. **Create Azure Container Registry**: Create a new Azure Container Registry to build and store the container images for the apps. Select the **create new registry** option to create a new ACR **learnappcontainerizationacr**.

   :::image type="content" source="../media/build-java-app.png" alt-text="Screenshot for app ACR selection.":::

2. **Configure Application Insights**: You can enable monitoring for your Java apps without instrumenting your code. The tool will install the Java standalone agent as part of the container image. Once configured during deployment, the Java agent will automatically collect a multitude of requests, dependencies, logs, and metrics for your application that can be used for monitoring with Application Insights. This option is enabled by default for all Java applications and we'll leave it as is. 

3. **Review the Dockerfile**: The Dockerfile needed to build the container images for each selected application is generated at the beginning of the build step. Click **Review** to review the Dockerfile. You can also add any necessary customizations to the Dockerfile in the review step and save the changes before starting the build process. We'll not be making any changes to the Dockerfile in this exercise.

4. **Trigger build process**: Select the application for which the images need to be built and select **Build**. Clicking build will start the container image build for each application. The tool keeps monitoring the build status continuously and will let you proceed to the next step upon successful completion of the build.

5. **Track build status**: You can also monitor progress of the build step by clicking the **Build in Progress** link under the status column. The link takes a couple of minutes to be active after you've triggered the build process.  

6. Once the build is completed, select **Continue** to specify deployment settings. 

