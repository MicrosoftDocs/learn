We talked about the concepts behind the pipeline, CI, and Docker. Now, it's time to put these concepts into practice.

Let's review our designed pipeline:

:::image type="content" source="../media/3-pipeline-5-deploy.png" alt-text="Diagram that depicts the procession from triggers, through three build steps, to the deploy step in a pipeline.":::

You'll build this pipeline by using the GitHub Actions workflow.

## Build the Action workflow

1. To start building your pipeline, go to the fork of the sample repository in the GitHub website and select the **Actions** tab.

    :::image type="content" source="../media/6-1-actions-tab.png" alt-text="Screenshot that shows the Get started with GitHub Actions page on the GitHub website.":::

1. Just below the header, select the **Set up a workflow yourself** link. A new editor with a file in it should open.

    :::image type="content" source="../media/6-2-example-editor.png" alt-text="Screenshot that shows an example file being edited in the Edit new file pane on the GitHub website.":::

    At this point, the pipeline is just a file in the .github/workflows directory in your repository.

    GitHub provides you with the prebuilt components you need to build most of the pipelines. You'll have a workflow file like this example:

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
          # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
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

1. In the top input panel, rename the file build-latest.yml.

1. Change the `name` key to **Build and push the latest build to staging**. 

   Your file now will look like this example:

   ```yaml
   # This is a basic workflow to help you get started with Actions

   name: Build and push the latest build to staging
   ```

### Create the trigger

1. Change the default triggers in the `on` key.

    The default file comes with two triggers:

    * Any push to the `main` branch.

    *Any pull request on the `main` branch.

    Remove the second trigger and leave only the `push` tags. 
    
    The keys should look like this example:

    ```yaml
    name: Build and push the latest build to staging

    on:
      push:
        branches: [ main ]
    ```

    Running this command closes the second trigger in the pipeline design diagram.

### Build and push the image

1. Let's work on the jobs you're going to run.

    In this process, you address both the build steps and the deploy steps from the diagram.

    GitHub workflows are divided into jobs. Jobs are divided into steps. Each step can have multiple commands and use multiple actions to be executed.

    The `jobs` key is already set to run on `ubuntu-latest`, which is the environment where you want this workflow to run.

1. Rename the `build` key to `build_push_image`.

1. In the `steps` key, delete the last two commands, which are only examples from the template. Your file will look like this example:

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

    You already have a step that uses the `checkout` action. This action is responsible for cloning the repository into the job environment.

    This step is equivalent to the first action (clone the repo) in the build steps in the diagram.

    Next, add another action to build your Docker image.

1. In the right panel, search for **Build and push Docker images**. Select the first result published by **Docker**.

    :::image type="content" source="../media/6-3-docker-action.png" alt-text="Screenshot that shows the search results that list Build and push Docker images.":::

    In the opened panel, select the copy icon to copy the usage YAML.

    :::image type="content" source="../media/6-4-docker-copy.png" alt-text="Screenshot that shows the copy icon selected in the Build and push Docker images pane.":::

1. Paste the copied YAML below the `- uses: actions/checkout@v2` key. Your YAML file should look like the following example:

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
            # You may pin to the exact commit or the version.
            # uses: docker/build-push-action@ab83648e2e224cfeeab899e23b639660765c3a89
            uses: docker/build-push-action@v1.1.1
            with:
              # Username used to log in to a Docker registry. If not set then no login will occur
              username: # optional
              # Password or personal access token used to log in to a Docker registry. If not set then no login will occur
              password: # optional
              # Server address of Docker registry. If not set then will default to Docker Hub
              registry: # optional
              # Docker repository to tag the image with
              repository:
              # Comma-delimited list of tags. These will be added to the registry/repository to form the image's tags
              tags: # optional
              # Automatically tags the built image with the git reference as per the readme
              tag_with_ref: # optional
              # Automatically tags the built image with the git short SHA as per the readme
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
              # Adds labels with git repository information to the built image
              add_git_labels: # optional
              # Whether to push the image
              push: # optional, default is true
    ```

    > [!IMPORTANT]
    > Be mindful of the indentation when using YAML. The `name` key should be aligned with the previous `uses` key.

    This action gives us several options to tweak the usage. You can learn more about each one of them in the [GitHub build-push-action documentation](https://github.com/docker/build-push-action/tree/releases/v1).

1. In the `name` key, rename the value **Build and push staging image**.

1. You'll use only a handful of the parameters available for this action. Set the following actions and delete the others.

    Add the values according to the following table:

    |Key name     |Value                                           |
    |-------------|------------------------------------------------|
    |username     |`${{ secrets.ACR_LOGIN }}`                      |
    |password     |`${{ secrets.ACR_PASSWORD }}`                   |
    |registry     |`${{ secrets.ACR_NAME }}`                       |
    |repository   |contoso-website                                 |
    |tags         |latest                                          |

    You can delete all the other keys because we won't use them in this exercise.
    
    Your file should look like the following example:

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

1. To commit the changes, select the green **Start commit** button at the top right. Enter a description for the commit, and then select the **Commit new file** button:

  :::image type="content" source="../media/6-5-commit-staging.png" alt-text="Screenshot that shows the Start commit and Commit new file button in the Commit new file pane.":::

Selecting the **Commit new file** button triggers a new build to start on the **Actions** tab. This build will fail because you haven't set the secrets yet!

:::image type="content" source="../media/6-6-first-build.png" alt-text="Screenshot that shows the failed build results for build_push_image.":::

### Set the secrets

1. On the repository start page, select the **Settings** tab. Scroll down and select **Secrets** in the left menu.

1. Select the **New secret** button at the top right.

1. Create the `ACR_NAME` secret:

    1. For **Name**, enter **ACR_NAME**.
    1. Run the following command in the Azure Cloud Shell to obtain the login server of the Container Registry instance you created earlier:

    ```azurecli-interactive
    az acr list --query "[?contains(resourceGroup, 'mslearn-gh-pipelines')].loginServer" -o table
    ```

    1. For **Value**, enter value of the secret.

1. Create `ACR_LOGIN` secret:

    1. Put `ACR_LOGIN` in the **Name** field.

    1. If you saved the values presented to you in the end of the set-up script, copy the **ACR Login Username** value. If not, run the following command in the Azure Cloud Shell to obtain the login of the ACR you created earlier.

    ```azurecli-interactive
    az acr credential show --name <ACR_NAME> --query "username" -o table
    ```

    1. Put the value in the **Value** field of the secret

1. Create `ACR_PASSWORD` secret

    1. Put `ACR_PASSWORD` in the **Name** field.

    1. If you saved the values presented to you in the end of the set-up script, copy the **ACR Login Password** value. If not, run the following command in the Azure Cloud Shell to obtain the login of the ACR you created earlier.

    ```azurecli-interactive
    az acr credential show --name <ACR_NAME> --query "passwords[0].value" -o table
    ```

    1. Put the value in the **Value** field of the secret

### Push the image

1. Go back to the **Actions** tab

1. Click the only execution in the list

1. Click on the **Rerun jobs** in the right-hand side of the screen and then "Rerun all jobs"

    :::image type="content" source="../media/6-7-rerun-jobs.png" alt-text="Rerun all jobs":::

1. Run `az acr repository list --name <ACR_NAME> -o table` in the Azure Cloud Shell to confirm there's a repository named `contoso-website` listed in the results
    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)
