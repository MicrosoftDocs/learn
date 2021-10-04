In the previous section you saw how Azure policies can be used to easily govern your cluster by using a built-in policy  and policy initiative. We also noted that the policy does not terminate already existing pods. We however would like to see non-compliant pods so that we can take actions on them. We will do that in this exercise.

## Using the Azure Portal to see non-compliant pods

1. Go to the [Policy](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyMenuBlade/Overview) page in **Azure Portal**.

1. At the top you can set the scope to your cluster resource group by clicking on the **...** Select the Subscription and the resource group where the AKS cluster is sitting and click **Select** at the bottom.

   ![screenshot showing how to set the scope of what policies you're interested in viewing](../media/6-find-the-right-scope.png)

   Here we see that we have non-compliant resources for both policies we deployed. The resources are not compliant with 3 of the policies from the **Kubernetes cluster pod security restricted standards for Linux-based workloads for videogamerg** initiative. Clicking on that initiative will show which of the nine polices are the three that are not compliant.

   ![screenshot showing the policies that the resources are not compliant with](../media/6-not-compliant-cluster.png)

1. Click on the **Kubernetes cluster containers should only use allowed images** policy. You will see the cluster that has the non-compliant pod in it

1. Click on the cluster to get more details on which pod is not compliant. Here you will see the name of the specific pod that is not compliant. You will see that it is only the first pod that was deployed that is not compliant. This is an effective way to audit compliance status of your cluster.

   ![screenshot showing the policies that the resources are not compliant with](../media/6-non-compliant-pod.png)

## Remove non compliant pod and check for compliance

Now that we have found the pod that is not compliant, we will go ahead and delete that pod. Once the pod is deleted, the policy will prevent future pods that are not compliant with the policy: **Kubernetes cluster containers should only use allowed images** from being deployed. The **Kubernetes cluster pod security restricted standards for Linux-based workloads for videogamerg** initiative is set to audit meaning we can identify pods that are not compliant, but would not prevent the pods from being deployed. Getting our pods to comply with that initiative is beyond the scope of this course, so we will focus on fixing the policy that we set to have the **deny** effect.

1. Open the Cloud shell again and delete the non-compliant deployment

   ```bash
   kubectl delete -f nginxfromdocker.yaml
   ```

1. It might take up to 45 minutes for the changes to reflect on the portal. After waiting, head back to the policy to to see if there are still any uncompliant pods under that policy. You will find that your cluster is now in compliance with the policy.

   ![screenshot showing that the resource is now compliant](../media/6-cluster-now-compliant.png)

## Summary

In this module, you learned Azure policy is and how to use it for your Kubernetes cluster. You also learned how to troubleshoot your deployments and identify pods that are not being deployed because of a deny policy it is not compliant with. You also learned how to use Azure Portal to see uncompliant resources and which policies they are not compliant with. You also resolved one of the issues by deleting the uncompliant pod you first created. Now that you have added and tested out a Policy and an Initiative, you can go through the other in-built policies for Kubernetes and find those that suit your business needs.
