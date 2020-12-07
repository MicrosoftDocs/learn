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

    :::image type="content" source="../media/6-1-actions-tab.png" alt-text="Screenshot that shows the Get started with GitHub Actions page and the Set up a workflow yourself link on the GitHub website.":::

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

1. In the right panel, search for **Build and push Docker images**. Select the first result published by Docker.

    :::image type="content" source="../media/6-3-docker-action.png" alt-text="Screenshot that shows the search results that list Build and push Docker images.":::

1. In the panel for the search result item, select the copy icon to copy the usage YAML.

    :::image type="content" source="../media/6-4-docker-copy.png" alt-text="Screenshot that shows the copy icon selected in the Build and push Docker images pane.":::

1. Paste the copied YAML below the `- uses: actions/checkout@v2` key. 

   Your YAML file should look like this example:

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

          - name: Build and push Docker images
            # You can pin to the exact commit or the version.
            # uses: docker/build-push-action@ab83648e2e224cfeeab899e23b639660765c3a89
            uses: docker/build-push-action@v1.1.1
            with:
              # Username used to log in to a Docker registry. If not set, no login occurs
              username: # optional
              # Password or personal access token used to log in to a Docker registry. If not set, no login occurs
              password: # optional
              # Server address of Docker registry. If not set, it defaults to Docker Hub
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

    This action gives you several options to adjust the usage. For more information, see the GitHub [GitHub build-push-action documentation](https://github.com/docker/build-push-action/tree/releases/v1?azure-portal=true).

1. Rename the `name` key `Build and push production image`.

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

          - name: Build and push production image
            uses: docker/build-push-action@v1.1.1
            with:
              username: ${{ secrets.ACR_LOGIN }}
              password: ${{ secrets.ACR_PASSWORD }}
              registry: ${{ secrets.ACR_NAME }}
              repository: contoso-website
              tag_with_ref: true
    ```

    The `tag_with_ref` key is a handy parameter that automatically tags the image with the tag name. As described in the documentation, it:

    - Automatically tags the built image with the git reference. The format of the tag depends on the type of git reference. All forward slashes are replaced with `-`.
    - For pushes to a branch, the reference will be `refs/heads/{branch-name}` and the tag will be `{branch-name}`. If `{branch-name}` is master, the tag will be `latest`.
    - For pull requests, the reference will be `refs/pull/{pull-request}` and the tag will be `pr-{pull-request}`.
    - For git tags, the reference will be `refs/tags/{git-tag}` and the tag will be `{git-tag}`.

1. To commit the changes, select the green **Start commit** button at the top right. Enter a description for the commit, and then select the **Commit new file** button.

    This time, the action won't be triggered because you didn't push a new tag. But our earlier action triggers and builds a new `latest` image.

## Check the results

1. Open your cloned repository in Azure Cloud Shell. Run `git tag -a v1.0.0 -m'First tag'`.
    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

1. Run `git push --tags`.

1. Select the **Actions** tab and check the running process.

1. In Azure Cloud Shell, run `az acr repository show-tags --repository contoso-website --name <ACR_NAME> -o table` to confirm that two tags are listed in the results.
