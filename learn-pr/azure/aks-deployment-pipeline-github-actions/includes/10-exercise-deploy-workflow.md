With the Helm charts created, you now have all the tools you need to deploy the application to AKS by using GitHub Actions. In this unit, you finish the CI/CD pipeline by completing the final deployment steps.

:::image type="content" source="../media/3-pipeline-5-deploy.png" alt-text="Diagram that shows the procession from triggers, through three build steps, to the deploy step in a pipeline.":::

The deployment steps include:

- Create the deploy job.
- Set up Open ID Connect (OIDC).
- Deploy the application with Helm.
- Run the deployment on production.

## Add the deploy job

1. In GitHub, go to your fork of the repository.

1. Expand the *.github/workflows* directory and open the *build-staging.yml* file for editing.

1. Add a new `deploy` job at the end of the file, after the `build_push_image` job, as follows. Be sure to match the indentation.

    The job has three keys: `runs-on`, `needs`, and `permissions`.

    - For `runs-on`, use `ubuntu-20.04` to be consistent with the other job.
    - For `needs`, use the name of the first job, `build_push_image`, so the application only deploys after the image is built
    - For `permissions`, add two arguments called `id-token` and `contents`. Set `id-token` to `write` and `contents` to `read`, to grant GitHub Actions access to send requests and read the repo contents.

1. Add `- uses: actions/checkout@v2` as the first step of the job.

    The added `deploy` job should look like the following code:
    
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

### Add the Install Helm step

Use a GitHub action to download and install Helm version `v3.3.1`.

1. In the right panel of the editing page, search for *helm tool installer*. Select the first result published by **Azure**.

    :::image type="content" source="../media/10-helm-tool-installer.png" alt-text="Screenshot that shows the search results for the Helm installer action.":::

1. Select the copy icon to copy the usage YAML.

    :::image type="content" source="../media/10-helm-tool-installer-copy.png" alt-text="Screenshot that shows the copy function after selecting the Helm installer action.":::

1. Copy and paste the YAML below the `uses` key in *build-staging.yml*.

1. Rename the step from `Helm tool installer` to `Install Helm`, and pin the `version` key to `v3.3.1`.

    ```yaml
        steps:
          - uses: actions/checkout@v2

          - name: Install Helm
            uses: Azure/setup-helm@v1
            with:
              version: v3.3.1
      ```

### Add the Azure Login authentication step

Use OIDC to authenticate GitHub Actions to access AKS.

1. In the right panel, search for *Azure login*, and select **Azure Login** published by **Azure**.

    :::image type="content" source="../media/10-azure-login.png" alt-text="Screenshot that shows results for the Azure Login search.":::

1. Select the copy icon to copy the usage YAML, and paste it below the `Install Helm` step in *build-staging.yml*.

1. Change the step name from `Azure Login` to `Sign in to Azure with OIDC`.

1. `Azure Login` requires three parameters to authenticate: `client-id`, `tenant-id`, and `subscription-id`. Fill these parameters with placeholders for secrets you set later.

    ```yaml
          - name: Sign in to Azure with OIDC
            uses: Azure/login@v1.5.1
            with:
              client-id: ${{ secrets.AZURE_CLIENT_ID }}
              tenant-id: ${{ secrets.AZURE_TENANT_ID }}
              subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
    ```

1. In the right panel, search for *set context*, and select **Azure Kubernetes set context** published by **Azure**.

    :::image type="content" source="../media/10-azure-kubernetes-set-context.png" alt-text="Screenshot that shows the results for a Set Context search.":::

1. Select the copy icon to copy the usage YAML, and paste it below the `Sign in to Azure with OIDC` step in *build-staging.yml*. Fill the `resource-group` and `cluster-name` parameters with placeholders for the secrets you set in an earlier unit.

    ```yaml
          - name: Azure Kubernetes set context
            uses: Azure/aks-set-context@v3
            with:
              resource-group: ${{ secrets.RESOURCE_GROUP }}
              cluster-name: ${{ secrets.CLUSTER_NAME }}
    ```

    Your *build-staging.yml* file should look like the following example:

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
            needs: build_push_image # Will wait for the execution of the previous job
            permissions:
              id-token: write # This is required for requesting the JWT
              contents: read  # This is required for actions/checkout
    
            steps:
              - uses: actions/checkout@v2
    
              - name: Install Helm
                uses: Azure/setup-helm@v1
                with:
                  version: v3.3.1
    
              - name: Sign in to Azure with OIDC
                uses: Azure/login@v1.5.1
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

