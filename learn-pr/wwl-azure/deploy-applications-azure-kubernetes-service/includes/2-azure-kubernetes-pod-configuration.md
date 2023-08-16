You can apply and enforce security settings on Azure Kubernetes Service cluster-hosted pods by using Azure Policy. Azure Policy helps enforce organizational standards and assess compliance at-scale. After you install the Azure Policy add-on for AKS, you can assign built-in and custom policy definitions either individually or in groups referred to as policy initiatives.

### Explore Azure Policy add-on for AKS

Azure Policy for AKS uses the admission controller functionality implemented by Gatekeeper v3, to apply at-scale enforcements and safeguards in a centralized, consistent manner. Azure Policy makes it possible to manage and report on the compliance state of your AKS environment.

> [!NOTE]
> You can implement security policies for individual AKS clusters (without relying on Azure Policy) by using Pod Security Admission. Pod Security Admission is a built-in policy solution suitable for individual cluster deployments. In enterprise scenarios, you should consider using Azure Policy-based policies instead.

To implement Azure Policy for AKS, you have to first install the Azure Policy add-on for AKS. The add-on manages interaction between Azure Policy and Gatekeeper components, including the following tasks:

 -  Monitoring for Azure Policy assignments targeting the AKS cluster.
 -  Deploying policy definitions to the cluster as constraint template and constraint custom resources.
 -  Reporting resulting auditing and compliance details back to Azure Policy.

To install the Azure Policy add-on for AKS, you can use Azure CLI and Azure templates. Alternatively, you have the option of applying it by assigning the Azure Policy definition *Deploy Azure Policy Add-on to Azure Kubernetes Service clusters* to target AKS clusters.

 -  The Azure Policy add-on can only be deployed to Linux node pools.
 -  Installations of Gatekeeper outside of the Azure Policy add-on aren't supported. You need to uninstall any existing Gatekeeper components before enabling the Azure Policy add-on.
 -  Some policy settings are operating system-specific. For example, disallowing root privileges is applicable only to Linux pods.<br>

### Review built-in Azure Policy for AKS initiative and policy definitions targeting pod configurations

Commonly used Azure Policy built-in initiatives for AKS targeting pod security include:

 -  Kubernetes cluster pod security baseline standards for Linux-based workloads
 -  Kubernetes cluster pod security restricted standards for Linux-based workloads

### Assign a policy definition

Once you have identified or authored the policy definition or initiative you want to implement, you need to assign it to the target AKS cluster or clusters. Your account must have a sufficient level of Azure role-based access control (RBAC) permissions. These permissions are part of the built-in **Resource Policy Contributor** and **Owner** roles.

> [!NOTE]
> It might take up to 20 minutes for the initial assignments to apply to a target cluster. Subsequent checks for changes in policy assignments take place every 15 minutes. Azure Policy compliance reports include all violations within the last 45 minutes.

A deny policy applied to a cluster doesn't affect the operational status of any existing non-compliant resources. However, if a non-compliant resource gets rescheduled on a different node the Gatekeeper blocks the resource creation.
