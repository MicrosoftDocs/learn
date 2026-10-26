At the beginning of this module, you needed to block new deployments from untrusted registries to your Azure Kubernetes Service cluster and present a report of the status of your cluster against that policy.

In this module, you learned how Azure Policy for Kubernetes can be used to achieve this goal. You created an Azure Kubernetes Service (AKS) cluster with the Azure Policy add-on enabled and assigned a policy that restricts in-scope Pod image references to an approved registry. You verified that the second Deployment and ReplicaSet could exist while the policy denied their requests to create noncompliant Pods, then diagnosed the rejection in ReplicaSet events. You authorized the cluster to pull an image from the approved registry and deployed that image. You also assigned the restricted initiative in Audit mode. Finally, you inspected component compliance and removed the original noncompliant Deployment to address violations of the allowed-images assignment.

Without this solution, your team would be wasting time by manually creating company policies, asking coworkers not to do certain things, and potentially opening your clusters to security and operational issues. In the end, you saved the company thousands of dollars in time by automating that manual work using Azure policies for AKS.

## Clean up policy assignments

Don't remove inherited or unrelated assignments. Follow these steps to remove the two exercise assignments while the lab resource group still exists:

1. Open **Policy** in the Azure portal and select **Assignments**.
1. Filter to the exact lab resource-group scope.
1. Select the allowed-images assignment created in this exercise, select **Delete assignment**, and confirm.
1. Delete the restricted initiative assignment created in this exercise in the same way.

For more information, see Disable a policy or initiative in the **More info** section.

## Clean up resources

These steps remove the dedicated lab resources. Review any resources created outside the lab resource group separately to avoid ongoing charges.

> [!WARNING]
> Deleting a resource group is irreversible and deletes its contained resources. Delete the group only if it was created solely for this exercise. Don't select a group merely because its name starts with `videogamerg`. If you used existing or shared resources, remove only exercise-specific assignments and resources with the resource owner's approval.

Delete the dedicated lab resource group:

1. In the Azure portal, open **Resource groups**.
1. Select the exact dedicated lab resource group, `videogamerg` or the alternative name you used, and inspect its contents.
1. On **Overview**, select **Delete resource group**.
1. Confirm the exact resource-group name and select **Delete**.
1. Wait for deletion to finish and confirm that the lab resources are gone. If deletion fails, resolve the reported locks or dependencies instead of assuming cleanup succeeded. See Delete resource groups and resources in the **More info** section.

## Review optional Cloud Shell storage

If you used an ephemeral Cloud Shell session, no Cloud Shell storage account was required. If you created persistent storage solely for this exercise, it might be in a separate resource group. Back up anything you need, identify the exact exercise-created storage resources, and delete them only when they're no longer needed. Unmounting a file share doesn't delete it or stop its storage charges.

> [!WARNING]
> Don't delete a pre-existing or shared Cloud Shell storage account or file share. It can contain your persistent home directory and other files. Deleting that storage permanently removes its contents.

See Persist files in Azure Cloud Shell in the **More info** section for storage lifetime and deletion considerations.

## More info

Use these resources to learn more about AKS governance, complete the exercises, and review the module's supporting references.

### Azure Policy and AKS governance

These articles explain policy definitions, assignment scopes, and governance patterns:

