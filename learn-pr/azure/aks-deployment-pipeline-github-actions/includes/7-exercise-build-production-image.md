In the previous exercise, we built the staging workflow for building and publishing the image. Now let's recap the production workflow.

:::image type="content" source="../media/3-pipeline-5-deploy.png" alt-text="The designed pipeline":::

We'll build the tagged version using another workflow.

## Build the Action Workflow

1. To start building our pipeline, let's go to the fork of the sample repository in the GitHub website. And click on the "Actions" tab.

1. Click the "New Workflow" button, you'll be led to the same page as before.

    :::image type="content" source="../media/6-1-actions-tab.png" alt-text="Open the actions tab in the GitHub website":::

1. Click on the "set up a workflow yourself" link just below the header. This should open a new editor with a file in it

    :::image type="content" source="../media/6-2-example-editor.png" alt-text="Example file being edited":::

    GitHub gave us the same editor with another workflow file created within the `.github/workflows` directory. This is the file you'll have displayed.

    ```yml
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

1. Rename the file from `main.yml` to `build-production.yml` by typing on the top input panel

1. Change the `name` key to _"Build and push the tagged build to production"_, your file will look like this

    ```yml
    # This is a basic workflow to help you get started with Actions

    name: Build and push the tagged build to production
    ```

### Create the trigger

1. Next up, we'll change the default triggers in the `on` key.

    Let's now remove the second part and leave just the `push` tags. The keys should be like this afterwards:

    ```yml
    name: Build and push the tagged build to production

    on:
      push:
        branches: [ main ]
    ```

    Let's remove the `branches` key and replace it by the `tags` key. This tag says that we'll only run this workflow on determined tags.

    ```yml
    name: Build and push the tagged build to production

    on:
      push:
        tags:
          - 'v*'
    ```

    In this case, we'll only run the workflow if the tag follows the `v*` pattern, which includes `v1.0.0`.

### Build and push the image

1. Now, let's work on the jobs we're going to run.

    In this part, we'll be addressing both the build and deploy steps from the diagram.

    The `jobs` key is already set to run on `ubuntu-latest`, which is the environment we want this workflow to run.

1. Rename the `build` key to `build_push_image`.

1. Jump into the `steps` key. Delete the last two commands, those are only examples from the template. Your file will be like the following.

    ```yml
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

    We leave the checkout option like before.

1. In the right panel, search for "Build and push docker images". Click on the first result published by **Docker**.

    :::image type="content" source="../media/6-3-docker-action.png" alt-text="Select the action":::

    In the opened panel, click on the `copy` icon to copy the usage YAML

    :::image type="content" source="../media/6-4-docker-copy.png" alt-text="Copy the YAML":::

1. Paste the copied yaml below the `- uses: actions/checkout@v2` key. Your YAML file should be like the following

    ```yml
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

    This action gives us several options to tweak the usage. You can learn more about each one of them in the [documentation page](https://github.com/docker/build-push-action/tree/releases/v1).

1. In the `name` key, rename the value to "Build and push production image"
1. We'll only use a handful of the parameters given by this action. So let's set them and delete the others.

    Add the values according to the table below.

    |Key name     |Value                                           |
    |-------------|------------------------------------------------|
    |username     |`${{ secrets.ACR_LOGIN }}`                      |
    |password     |`${{ secrets.ACR_PASSWORD }}`                   |
    |registry     |`${{ secrets.ACR_NAME }}`                       |
    |repository   |contoso-website                                 |
    |tag_with_ref |true                                            |

    You can delete all the other keys since they'll not be used. Your file should be like the following:

    ```yml
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

    The `tag_with_ref` key is one handy parameter that will tag the image with the tag name automatically. According to the documentation:

    > Automatically tags the built image with the git reference. The format of the tag depends on the type of git reference with all forward slashes replaced with `-`.
    >
    > For pushes to a branch the reference will be `refs/heads/{branch-name}` and the tag will be `{branch-name}`. If `{branch-name}` is master then the tag will be latest.
    >
    > For pull requests the reference will be `refs/pull/{pull-request}` and the tag will be `pr-{pull-request}`.
    >
    > For git tags the reference will be `refs/tags/{git-tag}` and the tag will be `{git-tag}`.

1. Commit the changes by clicking the green button on the top right. Give the commit a message and click the "Commit new file" button

    This time, the action won't be triggered, because we didn't push a new tag. But our earlier action will trigger and build a new `latest` image.

### Check your work

1. Open your cloned repository in Azure Cloud Shell. Run `git tag -a v1.0.0 -m'First tag'`
    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)
1. Run `git push --tags`
1. Open the "Actions" tab and check the running process
1. Run `az acr repository show-tags --repository contoso-website --name <ACR_NAME> -o table` in the Azure Cloud Shell to confirm there are two tags listed in the results
