You can apply and enforce security settings on pods hosted in Azure Kubernetes Service (AKS) clusters by using Azure Policy. Azure Policy helps enforce organizational standards and assess compliance at scale. After you install the Azure Policy add-on for AKS, you can assign built-in and custom policy definitions either individually or in groups referred to as policy initiatives.

### Explore Azure Policy add-on for AKS

[Azure Policy for Kubernetes](/azure/governance/policy/concepts/policy-for-kubernetes) extends Gatekeeper v3, an admission controller webhook for Open Policy Agent (OPA), to apply at-scale enforcements and safeguards in a centralized, consistent manner. Current Azure Policy add-on versions still use Gatekeeper v3. On supported add-on and Kubernetes versions, the add-on can also generate Kubernetes-native ValidatingAdmissionPolicy (VAP) resources for Common Expression Language (CEL)-based policies. Azure Policy makes it possible to manage and report on the compliance state of your AKS environment.

> [!NOTE]
> You can implement namespace-level security policies for individual AKS clusters (without relying on Azure Policy) by using [Pod Security Admission](/azure/aks/use-psa). Pod Security Admission is enabled by default in AKS clusters running Kubernetes version 1.23 or later, but AKS doesn't enforce baseline or restricted policies on namespaces automatically. To apply a profile, label the namespace (for example, `pod-security.kubernetes.io/enforce=restricted`). PSA replaces the Kubernetes PodSecurityPolicy feature, which was deprecated in Kubernetes 1.21 and removed in Kubernetes 1.25. In enterprise scenarios, you should consider using Azure Policy-based policies instead.

To implement Azure Policy for AKS, register the `Microsoft.PolicyInsights` resource provider in the subscription, verify that the cluster runs a supported AKS Kubernetes version, and then install the Azure Policy add-on for AKS. The add-on manages interaction between Azure Policy and Gatekeeper components, including the following tasks:

- Monitoring for Azure Policy assignments targeting the AKS cluster.
- Deploying policy definitions to the cluster as constraint templates and constraint custom resources, mutation template resources when applicable, and, on supported add-on and Kubernetes versions, Kubernetes-native ValidatingAdmissionPolicy resources for supported CEL policies.
- Reporting resulting auditing and compliance details back to Azure Policy.

To install the Azure Policy add-on for AKS, you can use the Azure portal, Azure CLI, and Azure Resource Manager templates. Alternatively, you have the option of applying it by assigning the Azure Policy definition *Deploy Azure Policy Add-on to Azure Kubernetes Service clusters* to target AKS clusters.

- The Azure Policy add-on for Kubernetes can only be deployed to Linux node pools.
- Installations of Gatekeeper outside of the Azure Policy add-on aren't supported. You need to uninstall any existing Gatekeeper components before enabling the Azure Policy add-on.
- The Azure Policy add-on Helm model and the add-on for AKS Engine are deprecated; use the managed Azure Policy add-on for AKS clusters.
- Some policy settings are operating system-specific. For example, disallowing root privileges is applicable only to Linux pods.
- The add-on automatically excludes the `kube-system` and `gatekeeper-system` namespaces from evaluation.

### Review built-in Azure Policy for AKS initiative and policy definitions targeting pod configurations

Commonly used [Azure Policy built-in initiatives](/azure/governance/policy/samples/built-in-initiatives#kubernetes) for AKS targeting pod security include:

- Kubernetes cluster pod security baseline standards for Linux-based workloads.
- Kubernetes cluster pod security restricted standards for Linux-based workloads.

### Assign a policy definition

Once you have identified or authored the policy definition or initiative you want to implement, you need to assign it to the target AKS cluster or clusters. Your account must have a sufficient level of Azure role-based access control (RBAC) permissions. These permissions are part of the built-in **Resource Policy Contributor** and **Owner** roles.

> [!NOTE]
> It might take up to 20 minutes for initial assignments to sync to a target cluster. Subsequent checks for changes in policy assignments take place every 15 minutes. Azure Policy compliance reports include all violations within the last 45 minutes.

A deny policy applied to a cluster doesn't affect the operational status of any existing non-compliant resources. Gatekeeper or generated ValidatingAdmissionPolicy resources block creation or admission of new or replacement non-compliant resources, including replacement Pods created by controllers.
