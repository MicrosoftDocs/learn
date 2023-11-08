## Enable the cluster autoscaler on an AKS cluster

1. Open the [Azure Cloud Shell](https://shell.azure.com) in your browser and select **Bash**.
2. Create an Azure resource group using the `az group create` command.

    ```azurecli-interactive
    az group create --name myResourceGroup --location eastus
    ```

3. Create a new AKS cluster with the cluster autoscaler enabled using the `az aks create` command and the `--enable-cluster-autoscaler` flag.

    ```azurecli-interactive
    az aks create --resource-group myResourceGroup --name myAKSCluster --enable-cluster-autoscaler --min-count 1 --max-count 3 --generate-ssh-keys
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

## Update the cluster autoscaler profile

It's possible to fine-tune the autoscaler profiles by setting a series of flags in its configuration. All the available flags can be found in [this Microsoft documentation](/azure/aks/cluster-autoscaler#using-the-autoscaler-profile). For now, let's fine-tune the autoscaler to be faster when scaling and polling the API, and decreasing the time for it to decrease the node count.

```azurecli-interactive
az aks update \
  -g learn-aks-cluster-scalability \
  -n learn-aks-cluster-scalability \
  --cluster-autoscaler-profile scan-interval=5s \
    scale-down-unready-time=5m \
    scale-down-delay-after-add=5m
```

What you're doing is reducing the polling time of the autoscaler to check for pending pods, and reducing the amount of time it needs to wait before scaling down from a previous state.

Try to scale down your deployment using `kubectl scale deployment contoso-website --replicas 5` and wait about five minutes to see the autoscaler in action. You can check the logs of the cluster autoscaler by querying the config map called `cluster-autoscaler-status`:

```azurecli-interactive
kubectl describe cm cluster-autoscaler-status -n kube-system
```

Initially it's going to show the number of current replicas, and current candidates to scale down, which means the number of nodes that will be scaled down in the future:

```output
Cluster-autoscaler status at 2021-03-29 23:26:41.892961701 +0000 UTC:
Cluster-wide:
  Health:      Healthy (ready=3 unready=0 notStarted=0 longNotStarted=0 registered=3 longUnregistered=0)
               LastProbeTime:      2021-03-29 23:26:41.890988498 +0000 UTC m=+1673.465985892
               LastTransitionTime: 2021-03-29 23:11:42.593593337 +0000 UTC m=+774.168590731
  ScaleUp:     NoActivity (ready=3 registered=3)
               LastProbeTime:      2021-03-29 23:26:41.890988498 +0000 UTC m=+1673.465985892
               LastTransitionTime: 2021-03-29 23:11:42.593593337 +0000 UTC m=+774.168590731
  ScaleDown:   CandidatesPresent (candidates=2)
               LastProbeTime:      2021-03-29 23:26:41.890988498 +0000 UTC m=+1673.465985892
               LastTransitionTime: 2021-03-29 23:17:09.440038763 +0000 UTC m=+1101.015036157
```

And after the scale down:

```output
Cluster-autoscaler status at 2021-03-29 23:34:39.123206413 +0000 UTC:
Cluster-wide:
  Health:      Healthy (ready=1 unready=0 notStarted=0 longNotStarted=0 registered=1 longUnregistered=0)
               LastProbeTime:      2021-03-29 23:34:39.122178207 +0000 UTC m=+2150.697175601
               LastTransitionTime: 2021-03-29 23:11:42.593593337 +0000 UTC m=+774.168590731
  ScaleUp:     NoActivity (ready=1 registered=1)
               LastProbeTime:      2021-03-29 23:34:39.122178207 +0000 UTC m=+2150.697175601
               LastTransitionTime: 2021-03-29 23:11:42.593593337 +0000 UTC m=+774.168590731
  ScaleDown:   NoCandidates (candidates=0)
               LastProbeTime:      2021-03-29 23:34:39.122178207 +0000 UTC m=+2150.697175601
               LastTransitionTime: 2021-03-29 23:27:27.349763602 +0000 UTC m=+1718.924760896
```

If you get the list of nodes, with `kubectl get nodes`, you see there's only one node available.
