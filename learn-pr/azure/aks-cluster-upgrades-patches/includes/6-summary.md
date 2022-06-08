
Your deployment team has set up an AKS cluster that will go out of support soon. Your team needs to upgrade and patch the AKS clusters to the latest supported Kubernetes versions. This will ensure the music applications deployed to those AKS clusters are supported by Kubernetes.

Your deployment team first checked for the current list of Kubernetes versions supported by Azure Kubernetes Service. Then, by adopting a Blue/Green deployment approach, the team safely rolled out the available patches and version upgrades to the existing AKS clusters.

If the AKS cluster patches and upgrades had not taken place, the existing versions will go out of support. This means any issues that could impact the music applications deployed to the AKS clusters will not be supported by Azure Kubernetes Service. 

The benefit of version patches and upgrades is to ensure  when software loopholes are identified, they are fixed immediately. This prevents malicious intent from exploiting it. Additionally, when new features of software are released, they are designed to improve the quality and performance of the software. If the adoption process of new versions of software is delayed for too long, this process could result in expensive upgrade costs to the business. Therefore, patches and upgrades to AKS cluster versions should be applied as soon as they are available to avoid potential large costs to the business that could arise in the future.

Remember, these upgrades are for updating the components within the AKS cluster only. Operating system updates and node image upgrades is a separate upgrades and patches process.

[!include[azure-optional-exercise-subscription-cleanup](../../../includes/azure-optional-exercise-subscription-cleanup.md)]

## References

* [Upgrade AKS cluster tutorial](/azure/aks/tutorial-kubernetes-upgrade-cluster?tabs=azure-cli)
* [Best practices for AKS cluster security upgrades](/azure/aks/operator-best-practices-cluster-security)
* [Kubernetes versions supported in AKS](/azure/aks/supported-kubernetes-versions)
* [Blue/Green Deployment with Azure Front Door](https://techcommunity.microsoft.com/t5/azure-architecture-blog/blue-green-deployment-with-azure-front-door/ba-p/1609178)
* [AKS Release Calendar](https://github.com/Azure/AKS/releases)