- [Azure Policy overview](/azure/governance/policy/overview)
- [Use Azure Policy with AKS](/azure/aks/use-azure-policy)
- [Azure Policy for Kubernetes](/azure/governance/policy/concepts/policy-for-kubernetes)
- [Azure Policy definition structure](/azure/governance/policy/concepts/definition-structure)
- [Understand scope in Azure Policy](/azure/governance/policy/concepts/scope)
- [Azure Policy assignment structure](/azure/governance/policy/concepts/assignment-structure)
- [Azure Policy exemption structure](/azure/governance/policy/concepts/exemption-structure)
- [Layering policy definitions](/azure/governance/policy/concepts/effect-basics#layering-policy-definitions)
- [Built-in Azure Policy definitions](/azure/governance/policy/samples/built-in-policies)
- [AKS policy initiatives](/azure/aks/policy-reference#initiatives)
- [AKS secure baseline architecture](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks)
- [AKS landing zone accelerator](/azure/cloud-adoption-framework/scenarios/app-platform/aks/landing-zone-accelerator)

### Prerequisites and setup

Use these resources to prepare your subscription, tools, and cluster:

- [Kubernetes basics](https://azure.microsoft.com/topic/what-is-kubernetes)
- [Azure subscription options](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn)
- [Azure CLI](/cli/azure/)
- [Install Azure CLI](/cli/azure/install-azure-cli)
- [Azure Policy RBAC permissions](/azure/governance/policy/overview#azure-rbac-permissions-in-azure-policy)
- [Resource provider registration](/azure/azure-resource-manager/management/resource-providers-and-types#register-resource-provider)
- [Resolve resource provider registration errors](/azure/azure-resource-manager/troubleshooting/error-register-resource-provider)
- [AKS quotas, SKUs, and regions](/azure/aks/quotas-skus-regions)
- [AKS supported Kubernetes versions](/azure/aks/supported-kubernetes-versions)
- [AKS operating-system FAQ](/azure/aks/faq#what-operating-systems-os-versions-are-supported-on-aks)
- [Cloud Shell ephemeral sessions](/azure/cloud-shell/get-started/ephemeral)
- [Cloud Shell with persistent storage](/azure/cloud-shell/get-started/new-storage)
- [Install the Azure Policy add-on for AKS](/azure/governance/policy/concepts/policy-for-kubernetes#install-azure-policy-add-on-for-aks)
- [Enable monitoring for AKS](/azure/azure-monitor/containers/kubernetes-monitoring-enable)

### Azure portal and example policies

These links open the portal pages and built-in policies used in the module:

- [Azure portal](https://portal.azure.com?azure-portal=true)
- [Azure Policy overview in the portal](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyMenuBlade/Overview)
- [Azure Policy definitions in the portal](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyMenuBlade/Definitions)
- [Authorized IP ranges should be defined on Kubernetes Services](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F0e246bcf-5f6f-4f87-bc6f-775d4712c7ea)
- [Role-Based Access Control (RBAC) should be used on Kubernetes Services](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fac4a19c2-fa67-49b4-8ae5-0b2e78c49457)
- [Kubernetes cluster containers should only use allowed images](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Ffebd0533-8e55-448f-b837-bd0e06f16469)
- [Kubernetes cluster pods should only use allowed volume types](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F16697877-1118-4fb1-9b65-9898ec2509ec)

### Container registry

These articles cover registry creation, image import, and access permissions:

- [Create an ACR using Azure CLI](/azure/container-registry/container-registry-get-started-azure-cli)
- [AKS-ACR integration](/azure/aks/cluster-container-registry-integration)
- [ACR image import](/azure/container-registry/container-registry-import-images)
- [ACR image-import prerequisites](/azure/container-registry/container-registry-import-images#prerequisites)
- [Import container images from Docker Hub](/azure/container-registry/container-registry-import-images#import-container-images-from-docker-hub)
- [ACR built-in roles](/azure/container-registry/container-registry-rbac-built-in-roles-directory-reference)

### Enforcement, compliance, and cleanup

Use these references to diagnose policy results and remove exercise resources safely:

- [View Gatekeeper artifacts](/azure/governance/policy/concepts/policy-for-kubernetes#view-gatekeeper-artifacts)
- [Policy evaluation](/azure/governance/policy/concepts/policy-for-kubernetes#policy-evaluation)
- [Component details for Resource Provider modes](/azure/governance/policy/how-to/determine-non-compliance#component-details-for-resource-provider-modes)
- [Azure Policy for Kubernetes troubleshooting](/azure/governance/policy/concepts/policy-for-kubernetes#troubleshooting-the-add-on)
- [Azure Resource Manager policy evaluation triggers](/azure/governance/policy/how-to/get-compliance-data#evaluation-triggers)
- [Disable a policy or initiative](/azure/aks/use-azure-policy#disable-a-policy-or-initiative)
- [Delete resource groups and resources](/azure/azure-resource-manager/management/delete-resource-group)
- [AKS cluster deletion behavior](/azure/aks/delete-cluster#what-happens-when-you-delete-a-cluster)
- [Persist files in Azure Cloud Shell](/azure/cloud-shell/persisting-shell-storage)

### Implementation and technical review references

These implementation sources and upstream Kubernetes resources support the module and its technical review reports:

- [Azure Policy add-on for AKS changelog](/azure/governance/policy/concepts/policy-for-kubernetes#azure-policy-add-on-for-aks-changelog)
- [Private-cluster policy definition](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Kubernetes/AKS_PrivateCluster_Deny.json)
- [Allowed-images policy definition](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Kubernetes/ContainerAllowedImages.json)
- [Allowed-images v2 constraint template](https://store.policy.core.windows.net/kubernetes/container-allowed-images/v2/template.yaml)
- [Restricted security initiative definition](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policySetDefinitions/Kubernetes/PSPRestrictedStandard.json)
- [Container resource-limits policy definition](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Kubernetes/ContainerResourceLimits.json)
- [Container resource-limits v3 constraint template](https://store.policy.core.windows.net/kubernetes/container-resource-limits/v3/template.yaml)
- [Azure CLI 2.91.0 AKS help](https://github.com/Azure/azure-cli/blob/da4c0548a2725ea3d08b1d94b8e7fa1b0b07256e/src/azure-cli/azure/cli/command_modules/acs/_help.py#L95-L101)
- [Azure CLI 2.91.0 SSH-key validator](https://github.com/Azure/azure-cli/blob/da4c0548a2725ea3d08b1d94b8e7fa1b0b07256e/src/azure-cli/azure/cli/command_modules/acs/_validators.py#L65-L98)
- [Kubernetes admission webhooks](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/)
- [Open Policy Agent](https://www.openpolicyagent.org/)
- [Gatekeeper](https://open-policy-agent.github.io/gatekeeper/website/docs/howto/)
- [Kubernetes server-side dry run](https://kubernetes.io/docs/reference/using-api/api-concepts/#dry-run)
- [Kubernetes resource requests and limits](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits)

### Contributor guidance

For contributors, this resource explains scenario authoring:

- [Scenario guidance for training modules](/help/learn/id-guidance-scenarios)