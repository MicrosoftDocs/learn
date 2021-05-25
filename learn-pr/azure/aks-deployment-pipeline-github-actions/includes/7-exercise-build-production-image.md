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

    The following file is shown in the GitHub editor:

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

1. Above the **Edit new file** pane, rename the file from **main.yml** to **build-production.yml**.

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

The `jobs` key is already set to run on `ubuntu-latest`, which is the environment you want this workflow to run.

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
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v2
    ```

    Leave the `checkout` option like you did when you created the staging image.

1. In the right panel, search for **Docker Login**

    In the panel for the search result item, under **Installation**, select the copy icon to copy the usage YAML.

    :::image type="content" source="../media/6-3-docker-login.png" alt-text="Screenshot showing the search results listing Docker Login":::

    > [!NOTE]
    > Docker action prior to version 2 had the login flow built-in, however, on versions 2 and above, these actions were separated. This is why we need two actions to set the entire workflow correctly.

    In the panel for the search result item, under **Installation**, select the copy icon to copy the usage YAML.

    ```yml
    name: Build and push the latest build to production

    on:
      push:
        tags:
          - 'v*'

    jobs:
      build_push_image:
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v2

          - name: Docker Login
            # You may pin to the exact commit or the version.
            # uses: docker/login-action@f3364599c6aa293cdc2b8391b1b56d0c30e45c8a
            uses: docker/login-action@v1.8.0
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

    Paste the copied YAML below the last key from the previously copied `docker-login` action.

    Your YAML file should look like this example:

    ```yaml
    name: Build and push the latest build to production

    on:
      push:
        tags:
          - 'v*'

    jobs:
      build_push_image:
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v2

          - name: Docker Login
            # You may pin to the exact commit or the version.
            # uses: docker/login-action@f3364599c6aa293cdc2b8391b1b56d0c30e45c8a
            uses: docker/login-action@v1.8.0
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
            uses: docker/build-push-action@v2.4.0
            with:
              # List of extra privileged entitlement (eg. network.host,security.insecure)
              allow: # optional
              # List of build-time variables
              build-args: # optional
              # Builder instance
              builder: # optional
              # List of external cache sources for buildx (eg. user/app:cache, type=local,src=path/to/dir)
              cache-from: # optional
              # List of cache export destinations for buildx (eg. user/app:cache, type=local,dest=path/to/dir)
              cache-to: # optional
              # Build's context is the set of files located in the specified PATH or URL
              context: # optional
              # Path to the Dockerfile
              file: # optional
              # List of metadata for an image
              labels: # optional
              # Load is a shorthand for --output=type=docker
              load: # optional, default is false
              # Set the networking mode for the RUN instructions during build
              network: # optional
              # Do not use cache when building the image
              no-cache: # optional, default is false
              # List of output destinations (format: type=local,dest=path)
              outputs: # optional
              # List of target platforms for build
              platforms: # optional
              # Always attempt to pull a newer version of the image
              pull: # optional, default is false
              # Push is a shorthand for --output=type=registry
              push: # optional, default is false
              # List of secrets to expose to the build (eg. key=string, GIT_AUTH_TOKEN=mytoken)
              secrets: # optional
              # List of secret files to expose to the build (eg. key=filename, MY_SECRET=./secret.txt)
              secret-files: # optional
              # List of SSH agent socket or keys to expose to the build
              ssh: # optional
              # List of tags
              tags: # optional
              # Sets the target stage to build
              target: # optional
              # GitHub Token used to authenticate against a repository for Git context
              github-token: # optional, default is ${{ github.token }}
    ```

    > [!IMPORTANT]
    > Be careful with indentation when you use YAML. The `name` key should be aligned with the preceding `uses` key.

    You can adjust usage for this action. For more information, see the [GitHub build-push-action documentation](https://github.com/docker/build-push-action/tree/v2.4.0?azure-portal=true).

1. Rename the `name` key `Build and push production image`.

1. You'll use only a handful of the parameters that are available for these actions.

    Add the values according to the following table:

    |Key name     | Used on action |Value                                           |
    |-------------|--------|------------------------------------------------|
    |username     |`docker/login`|`${{ secrets.ACR_LOGIN }}`                      |
    |password     |`docker/login`|`${{ secrets.ACR_PASSWORD }}`                   |
    |registry     |`docker/login`|`${{ secrets.ACR_NAME }}`                       |
    |repository   |`docker/build-and-push`|contoso-website                                 |
    |tags         |`docker/build-and-push`|the version number obtained by `${GITHUB_REF#refs/tags}` |
    |context      |`docker/build-and-push`|`.`                                             |

    You can delete all the other keys because we won't use them in this exercise.

    Your file should look like this example:

    ```yaml
    name: Build and push the latest build to production

    on:
      push:
        tags:
          - 'v*'

    jobs:
      build_push_image:
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v2

          - name: Docker Login
            uses: docker/login-action@v1.8.0
            with:
              registry: ${{ secrets.ACR_NAME }}
              username: ${{ secrets.ACR_LOGIN }}
              password: ${{ secrets.ACR_PASSWORD }}

          - name: Build and push production images
            uses: docker/build-push-action@v2.4.0
            with:
              context: .
              tags: ${GITHUB_REF#refs/tags}
              repository: contoso-website
    ```

1. Before you save the file, we'll also add another action between the checkout action and the login action to set up the build engine for Docker to use. This action is called `docker/setup-buildx-action` and you'll use `v1`.

    To set this action, copy the below snippet and paste it between the checkout and the login actions.

    ```yml
    - name: Set up Buildx
      uses: docker/setup-buildx-action@v1
    ```

    Your final file should be like this:

    ```yaml
    name: Build and push the latest build to production

    on:
      push:
        tags:
          - 'v*'

    jobs:
      build_push_image:
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v2

          - name: Set up Buildx
            uses: docker/setup-buildx-action@v1

          - name: Docker Login
            uses: docker/login-action@v1.8.0
            with:
              registry: ${{ secrets.ACR_NAME }}
              username: ${{ secrets.ACR_LOGIN }}
              password: ${{ secrets.ACR_PASSWORD }}

          - name: Build and push production images
            uses: docker/build-push-action@v2.4.0
            with:
              context: .
              tags: ${GITHUB_REF#refs/tags}
              repository: contoso-website
    ```

1. To commit the changes, select the green **Start commit** button at the top right. Enter a description for the commit, and then select the **Commit new file** button.

    This time, the action won't be triggered because you didn't push a new tag. But our earlier action triggers and builds a new `latest` image.

## Check the results

1. Open your cloned repository in Azure Cloud Shell. Run `git tag -a v1.0.0 -m'First tag'`.
    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

1. Run `git push --tags`.

1. Select the **Actions** tab and check the running process.

1. In Azure Cloud Shell, run `az acr repository show-tags --repository contoso-website --name <ACR_NAME> -o table` to confirm that two tags are listed in the results.
