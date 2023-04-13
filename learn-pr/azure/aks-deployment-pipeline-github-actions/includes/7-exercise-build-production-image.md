In the preceding exercise, you built the staging workflow for building and publishing the image. Let's recap the production workflow:

:::image type="content" source="../media/3-pipeline-5-deploy.png" alt-text="Diagram that shows the procession from triggers, through three build steps, to the deploy steps in a pipeline.":::

You'll build the tagged version by using a different workflow.

In this exercise, you'll:

- Build the Actions workflow
- Create the trigger
- Build and push the image
- Check the results

## Build the Actions workflow

1. To start building the pipeline, go to the fork of the sample repository in the GitHub website. Select the **Actions** tab.

1. Below the header, select **set up a workflow yourself**.

    :::image type="content" source="../media/6-1-actions-tab.png" alt-text="Screenshot that shows the Get started with GitHub Actions page and the Set-up a workflow yourself link on the GitHub website.":::

    Copy and paste this basic workflow into the **Edit new file** pane:

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

1. Above the **Edit new file** pane, rename the file from `main.yml` to `build-production.yml`.

    :::image type="content" source="../media/6-2-example-editor.png" alt-text="Screenshot that shows an example file being edited in the Edit new file pane on the GitHub website.":::

1. Change the `name` key to `Build and push the tagged build to production`.

   Your file should look like this example:

    ```yaml
    # This is a basic workflow to help you get started with Actions

    name: Build and push the tagged build to production
    ```

## Create the trigger

1. Change the default triggers in the `on` key.

1. Remove the second trigger and leave only the `push` tags.

    The keys should look like this example:

    ```yaml
    name: Build and push the tagged build to production

    on:
      push:
        branches: [ main ]
    ```

1. Remove the `branches` key and replace it with the `tags` key. This tag says that you'll run this workflow only on specific tags.

    ```yaml
    name: Build and push the tagged build to production

    on:
      push:
        tags:
          - 'v*'
    ```

    In this case, you'll run the workflow only if the tag follows the `v*` pattern, which includes `v1.0.0`.

## Build and push the image

Let's work on the jobs you're going to run. In this process, you address both the build steps and the deploy steps from the diagram.

The `jobs` key is set to run on `ubuntu-latest`, let's fix that version to `ubuntu-20.04`, which is the environment you want this workflow to run in.

1. Rename the `build` key `build_push_image`.

1. In the `steps` key, delete the last two commands, which are only examples from the template.

   Your file should look like this example:

    ```yaml
    name: Build and push the tagged build to production

    on:
      push:
        tags:
          - 'v*'

    jobs:
      build_push_image:
        runs-on: ubuntu-20.04

        steps:
          - uses: actions/checkout@v2
    ```

    Leave the `checkout` option like you did when you created the staging image.

1. Create a new step that will gather the necessary version information. You'll use the `::set-output` internal command to create this step. Add the following lines below the checkout action:

    ```yaml
    - name: Fetch latest version
      id: fetch_version
      run: echo ::set-output name=TAG::${GITHUB_REF#refs/tags/}
    ```

    Your YAML file should now look like this:

    ```yaml
    name: Build and push the tagged build to production

    on:
      push:
        tags:
          - 'v*'

    jobs:
      build_push_image:
        runs-on: ubuntu-20.04

        steps:
          - uses: actions/checkout@v2

          - name: Fetch latest version
            id: fetch_version
            run: echo ::set-output name=TAG::${GITHUB_REF#refs/tags/}
    ```

