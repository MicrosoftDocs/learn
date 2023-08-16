## Multiple Choice
What is the purpose of Azure Policy in relation to Kubernetes clusters?
( ) Azure Policy is used to manage and report on the compliance state of your Kubernetes clusters from multiple places. {{Incorrect. Azure Policy allows for centralized management and reporting of compliance state.}}
( ) Azure Policy is used to deploy policy definitions into the cluster as pod templates. {{Incorrect. Azure Policy deploys policy definitions as constraint templates and constraint custom resources.}}
(x) Enables the automation and validation of the creation and teardown of environments to help deliver secure and stable application hosting platforms. {{Correct. Azure Policy applies at scale enforcements and safeguards on Kubernetes clusters in a centralized, consistent manner to ensure secure and stable application hosting platforms.}}

## Multiple Choice
What is host based encryption in Azure Kubernetes Service (AKS)?
( ) Encryption of data at rest using server side encryption with platform managed keys {{Incorrect. Server side encryption with platform managed keys is used by Azure Storage, not host based encryption in AKS.}}
( ) Encryption of data at rest using customer managed keys for all disks {{Incorrect. Host based encryption in AKS can use either platform managed keys or customer managed keys depending on the encryption type set on the disks.}}
(x) Enables encryption of data at rest on the VM host of AKS agent nodes using platform or customer managed keys, and encrypts data flows to the Storage service {{Correct. Host based encryption in AKS encrypts data at rest on the VM host of AKS agent nodes using platform or customer managed keys, and encrypts data flows to the Storage service. It can be enabled at cluster or node pool creation time and requires a specific VM set type and supported VM sizes.}}

## Multiple Choice
What are the two Azure built-in roles that have the appropriate Azure RBAC policy assignment operations to assign a policy definition to your Kubernetes cluster?
( ) Resource Group Contributor and Reader {{Incorrect. Resource Group Contributor and Reader do not have the appropriate Azure RBAC policy assignment operations to assign a policy definition to your Kubernetes cluster.}}
( ) Virtual Machine Contributor and Network Contributor {{Incorrect. Virtual Machine Contributor and Network Contributor do not have the appropriate Azure RBAC policy assignment operations to assign a policy definition to your Kubernetes cluster.}}
(x) Resource Policy Contributor and Owner {{Correct. Resource Policy Contributor and Owner have the appropriate Azure RBAC policy assignment operations to assign a policy definition to your Kubernetes cluster.}}

## Multiple Choice
What is the purpose of Azure Policy in relation to Kubernetes clusters?
( ) Azure Policy is used to deploy policy definitions into the cluster as pod templates. {{Incorrect. Azure Policy deploys policy definitions as constraint templates and constraint custom resources.}}
( ) Azure Policy is used to manage and report on the compliance state of your Kubernetes clusters from multiple places. {{Incorrect. Azure Policy allows for centralized management and reporting of compliance state.}}
(x) Enables the automation and validation of the creation and teardown of environments to help deliver secure and stable application hosting platforms. {{Correct. Azure Policy applies at scale enforcements and safeguards on Kubernetes clusters in a centralized, consistent manner to ensure secure and stable application hosting platforms.}}

