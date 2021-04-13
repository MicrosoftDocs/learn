We talked about the concepts behind the pipeline, CI, and Docker. Now, it's time to put these concepts into practice.

Let's review our designed pipeline:

:::image type="content" source="../media/3-pipeline-5-deploy.png" alt-text="Diagram that shows the procession from triggers, through three build steps, to the deploy steps in a pipeline.":::

You'll build this pipeline by using the GitHub Actions workflow.

In this exercise, you'll:
- Build the Actions workflow
- Create the trigger
- Build and push the image
- Set the secrets
- Push the image

## Build the Actions workflow

1. To start building your pipeline, go to the fork of the sample repository in the GitHub website. Select the **Actions** tab.

1. Below the header, select **set up a workflow yourself**.

    :::image type="content" source="../media/6-1-actions-tab.png" alt-text="Screenshot that shows the Get started with GitHub Actions page on the GitHub website.":::

    At this point, the pipeline is just a file in the .github/workflows directory in your repository. GitHub provides the prebuilt components that you need to build most of the pipelines. You'll have a workflow file that looks like this example:

    ```yaml
    # This is a basic workflow to help you get started with Actions

    name: CI

    # Controls when the action will run. Triggers the workflow on push or pull request
    # events but only for the main branch
    on:
      push:
        branches: [ main ]
      pull_request:
        branches: [ main ]

    # A workflow run is made up of one or more jobs that can run sequentially or in parallel
    jobs:
      # This workflow contains a single job called "build"
      build:
        # The type of runner that the job will run on
        runs-on: ubuntu-latest

        # Steps represent a sequence of tasks that will be executed as part of the job
        steps:
          # Checks out your repository under $GITHUB_WORKSPACE, so your job can access it
          - uses: actions/checkout@v2

          # Runs a single command using the runners shell
          - name: Run a one-line script
            run: echo Hello, world!

          # Runs a set of commands using the runners shell
          - name: Run a multi-line script
            run: |
              echo Add other actions to build,
              echo test, and deploy your project.
    ```

1. Above the **Edit new file** pane, rename the file from **main.yml** to **build-staging.yml**.

    :::image type="content" source="../media/6-2-example-editor.png" alt-text="Screenshot that shows an example file being edited in the Edit new file pane on the GitHub website.":::

1. Change the `name` key to `Build and push the latest build to staging`. 

   Now, your file should look like this example:

   ```yaml
   # This is a basic workflow to help you get started with Actions

   name: Build and push the latest build to staging
   ```

## Create the trigger

The default file comes with two triggers:

* Any push to the main branch.

* Any pull request on the main branch.

1. Change the default triggers in the `on` key.

1. Remove the second trigger and leave only the `push` tags. 
    
    The keys should look like this example:

    ```yaml
    name: Build and push the latest build to staging

    on:
      push:
        branches: [ main ]
    ```

    Running this command closes the second trigger in the pipeline design diagram.

## Build and push the image

Let's work on the jobs you're going to run. In this process, you address both the build steps and the deploy steps that are shown in the pipeline design diagram.

GitHub workflows are divided into jobs, and jobs are divided into steps. Each step can have multiple commands and use multiple actions to be executed.

The `jobs` key is already set to run on `ubuntu-latest`, which is the environment where you want this workflow to run.

1. Rename the `build` key `build_push_image`.

1. In the `steps` key, delete the last two commands, which are only examples from the template. 

   Your file should look like this example:

    ```yaml
    name: Build and push the latest build to staging

    on:
      push:
        branches: [ main ]

    jobs:
      build_push_image:
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v2
    ```

    You already have a step that uses the `checkout` action. This action clones the repository into the job environment.

    This step is equivalent to the first action (clone the repo) in the build steps in the pipeline design diagram.

    Next, add another action to build your Docker image.

1. In the right panel, search for **Build and push Docker images**. Select the first result published by **Docker**.

    :::image type="content" source="../media/6-3-docker-action.png" alt-text="Screenshot that shows the search results that list Build and push Docker images.":::

    In the panel for the search result item, under **Installation**, select the copy icon to copy the usage YAML.

    :::image type="content" source="../media/6-4-docker-copy.png" alt-text="Screenshot that shows the copy icon selected in the Build and push Docker images pane.":::

