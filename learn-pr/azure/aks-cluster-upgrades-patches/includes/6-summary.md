Your deployment team set up an AKS cluster that was going to go out of support soon. Your team needed to upgrade and patch the AKS clusters to the latest supported Kubernetes versions to ensure that Kubernetes would support the music applications deployed to those AKS clusters. To resolve this issue, you began by checking for the current list of Kubernetes versions AKS supports and then used a Blue/Green deployment approach to safely roll out the available patches and version upgrades to the existing AKS clusters.

The benefit of version patches and upgrades is to ensure that you can immediately fix any software loopholes you identify, which prevents people with malicious intent from exploiting your workloads. New feature releases improve the quality and performance of the software. If you delay the new-version adoption process for too long, it can  result in expensive upgrade costs to the business. Therefore, you should apply patches and upgrades to AKS cluster versions as soon as they're available to avoid potential large costs to the business.

Remember, these upgrades only apply to components within the AKS cluster. Operating-system updates and node-image upgrades have a separate upgrade and patch process.

[!include[azure-optional-exercise-subscription-cleanup](../../../includes/azure-optional-exercise-subscription-cleanup.md)]

## References

* [Tutorial: Upgrade Kubernetes in Azure Kubernetes Service (AKS)](/azure/aks/tutorial-kubernetes-upgrade-cluster?tabs=azure-cli)
* [Best practices for cluster security and upgrades in Azure Kubernetes Service (AKS)](/azure/aks/operator-best-practices-cluster-security)
* [Supported Kubernetes versions in Azure Kubernetes Service (AKS)](/azure/aks/supported-kubernetes-versions)
* [Blue/Green Deployment with Azure Front Door](https://techcommunity.microsoft.com/t5/azure-architecture-blog/blue-green-deployment-with-azure-front-door/ba-p/1609178)
* [AKS Release Calendar](https://github.com/Azure/AKS/releases)