1. In the right panel, search for **Docker Login**. Select the first result published by **Docker**.

    :::image type="content" source="../media/6-3-docker-login.png" alt-text="Screenshot showing the search results listing Docker Login.":::

    In the panel for the search result item, under **Installation**, select the copy icon to copy the usage YAML.

    :::image type="content" source="../media/6-3-docker-login-copy.png" alt-text="Screenshot that shows the copy icon after selecting the task.":::

    > [!NOTE]
    > Docker action prior to version 2 had the login flow built-in. However, on versions 2 and above, these actions were separated. This is why we need two actions to set the entire workflow correctly.

    In the panel for the search result item, under **Installation**, select the copy icon to copy the usage YAML.

    Paste the copied YAML below the `Fetch latest version` action.

    Your YAML file should look like this example:

    ```yaml
    name: Build and push the tagged build to production

    on:
      push:
        tags:
          - 'v*'

    jobs:
      build_push_image:
        runs-on: ubuntu-20.04

        steps:
          - uses: actions/checkout@v2

          - name: Fetch latest version
            id: fetch_version
            run: echo ::set-output name=TAG::${GITHUB_REF#refs/tags/}

          - name: Docker Login
            # You may pin to the exact commit or the version.
            # uses: docker/login-action@f4ef78c080cd8ba55a85445d5b36e214a81df20a
            uses: docker/login-action@v2.1.0
            with:
              # Server address of Docker registry. If not set then will default to Docker Hub
              registry: # optional
              # Username used to log against the Docker registry
              username: # optional
              # Password or personal access token used to log against the Docker registry
              password: # optional
              # Specifies whether the given registry is ECR (auto, true or false)
              ecr: # optional, default is auto
              # Log out from the Docker registry at the end of a job
              logout: # optional, default is true
    ```

