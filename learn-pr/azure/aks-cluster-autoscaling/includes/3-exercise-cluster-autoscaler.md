Now that you know how the cluster autoscaler works, it's time to implement it.

> [!IMPORTANT]
> If you haven't deployed the example cluster, please refer back to [the introduction](/training/modules/aks-cluster-autoscaling/1-introduction).

## Enable the cluster autoscaler on an existing cluster

To enable the cluster autoscaler in an existing cluster, you can execute the `az aks update` command defining the minimum and maximum number of nodes you want it to create:

```azurecli-interactive
az aks update \
  -g learn-aks-cluster-scalability \
  -n learn-aks-cluster-scalability \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 10
```

You can update the autoscaler settings by replacing the `--enable-cluster-autoscaler` flag with `--update-cluster-autoscaler` and keeping the following parameters to update them to a new value.

Also, to enable the cluster autoscaler on a new cluster, just add `--enable-cluster-autoscaler` along with the `--min-count` and `--max-count` flags to an `az aks create` command.

> [!NOTE]
> It's important to notice that the autoscaler will not enforce the configurations once set. For example, if your node count is 3 and the minimum amount set is 5, the autoscaler won't immediately scale the cluster to 5 nodes.

After a few minutes the number of nodes in your cluster grows, and the number of pods in the **Pending** state decreases as more resources get allocated to them.

```
NAME                                      READY   STATUS    RESTARTS   AGE
contoso-website-ttlpv                     1/1     Running   0          5m12s
contoso-website-anzcydsfk-80tfl           1/1     Running   0          5m12s
contoso-website-mb62hlxfx-tr3xm           1/1     Running   0          5m12s
contoso-website-aexxpkyfu-dveyn           1/1     Running   0          5m12s
contoso-website-yien0mk3f-iy4bz           1/1     Running   0          5m12s
contoso-website-zbg3hvswb-uptrn           1/1     Running   0          5m12s
contoso-website-c04xe6ldd-i9mpx           1/1     Running   0          5m12s
contoso-website-eaywf5glm-raz9q           1/1     Running   0          5m12s
contoso-website-gbtgk04jj-c6usj           1/1     Running   0          5m12s
contoso-website-oiedarxiy-5i3kz           1/1     Running   0          5m12s
contoso-website-yeol8hald-6kg7y           0/1     Pending   0          5m12s
contoso-website-xkg9kmufy-juksf           0/1     Pending   0          5m12s
contoso-website-wb45271o4-30u0y           0/1     Pending   0          5m12s
...
```

## Tweak the cluster autoscaler profiles

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
