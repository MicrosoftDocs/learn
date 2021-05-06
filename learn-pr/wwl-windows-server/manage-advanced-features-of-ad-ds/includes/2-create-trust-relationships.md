An AD DS forest represents a security boundary, providing secure authentication and authorization for its users, computers, and applications. Sometimes, it might be necessary to extend this boundary to include other AD DS domains and forests. This, for example, might result from mergers and acquisitions between organizations, or from consolidation initiatives, as is the case with Contoso.

## What is a trust relationship?

AD DS trusts enable access to resources in a multiple-domain and multiple-forest AD DS environment. In a single-domain forest, all users and resources, such as file shares, printers, or applications share the same domain, so access management is straightforward and readily available. When you have multiple domains or forests, you need trusts to provide users in one domain with secure access to resources in another domain.

In a multiple-domain AD DS forest, by default, domains form a tree-like structure with a two-way transitive trust relationship between directly adjacent domains. Trust transitivity implies that a path of trust exists between all the AD DS domains in the same forest. Additionally, you can create other types of trusts. The following table describes the main trust types.

|Trust type|Description|Direction|Description|
|-|--|||
|External|Nontransitive|One-way or two-way|Enable resource access with an individual AD DS domain in another forest.|
|Realm|Transitive or nontransitive|One-way or two-way|Establish an authentication path between a Windows Server AD DS domain and a Kerberos version 5 (v5) protocol realm that implements by using a directory service other than AD DS.|
|Forest (complete or selective)|Transitive|One-way or two-way|Allow two forests to share resources.|
|Shortcut|Nontransitive|One-way or two-way|Reduce the time taken to authenticate between two, not directly adjacent domains in the same multiple-domain AD DS forest.|

:::image type="content" source="../media/m9-shortcut-trust.png" alt-text="The shortcut trust between two child domains in the adatum.com AD DS forest." border="false":::

:::image type="content" source="../media/m9-forest-trust.png" alt-text="The two-way forest trust between the Tailspintoys.com and Wideworldimporters.com AD DS forests." border="false":::

> [!NOTE]
> Forest trust relationships provide most flexibility from the authentication standpoint. They are also easier to establish, maintain, and administer than separate trust relationships between external, domain-level trusts and individual domains across the two forests.

## Create and configure forest trust relationships

If the AD DS environment contains multiple forests, it is possible to set up one-way or two-way trust relationships between any pair of forests. With a one-way forest trust, you can grant users in the trusted forest access to resources in the trusting forest. With a two-way forest trust, it becomes possible to grant users on each side of the trust access to resources in the other forest.

When creating a trust, you specify the root domain of each forest. However, because forest trusts are transitive for all domains in each forest, you effectively establish a trust between each pair of domains across both forests. However, unlike trusts between multiple domains in the same forest, forest trusts are not transitive across multiple forests. This means that if you create a forest trust between Forest 1 and Forest 2 and you create a forest trust between Forest 2 and Forest 3, Forest 1 doesn't implicitly trust Forest 3.

Forest trusts are particularly useful in scenarios that involve cross-organization collaboration, mergers and acquisitions, or within a single organization that has more than one forest in which to isolate Active Directory data and services. Forest trusts are also useful for application service providers, for collaborative business extranets, and for organizations that want a solution for administrative autonomy.

Before you can implement a forest trust, you need to ensure that DNS name resolution exists between the forests. To implement such name resolution, you can use several different DNS resolution techniques, such as secondary zones, stub zones, or conditional forwarding.

### Configuring advanced AD DS trust settings

In some cases, you might want to limit the scope of trust relationships to minimize the possibility of unauthorized access to resources in your forest. Several technologies can help you accomplish this goal.

#### SID filtering

By default, when you establish a forest or domain trust, you can enable a domain quarantine, also known as SID filtering. When a user authenticates in a trusted domain, the user presents an authorization request that includes the SID attributes of all groups to which the user belongs. Additionally, the user's authorization request includes the SID-History attribute of the user and the user's groups. SID filtering blocks the use of SIDs present in SID-History that don't originate from the trusted domain. This prevents a potential exploit that involves tempering with the SID-History attribute to gain unauthorized access to resources in the trusted domain.

## Selective authentication

When you create a forest trust, you can manage the scope of authentication of trusted security principals. There are two modes of authentication for an external or forest trust:

- Forest-wide authentication.
- Selective authentication.

Choosing the forest-wide authentication enables all users in the trusted forest to authenticate for services and access on all computers in the trusting forest. Therefore, it is possible for resource administrators in the trusting forest to grant users from the trusted forest permissions to resources in the local forest. Additionally, all users from a trusted forest are considered Authenticated Users in the trusting forest. Effectively, any resource that grants permissions to Authenticated Users becomes accessible by users in the trusted forest.

If you choose selective authentication, users in the trusted forest are not considered Authenticated Users in the trusting forest. Instead, you have to explicitly designate computers that they will be able to authenticate to by granting them the Allowed to Authenticate permission on those computers. For example, imagine that you have a forest trust with a partner organization's forest. You want to ensure that only users from the partner organization's marketing group can access shared folders on a specific file server. To do so, you can configure selective authentication for the trust relationship and then grant the trusted users the right to authenticate only to that one file server.

> [!NOTE]
> When using selective authentication, in addition to the right to authenticate, users from the trusted forest still need file-system and folder-level permissions on the shared folders to access their content.

## Demonstration

The following video demonstrates how to:

- Configure prerequisites for trust relationships.
- Create a trust relationship.

The main steps in the process are:

1. Create two AD DS forests. Deploy two domain controllers, with each one in a separate forest. Make sure that their names don't match.
1. Configure DNS conditional forwarding. Configure DNS conditional forwarding on each AD DS Domain controller to provide DNS name resolution across forests.
1. Create a forest trust relationship from the first forest to the second one. Use Active Directory Domains and Trusts to establish one-way trust relationship from the first forest to the second forest.
1. Create a forest trust relationship from the second forest to the first one. Use Active Directory Domains and Trusts to establish one-way trust relationship from the second forest to the first forest.

 >[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4M7ug]