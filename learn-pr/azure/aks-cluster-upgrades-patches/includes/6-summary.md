Your deployment team has set up an AKS cluster that will go out of support soon. Your team needs to upgrade and patch the AKS clusters to the latest supported Kubernetes versions. This will ensure the music applications deployed to those AKS clusters are supported by Kubernetes.

Your deployment team first checked for the current list of Kubernetes versions supported by Azure Kubernetes Service. Then, by adopting a Blue/Green deployment approach, the team safely rolled out the available patches and version upgrades to the existing AKS clusters.

If the AKS cluster patches and upgrades hadn't taken place, the existing versions would've gone out of support. This means any issues that could impact the music applications deployed to the AKS clusters wouldn't be supported by Azure Kubernetes Service.

The benefit of version patches and upgrades is to ensure that when software loopholes are identified, they're fixed immediately. This prevents people with malicious intent from exploiting it. Additionally, when new features of software are released, they're designed to improve the quality and performance of the software. If you delay the new-version adoption process for too long, it could result in expensive upgrade costs to the business. Therefore, you should apply patches and upgrades to AKS cluster versions as soon as they're available to avoid potential large costs to the business.

Remember, these upgrades are for updating the components within the AKS cluster only. Operating-system updates and node-image upgrades have a separate upgrade and patch process.

[!include[azure-optional-exercise-subscription-cleanup](../../../includes/azure-optional-exercise-subscription-cleanup.md)]

## References

* [Tutorial: Upgrade Kubernetes in Azure Kubernetes Service (AKS)](/azure/aks/tutorial-kubernetes-upgrade-cluster?tabs=azure-cli)
* [Best practices for cluster security and upgrades in Azure Kubernetes Service (AKS)](/azure/aks/operator-best-practices-cluster-security)
* [Supported Kubernetes versions in Azure Kubernetes Service (AKS)](/azure/aks/supported-kubernetes-versions)
* [Blue/Green Deployment with Azure Front Door](https://techcommunity.microsoft.com/t5/azure-architecture-blog/blue-green-deployment-with-azure-front-door/ba-p/1609178)
* [AKS Release Calendar](https://github.com/Azure/AKS/releases)
