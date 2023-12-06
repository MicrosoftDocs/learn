With the Helm charts created, you now have all the tools you need to deploy the application to AKS by using GitHub Actions. Let's use what you created to finish the deployment pipeline.

In this unit, you'll complete the final step in the diagram—the deploy steps.

:::image type="content" source="../media/3-pipeline-5-deploy.png" alt-text="Diagram that shows the procession from triggers, through three build steps, to the deploy step in a pipeline.":::

These steps include:

- Create the deploy job
- Set up Open ID Connect (OIDC)
- Deploy the application with Helm
- Run the deployment on production

## Create the deploy job

1. In GitHub, go to your fork of the repository.

1. Go to the `.github/workflows` directory in the repository, and then open the `build-staging.yml` file.

   Your `build-staging.yml` should match exercise 6:

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

1. Add a new `deploy` job after the `build_push_image` job. Keep underneath all the contents and match the indentation.

1. Assign it three keys: `runs-on`, `needs`, and `permissions`.

    1. For `runs-on`, we use the same as the other job, to keep consistency as `ubuntu-20.04`.
    1. Set the `needs` value as the name of the first job, `build_push_image`, so will only deploy after the image is built
    1. Add the permissions key with two arguments under called `id-token` and `contents`. 

1. For workflow permissions, add the keys `id-token` and `contents` under the `permissions` key.

    Set the `id-token` to `write`, and `contents` to `read` to grant GitHub Actions access to read the repo and write to send requests.

    ```yaml
    name: Build and push the latest build to staging
    
    on:
      push:
        branches: [ main ]
    
    jobs:
      build_push_image:
        ...

      deploy:
        runs-on: ubuntu-20.04
        needs: build_push_image # Will wait for the execution of the previous job
        permissions:
          id-token: write # This is required for requesting the JWT
          contents: read  # This is required for actions/checkout
        ```

1. Add `- uses: actions/checkout@v2` as the first step:

    ```yaml
      deploy:
        runs-on: ubuntu-20.04
        needs: build_push_image
        permissions:
          id-token: write
          contents: read

        steps:
          - uses: actions/checkout@v2
    ```

### Install Helm

In this exercise, you use Helm version `v3.3.1`. GitHub has an action that downloads and installs Helm.

1. Add a new `steps` key to deploy. Then, search for **Helm tool installer**. Select the first result published by **Azure**.

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

### Authenticate with Azure Login

For authentication, it's recommended to use Open Identity Connect (OIDC) for GitHub Actions to access Azure Kubernetes Services (AKS).

1. In the search bar of the workflow Actions, enter *Azure login*. In the search results, select **Azure Login** published by **Azure**.

    :::image type="content" source="../media/10-azure-login.png" alt-text="Screenshot that shows results for the Azure Login search.":::

    In the panel for the search result item, under **Installation**, select the copy icon to copy the usage YAML.

    :::image type="content" source="../media/10-azure-login-copy.png" alt-text="Screenshot that shows the copy function after selecting the Azure Login action.":::

1. Azure Login requires three parameters to authenticate: `client-id`, `tenant-id`, and `subscription-id`. Fill it in with placeholders to set for later.

1. In the search bar of the workflow Actions, enter *set context*. In the search results, select **Azure Kubernetes set context** published by **Azure**.

    :::image type="content" source="../media/10-azure-kubernetes-set-context.png" alt-text="Screenshot that shows the results for a Set Context search.":::

    In the panel for the search result item, under **Installation**, select the copy icon to copy the usage YAML.

    :::image type="content" source="../media/10-azure-kubernetes-set-context-copy.png" alt-text="Screenshot that shows the copy function after selecting the Azure Kubernetes set context action.":::
 
1. Define the `RESOURCE_GROUP` key to the name of the resource group that contains your AKS resource. Run the following command in Cloud Shell to get the resource group:

    ```azurecli-interactive
    az aks list -o tsv --query "[?name=='contoso-video'].resourceGroup"
    ```

1. In the `CLUSTER_NAME` key, enter the cluster name. The name of the AKS cluster in this exercise is fixed as `contoso-video`.

1. Fill in the secrets with the values of this key `${{ secrets.YOUR_KEY_NAME }}`.


    ```yaml
    steps:
      - uses: actions/checkout@v2

      - name: Install Helm
        uses: Azure/setup-helm@v1
        with:
          version: v3.3.1

      - name: Login to Azure with OIDC
        uses: azure/login@v1
        with:
          client-id: ${{ secrets.AZURE_CLIENT_ID }}
          tenant-id: ${{ secrets.AZURE_TENANT_ID }}
          subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

      - name: Azure Kubernetes set context
        uses: Azure/aks-set-context@v3
        with:
          resource-group: ${{ secrets.RESOURCE_GROUP }}
          cluster-name: ${{ secrets.CLUSTER_NAME }}
    ```

## Set up Open ID Connect (OIDC)

You've added secrets, but they have no value. Let's assign them by creating a service principal and certificates to log in with OIDC.

