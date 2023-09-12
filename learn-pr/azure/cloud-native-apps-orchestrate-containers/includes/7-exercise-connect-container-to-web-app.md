Kubernetes gives Pods their own IP addresses and a single DNS name for a set of Pods. Service-manifest files contain instructions to expose Pods in a reliable way by defining a policy by how to connect with them. If a container image is redeployed, you don't need to reconfigure how to connect to the new image because of the instructions in the service manifest.

Ingress controllers define how your application can connect to the outside world. In the example scenario, smart fridges need to send messages to the Node.js container, and Ingress controllers determine the configuration of that connection.

In this unit, you will:

* Configure the ingress manifest so the container image can be accessed by outside applications.
* Deploy the ingress controller.
* Create a web app using a Docker image.

## Configure the ingress manifest

To expose your container to the management web app via DNS, you'll configure and deploy an ingress controller. You'll find the zone name to access the cna-express service and add to the `ingress.yaml` file.

1. Identify the fully qualified domain name (FQDN) of the host allowed access to the cluster.

     In Cloud Shell, run the `az network dns zone list` command to query the Azure DNS zone list:

    ```bash
    az aks show --resource-group $RESOURCEGROUP --name $CLUSTERNAME -o tsv --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName
    ```

2. Copy the output and open the integrated editor in Cloud Shell by entering `code .`
3. Open the `ingress.yaml` file and replace the `apiVersion` value with `networking.k8s.io/v1`.

    The `ingress.yaml` file should match the following YAML, with `<exampleURL.eastus.aksapp.io>` **replaced by the output in step 1**.

    ```yaml
    #ingress.yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: cna-express
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
      - host: cna-express.<exampleURL.eastus.aksapp.io>
        http:
          paths:
          - path: / # Which path is this rule referring to
            pathType: Prefix
            backend: # How the ingress will handle the requests
              service:
                name: cna-express # Which service the request will be forwarded to
                port: 
                  name: http # Which port in that service    
    ```

4. Save the manifest file by using <kbd>CTRL</kbd> + <kbd>S</kbd> and close the editor by using <kbd>CTRL</kbd> + <kbd>Q</kbd>.

### Deploy the ingress

Now we need to deploy the service for our changes to take effect.

1. In Cloud Shell, run the `kubectl apply` command to submit the ingress manifest to your cluster.

    ```bash
    kubectl apply -f ./ingress.yaml
    ```

    The command should output a result similar to the following example.

    ```output
    ingress.networking.k8s.io/cna-express created
    ```

1. Return the Cloud Shell to the source folder.

    ```bash
    cd ..
    ```

    There could be a small delay between the creation of the ingress and the creation of the zone record. Let's load the web app while this happens.

### Use a Docker image to create the web app

While AKS gets sets up, you can start to use the Container Registry to deploy the management web app.

You'll use the Docker image to deploy the web app, which will require a username and password to perform this action. The ACR allows you to enable the registry name as the username and admin access key as the password to allow Docker to sign in to your container registry.

