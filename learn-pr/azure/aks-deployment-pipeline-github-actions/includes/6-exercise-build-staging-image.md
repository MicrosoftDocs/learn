In this unit, you create your GitHub Actions staging pipeline by building the application image and pushing it to Azure Container Registry.

The following image shows the CI/CD pipeline you designed:

:::image type="content" source="../media/3-pipeline-5-deploy.png" alt-text="Diagram that shows the procession from triggers, through three build steps, to the deploy steps in a pipeline.":::

In this exercise, you create the staging pipeline by doing the following steps:

- Create the GitHub Actions workflow.
- Create the `on push` trigger.
- Build and push the application image.
- Set secrets.
- Run the job.

## Create the GitHub Actions workflow

GitHub workflows are divided into jobs, and jobs are divided into steps. Each step can have multiple commands and use multiple actions to execute.

To start building your pipeline, go to your fork of the sample repository in the GitHub website.

1. Select the **Actions** tab.

1. Select the link to **set up a workflow yourself**.

    :::image type="content" source="../media/6-1-actions-tab.png" alt-text="Screenshot that shows the Get started with GitHub Actions page on the GitHub website.":::

    At this point, the pipeline is just a blank file in the *.github/workflows* directory in your repository. GitHub provides the prebuilt components that you need to build most of the pipelines. To get started, copy and paste the following code into the **Edit new file** pane:

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

1. Above the **Edit new file** pane, rename the file from *main.yml* to *build-staging.yml*.

    :::image type="content" source="../media/6-2-example-editor.png" alt-text="Screenshot that shows an example file being edited in the Edit new file pane on the GitHub website.":::

1. Change the `name` key from `CI` to `Build and push the latest build to staging`.

    ```yaml
    # This is a basic workflow to help you get started with Actions
    
    name: Build and push the latest build to staging
    ```

### Modify the 'on' trigger

The basic workflow template comes with two triggers:

- Any push to the main branch.
- Any pull request on the main branch.

You don't need the pipeline to run on a pull request, so modify it to keep only the push trigger by changing the triggers in the `on` key. Remove the second trigger and leave only the `push` tags.

```yaml
name: Build and push the latest build to staging

on:
  push:
    branches: [ main ]
```

### Configure the checkout step

Next, start working on the job steps. In this process, you implement both the build tasks and the deploy tasks in your pipeline design diagram.

1. Under `jobs`, rename the `build` key to `build_push_image`.

1. You want this workflow to run on Ubuntu 20.04, so change the `runs-on` key from `ubuntu-latest` to `ubuntu-20.04`.

1. Delete the last two commands in the `steps` key, which are just examples for the template.

    Your file, without the comments, should look like this example:

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

You now have a step that uses the `checkout` action. This action clones the repository into the job environment. This step is equivalent to the first action, **Clone repo**, in the pipeline design diagram.

### Add Docker steps