### Register your app

1. Find your subscription ID

    ```azurecli-interactive
    az account show
    ```

    Your subscription_id is the `id`. Copy the ID.

1. Create a Service Principal

    ```azurecli-interactive
    az ad sp create-for-rbac --scopes /subscriptions/$SUBSCRIPTION_ID --role Contributor 
    ```

    Copy your JSON output and save it for the next step.

    ```json
      {
        "appId": <client_id>,
        "displayName": <generated-display-name>,
        "password": <secret>,
        "tenant": <tenant_id>
      }
    ```

### Load the secrets

1. Go to your fork of the GitHub online repository and select the **Settings** tab.

1. In the menu under **Security**, select **Secrets** and choose **Actions**. 

1. Inside the **Actions Secrets** pane, select **New repository secret**.

1. Define three new secrets in GitHub called `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, and `AZURE_SUBSCRIPTION_ID`.

1. Create a new secret for each new value added.

1. Copy the output from the service principal and paste it in the corresponding values for all three.

### Assign Federated Certificates

1. Verify your app in the [Application Registration](https://ms.portal.azure.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade).

1. Select the application that matches your displayName. By default, it uses a timestamp for the service principal creation.

1. Confirm the contents of the appID (Client ID), Object ID (Application Object ID), and Directory ID (Tenant ID).

1. Create a new file named staging-cred.json. Copy and paste this template into it.

    ```json
    {
      "name": "<CREDENTIAL-NAME-1>",
      "issuer": "https://token.actions.githubusercontent.com",
      "subject": "repo:<YOUR_USERNAME>/mslearn-aks-deployment-pipeline-github-actions:ref:refs/head/main",
      "description": "Testing",
      "audiences": [
          "api://AzureADTokenExchange"
      ]
    }
    ```

1. Overwrite `<CREDENTIAL-NAME-1>` with any name with no spaces.

1. Edit the `subject` to fill in with your GitHub username.

1. Create another file named prod-cred.json. Copy and paste this template into it.

    ```json
    {
      "name": "<CREDENTIAL-NAME-2>",
      "issuer": "https://token.actions.githubusercontent.com",
      "subject": "repo:<YOUR_USERNAME>/mslearn-aks-deployment-pipeline-github-actions:ref:refs/tags/<YOUR_TAG>",
      "description": "Testing",
      "audiences": [
          "api://AzureADTokenExchange"
      ]
    }
    ```

1. Overwrite the `<CREDENTIAL-NAME-2>` with a different name from the first, with no spaces.

1. In the subject, update it with your username and replace `<YOUR_TAG>` with `v2.0.0`. In the next step, we deploy version 2.

1. Attach the new federated certificates to the authorize GitHub actions to access the application.

    ```azurecli-interactive
    az ad app federated-credential create --id $APPLICATION_OBJECT_ID --parameters <prod-cred.json 
    ```

## Deploy the application with Helm

Now, you have granted access to your cluster and have Helm installed. You're ready to deploy the application.

1. In the YAML file, below the latest step, create a new `- name:` key. Name the key `Run Helm Deploy`. Then, below this key, create another key called `run`.

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

      deploy:
        runs-on: ubuntu-20.04
        needs: build_push_image

        steps:
          - uses: actions/checkout@v2

          - name: Install Helm
            uses: Azure/setup-helm@v1
            with:
              version: v3.3.1

          - name: Login to Azure with OIDC
            uses: azure/login@v1
            with:
              client-id: ${{ secrets.AZURE_CLIENT_ID }}
              tenant-id: ${{ secrets.AZURE_TENANT_ID }}
              subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

          - name: Azure Kubernetes set context
            uses: Azure/aks-set-context@v3
            with:
              resource-group: ${{ secrets.RESOURCE_GROUP }}
              cluster-name: ${{ secrets.CLUSTER_NAME }}

          - name: Run Helm Deploy
            run:
    ```

