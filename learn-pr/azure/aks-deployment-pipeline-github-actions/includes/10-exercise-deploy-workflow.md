With the Helm charts created, you now have all the tools you need to deploy the application to AKS by using GitHub Actions. Let's use what you created to finish the deployment pipeline.

In this unit, you'll tackle the last step in the diagram—the deploy steps.

:::image type="content" source="../media/3-pipeline-5-deploy.png" alt-text="Diagram that shows the procession from triggers, through three build steps, to the deploy step in a pipeline.":::

For staging, the steps include:
- Add a deploy job
- Install Helm
- Get the AKS credentials
- Create a secret
- Deploy the application
- Test the deployment

To deploy to production, we'll:
- Create the production deploy job
- Test the deployment

## Create the deploy to staging job

Start by deploying the staging pipeline.

### Add a deploy job

1. In GitHub, go to your fork of the repository.

1. Go to the `.github/workflows` directory in the repository, and then open the `build-staging.yml` file.

   The file should look like this example:

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

1. To add another job, below the `build_push_image` key, create a new key called `deploy`:

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
      
      deploy:
        runs-on: ubuntu-20.04
        needs: build_push_image # Will wait for the execution of the previous job
    ```

1. Clone and check out your working branch.

1. Add `- uses: actions/checkout@v2` as the first step:

    ```yaml
      deploy:
        runs-on: ubuntu-20.04
        needs: build_push_image
        
        steps:
          - uses: actions/checkout@v2
    ```

### Install Helm

In this exercise, you use Helm version `v3.3.1`. Azure has a built action that downloads and installs Helm.

1. Below the `runs-on` key, add a new `steps` key. Then, search for **Helm tool installer**. Select the first result published by **Azure**.

    :::image type="content" source="../media/10-helm-tool-installer.png" alt-text="Screenshot that shows the search results for the Helm installer action.":::

    In the panel for the search result item, under **Installation**, select the copy icon to copy the usage YAML.

    :::image type="content" source="../media/10-helm-tool-installer-copy.png" alt-text="Screenshot that shows the copy function after selecting the Helm installer action.":::

1. Copy the YAML that appears, and then paste it below the `uses` key:

    ```yaml
      deploy:
        runs-on: ubuntu-20.04
        needs: build_push_image

        steps:
          - uses: actions/checkout@v2

          - name: Helm tool installer
            uses: Azure/setup-helm@v1
            with:
              # Version of helm
              version: # default is latest
    ```

1. Rename the step name `Install Helm`, and then pin the `version` key to `v3.3.1`:

     ```yaml
      deploy:
        runs-on: ubuntu-20.04
        needs: build_push_image

        steps:
          - uses: actions/checkout@v2

          - name: Install Helm
            uses: Azure/setup-helm@v1
            with:
              version: v3.3.1
      ```

1. Sign in to your AKS cluster by using the Azure CLI through another action that Azure provides. In the search bar, enter **Set Context**. In the search results, select **Azure Kubernetes Set Context** published by **Azure**.

    :::image type="content" source="../media/10-azure-kubernetes-set-context.png" alt-text="Screenshot that shows the results for a Set Context search.":::

    In the panel for the search result item, under **Installation**, select the copy icon to copy the usage YAML.

    :::image type="content" source="../media/10-azure-kubernetes-set-context-copy.png" alt-text="Screenshot that shows the copy function after selecting the Azure Kubernetes set context action.":::

1. Copy the YAML, and then paste it below the previous `Install Helm` step:

    ```yaml
    steps:
      - uses: actions/checkout@v2

      - name: Install Helm
        uses: Azure/setup-helm@v1
        with:
          version: v3.3.1

      - name: Azure Kubernetes set context
        uses: Azure/aks-set-context@v1
        with:
          # Azure credentials, i.e., output of `az ad sp create-for-rbac --scopes /subscriptions/<SUBSCRIPTION-ID> --role Contributor --sdk-auth`
          creds: # default is
          # Resource group name
          resource-group: # optional, default is
          # AKS cluster name
          cluster-name: # optional, default is
    ```

### Get the AKS credentials

Next, you use an action that uses the Azure CLI to get the AKS credentials. Then, you use Kubectl to deploy your workloads to the cluster.

1. Change the `name` key to `Get AKS Credentials`.

1. Change the `resource-group` key to the name of the resource group that contains your AKS resource. You can get this information by running the following command in Cloud Shell:

    ```azurecli-interactive
    az aks list -o tsv --query "[?name=='contoso-video'].resourceGroup"
    ```

1. In the `cluster-name` key, enter the cluster name. The name of the AKS cluster in this exercise is fixed as `contoso-video`.

1. In the `creds` key, define a secret called `AZURE_CREDENTIALS`. The value of this key `${{ secrets.AZURE_CREDENTIALS }}`.

    The final YAML should look like this example:

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
      
      deploy:
        runs-on: ubuntu-20.04
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
              resource-group: {resource-group}
              cluster-name: contoso-video    
      ```


### Create a secret

You've set the credential secret, but the secret isn't created yet. Let's create it.

1. In a new browser tab, go to your fork of the repository. Select **Settings** > **Secrets**.

1. Create a new secret called `AZURE_CREDENTIALS`. The value of this secret will be the output of the following command, a JSON object:

    ```azurecli-interactive
    az ad sp create-for-rbac --role Contributor --scopes /subscriptions/<SUBSCRIPTION-ID> --sdk-auth
    ```

