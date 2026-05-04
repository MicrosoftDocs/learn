Kubernetes uses *pods* to run an instance of your application. A pod represents a single instance of your application.

Pods typically have a 1:1 mapping with a container. In advanced scenarios, a pod may contain multiple containers. Multi-container pods are scheduled together on the same node, and allow containers to share related resources.

When you create a pod, you can define *resource requests* to request a certain amount of CPU or memory. The Kubernetes Scheduler uses requests to place a pod on a node that has enough available resources to satisfy them. You can also specify *resource limits* to cap how much CPU or memory a container can consume; the kubelet on each node enforces these limits at runtime. Best practice is to set both requests and limits for all pods—requests inform scheduling decisions, and limits prevent a single pod from starving other workloads on the node.

A pod is a logical resource, but application workloads run on the containers. Pods are typically ephemeral, disposable resources. Individually scheduled pods miss some of the high availability and redundancy Kubernetes features. Pods are deployed and managed using Kubernetes *Controllers*, such as the Deployment Controller.<br>

## Pod Disruption Budgets

A *Pod Disruption Budget* (PDB) defines the minimum number of pod replicas that must remain available—or the maximum that can be simultaneously unavailable—during voluntary disruptions, such as node drains during cluster upgrades or scale-down operations. PDBs help maintain application availability while still allowing controlled maintenance to proceed. When you plan an AKS deployment, defining PDBs for production workloads protects against availability loss during planned cluster maintenance.
