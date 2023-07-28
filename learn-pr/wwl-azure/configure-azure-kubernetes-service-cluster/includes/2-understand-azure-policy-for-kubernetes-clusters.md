
Azure Policy extends Gatekeeper v3, an *admission controller webhook* for Open Policy Agent (OPA), to apply at-scale enforcements and safeguards on your clusters in a centralized, consistent manner. Azure Policy makes it possible to manage and report on the compliance state of your Kubernetes clusters from one place. The add-on enacts the following functions:

 -  Checks with Azure Policy service for policy assignments to the cluster.
 -  Deploys policy definitions into the cluster as [constraint template](https://open-policy-agent.github.io/gatekeeper/website/docs/howto/#constraint-templates) and [constraint](https://open-policy-agent.github.io/gatekeeper/website/docs/howto/#constraints) custom resources.
 -  Reports auditing and compliance details back to Azure Policy service.

## Overview

To enable and use Azure Policy with your Kubernetes cluster, take the following actions:

1.  Configure your Kubernetes cluster and install the Azure Kubernetes Service add-on.
2.  Understand the Azure Policy language for Azure Kubernetes Service Kubernetes.
3.  Assign a definition to your Azure Kubernetes Service cluster.
4.  Wait for validation.

## Recommendations

The following are general recommendations for using the Azure Policy Add-on:

 -  The Azure Policy Add-on requires three Gatekeeper components to run: One audit pod and two webhook pod replicas. These components consume more resources as the count of Kubernetes resources and policy assignments increases in the cluster, which requires audit and enforcement operations.
    
    
     -  For fewer than 500 pods in a single cluster with a max of 20 constraints: two vCPUs and 350-MB memory per component.
     -  For more than 500 pods in a single cluster with a max of 40 constraints: three vCPUs and 600-MB memory per component.

The following recommendation applies only to AKS and the Azure Policy Add-on:

 -  Use system node pool with CriticalAddonsOnly taint to schedule Gatekeeper pods.
 -  Secure outbound traffic from your AKS clusters.
 -  If the cluster has aad-pod-identity enabled, Node Managed Identity (NMI) pods modify the nodes' iptables to intercept calls to the Azure Instance Metadata endpoint.
