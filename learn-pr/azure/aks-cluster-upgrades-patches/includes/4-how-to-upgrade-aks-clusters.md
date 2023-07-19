Suppose the Nod Publishers deployment team has already deployed their containerized applications onto an AKS cluster version that will go out of support within the next 30 days. They must upgrade to the latest Kubernetes version supported by Azure Kubernetes Service while ensuring the applications don't suffer from any downtime during the upgrade. 

There are several methods of safely upgrading AKS clusters. We'll discuss one of these methods, which is the Blue/Green deployment method.

### The Blue/Green deployment method

The Blue/Green deployment method requires two production environments, a blue environment and a green environment, which are almost identical. The router responsible for directing traffic will route all traffic to one environment, which is the live environment. The other environment is kept offline, and this is where you can test new features and patches. When testing is complete, the router switches and routes traffic to the other environment. This brings the offline environment online and takes the online environment offline.

For example, the Nod Publishers deployment team, following a Blue/Green deployment methodology, will need to create two identical AKS cluster environments: a blue environment that's currently live and a green environment that's currently offline.

 :::image type="content" source="../media/3-route-traffic-to-blue-environment.png" border="false" alt-text="Diagram showing all traffic routed by a router to the AKS cluster in the blue environment.":::

When the deployment team upgrades their AKS clusters to the latest supported version, they make the upgrade to the AKS cluster in the green environment and test the green environment to ensure no issues arise from the upgrade.

 :::image type="content" source="../media/3-upgrading-aks-cluster-in-green-environment.png" border="false" alt-text="Diagram showing the AKS clusters in the green environment being upgraded.":::

Once the green environment is ready to go, the team can switch the router to direct all user traffic to the green environment and take the blue environment offline.

 :::image type="content" source="../media/3-route-traffic-to-green-environment.png" border="false" alt-text="Diagram showing that the router has switched to route traffic to the AKS clusters in the green environment.":::

One of the benefits of Blue/Green deployment is that if Nod Publishers detects an issue with the upgraded AKS cluster versions in the green environment, they can roll back to the blue environment by switching the router, thereby minimizing application downtime.

 :::image type="content" source="../media/3-rollback-to-blue-environment.png" border="false" alt-text="Diagram showing the rollback process by making a switch at the router level back to the blue environment.":::
