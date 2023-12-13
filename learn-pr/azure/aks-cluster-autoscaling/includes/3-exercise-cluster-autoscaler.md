## Enable the cluster autoscaler on an AKS cluster

1. Open the [Azure Cloud Shell](https://shell.azure.com) in your browser and select **Bash**.
2. Create an Azure resource group using the `az group create` command.

    ```azurecli-interactive
    az group create --name myResourceGroup --location eastus
    ```

3. Create a new AKS cluster with the cluster autoscaler enabled using the `az aks create` command and the `--enable-cluster-autoscaler` flag.

    ```azurecli-interactive
    az aks create --resource-group myResourceGroup --name myAKSCluster --enable-addons monitoring --enable-msi-auth-for-monitoring --enable-cluster-autoscaler --min-count 1 --max-count 10 --generate-ssh-keys
    ```

    It takes a few minutes to create the cluster.

4. Connect to your cluster using the `az aks get-credentials` command.

    ```azurecli-interactive
    az aks get-credentials --resource-group myResourceGroup --name myAKSCluster
    ```

5. View the nodes in your cluster using the `kubectl get nodes` command.

    ```azurecli-interactive
    kubectl get nodes
    ```

    Your output should look similar to the following example output:

    ```output
    NAME                                STATUS   ROLES   AGE   VERSION
    aks-nodepool1-12345678-vmss000000   Ready    agent   1m    v1.26.6
    aks-nodepool1-12345678-vmss000001   Ready    agent   1m    v1.26.6
    aks-nodepool1-12345678-vmss000002   Ready    agent   1m    v1.26.6
    ```

## Deploy the sample application

1. In Cloud Shell, create a manifest file for the Kubernetes Deployment called *deployment.yml* using the `touch` command.

    ```azurecli-interactive
    touch deployment.yml
    ```

2. Open the manifest file using the `code` command.

    ```azurecli-interactive
    code deployment.yml
    ```

3. Paste the following code into the manifest file.

    ```yml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website
    spec:
      replicas: 35
      selector:
        matchLabels:
          app: contoso-website
      template:
        metadata:
          labels:
            app: contoso-website
        spec:
          containers:
            - image: mcr.microsoft.com/mslearn/samples/contoso-website
              name: contoso-website
              resources:
                requests:
                  cpu: 100m
                  memory: 128Mi
                limits:
                  cpu: 250m
                  memory: 256Mi
              ports:
                - containerPort: 80
                  name: http
    ```

4. Save the file and close the editor.

## Update the cluster autoscaler profile

You can fine-tune the autoscaler profiles by setting a series of flags in the configuration. View the list of available flags in [Use the cluster autoscaler profile](/azure/aks/cluster-autoscaler#use-the-cluster-autoscaler-profile). For this example, you update the autoscaler to reduce the polling time to check for pending pods and reduce the amount of time it needs to wait before scaling down from a previous state.

1. Update the cluster autoscaler profile using the `az aks update` command with the `--cluster-autoscaler-profile` flag.

    ```azurecli-interactive
    az aks update --resource-group myResourceGroup --name myAKSCluster --cluster-autoscaler-profile scan-interval=5s scale-down-unready-time=5m scale-down-delay-after-add=5m
    ```

2. Scale down the deployment using the `kubectl scale deployment` command.

    ```azurecli-interactive
    kubectl scale deployment contoso-website --replicas 5
    ```

3. Check the cluster autoscaler logs and query for the *cluster-autoscaler-status* config map using the `kubectl describe cm` command.

    ```azurecli-interactive
    kubectl describe cm cluster-autoscaler-status -n kube-system
    ```

    Before the scale down, your output should look similar to the following example output:

    ```output
    Cluster-autoscaler status at 2023-11-09 20:08:14.892961701 +0000 UTC:
    Cluster-wide:
      Health:      Healthy (ready=3 unready=0 notStarted=0 longNotStarted=0 registered=3 longUnregistered=0)
                   LastProbeTime:      2023-11-09 19:56:57.890988498 +0000 UTC m=+1673.465985892
                   LastTransitionTime: 2023-11-09 19:45:09.593593337 +0000 UTC m=+774.168590731
      ScaleUp:     NoActivity (ready=3 registered=3)
                   LastProbeTime:      2023-11-09 19:56:57.890988498 +0000 UTC m=+1673.465985892
                   LastTransitionTime: 2023-11-09 19:45:09.593593337 +0000 UTC m=+774.168590731
      ScaleDown:   CandidatesPresent (candidates=3)
                   LastProbeTime:      2023-11-09 19:56:57.890988498 +0000 UTC m=+1673.465985892
                   LastTransitionTime: 2023-11-09 19:56:52.440038763 +0000 UTC m=+1101.015036157
    ```

4. Wait about five minutes for the autoscaler to complete the scale down, and then rerun the previous `kubectl describe cm`.

    After the scale down, your output should look similar to the following example output:

    ```output
    Cluster-autoscaler status at 2023-11-09 20:14:39.123206413 +0000 UTC:
    Cluster-wide:
      Health:      Healthy (ready=1 unready=0 (resourceUnready=0) notStarted=0 longNotStarted=0 registered=1 longUnregistered=0)
                   LastProbeTime:      2023-11-09 20:14:39.113206413 +0000 UTC m=+2150.697175601
                   LastTransitionTime: 2023-11-09 19:45:09.593593337 +0000 UTC m=+774.168590731
      ScaleUp:     NoActivity (ready=1 registered=1)
                   LastProbeTime:      2023-11-09 20:14:39.113206413 +0000 UTC m=+2150.697175601
                   LastTransitionTime: 2023-11-09 19:45:09.593593337 +0000 UTC m=+774.168590731
      ScaleDown:   NoCandidates (candidates=0)
                   LastProbeTime:      2023-11-09 20:14:39.113206413 +0000 UTC m=+2150.697175601
                   LastTransitionTime: 2023-11-09 20:07:08.79828656 +0000 UTC m=+1718.924760896
    ```

5. View the nodes in your cluster using the `kubectl get nodes` command.

    ```azurecli-interactive
    kubectl get nodes
    ```

    Your output should look similar to the following example output, with the number of nodes reduced to *one*:

    ```output
    NAME                                STATUS   ROLES   AGE   VERSION
    aks-nodepool1-12345678-vmss000000   Ready    agent   37m    v1.26.6
    ```
