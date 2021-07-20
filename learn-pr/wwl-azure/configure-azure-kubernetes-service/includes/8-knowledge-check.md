Choose the best response for each question. Then select Check your answers.

## Multiple Choice
Which of the following is the Kubernetes agent that processes the orchestration requests and schedules running the requested containers? 
( ) container {{That's incorrect. A container is a lightweight and portable executable image that contains software and all its dependencies.}}
( ) node {{That's incorrect. Nodes are individual virtual machines running containerized applications.}}
(x) kubelet {{That's correct. The kubelet is the Kubernetes agent that processes the orchestration requests from the Azure-managed node.}}

## Multiple Choice
The infrastructure team is configuring networking for the Azure Kubernetes service. Which of the following services would be best for internal-only applications that support other workloads within the cluster?
( ) LoadBalancer {{That's incorrect. LoadBalancer creates an Azure load balancer resource, configures an external IP address, and connects the requested pods to the load balancer backend pool. To allow customers traffic to reach the application, load-balancing rules are created on the desired ports.}}
(x) ClusterIP {{That's correct. ClusterIP creates an internal IP address for use within the AKS cluster. This is good for internal-only applications that support other workloads within the cluster.}}
( ) NodePort {{That's incorrect. NodePort creates a port mapping on the underlying node that allows the application to be accessed directly with the node IP address and port.}}

## Multiple Choice
The leadership team has decided to move all services to Azure Kubernetes service. Which of the following components contributes to the monthly Azure charge? 
( ) Master node {{That's incorrect. In an AKS cluster, the master node is free and there's no charge for cluster management.}}
( ) Per deployed pod {{That's incorrect. Deploying and running pods on an AKS cluster is free.}}
(x) Per node VM {{That's correct. With Kubernetes organizations only pay for the virtual machine instances, storage, and networking resources consumed by the cluster.}}
