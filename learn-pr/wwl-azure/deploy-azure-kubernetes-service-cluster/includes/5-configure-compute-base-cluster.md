In AKS, each node pool maps to a Virtual Machine Scale Set. Nodes are VMs in each node pool. Consider using a smaller VM size for the system node pool to minimize costs. This reference implementation deploys the system node pool with three DS2\_v2 nodes. That size is sufficient to meet the expected load of the system pods. The OS disk is 512 GB.

For the user node pool, here are some considerations:

 -  Choose larger node sizes to pack the maximum number of pods set on a node. It minimizes the footprint of services that run on all nodes, such as monitoring and logging.
 -  Deploy at least two nodes. That way, the workload has a high availability pattern with two replicas. With AKS, you can change the node count without recreating the cluster.
 -  Actual node sizes for your workload depend on the requirements determined by the design team. Based on the business requirements, we've chosen DS4\_v2 for the production workload. To lower costs one could drop the size to DS3\_v2, which is the minimum recommendation.
 -  When planning capacity for your cluster, assume that your workload can consume up to 80% of each node; the remaining 20% is reserved for AKS services.
 -  Set the maximum pods per node based on your capacity planning. To establish a capacity baseline, start with a value of 30. Adjust that value based on the requirements of the workload, the node size, and your IP constraints.