1. Paste the copied YAML below the `- uses: actions/checkout@v2` key. 

    Your YAML file should look like this example:

    ```yaml
    name: Build and push the latest build to staging

    on:
      push:
        branches: [ main ]

    jobs:
      build_push_image:
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v2

          - name: Build and push Docker images
            # You can pin to the exact commit or the version.
            # uses: docker/build-push-action@ab83648e2e224cfeeab899e23b639660765c3a89
            uses: docker/build-push-action@v1.1.1
            with:
              # Username used to log in to a Docker registry. If not set, no login occurs
              username: # optional
              # Password or personal access token used to log in to a Docker registry. If not set, no login occurs
              password: # optional
              # Server address of Docker registry. If not set, login defaults to Docker Hub
              registry: # optional
              # Docker repository to tag the image with
              repository:
              # Comma-delimited list of tags. These are added to the registry/repository to form the image's tags
              tags: # optional
              # Automatically tags the built image with the Git reference as per the readme
              tag_with_ref: # optional
              # Automatically tags the built image with the Git short SHA as per the readme
              tag_with_sha: # optional
              # Path to the build context
              path: # optional, default is .
              # Path to the Dockerfile (Default is '{path}/Dockerfile')
              dockerfile: # optional
              # Sets the target stage to build
              target: # optional
              # Always attempt to pull a newer version of the image
              always_pull: # optional
              # Comma-delimited list of build-time variables
              build_args: # optional
              # Comma-delimited list of images to consider as cache sources
              cache_froms: # optional
              # Comma-delimited list of labels to add to the built image
              labels: # optional
              # Adds labels with Git repository information to the built image
              add_git_labels: # optional
              # Whether to push the image
              push: # optional, default is true
    ```

    > [!IMPORTANT]
    > Be careful with indentation when you use YAML. The `name` key should be aligned with the preceding `uses` key.

    You can adjust usage for this action. For more information, see the [GitHub build-push-action documentation](https://github.com/docker/build-push-action/tree/releases/v1?azure-portal=true).

1. Rename the `name` key `Build and push staging image`.

1. You'll use only a handful of the parameters that are available for this action. Set the following actions and delete the others.

    Add the values according to the following table:

    |Key name     |Value                                           |
    |-------------|------------------------------------------------|
    |username     |`${{ secrets.ACR_LOGIN }}`                      |
    |password     |`${{ secrets.ACR_PASSWORD }}`                   |
    |registry     |`${{ secrets.ACR_NAME }}`                       |
    |repository   |contoso-website                                 |
    |tags         |latest                                          |

    You can delete all the other keys because we won't use them in this exercise.
    
    Your file should look like this example:

    ```yaml
    name: Build and push the latest build to staging

    on:
      push:
        branches: [ main ]

    jobs:
      build_push_image:
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v2

          - name: Build and push staging image
            uses: docker/build-push-action@v1.1.1
            with:
              username: ${{ secrets.ACR_LOGIN }}
              password: ${{ secrets.ACR_PASSWORD }}
              registry: ${{ secrets.ACR_NAME }}
              repository: contoso-website
              tags: latest
    ```

1. To commit the changes, select the green **Start commit** button. Enter a description for the commit, and then select the **Commit new file** button:

    :::image type="content" source="../media/6-5-commit-staging.png" alt-text="Screenshot that shows the Start commit and Commit new file buttons in the Commit new file pane.":::

    Selecting the **Commit new file** button triggers a new build to start on the **Actions** tab. This build will fail because you haven't set the secrets yet!

    :::image type="content" source="../media/6-6-first-build.png" alt-text="Screenshot that shows the failed build results for build_push_image.":::

## Set the secrets

1. On the repository start page, select the **Settings** tab. In the menu, select **Secrets**.

1. Select **New secret**.

1. Create the `ACR_NAME` secret:

    1. For **Name**, enter **ACR_NAME**.

    1. Run the following command in Cloud Shell to get the sign-in information of the Container Registry instance you created earlier:

       ```azurecli-interactive
       az acr list --query "[?contains(resourceGroup, 'mslearn-gh-pipelines')].loginServer" -o table
       ```

    1. For **Value**, enter value of the secret.

1. Create the `ACR_LOGIN` secret:

    1. For **Name**, enter **ACR_LOGIN**.

    1. If you saved the values that were shown at the end of the setup script, copy the **ACR Login Username** value. If you didn't save the values, run the following command in Cloud Shell to get the sign-in information of the Container Registry instance you created earlier:

       ```azurecli-interactive
       az acr credential show --name <ACR_NAME> --query "username" -o table
       ```

    1. For **Value**, enter the value of the secret.

1. Create the `ACR_PASSWORD` secret:

    1. For **Name**, enter **ACR_PASSWORD**.

    1. Copy the **ACR Login Password** value or run the following command in Cloud Shell to get the sign-in information of the Container Registry instance you created earlier:

       ```azurecli-interactive
       az acr credential show --name <ACR_NAME> --query "passwords[0].value" -o table
       ```

    1. For **Value**, enter the value of the secret.

## Push the image

1. Select the **Actions** tab.

1. Select the only execution in the list.

1. On the right side, select **Rerun jobs**, and then select **Rerun all jobs**.

    :::image type="content" source="../media/6-7-rerun-jobs.png" alt-text="Screenshot that shows the Rerun jobs and Rerun all jobs buttons.":::

1. In Cloud Shell, run `az acr repository list --name <ACR_NAME> -o table` to confirm that a repository named `contoso-website` appears in the results.
    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)
