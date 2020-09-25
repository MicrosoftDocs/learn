With all the charts created, we now have all the tools we need to deploy the application to AKS using GitHub actions. Let's use what we created to finish our deployment pipeline.

In this part, we'll tackle the last bit of our diagram, the "Deploy Steps".

:::image type="content" source="../media/3-pipeline-5-deploy.png" alt-text="Deployment pipeline":::

## Create the deploy to staging

We'll start by the staging pipeline.

1. Open the GitHub website at your fork, got to the `.github/workflows` directory in the repository view and open the `build-latest.yml` file
1. Right now, the file should be like this

    ```yml
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

    The first step we need to take is to add another job, so let's create a new key called `deploy` below the `build_push_image` key:

    ```yml
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

      deploy:
        runs-on: ubuntu-latest
        needs: build_push_image # Will wait for the execution of the previous job
    ```

1. The first step is to clone and check out the branch we're working with. So let's add the same `- uses: actions/checkout@v2` as the first step:

    ```yml
      deploy:
        runs-on: ubuntu-latest
        needs: build_push_image

        - uses: actions/checkout@v2
    ```

1. The second step to execute is to install Helm, in this exercise we'll use Helm at version `v3.3.1`. Azure has a built action that already downloads and installs Helm for us, so let's use it.

    1. Add a new `steps` key below the `runs-on` key, just like the first job we created. Then, on the right-hand side of the screen, search for "Helm tool installer" and click on the result that was published by Azure

    :::image type="content" source="../media/10-helm-tool-installer.png" alt-text="Helm installer action":::

    1. Copy the presented YAML and paste it below the `uses` key, like so

    ```yml
      deploy:
        runs-on: ubuntu-latest
        needs: build_push_image

        steps:
          - uses: actions/checkout@v2

          - name: Helm tool installer
            uses: Azure/setup-helm@v1
            with:
              # Version of helm
              version: # default is latest
    ```

    Then let's rename the step name to "Install Helm" and pin the `version` key to `v3.3.1`:

    ```yml
      deploy:
        runs-on: ubuntu-latest
        needs: build_push_image

        steps:
          - uses: actions/checkout@v2

          - name: Install Helm
            uses: Azure/setup-helm@v1
            with:
              version: v3.3.1
    ```

1. Next up, we'll log in to our AKS cluster using Azure CLI through another action that Azure provides us. Use the search bar on the right-hand side of the screen to look for "Set Context". Select the "Azure Kubernetes Set Context" action

    :::image type="content" source="../media/10-aks-set-context.png" alt-text="Set AKS context":::

1. Copy the YAML and paste it below the previous "Install Helm" step

    ```yml
    steps:
      - uses: actions/checkout@v2

      - name: Install Helm
        uses: Azure/setup-helm@v1
        with:
          version: v3.3.1

      - name: Azure Kubernetes set context
        uses: Azure/aks-set-context@v1
        with:
          # Azure credentials i.e. output of `az ad sp create-for-rbac --sdk-auth`
          creds: # default is
          # Resource Group Name
          resource-group: # optional, default is
          # AKS Cluster Name
          cluster-name: # optional, default is
    ```

    This action uses AZ CLI to get the AKS credentials so we can use Kubectl to deploy our workloads to the cluster.

    1. Change the `name` key to "Get AKS Credentials"
    1. Change the `resource-group` key to the name of the resource group that contains the AKS resource. You can get this information by running the following command in the Cloud Shell

        ```azurecli-interactive
        az aks list -o tsv --query "[?name=='contoso-video'].resourceGroup"
        ```

    1. Put the cluster name in the `cluster-name` key. The name of the AKS cluster in this exercise is fixed at `contoso-video`.
    1. In the `creds` key, we'll define a secret called `AZURE_CREDENTIALS`. So the value of this key will be `${{ secrets.AZURE_CREDENTIALS }}`

    The final YAML should be like this:

    ```yml
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

      deploy:
        runs-on: ubuntu-latest
        needs: build_push_image

        steps:
          - uses: actions/checkout@v2

          - name: Install Helm
            uses: Azure/setup-helm@v1
            with:
              version: v3.3.1

          - name: Get AKS Credentials
            uses: Azure/aks-set-context@v1
            with:
              creds: ${{ secrets.AZURE_CREDENTIALS }}
              resource-group: <your-resource-group>
              cluster-name: contoso-video
    ```

1. We have set the credential secret but this secret isn't created yet. Let's create it.

    __In a new tab__, open the repository settings and navigate to "Secrets". Once there, create a new secret called `AZURE_CREDENTIALS`. The value of this secret will be the output of the following command, which is a JSON object.

    ```azurecli-interactive
    az ad sp create-for-rbac --sdk-auth
    ```

    Copy the output and paste it in the secret value. Then save the secret and close the tab.

1. Now we have access to our cluster and we have helm installed, so the next step is to actually deploy the application. For this, we'll use the common command instructions native to GitHub Actions.

    In the YAML file, create a new `- name:` key below the latest step. Give it the name of "Run Helm Deploy". Below this key, create another key called `run`. The YAML should look like this:

    ```yml
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

      deploy:
        runs-on: ubuntu-latest
        needs: build_push_image

        steps:
          - uses: actions/checkout@v2

          - name: Install Helm
            uses: Azure/setup-helm@v1
            with:
              version: v3.3.1

          - name: Get AKS Credentials
            uses: Azure/aks-set-context@v1
            with:
              creds: ${{ secrets.AZURE_CREDENTIALS }}
              # Resource Group Name
              resource-group: mslearn-gh-pipelines-6667
              # AKS Cluster Name
              cluster-name: contoso-video

          - name: Run Helm Deploy
            run:
    ```

    The `run` key allows you to run any shell command within the container. Since we're using Ubuntu, our shell is Bash. Let's run this command inside the `run` key:

    ```bash
    helm upgrade \
        --install \
        --create-namespace \
        --atomic \
        --wait \
        --namespace staging \
        contoso-website \
        ./kubernetes/contoso-website \
        --set image.repository=${{ secrets.ACR_NAME }} \
        --set dns.name=${{ secrets.DNS_NAME }}
    ```

    Let's go through each parameter to understand what we're doing:


    |Parameter  |Value  |
    |---------|---------|
    |`helm upgrade`     |Upgrades an installed release         |
    |`--install`     |If the release doesn't exist, install it. This transforms the command into an idempotent command, meaning we can run it exactly the same multiple times.         |
    |`--create-namespace`     |If the namespace in the `--namespace` flag doesn't exist, create it         |
    |`--atomic`     |If the release fails, remove all workloads that have been installed         |
    |`--wait`     |Wait for the release to be completed and return an "ok" signal         |
    |`--namespace staging`     |Deploy this release to the `staging` namespace, overrides all `namespace` keys in the manifest files         |
    |`contoso-website`     |Release name         |
    |`./kubernetes/contoso-website`   |Chart directory location         |
    |`--set image.repository`     |Updates the value of the `image.repository` key in the `values.yaml` file __for this release only__         |
    |`--set dns.name`   |Updates the `dns.name` key in the `values.yaml` file __for this release only__         |

    To do this, we'll start with a `|` character in the beginning. The final YAML should look something like this:

    ```yml
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

      deploy:
        runs-on: ubuntu-latest
        needs: build_push_image

        steps:
          - uses: actions/checkout@v2

          - name: Install Helm
            uses: Azure/setup-helm@v1
            with:
              version: v3.3.1

          - name: Get AKS Credentials
            uses: Azure/aks-set-context@v1
            with:
              creds: ${{ secrets.AZURE_CREDENTIALS }}
              # Resource Group Name
              resource-group: mslearn-gh-pipelines-6667
              # AKS Cluster Name
              cluster-name: contoso-video

          - name: Run Helm Deploy
            run: |
              helm upgrade \
                --install \
                --create-namespace \
                --atomic \
                --wait \
                --namespace staging \
                contoso-website \
                ./kubernetes/contoso-website \
                --set image.repository=${{ secrets.ACR_NAME }} \
                --set dns.name=${{ secrets.DNS_NAME }}
    ```

    __In a new tab__, go to the repository settings and navigate to the "Secrets" menu. Once there, create a new secret called `DNS_NAME`. Its value can be obtained by running the following command in the Cloud Shell.

    ```azurecli-interactive
    az network dns zone list -o tsv --query "[?contains(resourceGroup, 'mc_mslearn-gh-pipelines')].name"
    ```

    Save it and close the tab.

1. Commit the changes by clicking the "Start Commit" button

    :::image type="content" source="../media/10-commit-staging-deploy.png" alt-text="Commit the workflow":::

    As soon as the commit is done, you'll notice the steps will start to run in the "Actions" tab.

### Test the deployment

To test the staging deployment, go to `contoso-staging.<your-dns-name>` in your browser and check if the website is displayed.

## Create the production deploy

With the staging workflow created, the next step is to create the production workflow. This step is simpler because we can copy the whole `deploy` job and tweak its parameters.

1. Navigate to the `.github/workflows` directory in the "Code" view in the GitHub website. Click the `build-production.yaml` file and edit it.
1. Copy the `deploy` step from the previous module and paste it below the last line of the YAML file. The result should be like this:

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

          - name: Build and Push production image
            # You may pin to the exact commit or the version.
            # uses: docker/build-push-action@ab83648e2e224cfeeab899e23b639660765c3a89
            uses: docker/build-push-action@v1.1.1
            with:
              username: ${{secrets.ACR_LOGIN}}
              password: ${{secrets.ACR_PASSWORD}}
              registry: ${{ secrets.ACR_NAME }}
              repository: contoso-website
              tag_with_ref: true

      deploy:
        runs-on: ubuntu-latest
        needs: build_push_image

        steps:
          - uses: actions/checkout@v2

          - name: Install Helm
            uses: Azure/setup-helm@v1
            with:
              version: v3.3.1

          - name: Get AKS Credentials
            uses: Azure/aks-set-context@v1
            with:
              creds: ${{ secrets.AZURE_CREDENTIALS }}
              # Resource Group Name
              resource-group: mslearn-gh-pipelines-6667
              # AKS Cluster Name
              cluster-name: contoso-video

          - name: Run Helm Deploy
            run: |
              helm upgrade \
                --install \
                --create-namespace \
                --atomic \
                --wait \
                --namespace staging \
                contoso-website \
                ./kubernetes/contoso-website \
                --set image.repository=${{ secrets.ACR_NAME }} \
                --set dns.name=${{ secrets.DNS_NAME }}
    ```

