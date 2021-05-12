Contoso relies on AD DS as its identity provider for Windows and Linux-based workloads, with Kerberos as the primary authentication protocol. The Information Security team asked you to investigate the options for integrating containerized workloads hosted by AKS on Azure Stack HCI with the Contoso's AD DS environment. Considering that you intend to deploy Windows-based nodes and containers into Kubernetes clusters, you want to determine to what extent such integration is possible. 

## Integrate Windows containers in AKS on Azure Stack HCI with AD DS

There might be scenarios in which containerized Windows-based applications running in Kubernetes pods might need access to AD DS-protected resources. Such functionality requires the use of an AD DS domain-based identity to successfully complete authentication and authorization tasks. To implement this identity, you can use Group Managed Service Accounts (gMSA).

Compared to the traditional method for managing identities for Windows services and applications that need to be able to authenticate on their own, gMSA offers several benefits, which include automatic password changes, simplified setup and maintenance, and support for delegated management. 

To enable pods to use gMSA for authentication, join all the Windows Server-based Kubernetes worker nodes that will host the pods to an AD DS domain. Perform the domain join by connecting to each node through Secure Shell (SSH), and then running the netdom.exe command line utility with the join switch.

The rest of the process is the same as in any Kubernetes cluster that includes Windows Server worker nodes, and it has the following high-level steps:

1. Provisioning a gMSA in AD DS and assigning it to the Windows Server nodes.
1. Defining a custom Kubernetes resource type representing the AD DS gMSA (GMSACredentialSpec).
1. Configuring a webhook-based mechanism that automatically populates and validates GMSACredentialSpec references for pods and containers.
1. Creating a custom resource based on the GMSACredentialSpec resource type.
1. Defining a cluster role to enable RBAC for the GMSACredentialSpec resource.
1. Assigning the role to the AD DS gMSA to authorize its usage of the corresponding GMSACredentialSpec resource.
1. Including a reference to the GMSACredentialSpec resource in the definition of pods that will use it for AD DS authentication.

> [!NOTE]
> To enable gMSA support, the name of the Kubernetes cluster cannot exceed three characters. This constraint results from the 15-character limit of a domain-joined computer name. 

---
## Check your knowledge

## Multiple Choice
Contoso's Information Security team requests you to investigate the options for implementing AD DS-based authentication of Windows-based containerized workloads hosted by AKS on Azure Stack HCI. You start by deploying a Kubernetes cluster containing Windows Server nodes into your Azure Stack HCI cluster. What should you do next?
( ) Register the Azure Stack HCI cluster with Azure. {{Incorrect. This is a requirement for deploying AKS on Azure Stack HCI, which you have already completed.}}
( ) Enable CredSSP in the Azure Stack HCI cluster. {{Incorrect. This functionality does not depend in any way on CredSSP being enabled.}}
(x) Join the Kubernetes cluster Windows Server nodes to the AD DS domain. {{Correct. To provide the ability for pods to use gMSA for authentication, you must first join to an AD DS domain all of the Windows Server-based Kubernetes worker nodes that will host these pods.}}