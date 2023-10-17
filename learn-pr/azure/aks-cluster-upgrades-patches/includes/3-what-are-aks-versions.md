Updates and upgrades happen often in software development. By the time your deployment team was ready to deploy the containerized applications to the AKS clusters, the cluster versions were out of support. AKS follows the ***N-2*** rule when it comes to supporting Kubernetes versions.

## What's the N-2 rule?

Think of ***N*** as the current latest stable version that Kubernetes has released and ***-2*** as the previous two minor versions from ***N***.

For example, let's say Kubernetes releases version *1.20.x* today. Following the ***N-2*** rule, AKS provides support for version *1.20.x*, *1.19.x*, and *1.18.x*. Since version *1.17.x* isn't within the previous two minor versions, it will be deprecated and go out of support within 30 days of the version *1.20.x* release. You have 30 days from the new release to upgrade your clusters and ensure they stay in support.

 :::image type="content" source="../media/3-n-minus-2-example.png" border="false" alt-text="Diagram that shows when Kubernetes releases version 1.20, Azure Kubernetes Service will deprecate support for version 1.17 because it's out of scope of the N-2 version support rule.":::

For each minor version in which AKS maintains cluster support, only the latest stable two patch versions for each minor version are supported.

This means if Kubernetes decides to release patch version *1.19.9* and *1.18.10*, the current patch versions AKS supports changes to:

| Current supported versions | New supported versions |
| :------------------------- | :--------------------- |
| 1.20.2 | 1.20.2 |
| 1.20.1 | 1.20.1 |
| 1.19.8 | 1.19.9 |
| 1.19.7 | 1.19.8 |
| 1.18.9 | 1.18.10 |
| 1.18.8 | 1.18.9 |

## What's the AKS cluster version release and deprecation process?

AKS announces cluster version updates through several channels, including the AKS release notes, the AKS release tracker, email notifications, Azure Advisor alerts, and preview versions.

### AKS release notes

AKS publishes announcements with the planned date of new version releases and old version deprecations in the [AKS release notes](https://github.com/Azure/AKS/releases) at least 30 days prior to the release date.

### AKS release tracker

The [AKS release tracker](https://releases.aks.azure.com/webpage/index.html) provides real-time updates on the latest AKS releases by version and region. The tracker links to the specific version of the AKS release notes to help you identify which instance of the release is relevant to you.

### Email notifications

AKS sends out email notifications and service health notifications to AKS cluster owners impacted by the latest version updates to notify them that they have 30 days to upgrade their existing AKS cluster versions.

### Azure Advisor

AKS uses [Azure Advisor](/azure/advisor/advisor-overview) to alert you if a new version could cause issues in your cluster because of deprecated APIs or if your cluster is out of support.

### Preview versions

Before AKS provides support for a new minor version of Kubernetes, the new minor version is often released as a preview version. A preview version allows you to assess the next version ahead of its release. This gives you time to test your existing AKS cluster workloads with the next release and prepare to upgrade when the version becomes generally available.
