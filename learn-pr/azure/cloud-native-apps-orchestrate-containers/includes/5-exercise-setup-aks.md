In our example scenario, your team needs to deploy a container image from Azure Container Registry to AKS.

In this unit, you will:

* Connect to the AKS Kubernetes cluster using kubectl in Azure Cloud Shell.
* Configure a deployment manifest for the express.js container.
* Deploy the container image from the container registry to the AKS Kubernetes cluster.
* Enable an application gateway for your cluster.
* Review and deploy the service manifest file.

> [!NOTE]
>  
> If you exited your Azure Cloud Shell tab, you need to reapply the following commands or enter the resource names for each step.

    ```azurecli-interactive
    # Environment variable for the registry name
    REGISTRYNAME={registry_name}
    
    # Environment variable for the resource group name
    RESOURCEGROUP={resource-group-name}
    
    # Environment variable for the cluster name
    CLUSTERNAME={cluster-name}
    ```

## Connect to the cluster using kubectl

1. Navigate to [Azure Cloud Shell](https://shell.azure.com) and configure `kubectl` to connect to your Kubernetes cluster using the `az aks get-credentials` command.

    ```azurecli-interactive
    az aks get-credentials --resource-group $RESOURCEGROUP --name $CLUSTERNAME
    ```

2. Verify the connection to your cluster using the `kubectl get nodes` command, which returns a list of the cluster nodes.

    ```azurecli-interactive
    kubectl get nodes
    ```

3. Get your `ACR login server` name using the `az acr list` command.

    ```azurecli-interactive
    az acr list --resource-group $RESOURCEGROUP --query "[].{acrLoginServer:loginServer}" --output table
    ```

### Deploy your container to AKS

1. Change directories to the `aks` folder in the source code.

    ```azurecli-interactive
    cd mslearn-cloud-native-apps-express/aks
    ```

2. Open the integrated editor in Cloud Shell using `code .`

3. Open the `deployment.yaml` file to review the configuration. It contains the instructions to deploy the express.js container to AKS.

    ```yaml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: cna-express
    spec:
      selector: # Define the wrapping strategy
        matchLabels: # Match all pods with the defined labels
          app: cna-express # Labels follow the `name: value` template
      template: # This is the template of the pod inside the deployment
        metadata:
          labels:
            app: cna-express
        spec:
          containers:
            - image: <AcrLoginServer>/expressimage # Add your ACR login server from step 3 here
              name: expressimage
              ports:
                - containerPort: 80
    ```

4. In the `deployment.yaml`, replace `<AcrLoginServer>` with your ACR login server name. Make sure you leave the `/expressimage` at the end of the line.

5. Save the manifest file using <kbd>CTRL</kbd> + <kbd>S</kbd> and close the editor using <kbd>CTRL</kbd> + <kbd>Q</kbd>.

## Apply the manifest

1. Submit the deployment manifest to your cluster using the `kubectl apply` command.

    ```azurecli-interactive
    kubectl apply -f ./deployment.yaml
    ```

    The command should output a result similar to the following example:

    ```output
    deployment.apps/cna-express created
    ```

2. Check if the deployment was successful using the `kubectl get deploy` command.

    ```azurecli-interactive
    kubectl get deploy cna-express
    ```

    The command should output a table similar to the following example:

    ```output
    NAME              READY   UP-TO-DATE   AVAILABLE   AGE
    cna-express       0/1     1            0           16s
    ```

3. Check if the pod is running using the `kubectl get pods` command.

    ```azurecli-interactive
    kubectl get pods
    ```

    The command should output a table similar to the following example:

    ```output
    NAME                               READY   STATUS    RESTARTS   AGE
    cna-express-7c58c5f699-r79mv       1/1     Running   0          63s
    ```

### Enable the application gateway for the cluster

It can take some time to fully deploy Kubernetes clusters and access them. You can save time by enabling the application gateway for the cluster now, as it can take up to 15 minutes to be fully functional.

1. Navigate to the [Azure portal](https://portal.azure.com/) and select your AKS cluster.

1. Under **Settings**, select **Networking**.

1. Under **Traffic routing**, check the box for **Enable HTTP application routing**.

1. Under **Application Gateway ingress control**, check **Enable ingress controller**.

1. Select **Apply**.

### Review the service manifest

1. Navigate to [Azure Cloud Shell](https://shell.azure.com/) and make sure you're in the `aks` folder.

2. Open the integrated editor in Cloud Shell using `code .`.

3. Open the `service.yaml` file to review the configuration. **You don't need to edit anything**, just take note that we will name our service `cna-express`.

    ```yaml
    # service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: cna-express
    spec:
      type: ClusterIP
      selector:
        app: cna-express
      ports:
        - port: 80 # SERVICE exposed port
          name: http # SERVICE port name
          protocol: TCP # The protocol the SERVICE will listen to
          targetPort: 4000
    ```

4. Close the editor using <kbd>CTRL</kbd> + <kbd>Q</kbd>.

### Deploy the service

1. Submit the service manifest to your cluster using the `kubectl apply` command.

    ```azurecli-interactive
    kubectl apply -f ./service.yaml
    ```

    The command should output a result similar to the following example:

    ```output
    service/cna-express created
    ```

2. Check if the deployment was successful using the `kubectl get service` command.

    ```azurecli-interactive
    kubectl get service cna-express
    ```

    The command should output a result similar to the following example. Make sure the column `CLUSTER-IP` is filled with an IP address, the column `EXTERNAL-IP` is `<none>`, and the column `PORT(S)` is `80/TCP`.

    ```output
    NAME              TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
    cna-express       ClusterIP   10.0.158.189   <none>        80/TCP    42s
    ```

    With the external IP set to `<none>`, the application isn't available to external clients. The service is only accessible to the internal cluster. The ingress controller will change that.
