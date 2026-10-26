In the previous section, you saw how Azure policies can be used to govern your cluster by using a built-in policy and initiative. We also noted that the policy doesn't terminate already existing pods. We want to discover noncompliant pods so that we can take actions on them. In this exercise, we do just that.

## Using the Azure portal to see noncompliant pods

Follow these steps to locate noncompliant pods:

1. Go to the **Policy** page in the Azure portal.

1. Set the scope to your cluster resource group by selecting **...**. Select the subscription and resource group that contain the Azure Kubernetes Service (AKS) cluster, and then choose **Select**.

   :::image type="content" source="../media/6-find-the-right-scope.png" alt-text="Screenshot of the Azure Policy Scope pane with the subscription, resource group, and Select button highlighted." lightbox="../media/6-find-the-right-scope.png":::

   > [!NOTE]
   > Compliance reporting is asynchronous. The add-on requests a full scan every 15 minutes, and reports can include violations from the preceding 45 minutes. A deleted Pod can therefore remain visible in recent compliance history. These intervals aren't a guaranteed maximum portal-refresh time. Check the reported timestamps and refresh after a subsequent audit cycle.

   The following example shows noncompliance for both the allowed-images policy and the restricted initiative. In this example, three checks in the initiative report violations. Counts and Pod names are illustrative; inspect your assignment's results rather than expecting the same counts.

    :::image type="content" source="../media/6-not-compliant-cluster.png" alt-text="Screenshot of Azure Policy showing noncompliance for the allowed-images policy and restricted security initiative." lightbox="../media/6-not-compliant-cluster.png":::

1. Open the **Kubernetes cluster containers should only use allowed images** assignment and select the noncompliant AKS resource.

1. Inspect **Component Compliance** for the affected Pod names and namespaces. Identify the Pod created by the original `simple-nginx` Deployment and check the reported timestamps. See Component details for Resource Provider modes.

   :::image type="content" source="../media/6-non-compliant-pod.png" alt-text="Screenshot of Azure Policy component compliance identifying the original nginx pod as noncompliant." lightbox="../media/6-non-compliant-pod.png":::

## Remove the noncompliant pod and recheck compliance

Remove the original noncompliant Deployment rather than deleting only its controller-owned Pod. The allowed-images policy is already enforcing new Pod admission; deleting the existing workload doesn't activate the policy. The restricted initiative remains in Audit mode. Hardening the workload to satisfy that initiative is outside this exercise, so focus on compliance with the allowed-images assignment.

Open Cloud Shell Bash. If the session restarted, select the lab subscription and retrieve the cluster credentials again using the commands from the setup unit. Confirm that the current context is the lab cluster before deleting anything.

```bash
kubectl config current-context
```

Delete the original Deployment in the `default` namespace and check for its remaining Pods.

```bash
kubectl delete deployment simple-nginx --namespace default --wait=true
kubectl get pods --namespace default -l app=nginx
```

Confirm that the original workload's Pods have been removed. After reporting catches up, return to the allowed-images assignment and examine any remaining violations. If all remaining in-scope Pods comply, that assignment should report compliance. The separate restricted initiative can still report noncompliance. The following screenshot illustrates the allowed-images result, not a guarantee that every assignment is compliant.

   :::image type="content" source="../media/6-cluster-now-compliant.png" alt-text="Screenshot of Azure Policy showing the allowed-images assignment as compliant while other assignments remain noncompliant." lightbox="../media/6-cluster-now-compliant.png":::

If reports remain stale or show an error, inspect the add-on and constraint status and follow Azure Policy for Kubernetes troubleshooting. A missing or stale report doesn't prove compliance. For the scan and reporting behavior, see Policy evaluation.

## Summary

In this unit, you used Azure Policy component compliance to identify the original noncompliant workload, removed its Deployment, and checked the allowed-images assignment after reporting caught up. Compliance with this assignment is separate from compliance with the restricted initiative. You can use the same process to inspect other built-in Kubernetes policies that suit your business needs.