1. Now we'll tweak it to deploy it to the production namespace. In the "Run Helm Deploy" step, change the `--namespace` flag from `staging` to `production`
1. Add a new `--set image.tag=${GITHUB_REF##*/}` in the end of the helm command

    We're using a particular bash feature called "Parameter Expansion". This feature is defined by the syntax `${ENV##<wildcard><character>}` and will return the last occurrence of the string after `character`.

    In this case, we want to get the tag name. This variable is defined by the Actions runtime as `GITHUB_REF`, if it's a branch, it comes as `refs/heads/<branch>`, if it's a tag, it comes as `refs/tags/<tag>`.

    We need to remove the `refs/tags/` part to get only the tag name, so we execute `${GITHUB_REF##*/}`, which means "return everything after the last `/` in the `GITHUB_REF` environment variable.

1. The final YAML file will look like this

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

          - name: Build and Push production image
            # You may pin to the exact commit or the version.
            # uses: docker/build-push-action@ab83648e2e224cfeeab899e23b639660765c3a89
            uses: docker/build-push-action@v1.1.1
            with:
              username: ${{secrets.ACR_LOGIN}}
              password: ${{secrets.ACR_PASSWORD}}
              registry: ${{ secrets.ACR_NAME }}
              repository: contoso-website
              tag_with_ref: true

      deploy:
        runs-on: ubuntu-latest
        needs: build_push_image

        steps:
          - uses: actions/checkout@v2

          - name: Install Helm
            uses: Azure/setup-helm@v1
            with:
              version: v3.3.1

          - name: Get AKS Credentials
            uses: Azure/aks-set-context@v1
            with:
              creds: ${{ secrets.AZURE_CREDENTIALS }}
              # Resource Group Name
              resource-group: mslearn-gh-pipelines-6667
              # AKS Cluster Name
              cluster-name: contoso-video

          - name: Run Helm Deploy
            run: |
              helm upgrade \
                --install \
                --create-namespace \
                --atomic \
                --wait \
                --namespace production \
                contoso-website \
                ./kubernetes/contoso-website \
                --set image.repository=${{ secrets.ACR_NAME }} \
                --set dns.name=${{ secrets.DNS_NAME }} \
                --set image.tag=${GITHUB_REF##*/}
    ```

1. Commit the file by clicking the green "Start Commit" button
1. In your Cloud Shell, execute a `git pull` to fetch the latest changes and then run `git tag -a v1.0.1 -m'Creating new tag'` and then `git push --tags`
1. Open the "Actions" tab and see the running process

### Test the deployment

To test the staging deployment, go to `contoso-production.<your-dns-name>` in your browser and check if the website is displayed.
