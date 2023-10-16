Let's say your deployment team at Nod Publishers has already deployed the containerized applications onto an AKS cluster version going out of support within the next 30 days. This means that you need to upgrade to the latest Kubernetes version supported by AKS while ensuring the applications don't suffer from any downtime during the upgrade process.

There are many ways you can safely upgrade your AKS clusters. In this section, we discuss one of these methods: the Blue/Green deployment method.

### The Blue/Green deployment method

The Blue/Green deployment method requires two almost identical production environments, a blue environment and a green environment. The router responsible for directing traffic routes all traffic to one environment, the *live* environment. The other environment remains offline, providing a testing environment for new features and patches. When testing is complete, the router switches and routes traffic from the live environment to the other environment. This brings the offline environment online and takes the online environment offline.

Let's apply the Blue/Green deployment method to the Nod Publishers scenario. Your deployment team should follow these steps:

1. Create two identical AKS cluster environments: a live (online) blue environment and an offline green environment.

 :::image type="content" source="../media/3-route-traffic-to-blue-environment.png" border="false" alt-text="Diagram showing all traffic routed by a router to the AKS cluster in the blue environment.":::

2. Test the upgrade to the latest supported version by applying the upgrade to the green environment and ensure no issues arise.

 :::image type="content" source="../media/3-upgrading-aks-cluster-in-green-environment.png" border="false" alt-text="Diagram showing the AKS clusters in the green environment being upgraded.":::

3. Once you successfully complete testing, switch the router to direct all user traffic to the green environment and take the blue environment offline.

 :::image type="content" source="../media/3-route-traffic-to-green-environment.png" border="false" alt-text="Diagram showing that the router has switched to route traffic to the AKS clusters in the green environment.":::

A benefit of the Blue/Green deployment method is that if you detect an issue with the upgraded AKS cluster versions in the green environment, you can roll back to the blue environment by switching the router, thereby minimizing application downtime.

 :::image type="content" source="../media/3-rollback-to-blue-environment.png" border="false" alt-text="Diagram showing the rollback process by making a switch at the router level back to the blue environment.":::