1. Copy the output and paste it in the secret value. Then, save the secret and close the tab.

### Deploy the application

Now, you have access to your cluster and you have Helm installed. The next step is to deploy the application. For this step, you use the command instructions that are native to GitHub Actions.

1.  In the YAML file, below the latest step, create a new `- name:` key. Name the key `Run Helm Deploy`. Then, below this key, create another key called `run`.

    The YAML should look like this example:

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

          - name: Build and push staging image
            uses: docker/build-push-action@v1.1.1
            with:
              username: ${{ secrets.ACR_LOGIN }}
              password: ${{ secrets.ACR_PASSWORD }}
              registry: ${{ secrets.ACR_NAME }}
              repository: contoso-website
              tags: latest

      deploy:
        runs-on: ubuntu-20.04
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
              resource-group: {resource-group}
              # AKS Cluster Name
              cluster-name: contoso-video

          - name: Run Helm Deploy
            run:
    ```

1. You can use the `run` key to run any shell command inside the container. Because you're using Ubuntu, your shell is Bash. In a moment, we'll run the following command inside the `run` key:

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

    But first, let's look at each parameter to understand what the command does:

    |Parameter  |Action or value  |
    |---------|---------|
    |`helm upgrade`     |Upgrades an installed release.         |
    |`--install`     |If the release doesn't exist, install it. This parameter transforms the command into an idempotent command, so you can run it exactly the same multiple times.         |
    |`--create-namespace`     |If the namespace in the `--namespace` flag doesn't exist, create it.         |
    |`--atomic`     |If the release fails, remove all workloads that have been installed.         |
    |`--wait`     |Wait for the release to finish and return `ok`.         |
    |`--namespace staging`     |Deploy this release to the `staging` namespace. The parameter overrides all `namespace` keys in the manifest files.         |
    |`contoso-website`     |Release name.        |
    |`./kubernetes/contoso-website`   |Chart directory location.         |
    |`--set image.repository`     |Updates the value of the `image.repository` key in the values.yaml file *for this release only*.         |
    |`--set dns.name`   |Updates the `dns.name` key in the values.yaml file *for this release only*.         |

    Run the command, starting with the `|` character. The final YAML should look like this example:

    ```yaml
    # ... File omitted
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

1. In a new browser tab, in your fork of the repository, select **Settings** > **Secrets**.

1. Create a new secret called `DNS_NAME`. You can get the value to use for this secret by running the following command in Cloud Shell:

    ```azurecli-interactive
    az aks show -g {resource-group-name} -n {aks-cluster-name} -o tsv --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName
    ```

    Save the secret and close the browser tab.

1. To commit the changes, select the **Start commit** button. Enter a description for the commit, and then select **Commit new file**:

    :::image type="content" source="../media/6-5-commit-staging.png" alt-text="Screenshot that shows the Start commit and Commit new file button in the Commit new file pane.":::

    The build starts running on the **Actions** tab.

### Test the staging deployment

To test the staging deployment, in your browser, go to **contoso-staging.\<your-dns-name\>** and confirm that the website appears.

## Create the production deployment

With the staging workflow created, the next step is to create the production workflow. This step is simpler because you can copy the whole `deploy` job and just change its parameters.

1. In the **Code** view on the GitHub website, go to the `.github/workflows` directory. Select the `build-production.yaml` file and edit it.

1. Copy the `deploy` step from the previous pipeline and paste it below the last line of the YAML file.

   The result should look like this example:

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

      deploy:
        runs-on: ubuntu-20.04
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
              # Resource group name
              resource-group: {resource-group}
              # AKS cluster name
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

1. Change the `deploy` step to deploy to the production namespace. In the `Run Helm Deploy` step, change the `--namespace` flag from `staging` to `production`.

1. At the end of the Helm command, add a new `--set image.tag=${GITHUB_REF##*/}`.

    Here, you're using a Bash feature called *parameter expansion*. This feature is defined by the syntax `${ENV##<wildcard><character>}`. It returns the last occurrence of the string after `character`.

    In this case, you want to get the tag name. This variable is defined by the GitHub Actions runtime as `GITHUB_REF`. If it's a branch, it's also defined by `refs/heads/<branch>`. If it's a tag, it's defined by `refs/tags/<tag>`.

    We want to remove `refs/tags/` to get only the tag name, so run `${GITHUB_REF##*/}` to return everything after the last `/` in the `GITHUB_REF` environment variable.

   The final YAML file should look like this example:

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

      deploy:
        runs-on: ubuntu-20.04
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
              # Resource group name
              resource-group: {resource-group}
              # AKS cluster name
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

1. To commit the changes, select the **Start commit** button. Enter a description for the commit, and then select **Commit new file**.

1. In Cloud Shell, run `git pull` to fetch the latest changes. Then, run the following command to tag and push the changes:

    ```bash
    git tag -a v2.0.1 -m 'Creating first production deployment' && git push --tags
    ```

1. When prompted, provide your GitHub username, and the PAT created previously as the password.

1. Open the **Actions** tab and see the running process.

### Test the production deployment

To test the production deployment, go to **contoso-production.\<your-dns-name\>** in your browser and confirm that the website appears.