Next, add actions to build your Docker image. You can adjust usage for these actions. This example uses only a few of the parameters available. For more information, see the [GitHub build-push-action documentation](https://github.com/docker/build-push-action/tree/v2?azure-portal=true).

1. In the **Marketplace** tab in the right panel, search for *docker login*, and select the first result published by **docker**.
  
    :::image type="content" source="../media/6-3-docker-login.png" alt-text="Screenshot showing the search results listing Docker Login.":::

    > [!NOTE]
    > Docker actions prior to version 2 had the login flow built-in, but on versions 2 and above, these actions are separated, so you need two actions to set the workflow correctly.

1. Under **Installation**, select the copy icon to copy the usage YAML.

    :::image type="content" source="../media/6-3-docker-login-copy.png" alt-text="Screenshot showing the copy function and selecting the Docker Login task.":::

1. Paste the copied YAML below the `actions/checkout@v2` action.

    > [!IMPORTANT]
    > Be careful with indentation when you use YAML. The `name` key should be aligned with the preceding `uses` key.

1. Add the following values to the `registry`, `username`, and `password` keys:

   - `registry`: `${{ secrets.ACR_NAME }}`
   - `username`: `${{ secrets.ACR_LOGIN }}`
   - `password`: `${{ secrets.ACR_PASSWORD }}`

1. Delete the other keys, because they aren't used in this exercise.

1. In the right panel under **Marketplace**, search for *build and push docker images*, and select the first result published by **docker**.

    :::image type="content" source="../media/6-3-docker-action.png" alt-text="Screenshot that shows the search results that list Build and push Docker images.":::

1. Under **Installation**, select the copy icon to copy the usage YAML.

1. Paste the copied YAML below the last key from the previously copied `docker-login` action.

1. Rename the `name` key from `Build and push Docker images` to `Build and push staging images`.

1. Add the following values to the `context`, `push`, and `tags` keys:

   - `context`: `.`
   - `push`: `true`
   - `tags`: `${{secrets.ACR_NAME}}/contoso-website:latest`

1. Delete the other keys, because they aren't used in this exercise.

1. Add another action called `docker/setup-buildx-action` between the checkout action and the login action, to set up the build engine for Docker to use. Copy the following snippet and paste it between the `checkout` and `login` actions.

    ```yml
    - name: Set up Buildx
      uses: docker/setup-buildx-action@v3.0.0
    ```

    Your final file, without the comments, should look like the following example:

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
            uses: docker/setup-buildx-action@v3.0.0

          - name: Docker Login
            uses: docker/login-action@v3.0.0
            with:
              registry: ${{ secrets.ACR_NAME }}
              username: ${{ secrets.ACR_LOGIN }}
              password: ${{ secrets.ACR_PASSWORD }}

          - name: Build and push staging images
            uses: docker/build-push-action@v5.0.0
            with:
              context: .
              push: true
              tags: ${{secrets.ACR_NAME}}/contoso-website:latest
    ```

### Commit the changes

To commit your changes, select the **Commit changes** button at upper right. On the **Commit changes** screen, enter a description for the commit, and then select **Commit changes**.

:::image type="content" source="../media/6-5-commit-staging.png" alt-text="Screenshot that shows the Commit changes button in the Commit changes pane.":::

Selecting **Commit changes** triggers a new build, but this build fails because you haven't set the secrets yet.

## Set the secrets

To set the secrets, on your GitHub repository page, select the **Settings** tab, and then select **Secrets and variables** > **Actions** from the left menu. Define the following secrets that your workflow uses:

- `ACR_NAME`: The `ACR_Name` value returned by the setup script
- `ACR_LOGIN`: The `ACR Login Username` value returned by the setup script
- `ACR_PASSWORD`: The `ACR Login Password` value returned by the setup script
- `RESOURCE_GROUP`: The `Resource Group Name` value returned by the setup script
- `CLUSTER_NAME`: *contoso-video*

To define each secret:

1. Select **New repository secret**.
1. For **Name**, enter the secret name from the preceding list.
1. For **Secret**, enter the value you saved from the setup script, or run a Cloud Shell query to get the value.
1. Select **Add secret**.

### Run optional queries to get the secrets values

If you don't have the values the setup script returned, you can run the following commands in Azure Cloud Shell to get the information:

- `ACR_NAME`:

  ```azurecli-interactive
  az acr list --query "[?contains(resourceGroup, 'mslearn-gh-pipelines')].loginServer" -o table
  ```

- `ACR_LOGIN`:

  ```azurecli-interactive
  az acr credential show --name <ACR_NAME> --query "username" -o table
  ```

- `ACR_PASSWORD`:

  ```azurecli-interactive
  az acr credential show --name <ACR_NAME> --query "passwords[0].value" -o table
  ```

- `RESOURCE_GROUP`:

  ```azurecli-interactive
  az aks list -o tsv --query "[?name=='contoso-video'].resourceGroup"
  ```

## Run the job

1. Select the **Actions** tab.

1. Select the only execution in the list, the failed **build-staging.yml** job.

1. At upper right, select **Re-run jobs** > **Re-run all jobs**, and on the **Re-run all jobs** screen, select **Re-run jobs**.

    :::image type="content" source="../media/6-7-rerun-jobs.png" alt-text="Screenshot that shows the Re-run jobs and Re-run all jobs buttons.":::

1. When the build completes, run `az acr repository list --name <ACR_NAME> -o table` in [Cloud Shell](https://shell.azure.com/) to confirm that the `contoso-website` Container Registry repository appears in the results.

Continue to the next unit to build your production workflow.
