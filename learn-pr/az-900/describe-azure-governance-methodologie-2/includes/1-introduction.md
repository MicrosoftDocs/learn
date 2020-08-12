A good governance strategy helps you to maintain control over your applications and resources in Azure. This ensures they stay compliant with both external standards (like [PCI DSS](https://docs.microsoft.com/microsoft-365/compliance/offering-pci-dss?view=o365-worldwide)) and with internal standards you may wish to enforce (such as enforcing that a Data Lake Store account is encrypted.)    

Governance is most beneficial when:
+ You have multiple engineering teams working in Azure
+ You have multiple subscriptions in your tenant
+ You have regulatory requirements that must be enforced
+ You want to ensure standards are followed for all cloud resources

Governance involves planning y our initiatives and setting priorities on a strategic level to help manage and prevent issues. You can then configure Azure's governance tools to enforce or audit your required settings when a new resource is deployed. And finally, you can check the state of existing resources against your governance decisions, and automatically (in some cases) or manually correct configuration drift. 


<div style="background: yellow;">
TODO: 
Replace next para with speed v control animation?
</div>
You could enforce your standards by not allowing teams to directly create Azure resources - and instead have the IT team define and deploy all cloud-based assets. While this approach is often used for production on-premises environments, it slows down deployment and reconfiguration timeframes, reducing team agility and the ability to innovate. Instead, Azure provides several tools you can use to enforce and validate your standards, while still allowing your engineering teams to create and own their own resources in the cloud.

**Level**: 

Beginner

**Learning Objectives**

In this module, you will:
+ Learn how the Cloud Adoption Framework can help you make organizational decisions about your cloud environment.
+ Learn how role-based security can fine-tune access to your resources.
+ Apply tags to add metadata to your Azure resources, for configuration control and reporting.
+ Lock resources to prevent accidental deletion 
+ Apply policies to control and audit resource creation.
+ Apply governance at scale across multiple subscriptions.



<div style="background: yellow;">

TODO: 
+ Introduce CAF (early)
+ Add resource tags
+ Maybe move RBAC to before Policy 
+ Move subscription limits to near CAF (unit 11)

</div>
