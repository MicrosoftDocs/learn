## Multiple Choice
What is the recommended approach for scaling Kubernetes clusters?
( ) Cluster autoscaling {{Incorrect. Cluster autoscaling is an AKS add-on component that scales the number of nodes in a node pool.}}
( ) Manual scaling {{Incorrect. Manual scaling requires monitoring and setting alerts on CPU utilization or custom metrics.}}
(x) Autoscaling {{Correct. Autoscaling is recommended because some of the manual mechanisms are built into the autoscaler, which can scale both pod replicas and the node count in the cluster.}}

## Multiple Choice
What does the kubectl command 'apply' do?
( ) Lists all pods in all namespaces {{Incorrect. The 'get pods --all-namespaces' command is used to list all pods in all namespaces.}}
( ) Deletes a deployment {{Incorrect. The 'delete' command is used to delete a deployment.}}
(x) Applies a configuration to a resource by filename or stdin {{Correct. The 'apply' command is used to apply a configuration to a resource by filename or stdin.}}

## Multiple Choice
Why is it important to consider the address space of the virtual network when setting up an AKS cluster?
( ) To ensure that all pods have the same IP address {{Incorrect. Pods should have individual IP addresses.}}
( ) To limit the number of nodes in the cluster {{Incorrect. The address space should be large enough to accommodate all nodes and their scalability limits.}}
(x) To ensure that all entities that will receive traffic have an IP address allocated from the subnet address space {{Correct. The address space should be large enough to hold all subnets and allocate IP addresses for all entities that will receive traffic, including nodes, pods, and Azure Private Link addresses.}}

## Multiple Choice
What is the purpose of deploying Private Link endpoints in a dedicated subnet within the spoke virtual network?
( ) To keep the resources that belong to the cluster in a separate virtual network. {{Incorrect. While deploying Private Link endpoints in a dedicated subnet within the spoke virtual network does keep the resources that belong to the cluster in the same virtual network, this is not the primary purpose of doing so.}}
( ) To reduce traffic passing the hub virtual network connection. {{Incorrect. This answer describes the purpose of deploying Private Link endpoints in the hub virtual network, not in a dedicated subnet within the spoke virtual network.}}
(x) To enable granular security rules at the subnet level using network security groups. {{Correct. Deploying Private Link endpoints in a dedicated subnet within the spoke virtual network allows for granular security rules to be applied at the subnet level using network security groups, which can help improve security.}}