Assign values to your secrets by creating a service principal and certificates to log in with OIDC.

### Create the service principal

1. In [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true), run `az account show`, and save the `id` value from the output.

1. Create a service principal by running the following command, substituting the `id` value from the previous command for `$SUBSCRIPTION_ID`:

    ```azurecli
    az ad sp create-for-rbac --scopes /subscriptions/$SUBSCRIPTION_ID --role Contributor 
    ```

1. Copy the JSON output and save it for the next step.

### Set the secrets

On your GitHub repository page, select the **Settings** tab, and then select **Secrets and variables** > **Actions** from the left menu. Define the following three new secrets that use the output from the preceding steps.

- `AZURE_CLIENT_ID`: The `"appId"` value from `az ad sp create-for-rbac` output
- `AZURE_TENANT_ID`: The `"tenant"` value from `az ad sp create-for-rbac` output
- `AZURE_SUBSCRIPTION_ID`: The `id` value from `az account show` output

For each secret:

1. Select **New repository secret**.
1. For **Name**, enter the secret name.
1. For **Secret**, enter the value.
1. Select **Add secret**.

### Add federated credentials

Create federated certificates to authorize GitHub Actions to access the application.

1. In the Azure portal, go to [App registrations](https://ms.portal.azure.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade?azure-portal=true).

1. Search for and select the application that matches the `displayName` value returned in the previous `az ad sp create-for-rbac` step. By default, the application name uses the timestamp of the service principal creation.

1. Verify that the values of the **appID (Client ID)**, **Object ID (Application Object ID)**, and **Directory ID (Tenant ID)** match the previous JSON output.

1. In the left navigation, select **Certificates & secrets**.

1. On the **Certificates & secrets** screen, select the **Federated credentials** tab.

1. Select **Add credential**.

1. To add the staging credential, on the **Add a credential** screen, select or enter the following information:
   - **Federated credential scenario**: Select **GitHub Actions deploying Azure resources**.
   - **Organization**: Enter your GitHub user name.
   - **Repository**: Enter *mslearn-aks-deployment-pipeline-github-actions*.
   - **Entity type**: Select **Branch**.
   - **GitHub branch name**: Enter *main*.
   - **Name**: Enter *staging-cred*.
   - **Description** Enter *Testing*.

1. Select **Add**.

   :::image type="content" source="../media/add-credential.png" alt-text="Screenshot of the Add credential screen for the GitHub Actions staging credential.":::

1. To add the production credential, select **Add credential** again, and on the **Add a credential** screen, enter all the same values as for the previous credential except:
   - **Entity type**: Select **Tag**.
   - **GitHub tag name**: Enter *v2.0.0*, because in the next step you deploy version 2.
   - **Name**: Enter *prod-cred*.

1. Select **Add**.

## Deploy the application with Helm

Now that you configured Helm and granted access to your cluster, you're ready to deploy the application.

### Add the Run Helm Deploy step

1. Back in the *build-staging.yml* file in GitHub, after the latest step in the `deploy` job, create a new step named `Run Helm Deploy`. Below it, add another key called `run`.

    ```yaml
              - name: Run Helm Deploy
                run:
    ```

1. You can use the `run` key to execute any shell command inside the container. This pipeline uses the `run` key to execute the following Helm command:

    ```bash
    helm upgrade --install --create-namespace --atomic --wait 
        --namespace staging contoso-website \
        ./kubernetes/contoso-website \
        --set image.repository=${{ secrets.ACR_NAME }} \
        --set dns.name=${{ secrets.DNS_NAME }}
    ```

    Understand what each parameter does:

    |Parameter                       |Action or value                                                                  |
    |--------------------------------|---------------------------------------------------------------------------------|
    |`helm upgrade`                  |Upgrades an installed release.                                                   |
    |`--install`                     |If the release doesn't exist, installs it.                                        |
    |`--create-namespace`            |If the namespace in the `--namespace` flag doesn't exist, creates it.             |
    |`--atomic`                      |If the release fails, removes all workloads that have been installed.             |
    |`--wait`                        |Waits for the release to finish and returns `OK` status.                            |
    |`--namespace staging contoso-website` |Deploys the `contoso-website` release to the `staging` namespace.            |
    |`./kubernetes/contoso-website`  |Chart directory location.                                                        |
    |`--set image.repository`        |Updates the value of `image.repository` in the *values.yaml* file *for this release only*. |
    |`--set dns.name`                |Updates the `dns.name` key in the *values.yaml* file *for this release only*.      |

1. Add the command to the file and set it to run, starting with the `|` character. The `Run Helm deploy` step should match this example:

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

    Your completed *build-staging.yml* file should look like the following example:

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
            needs: build_push_image # Waits for the execution of the previous job
            permissions:
              id-token: write # Required for requesting the JWT
              contents: read  # Required for actions/checkout
    
            steps:
              - uses: actions/checkout@v2
    
              - name: Install Helm
                uses: Azure/setup-helm@v1
                with:
                  version: v3.3.1
    
              - name: Sign in to Azure with OIDC
                uses: Azure/login@v1.5.1
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

### Set the DNS_NAME secret

1. In a new browser tab, go to your fork of the repository, select the **Settings** tab, and then select **Secrets and variables** > **Actions** from the left menu.
1. Select **New repository secret**.
1. For **Name**, enter `DNS_NAME`.
1. For **Secret**, enter the **AKS DNS Zone Name** value from your original setup script output.

    If you don't have this value, run the following command in Cloud Shell, substituting your values for `<resource-group-name>` and `<aks-cluster-name>`:

    ```azurecli-interactive
    az aks show -g <resource-group-name> -n <aks-cluster-name> -o tsv --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName
    ```

1. Select **Add secret**.

### Commit the changes and test the staging deployment

1. To commit your changes, select **Commit changes**. Enter a description for the commit, and then select **Commit changes**. 

1. Select the **Actions** tab to see the build running.

1. After the build succeeds, in your browser go to `contoso-staging.<aks-dns-zone-name>` to confirm that the website appears.

## Run the deployment on production

The next step is to create the production workflow.

1. In the *.github/workflows* directory in your repository, open the *build-production.yml* file for editing.

1. Copy the `deploy` job from the staging pipeline and paste it below the last line in the *build-production.yml* file.

1. Change the `Run Helm Deploy` step to deploy to the production namespace by changing the `--namespace` flag from `staging` to `production`.

1. At the end of the Helm command, add a new parameter, `--set image.tag=${GITHUB_REF##*/}`.

    Here, you use a Bash feature called *parameter expansion*. The expansion `${ENV##<wildcard><character>}` returns the last occurrence of the string after `character`.

    In this case, you want to get only the tag name, which is represented as the GitHub Actions runtime, `GITHUB_REF`.  Branches are `refs/heads/<branch>`, while tags are `refs/tags/<tag>`. 

    You want to remove `refs/tags/` to get only the tag name, so you pass `${GITHUB_REF##*/}` to return everything after the last `/` in the `GITHUB_REF` environment variable.

   Your final *build-production.yml* file should look like the following example:

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

1. To commit your changes, select **Commit changes**. Enter a description for the commit, and then select **Commit changes**.

### Production changes

Every time you run the production workflow, you need to update the federated certificate with the corresponding tag version, as follows:

1. In the Azure portal, go to your application page and select **Certificates & secrets** in the left navigation.

1. Select the **Federated credentials** tab.

1. Select the **prod-cred** credential.

1. On the **Edit a credential** screen, next to **Based on selection**, increment the tag number to a new v.x.x.x such as *v.2.0.1*.

1. Select **Update**.

1. In [Cloud Shell](https://shell.azure.com/?azure-portal=true), run `git pull` to fetch the latest changes. Then, run the following command to tag and push the changes, substituting your new version tag for the placeholder:

    ```bash
    git tag -a v<new version tag> -m 'Create new production deployment' && git push --tags
    ```

1. When prompted, provide the PAT from previous exercises as the password.

1. In GitHub, open the **Actions** tab and see the running process.

1. After the workflow succeeds, to test the production deployment, go to `contoso-production.<aks-dns-zone-name>` in your browser and confirm that the website appears.

Continue to the next unit to delete your resources so they don't continue to incur charges.