1. You can use the `run` key to execute any shell command inside the container. Because you're using Ubuntu, your shell is Bash. We execute the following helm command using the `run` key:

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

    But first, let's look at each parameter to understand what each command does:

    |Parameter                       |Action or value                                                                  |
    |--------------------------------|---------------------------------------------------------------------------------|
    |`helm upgrade`                  |Upgrades an installed release.                                                   |
    |`--install`                     |If the release doesn't exist, install it.                                        |
    |`--create-namespace`            |If the namespace in the `--namespace` flag doesn't exist, create it.             |
    |`--atomic`                      |If the release fails, remove all workloads that have been installed.             |
    |`--wait`                        |Wait for the release to finish and return `OK`status.                            |
    |`--namespace staging`           |Deploy this release to the `staging` namespace.                                  |
    |`contoso-website`               |Release name.                                                                    |
    |`./kubernetes/contoso-website`  |Chart directory location.                                                        |
    |`--set image.repository`        |Updates the value of `image.repository` in `values.yaml`*for this release only*. |
    |`--set dns.name`                |Updates the `dns.name` key in the values.yaml file *for this release only*.      |

    Run the command, starting with the `|` character. The Run Helm deploy step should match this example:

    ```yaml
      ...
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

1. In a new browser tab, go to your fork of the repository. Select the **Settings** tab.

1. In the menu under **Security**, select **Secrets** and choose **Actions**. The **Actions Secrets** pane opens.

1. Select **New repository secret**.

1. Create a new secret called `DNS_NAME`. You can get the value to use for this secret by running the following command in Cloud Shell:

    ```azurecli-interactive
    az aks show -g {resource-group-name} -n {aks-cluster-name} -o tsv --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName
    ```

    Save the secret and close the browser tab.

1. To commit the changes, select the **Start commit** button. Enter a description for the commit, and then select **Commit new file**:

    :::image type="content" source="../media/6-5-commit-staging.png" alt-text="Screenshot that shows the Start commit and Commit new file button in the Commit new file pane.":::

    The build starts running on the **Actions** tab.

1. Test the staging deployment

Go to **contoso-staging.\<your-dns-name\>** to test the staging deployment in your browser.

## Run the deployment on production

With the staging workflow created, the next step is to create the production workflow.

1. In the **Code** view on the GitHub website, go to the `.github/workflows` directory. Select the `build-production.yaml` file and edit it.

1. Copy the `deploy` job from the previous pipeline and paste it below the last line of the YAML file.

   The job should look like this example:

    ```yaml
    name: Build and push the tagged build to production

      ...

      deploy:
        runs-on: ubuntu-20.04
        needs: build_push_image

        steps:
          - uses: actions/checkout@v2

          - name: Install Helm
            uses: Azure/setup-helm@v1
            with:
              version: v3.3.1

          - name: Login to Azure with OIDC
            uses: azure/login@v1
            with:
              client-id: ${{ secrets.AZURE_CLIENT_ID }}
              tenant-id: ${{ secrets.AZURE_TENANT_ID }}
              subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

          - name: Azure Kubernetes set context
            uses: Azure/aks-set-context@v3
            with:
              resource-group: ${{ secrets.RESOURCE_GROUP }}
              cluster-name: ${{ secrets.CLUSTER_NAME }}

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

1. At the end of the Helm command, add a new parameter, `--set image.tag=${GITHUB_REF##*/}`.

    Here, you're using a Bash feature called *parameter expansion*. The expansion `${ENV##<wildcard><character>}` returns the last occurrence of the string after `character`.

    In this case, you want to get only the tag name, which is represented as the GitHub Actions runtime, `GITHUB_REF`.  Branches are `refs/heads/<branch>`, while tags are `refs/tags/<tag>`.

    We want to remove `refs/tags/` to get only the tag name, so we pass `${GITHUB_REF##*/}` to return everything after the last `/` in the `GITHUB_REF` environment variable.

   The final YAML file should look like this example:

    ```yaml
    name: Build and push the tagged build to production
    
    permissions:
      id-token: write # This is required for requesting the JWT
      contents: read  # This is required for actions/checkout
    
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
            uses: docker/setup-buildx-action@v3.0.0
    
          - name: Docker Login
            uses: docker/login-action@v3.0.0
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
    
      deploy:
        runs-on: ubuntu-20.04
        needs: build_push_image
    
        steps:
          - uses: actions/checkout@v2
    
          - name: Install Helm
            uses: Azure/setup-helm@v1
            with:
              version: v3.3.1
    
          - name: Login to Azure with OIDC
            uses: azure/login@v1
            with:
              client-id: ${{ secrets.AZURE_CLIENT_ID }}
              tenant-id: ${{ secrets.AZURE_TENANT_ID }}
              subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
    
          - name: Azure Kubernetes set context
            uses: Azure/aks-set-context@v3
            with:
              resource-group: ${{ secrets.RESOURCE_GROUP }}
              cluster-name: ${{ secrets.CLUSTER_NAME }}
    
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

### Production changes

Each time you run the production workflow, you need to update the federated certificate with the corresponding tag version.

1. Open up your `prod-cred.json`

1. Edit the <TAG_NAME> from v2.0.0 to a different v.x.x.x.

1. Update the application's federated credential in Azure with this command.

    ```azurecli-interactive
    az ad app federated-credential update --federated-credential-id $CREDENTIAL_NAME --id $APPLICATION_OBJECT_ID --parameters prod-cred.json 
    ```

    Fill in the CREDENTIAL_NAME as the name you chose, and the APPLICATION_OBJECT_ID as the Object ID of your app.

1. In Cloud Shell, run `git pull` to fetch the latest changes. Then, run the following command to tag and push the changes:

    ```bash
    git tag -a v2.0.1 -m 'Creating first production deployment' && git push --tags
    ```

1. Provide your GitHub username and the PAT from the past exercise as the password.

1. Open the **Actions** tab and see the running process.

1. To test the production deployment, go to **contoso-production.\<your-dns-name\>** in your browser and confirm that the website appears.