1. Again, in the right panel, search for **Build and push Docker images** in the **Marketplace**. Select the first result published by **Docker**.

    :::image type="content" source="../media/6-3-docker-action.png" alt-text="Screenshot that shows the search results that list Build and push Docker images.":::

    In the panel for the search result item, under **Installation**, select the copy icon to copy the usage YAML.

    :::image type="content" source="../media/6-3-docker-action-copy.png" alt-text="Screenshot that shows the copy function after Build and push Docker images has been selected.":::

    Paste the copied YAML below the last key from the previously copied `docker-login` action.

    Your YAML file should look like this example:

    ```yaml
    name: Build and push the tagged build to production

    on:
      push:
        tags:
          - 'v*'

    jobs:
      build_push_image:
        runs-on: ubuntu-20.04

        steps:
          - uses: actions/checkout@v2

          - name: Fetch latest version
            id: fetch_version
            run: echo ::set-output name=TAG::${GITHUB_REF#refs/tags/}

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
            # uses: docker/build-push-action@c56af957549030174b10d6867f20e78cfd7debc5
            uses: docker/build-push-action@v3.2.0
            with:
              # Here you can set the parameters
    ```

    > [!IMPORTANT]
    > Be careful with indentation when you use YAML. The `name` key should be aligned with the preceding `uses` key.

    You can adjust usage for this action. For more information, see the [GitHub build-push-action documentation](https://github.com/docker/build-push-action/tree/v2.4.0?azure-portal=true).

1. Rename the `name` key `Build and push production images`.

1. You'll use only a handful of the parameters that are available for these actions.

    Add the values according to the following table:

    |Key name     | Used on action |Value                                           |
    |-------------|--------|------------------------------------------------|
    |registry     |`docker/login`|`${{ secrets.ACR_NAME }}`                       |
    |username     |`docker/login`|`${{ secrets.ACR_LOGIN }}`                      |
    |password     |`docker/login`|`${{ secrets.ACR_PASSWORD }}`                   |
    |repository   |`docker/build-and-push`|contoso-website                                 |
    |context      |`docker/build-and-push`|`.`                                    |
    |push         |`docker/build-and-push`|`true`                                 |
    |tags         |`docker/build-and-push`|The version number obtained by the `fetch_version` step (as shown in following example). |

    You can delete all the other keys because we won't use them in this exercise.

    Your file should look like this example:

    ```yaml
    name: Build and push the tagged build to production

    on:
      push:
        tags:
          - 'v*'

    jobs:
      build_push_image:
        runs-on: ubuntu-20.04

        steps:
          - uses: actions/checkout@v2

          - name: Fetch latest version
            id: fetch_version
            run: echo ::set-output name=TAG::${GITHUB_REF#refs/tags/}

          - name: Docker Login
            uses: docker/login-action@v1
            with:
              registry: ${{ secrets.ACR_NAME }}
              username: ${{ secrets.ACR_LOGIN }}
              password: ${{ secrets.ACR_PASSWORD }}

          - name: Build and push production images
            uses: docker/build-push-action@v2
            with:
              context: .
              push: true
              tags: ${{secrets.ACR_NAME}}/contoso-website:latest,${{secrets.ACR_NAME}}/contoso-website:${{ steps.fetch_version.outputs.TAG }}
    ```

    Using `steps.` in the YAML is a common practice to refer to previous steps in the pipeline. When we used `set-output` in the `fetch_version` step, we set the output of the step to the value of the `GITHUB_REF` variable. This output is now available in the pipeline inside the `steps` object.

1. Before you save the file, we'll also add another action between the checkout action and the login action, to set up the build engine for Docker to use. This action is called `docker/setup-buildx-action` and you'll use `v1`.

    To set this action, copy the snippet from this example and paste it between the `Fetch latest version` and the `Docker Login` actions.

    ```yaml
    - name: Set up Buildx
      uses: docker/setup-buildx-action@v1
    ```

    Your final file should be like this:

    ```yaml
    name: Build and push the tagged build to production

    on:
      push:
        tags:
          - 'v*'

    jobs:
      build_push_image:
        runs-on: ubuntu-20.04

        steps:
          - uses: actions/checkout@v2

          - name: Fetch latest version
            id: fetch_version
            run: echo ::set-output name=TAG::${GITHUB_REF#refs/tags/}

          - name: Set up Buildx
            uses: docker/setup-buildx-action@v1

          - name: Docker Login
            uses: docker/login-action@v1
            with:
              registry: ${{ secrets.ACR_NAME }}
              username: ${{ secrets.ACR_LOGIN }}
              password: ${{ secrets.ACR_PASSWORD }}

          - name: Build and push production images
            uses: docker/build-push-action@v2
            with:
              context: .
              tags: ${{secrets.ACR_NAME}}/contoso-website:latest,${{secrets.ACR_NAME}}/contoso-website:${{ steps.fetch_version.outputs.TAG }}
              push: true
    ```

1. To commit the changes, select the green **Start commit** button at the top right. Enter a description for the commit, and then select the **Commit new file** button.

    This time, the action won't be triggered because you didn't push a new tag. But our earlier action triggers and builds a new `latest` image.

## Create a personal access token (PAT)

1. Go to the fork of the sample repository in the GitHub website. On the top right hand corner, select your profile photo, then select **Settings**.

1. Select **Developer settings** at the bottom of the left menu.

1. Select **Personal access tokens**.

1. Select **Generate new token**.

1. Provide a name for your PAT, such as *myPersonalAccessToken*
  
1. Select the checkbox next to **public_repo**.

    :::image type="content" source="../media/7-create-personal-access-token.png" alt-text="Screenshot that shows the personal access tokens page.":::

1. Select **Generate token** at the bottom of the page.

1. Select the copy icon to copy your PAT. Make note of the PAT, as it will be used in later steps.

    :::image type="content" source="../media/7-copy-personal-access-token.png" alt-text="Screenshot that shows the personal access token after it has been created.":::

## Check the results

1. Open your cloned repository in Azure Cloud Shell. Run `git pull`.
    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)
  
1. Run the following command:

    ```bash
    git tag -a v2.0.0 -m 'First tag'
    ```

1. Run the following command:

    ```bash
    git push --tags
    ```

1. When prompted, provide your GitHub username, and the PAT created previously as the password.

1. Select the **Actions** tab and check the running process.

1. When the process is completed, in Azure Cloud Shell, run the following command to confirm that two tags are listed in the results:

    ```bash
    az acr repository show-tags --repository contoso-website --name <ACR_NAME> -o table
    ```
