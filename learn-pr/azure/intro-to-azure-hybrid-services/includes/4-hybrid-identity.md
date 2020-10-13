Tailwind Traders has used Active Directory Domain Services (AD DS) as its on-premises identity provider on its on-premises network environment since it migrated from Windows NT 4.0 in the early 2000s. Many existing Tailwind Traders applications have a dependency on Active Directory. Some of these applications have a simple dependency on Active Directory as an identity provider. Others have deeper dependencies, such as complex Group Policy requirements, custom domain partitions, and custom schema extensions. 

As Tailwind Traders starts to move some resources and develop new applications in Azure, the company wants to avoid creating a parallel identity solution that would require separate login information for on-premises and cloud resources.

In this unit, you'll learn about the different ways to implement hybrid identity.

## Deploying domain controllers to Azure

The simplest way to provide the same AD DS environment in Azure that an organization has on-premises is to:

1. Deploy a pair of AD DS domain controllers on a subnet on an Azure virtual network.
1. Connect that virtual network to the on-premises network.
1. Configure that subnet as a new AD DS site, as shown in the following image.

   :::image type="content" source="../media/image5.png" alt-text="Replication of an on-premises identity hosted in Active Directory Domain Services to Azure Active Directory." lightbox="../media/image5.png":::

Another option is to configure the cloud-hosted AD DS domain as a child domain of the on-premises domain's forest. An additional option is to configure the AD DS domain controllers running in the cloud as a separate forest that has a trust relationship with the on-premises forest. The following image shows this resource forest topology.

:::image type="content" source="../media/image6.png" alt-text=" On-premises AD DS configured in a trust relationship with an AD DS deployment hosted on an Azure subnet." lightbox="../media/image6.png":::

When organizations deploy domain controllers on virtual machines (VMs) in Azure, those organizations can then deploy workloads that require line of sight to a domain controller on the same Azure Virtual Network subnet where they deployed the domain controller VMs. This is a conceptually simple model of hybrid cloud for many organizations because Azure datacenters are treated as a remote Active Directory site.

For Tailwind Traders, extending its on-premises Active Directory domain or forest into Azure might be sufficient, depending on application requirements. The drawback in deploying this option is that VMs that are running all the time, in the way that domain controllers must, have an associated ongoing expense.

## What is Azure AD Connect?

Azure Active Directory (Azure AD) Connect allows organizations to synchronize the identities present in their on-premises Active Directory instance to Azure Active Directory. This allows you to use the same identity for cloud resources and on-premises resources. Azure AD Connect is most often used when organizations adopt Microsoft 365 to permit applications such as Microsoft SharePoint and Exchange running in the cloud to be accessed via on-premises applications. 

The following image shows an on-premises AD DS instance synchronizing with an Azure AD instance.

:::image type="content" source="../media/image7.png" alt-text="Identity synchronization between on-premises Active Directory Domain Services instances and an Azure Active Directory tenant." lightbox="../media/image7.png":::

If Tailwind Traders plans to adopt Microsoft 365 technologies such as Exchange Online or Microsoft Teams, it will need to configure Azure AD Connect to replicate identities from its on-premises AD DS environment to Azure. If the company also wants to use on-premises identities with applications in Azure, but doesn't want to deploy AD DS domain controllers on VMs, it will also need to deploy Azure AD Connect.

## What is Azure AD DS?

You can use Azure AD DS to project an Azure AD domain onto an Azure virtual subnet. When you do this, services like domain join, Group Policy, Lightweight Directory Access Protocol (LDAP), and Kerberos and NTLM authentication become available to any VM deployed on the subnet. 

Azure AD DS allows you to have a basic managed Active Directory environment available to VMs without worrying about managing, maintaining, and paying for the VMs that run as domain controllers. Azure AD DS also allows you to use on-premises identities through Azure AD Connect to interact with VMs running on a specially configured Azure Virtual Network subnet. 

The following image shows an Azure AD DS architecture.

:::image type="content" source="../media/image8.png" alt-text="On-premises AD DS synchronizes with an Azure AD tenant that populates an Azure AD DS managed domain." lightbox="../media/image8.png":::

One drawback to Azure AD DS is that the Group Policy implementation is basic. It includes a fixed set of policies and offers no ability to create Group Policy Objects (GPOs). Even though the identities used on-premises will be available in Azure, any policies configured on-premises won't be available.

For Tailwind Traders, Azure AD DS provides a good middle ground for hybrid workloads. It enables domain-joined identity usage and a substantial amount of Group Policy configuration. But it won't support applications that require complex Active Directory functionality such as custom domain partitions and schema extensions.