1. Return to the [Azure portal](https://portal.azure.com/), and go to **All resources**.

1. Select the container registry you created earlier, to navigate to the Overview page for the container registry.

1. In the left menu pane, under **Settings**, select **Access keys**.

1. Set the **Admin user** option to **Enabled**. This change saves automatically.

    :::image type="content" source="../media/admin-user.png" alt-text="Screenshot that shows the Access keys page for the container registry with Admin user selected.":::

    You're now ready to create your web app.

### Review the ingress

1. In the Cloud Shell, run the ` kubectl get ingress` command to check if the deployment was successful:

    ```bash
    kubectl get ingress cna-express
    ```

    The command should output a result similar to the following example:

    ```output
    NAME              HOSTS                                           ADDRESS        PORTS   AGE
    cna-express       cna.5cd29ec927f24764b052.eastus.aksapp.io       52.226.96.30   80      4m44s
    ```

    Make sure the `ADDRESS` column of the output is filled with an IP address. That's the address of your cluster.

1. Let's query Azure to find out if our DNS has been created and we can access the website container.

    Run the `list` command to list all DNS zones again:

    ```bash
    az network dns zone list --output table
    ```

    The command should output a result similar to the following example:

    ```output
    ZoneName                               ResourceGroup                                 RecordSets    MaxRecordSets
    -------------------------------------  --------------------------------------------  ------------  ---------------
    5cd29ec927f24764b052.eastus.aksapp.io  mc_rg-contoso-video_aks-contoso-video_eastus  4             10000
    ```

1. Copy the `ZoneName` and `ResourceGroup` columns, and run the `az network dns` command. Replace the `<resource-group>` and `<zone-name>` value placeholders with the values you copied.

    ```bash
    az network dns record-set list -g <resource-group> -z <zone-name> --output table
    ```

    The command should output a result similar to the following example:

    ```output
    Fqdn                                            Name     ProvisioningState    ResourceGroup                                 Ttl
    ----------------------------------------------  -------  -------------------  --------------------------------------------  ------
    5cd29ec927f24764b052.eastus.aksapp.io.          @        Succeeded            mc_learn-cna-rg_cna-demo-aks_eastus           172800
    5cd29ec927f24764b052.eastus.aksapp.io.          @        Succeeded            mc_learn-cna-rg_cna-demo-aks_eastus           3600
    cna.5cd29ec927f24764b052.eastus.aksapp.io.      cna      Succeeded            mc_learn-cna-rg_cna-demo-aks_eastus           300
    cna.5cd29ec927f24764b052.eastus.aksapp.io.      cna      Succeeded            mc_learn-cna-rg_cna-demo-aks_eastus           300
    ```

    Make sure there are two new records at the bottom of the list with the host we created in the `host` key. The `ProvisioningState` value is `Succeeded`. It can take several minutes for zone records to propagate.

1. Open your browser, and go to your full aksapp.io FQDN URL described in the output. You should see a "hello world" message. **Remember to not include the `.` from the end of the URL.**

    :::image type="content" source="../media/deployment.png" alt-text="Screenshot of the deployment test.":::

### Create a web app

1. Go back to the [Azure portal](https://portal.azure.com/) home page, and select **Create a resource**.

1. In the left menu pane, select **Web**, then search for and select **Web App**. The **Web App** pane appears.

1. Select **Create**.

    :::image type="content" source="../media/search-web-app-annotated.png" alt-text="Screenshot that shows the Azure Marketplace with Web App selected.":::

    The **Create Web App** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Project Details** |
    | Subscription | Select your default Azure subscription in which you're allowed to create and manage resources. |
    | Resource Group | From the dropdown list, select the existing resource group. |
    | **Instance Details** |
    | Name | Enter a unique name and make a note of it for later. |
    | Publish | **Docker Container** (this is important)|
    | Operating System | **Linux** |
    | Region | Leave as default, or select a location that is close to you. |
    | **App Service Plan** |
    | App Service plan | Use the default |
    | Pricing plan | **Free F1** |

    Take note of your web app name; you'll need this in a couple of steps.

1. Select **Next: Docker**.

1. On the **Docker** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | Options | **Single Container** |
    | Image Source | **Azure Container Registry** (this is important) |
    | **Azure container registry options** |
    | Registry | Select your registry. |
    | Image | `webimage` |
    | Tag | `latest` |
    | Startup Command | Leave this setting empty. |

1. Select **Review and create**, then select **Create**.

1. When the deployment is complete, select **Go to resource**.

1. In the left menu pane, under **Settings**, select **Configuration**.

1. Under **Application settings**, select **New application setting**.

1. Copy the following value and paste it into the **Name** field.

    ```text
    SOCKET_SERVER_URL
    ```

1. For **Value**, use the same aksapp.io FQDN URL you used with your ingress controller and to access the hello world webpage.

1. Select **OK**, then select **Save**, then **Continue**.

    :::image type="content" source="../media/application-setting.png" alt-text="Screenshot that shows the Web App application setting being set.":::

1. Return to the Cloud Shell, and paste in the following command. Replace `<webapp-name>` with the name of your web app, and select <kbd>Enter</kbd> to save your web app name.

    ```bash
    WEBAPPNAME=<webapp-name>
    ```

### Test the solution

1. In the Azure Cloud Shell, run the following command and select the URL for your web app.

    ```bash
    echo select the link below
    echo http://$WEBAPPNAME.azurewebsites.net
    ```

And that's it! You've now created a scalable, cloud-native solution. Feel free to play around with the resources and code you've created. When you're done, run the next step in the Azure Cloud Shell to delete the resource group and avoid any unnecessary charges to your account.

```azurecli
az group delete --name $RESOURCEGROUP
```

Press <kbd>y</kbd>, then press <kbd>Enter</kbd>. The process will take a while, and you can move on to the next unit.
