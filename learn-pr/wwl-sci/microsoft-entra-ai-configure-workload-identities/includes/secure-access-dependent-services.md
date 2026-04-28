Least-privilege role assignment follows a consistent pattern. Identify the workload's task, pick the narrowest role, and scope it to the specific resource. Now the question is which specific role to pick when you're looking at Key Vault, Azure AI services, storage, or a downstream API. Azure services use similar role names, and the difference between the right role and an over-privileged one is often a single word: User vs. Officer, Reader vs. Contributor, User vs. Administrator.

## Scope Key Vault roles to the operation

AI workloads commonly access Key Vault to retrieve secrets, keys, or certificates. The right role depends on what the workload does with those objects. A workload that only reads secrets at runtime needs a different role than one that manages secret lifecycle.

| Workload task | Correct role | Why not a broader role |
| --- | --- | --- |
| Read secrets at runtime | Key Vault Secrets User | Key Vault Secrets Officer adds write and delete capabilities the workload doesn't need. |
| Read and manage secrets as part of operations | Key Vault Secrets Officer | Key Vault Administrator adds full management over keys, certificates, and vault settings. |
| Read certificates for validation | Key Vault Certificate User | Key Vault Certificates Officer includes lifecycle management permissions. |

Assign Key Vault roles at the individual vault level, not at the resource group level. If the workload accesses multiple vaults, assign the role on each vault separately so the scope matches the access pattern.

> [!IMPORTANT]
> Use Azure RBAC for Key Vault authorization rather than the legacy vault access policies. Azure RBAC provides consistent role assignment, fine-grained scoping, and integration with Microsoft Entra conditional access and audit logging.

## Narrow Azure AI services and Foundry roles by service type

AI workloads that call Azure AI services or Microsoft Foundry models need roles scoped to the specific resource. The correct role depends on whether the workload uses Azure OpenAI, other Cognitive Services, or Foundry project resources.

| Workload task | Correct role | Why not a broader role |
| --- | --- | --- |
| Call Azure OpenAI models for completions, embeddings, or chat | Cognitive Services OpenAI User | Cognitive Services User grants data actions across all Cognitive Services, not just OpenAI. |
| Deploy and fine-tune Azure OpenAI models | Cognitive Services OpenAI Contributor | Cognitive Services Contributor adds full resource management capabilities beyond model operations. |
| Call non-OpenAI Cognitive Services (Speech, Vision, Language) | Cognitive Services User | Cognitive Services Contributor adds resource management capabilities the workload doesn't need for inference. |
| Access Microsoft Foundry project resources | Azure AI User | Azure AI Developer grants broader workspace management permissions the workload doesn't need for project-level access. |

Microsoft Foundry has two resource models. New Foundry resources use an account-based model where Azure AI User is the least-privilege developer role. Legacy Foundry hubs use Machine Learning workspaces where Azure AI Developer applies instead. Check which model your Foundry resource uses before assigning the role.

Scope the role to the specific Cognitive Services account or AI Foundry project resource. A Contributor role at the resource group level grants management access to every resource in the group, not just the AI service.

> [!CAUTION]
> An identity with Cognitive Services Contributor can redeploy models, delete endpoints, and modify resource configurations. If the workload only calls models for inference, Contributor access turns a compromised identity into one that can disrupt the AI service itself.

## Assign storage roles at the container level

Storage accounts are among the most common role assignment targets for AI workloads, whether for training data, output files, or data lake access. The scoping decision here matters because storage roles can be assigned at the container level, not just the account level.

| Workload task | Correct role | Why not a broader role |
| --- | --- | --- |
| Read blobs from a storage container | Storage Blob Data Reader | Storage Blob Data Contributor adds write and delete permissions. |
| Read and write blobs | Storage Blob Data Contributor | Storage Blob Data Owner adds the ability to set access control. |
| Read from a queue | Storage Queue Data Reader | Storage Queue Data Contributor allows message processing and deletion. |

When the workload accesses a specific container or queue, scope the role assignment to that container or queue rather than the entire storage account. Container-scoped Azure RBAC assignments limit the identity's access to exactly the data it needs.

## Evaluate role definitions for downstream APIs

Downstream APIs and partner applications use app roles instead of Azure RBAC. Assigning app roles follows the same pattern as any permission plane: identify the workload's operations and assign only the roles that cover them. Because you didn't define these roles, you need to evaluate what they actually grant before assigning them.

Review the app roles defined on the target application and check whether the role names describe the scope of access clearly. A role named "DataReader" that also grants write access to a subset of endpoints is over-privileged even if the name suggests otherwise. If the available roles are broader than the workload's task requires, ask the API owner whether narrower roles exist or can be created. Accepting what's available without evaluating it carries the same risk as assigning Contributor when Reader would suffice.

Every role decision follows the same pattern: identify the workload's operation, find the narrowest role that covers it, and scope the assignment to the specific resource. When the names look similar, the distinction matters. The difference determines whether a compromised identity can only read what it needs or manage everything in the resource group.
