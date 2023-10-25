Deployment manifest files contain instructions to define what type of resource you want to deploy and all the details associated with the deployment workload. In the example scenario, the team needs to deploy a container image from Azure Container Registry to AKS.

In this unit, you will:

* Connect to the AKS Kubernetes cluster using kubectl in Azure Cloud Shell.
* Configure a deployment manifest for the express.js container.
* Deploy the container image from the container registry to the AKS Kubernetes cluster.
* Enable an Application gateway for your cluster.
* Review and deploy the service manifest file.

> [!NOTE]
>  
> If you've exited your Azure Cloud Shell tab, you'll have to reapply the following commands or type the names in each step.

  ```bash
  CLUSTERNAME={cluster-name}
  ```

  ```bash
  REGISTRYNAME={registry_name}
  ```

  ```bash
  RESOURCEGROUP={resource-group-name}
  ```

## Connect to the cluster using kubectl

1. To configure `kubectl` to connect to your Kubernetes cluster, use the `az aks get-credentials` command in the Azure Cloud Shell.

      ```azurecli
      az aks get-credentials --resource-group $RESOURCEGROUP --name $CLUSTERNAME
      ```

1. To verify the connection to your cluster, run the `kubectl get nodes` command to return a list of the cluster nodes:

    ```azurecli
    kubectl get nodes
    ```

    Now, you've connected to the cluster and verified that the nodes are deployed and ready. Next, you'll query the server to get information for our deployment file.

1. Get the `ACR login server` name using the `az acr list` command as follows:

    ```azurecli
    az acr list --resource-group $RESOURCEGROUP --query "[].{acrLoginServer:loginServer}" --output table
    ```

### Deploy your container to AKS

You'll be using a deployment manifest file to deploy your application. The manifest file allows you to define what type of resource you want to deploy and all the details associated with the workload.

Kubernetes groups containers into logical structures called pods, which have no intelligence. Deployments add the missing intelligence to create your application. Let's edit the base deployment file in the source code for your cluster.

1. In Cloud Shell, move to the AKS folder:

    ```bash
    cd mslearn-cloud-native-apps-express/aks
    ```

1. Open the integrated editor in Cloud Shell by entering `code .`

1. Open the `deployment.yaml` file, which is missing our `ACR login server` from step 3. The file contains the instructions to deploy our express container, with the following configuration.

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

1. **Change the `<AcrLoginServer>` to the server that was output in step 3**. Remember to leave the `/expressimage` directly after.

1. Save the manifest file by using <kbd>CTRL</kbd> + <kbd>S</kbd> and close the editor by using <kbd>CTRL</kbd> + <kbd>Q</kbd>.

## Apply the manifest

1. In Cloud Shell, run the `kubectl apply` command to submit the deployment manifest to your cluster:

    ```bash
    kubectl apply -f ./deployment.yaml
    ```

    The command should output a result similar to the following example:

    ```output
    deployment.apps/cna-express created
    ```

1. Run the `kubectl get deploy` command to check if the deployment was successful:

    ```bash
    kubectl get deploy cna-express
    ```

    The command should output a table similar to the following example:

    ```output
    NAME              READY   UP-TO-DATE   AVAILABLE   AGE
    cna-express       0/1     1            0           16s
    ```

1. Run the `kubectl get pods` command to check if the pod is running:

    ```bash
    kubectl get pods
    ```

    The command should output a table similar to the following example:

    ```output
    NAME                               READY   STATUS    RESTARTS   AGE
    cna-express-7c58c5f699-r79mv       1/1     Running   0          63s
    ```

### Prepare AKS for use

It can take some time to fully deploy Kubernetes clusters and access them. You'll save time by enabling the Application gateway for the cluster now, as it can take up to 15 minutes to be fully functional.

1. Go to the Azure portal and select the AKS service you created earlier.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com/)

1. On **Settings** menu on the left side of the screen, select **Networking**.

1. Check the box for **Enable ingress controller**.

1. Select **Apply** and return to the Cloud Shell.

    You set your cluster up for deployment by configuring the deployment manifest file and enabling the Application gateway. In the next unit, we'll review the ingress controller you just enabled.

### Review the service manifest

Like all resources, services also have manifest files that describe how they should behave. Let's create a new service description.

1. Return to Azure Cloud Shell if you haven't done so already.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/)

1. In the Cloud Shell, if you've left the `aks` folder, navigate back to it.

1. Open the integrated editor in Cloud Shell by entering `code .`

1. Open the `service.yaml` file to review the following configuration. **You don't need to edit anything**, just take note that we're going to name our service `cna-express`.

    ```yaml
    #service.yaml
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

1. Close the editor by using <kbd>CTRL</kbd> + <kbd>Q</kbd>.

### Deploy the service

1. In Cloud Shell, run the `kubectl apply` command to submit the service manifest to your cluster:

    ```bash
    kubectl apply -f ./service.yaml
    ```

    The command should output a result similar to the following example:

    ```output
    service/cna-express created
    ```

1. Run the `kubectl get service` command to check if the deployment was successful:

    ```bash
    kubectl get service cna-express
    ```

    The command should output a result similar to the following example. Make sure the column `CLUSTER-IP` is filled with an IP address and the column `EXTERNAL-IP` is `<none>`. Also, make sure the column `PORT(S)` is defined to `80/TCP`.

    ```output
    NAME              TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
    cna-express       ClusterIP   10.0.158.189   <none>        80/TCP    42s
    ```

    With the external IP set to `<none>`, the application isn't available to external clients. The service is only accessible to the internal cluster. The ingress controller will change that.
