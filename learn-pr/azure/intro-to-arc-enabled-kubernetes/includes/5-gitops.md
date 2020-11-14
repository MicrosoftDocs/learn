One of the primary benefits of Azure Arc is facilitating implemenation of DevOps principles that apply established development practices to operations. This results in improved agility, without jeopardizing the stability of IT environment. One way to promote DevOps principles is to implement GitOps, which streamline releases of new versions of applications by eliminating the manual effort involved in their deployment. Azure Arc enabled Kubernetes clusters offer support for GitOps.

## What is GitOps?

GitOps is a DevOps practice that relies on a Git repository to store code or configuration representing the current state of a resource external to the repository. An approved change to this repository leads automatically to an update of the corresponding resource.

In the context of Azure  Arc enabled Kubernetes clusters, a Git repository hosts configuration of a Kubernetes cluster. A pod or a set of pods running on the cluster polls the status of the repository and, once it detects a change, it applies the new configuration to the cluster. 

