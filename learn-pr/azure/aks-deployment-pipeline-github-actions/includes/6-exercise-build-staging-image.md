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

    At this point, the pipeline is just a file in the `.github/workflows` directory in your repository. GitHub provides the prebuilt components that you need to build most of the pipelines. You'll have a workflow file that looks like this example:

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

1. Above the **Edit new file** pane, rename the file from `main.yml` to `build-staging.yml`.

    :::image type="content" source="../media/6-2-example-editor.png" alt-text="Screenshot that shows an example file being edited in the Edit new file pane on the GitHub website.":::

1. Change the `name` key to `Build and push the latest build to staging`.

   Now, your file should look like this example:

   ```yaml
   # This is a basic workflow to help you get started with Actions

   name: Build and push the latest build to staging
   ```

## Create the trigger

The default file comes with two triggers:

- Any push to the main branch.
- Any pull request on the main branch.

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

The `jobs` key is set to run on `ubuntu-latest`, let's fix that version to `ubuntu-20.04` which is the environment you want this workflow to run in.

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
        runs-on: ubuntu-20.04

        steps:
          - uses: actions/checkout@v2
    ```

    You already have a step that uses the `checkout` action. This action clones the repository into the job environment.

    This step is equivalent to the first action (clone the repo) in the build steps in the pipeline design diagram.

    Next, add other actions to build your Docker image.

1. In the right panel, search for **Docker Login**. Select the first result published by **Docker**.
    
    :::image type="content" source="../media/6-3-docker-login.png" alt-text="Screenshot showing the search results listing Docker Login.":::

    In the panel for the search result item, under **Installation**, select the copy icon to copy the usage YAML.

    :::image type="content" source="../media/6-3-docker-login-copy.png" alt-text="Screenshot showing the copy function and selecting the Docker Login task.":::

    > [!NOTE]
    > Docker action prior to version 2 had the login flow built-in. However, on versions 2 and above, these actions were separated. This is why we need two actions to set the entire workflow correctly.

    ```yml
    name: Build and push the latest build to staging

    on:
      push:
        branches: [ main ]

    jobs:
      build_push_image:
        runs-on: ubuntu-20.04

        steps:
          - uses: actions/checkout@v2

          - name: Docker Login
            # You may pin to the exact commit or the version.
            # uses: docker/login-action@f3364599c6aa293cdc2b8391b1b56d0c30e45c8a
            uses: docker/login-action@v1
            with:
              # Server address of Docker registry. If not set then will default to Docker Hub
              registry: # optional
              # Username used to log against the Docker registry
              username: # optional
              # Password or personal access token used to log against the Docker registry
              password: # optional
              # Log out from the Docker registry at the end of a job
              logout: # optional, default is true
    ```

1. Again, in the right panel, search for **Build and push Docker images**. Select the first result published by **Docker**.

    :::image type="content" source="../media/6-3-docker-action.png" alt-text="Screenshot that shows the search results that list Build and push Docker images.":::

    In the panel for the search result item, under **Installation**, select the copy icon to copy the usage YAML.

    :::image type="content" source="../media/6-3-docker-action-copy.png" alt-text="Screenshot that shows the copy icon after selecting the task.":::

    Paste the copied YAML below the last key from the previously copied `docker-login` action.

    Your YAML file should look like this example:

    ```yaml
    name: Build and push the latest build to staging

    on:
      push:
        branches: [ main ]

    jobs:
      build_push_image:
        runs-on: ubuntu-20.04

        steps:
          - uses: actions/checkout@v2

          - name: Docker Login
            # You may pin to the exact commit or the version.
            # uses: docker/login-action@f3364599c6aa293cdc2b8391b1b56d0c30e45c8a
            uses: docker/login-action@v1
            with:
              # Server address of Docker registry. If not set then will default to Docker Hub
              registry: # optional
              # Username used to log against the Docker registry
              username: # optional
              # Password or personal access token used to log against the Docker registry
              password: # optional
              # Log out from the Docker registry at the end of a job
              logout: # optional, default is true

          - name: Build and push Docker images
            # You may pin to the exact commit or the version.
            # uses: docker/build-push-action@e1b7f96249f2e4c8e4ac1519b9608c0d48944a1f
            uses: docker/build-push-action@v2
            with:
              # Here we'll have a list of parameters
    ```

    > [!IMPORTANT]
    > Be careful with indentation when you use YAML. The `name` key should be aligned with the preceding `uses` key.

    You can adjust usage for this action. For more information, see the [GitHub build-push-action documentation](https://github.com/docker/build-push-action/tree/v2?azure-portal=true).

1. Rename the `name` key `Build and push staging image`.

1. You'll use only a handful of the parameters that are available for these actions.

    Add the values according to the following table:

    |Key name     | Used on action |Value                                           |
    |-------------|--------|------------------------------------------------|
    |username     |`docker/login`|`${{ secrets.ACR_LOGIN }}`                      |
    |password     |`docker/login`|`${{ secrets.ACR_PASSWORD }}`                   |
    |registry     |`docker/login`|`${{ secrets.ACR_NAME }}`                       |
    |repository   |`docker/build-and-push`|contoso-website                                 |
    |tags         |`docker/build-and-push`|latest                                          |
    |context      |`docker/build-and-push`|`.`                                             |
    |push      |`docker/build-and-push`|`true`                                             |

    You can delete all the other keys because we won't use them in this exercise.

    Your file should look like this example:

    ```yaml
    name: Build and push the latest build to staging

    on:
      push:
        branches: [ main ]

    jobs:
      build_push_image:
        runs-on: ubuntu-20.04

        steps:
          - uses: actions/checkout@v2

          - name: Docker Login
            uses: docker/login-action@v1
            with:
              registry: ${{ secrets.ACR_NAME }}
              username: ${{ secrets.ACR_LOGIN }}
              password: ${{ secrets.ACR_PASSWORD }}

          - name: Build and push staging images
            uses: docker/build-push-action@v2
            with:
              context: .
              tags: ${{secrets.ACR_NAME}}/contoso-website:latest
              push: true
    ```

1. Before you save the file, we'll also add another action between the checkout action and the login action to set up the build engine for Docker to use. This action is called `docker/setup-buildx-action` and you'll use `v1`.

    To set this action, copy the below snippet and paste it between the checkout and the login actions.

    ```yml
    - name: Set up Buildx
      uses: docker/setup-buildx-action@v1
    ```

    Your final file should be like this:

    ```yaml
    name: Build and push the latest build to staging

    on:
      push:
        branches: [ main ]

    jobs:
      build_push_image:
        runs-on: ubuntu-20.04

        steps:
          - uses: actions/checkout@v2

          - name: Set up Buildx
            uses: docker/setup-buildx-action@v1

          - name: Docker Login
            uses: docker/login-action@v1
            with:
              registry: ${{ secrets.ACR_NAME }}
              username: ${{ secrets.ACR_LOGIN }}
              password: ${{ secrets.ACR_PASSWORD }}

          - name: Build and push staging images
            uses: docker/build-push-action@v2
            with:
              context: .
              tags: ${{secrets.ACR_NAME}}/contoso-website:latest
              push: true
    ```

1. To commit the changes, select the **Start commit** button. Enter a description for the commit, and then select the **Commit new file** button:

    :::image type="content" source="../media/6-5-commit-staging.png" alt-text="Screenshot that shows the Start commit and Commit new file buttons in the Commit new file pane.":::

    Selecting the **Commit new file** button triggers a new build to start on the **Actions** tab. This build will fail because you haven't set the secrets yet!

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
