
## Multiple Choice
What is the purpose of the Horizontal Pod Autoscaler in Azure Kubernetes Service?
( ) To provision a larger number of application instances {{Incorrect. Provisioning a larger number of application instances is a separate concept from the purpose of the Horizontal Pod Autoscaler.}}
( ) To manually scale replicas or nodes based on a fixed cost {{Incorrect. This describes manually scaling resources, not the purpose of the Horizontal Pod Autoscaler.}}
(x) To monitor resource demand and automatically scale the number of pods based on defined metrics such as CPU usage {{Correct. The Horizontal Pod Autoscaler monitors resource demand and automatically scales the number of pods based on defined metrics such as CPU usage, allowing for efficient use of resources.}}

## Multiple Choice
What is the purpose of the Kubernetes cluster autoscaler?
( ) To monitor the status of the Kubernetes API server {{Incorrect. The cluster autoscaler monitors the Metrics API server, not the Kubernetes API server.}}
( ) To adjust the number of pods based on application demand {{Incorrect. This is the purpose of the horizontal pod autoscaler.}}
(x) To adjust the number of nodes based on the requested compute resources in the node pool {{Correct. The cluster autoscaler adjusts the number of nodes in the AKS cluster based on the requested compute resources in the node pool to ensure that there are enough resources to run the pods.}}

## Multiple Choice
What is the purpose of the cluster autoscaler component in AKS?
( ) To manually enable or edit settings for scale set autoscale in the Azure portal or using the Azure CLI. {{Incorrect. This is not the purpose of the cluster autoscaler component in AKS.}}
( ) To create a resource group using the az group create command. {{Incorrect. This is not the purpose of the cluster autoscaler component in AKS.}}
(x) Enables the automation and validation of the creation and teardown of environments to help deliver secure and stable application hosting platforms. {{Correct. The cluster autoscaler component can watch for pods in your cluster that can't be scheduled because of resource constraints. When issues are detected, the number of nodes in a node pool increases to meet the application demand. Nodes are also regularly checked for a lack of running pods, with the number of nodes then decreased as needed. This ability to automatically scale up or down the number of nodes in your AKS cluster lets you run an efficient, cost effective cluster.}}

