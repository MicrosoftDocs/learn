The address space of the virtual network should be large enough to hold all subnets. Account for all entities that receives traffic. IP addresses for the entities are allocated from the subnet address space.

## Upgrade

AKS updates nodes regularly to make sure the underlying virtual machines are up to date on security features and other system patches. During an upgrade process, AKS creates a node that temporarily hosts the pods, while the upgrade node is cordoned and drained. That temporary node is assigned an IP address from the cluster subnet.

For pods, you might need extra addresses depending on your strategy. For rolling updates, you need to addresses for the temporary pods that run the workload while the actual pods are updated. If you use the replace strategy, pods are removed, and the new ones are created. So, addresses associated with the old pods are reused.

## Scalability

Take into consideration the node count of all system and user nodes and their maximum scalability limit. Suppose you want to scale out by 400%. Use four times the number of addresses for all those scaled-out nodes.

In this architecture, each pod can be contacted directly. So, each pod needs an individual address. Pod scalability impacts the address calculation. That decision depends on your choice about the number of pods you want to grow.

## Azure Private Link addresses

Factor in the addresses that are required for communication with other Azure services over Private Link. In this architecture, we have two addresses assigned for the links to Azure Container Registry and Key Vault.

:::image type="content" source="../media/hub-spoke-network-address-d9ccb539.png" alt-text="Diagram showing how hub and spoke topology works with network assignments.":::


This architecture is designed for a single workload. For multiple workloads, you might want to isolate the user node pools from each other and from the system node pool. That choice results in more subnets that are smaller in size. Also, the ingress resource might be more complex, and as a result you might need multiple ingress controllers that require extra IP addresses.
