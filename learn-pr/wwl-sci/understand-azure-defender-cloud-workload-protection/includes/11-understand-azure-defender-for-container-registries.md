Microsoft Defender for Containers is the cloud-native solution for securing your containers.

## Defender for Containers features

- **Environment hardening** - Defender for Containers protects your Kubernetes clusters whether they're running on Azure Kubernetes Service, Kubernetes on-prem / IaaS, or Amazon EKS. By continuously assessing clusters, Defender for Containers provides visibility into misconfigurations and guidelines to help mitigate identified threats. 

- **Vulnerability assessment** - Vulnerability assessment and management tools for images stored in ACR registries and running in Azure Kubernetes Service. 

- **Run-time threat protection for nodes and clusters** - Threat protection for clusters and Linux nodes generates security alerts for suspicious activities.

## Architecture

The architecture of the various elements involved in the full range of protections provided by Defender for Containers varies depending on where your Kubernetes clusters are hosted.

Defender for Containers protects your clusters whether they're running in:

- **Azure Kubernetes Service (AKS)** - Microsoft's managed service for developing, deploying, and managing containerized applications.

- **Amazon Elastic Kubernetes Service (EKS)** in a connected Amazon Web Services (AWS) account - Amazon's managed service for running Kubernetes on AWS without needing to install, operate, and maintain your own Kubernetes control plane or nodes.

- **An unmanaged Kubernetes distribution (using Azure Arc-enabled Kubernetes)** - Cloud Native Computing Foundation (CNCF) certified Kubernetes clusters hosted on-premises or on IaaS.

Defender for Cloud continuously assesses the configurations of your clusters and compares them with the initiatives applied to your subscriptions. When it finds misconfigurations, Defender for Cloud generates security recommendations. Use Defender for Cloud's recommendations page to view recommendations and remediate issues.

For Kubernetes clusters on EKS, you'll need to connect your AWS account to Microsoft Defender for Cloud via the environment settings page as described in Connect your AWS accounts to Microsoft Defender for Cloud. Then ensure you've enabled the CSPM plan.

### Environment hardening
For a bundle of recommendations to protect the workloads of your Kubernetes containers, install the Azure Policy for Kubernetes. By default, auto provisioning is enabled when you enable Defender for Containers.

With the add-on on your AKS cluster, every request to the Kubernetes API server will be monitored against the predefined set of best practices before being persisted to the cluster. You can then configure to enforce the best practices and mandate them for future workloads.

For example, you can mandate that privileged containers shouldn't be created, and any future requests to do so will be blocked.

### View vulnerabilities for running images
Defender for Containers expands on the registry scanning features of the Defender for container registries plan by introducing the preview feature of run-time visibility of vulnerabilities powered by the Defender profile, or extension.

The new recommendation, Running container images should have vulnerability findings resolved, only shows vulnerabilities for running images, and relies on the Defender security profile, or extension to discover which images are currently running. This recommendation groups running images that have vulnerabilities, and provides details about the issues discovered, and how to remediate them. The Defender profile, or extension is used to gain visibility into vulnerable containers that are active.

This recommendation shows running images, and their vulnerabilities based on ACR images. Images that are deployed from a non ACR registry, won't be scanned, and will appear under the Not applicable tab.

### Run-time protection for Kubernetes nodes and clusters
Defender for Cloud provides real-time threat protection for your containerized environments and generates alerts for suspicious activities. You can use this information to quickly remediate security issues and improve the security of your containers.

Threat protection at the cluster level is provided by the Defender profile and analysis of the Kubernetes audit logs. Examples of events at this level include exposed Kubernetes dashboards, creation of high-privileged roles, and the creation of sensitive mounts.

In addition, our threat detection goes beyond the Kubernetes management layer. Defender for Containers includes host-level threat detection with over 60 Kubernetes-aware analytics, AI, and anomaly detections based on your runtime workload. Our global team of security researchers constantly monitor the threat landscape. They add container-specific alerts and vulnerabilities as they're discovered. Together, this solution monitors the growing attack surface of multi-cloud Kubernetes deployments and tracks the MITRE ATT&CK® matrix for Containers, a framework that was developed by the Center for Threat-Informed Defense in close partnership with Microsoft and others.