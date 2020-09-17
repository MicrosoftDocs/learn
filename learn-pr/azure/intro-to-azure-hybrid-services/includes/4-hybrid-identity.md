Tailwind Traders has used Active Directory Domain Services as their on-premises identity provider on their on-premises network environment since they migrated from Windows NT 4.0 in the early 2000s. Many existing Tailwind Traders applications have a dependency on Active Directory. Some of these applications have a simple dependency on Active Directory as an identity provider. Others have deeper dependencies, such as complex Group Policy requirements, custom domain partitions, and custom schema extensions. As Tailwind Traders starts to move some resources and develop new applications in Azure, the company wishes to avoid creating a parallel identity solution that would require separate login information for on-premises and cloud resources.

In this unit, you’ll learn about the different ways of implementing hybrid identity.

## Deploying domain controllers to Azure

The simplest way of providing the same Active Directory Domain Services (AD DS) environment in Azure that an organization has on-premises is to deploy a pair of AD DS domain controllers on a subnet on an Azure Virtual Network, connect that virtual network to the on-premises network, then configure that subnet as a new Active Directory Domain Services site, as depicted in the following image.

:::image type="content" source="../media/image5.png" alt-text="Replication of on-premises identity hosted in AD DS to Azure AD" lightbox="../media/image5.png":::

Another option is to configure the cloud-hosted AD DS domain as a child domain of the on-premises domain’s forest. An additional option is to configure the AD DS domain controllers running in the cloud as a separate forest that has a trust relationship with the on-premises forest. The image below depicts this resource forest topology.

:::image type="content" source="../media/image6.png" alt-text=" On-premises AD DS configured in a trust relationship with an AD DS deployment hosted on an Azure subnet." lightbox="../media/image6.png":::

When organizations deploy domain controllers on virtual machines in Azure, those organizations can then deploy workloads that require line of sight to a domain controller on the same Azure Virtual Network subnet where they deployed the domain controller virtual machines. This is a conceptually simple model of hybrid cloud for many organizations because Azure datacenters are treated as a remote Active Directory site.

For Tailwind Traders, extending their on-premises Active Directory domain or forest into Azure might be sufficient depending on application requirements. The drawback in deploying this option is that virtual machines that are running all the time, in the way that domain controllers must, have an associated ongoing expense associated.

## What is Azure AD Connect?

Azure Active Directory Connect allows organizations to synchronize the identities present in their on-premises Active Directory instance to Azure Active Directory. This allows you to use the same identity for cloud resources and on-premises resources. Azure AD Connect is most often used when organizations adopt Microsoft 365 to permit applications such as Microsoft SharePoint and Exchange running in the cloud to be accessed via on-premises applications. The following image indicates an on-premises AD DS instance synchronizing with an Azure AD instance.

:::image type="content" source="../media/image7.png" alt-text="Identity synchronization between on-premises AD DS instances and Azure Active Directory tenant." lightbox="../media/image7.png":::

If Tailwind Traders plans to adopt Microsoft 365 technologies such as Exchange Online or Microsoft Teams, they’ll need to configure Azure AD Connect to replicate identities from their on-premises AD DS environment to Azure. If they also want to use on-premises identities with applications in Azure, but don’t want to deploy AD DS domain controllers on VMs, they will also need to deploy Azure AD Connect.

## What is Azure Active Directory Domain Services (Azure AD DS)?

Azure AD DS allows you to project an Azure AD domain onto an Azure virtual subnet. When you do this, services including domain join, Group Policy, lightweight directory access protocol (LDAP), and Kerberos and NTLM authentication become available to any virtual machine deployed on the subnet. Azure AD DS allows you to have a basic managed Active Directory environment available to virtual machines without worrying about managing, maintaining, and paying for the virtual machines that run as domain controllers. Azure AD DS also allows you to use on-premises identities through Azure AD Connect to interact with virtual machines running on a specially configured Azure virtual network subnet. The image below depicts an Azure AD DS architecture.

:::image type="content" source="../media/image8.png" alt-text="On-premises AD DS synchronizes with an Azure AD tenant which populates an Azure AD DS managed domain." lightbox="../media/image8.png":::

One Azure AD DS drawback is that the Group Policy implementation is basic—it includes a fixed set of Group Policies and offers no ability to create Group Policy Objects (GPOs). Even though the identities used on-premises will be available in Azure, any Group Policies configured on-premises won’t be available.

For Tailwind Traders, Azure AD DS provides a good middle ground for hybrid workloads. It enables domain-joined identities usage and a substantial amount Group Policy configuration, but it won’t support applications that require complex Active Directory functionality such as custom domain partitions and schema extensions.
