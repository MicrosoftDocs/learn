To delegate your domain to Azure DNS, you need to identify the DNS name servers for your DNS zone. Each time a DNS zone is created, Azure DNS allocates DNS name servers from a pool. After the DNS name servers are assigned, Azure DNS automatically creates authoritative `NS` (or _Name server_) records in your DNS zone.

The delegation process for your domain involves several steps:

1. Identify your DNS name servers
1. Update your parent domain
1. Delegate subdomains (optional)

## How to find your DNS name servers

The easiest way to find the DNS name servers assigned to your DNS zone is through the Azure portal.

Let's take another look at our sample Azure Administrator Incorporated Azure AD domain. In a previous unit, we defined a custom domain name for the sample instance as `azureadmininc.org`. In the Azure portal, we can examine the custom domain and find that Azure assigned four DNS name servers to the DNS zone for the domain: `ns1-02.azure-dns.com.`, `ns2-02.azure-dns.net.`, `ns3-02.azure-dns.org.`, and `ns4-02.azure-dns.info.`.

:::image type="content" source="../media/name-servers-cf7cec6a.png" alt-text="Screenshot of a DNS zone with four assigned DNS name servers in the Azure portal.":::

## How to update your parent domain

After your DNS zone is created, and you can identify your DNS name servers, you need to update your parent domain.

Each registrar has their own DNS management tools to manage the DNS name server records for a domain. The term _registrar_ refers to the third-party domain registrar, which is the company where you registered your domain.

Here's a basic process you can follow to update your parent domain information with your registrar:

1. Go to your registrar's DNS management page.
1. Find the existing `NS` records for your parent domain.
1. Replace the existing `NS` records with the `NS` records created for your domain by Azure DNS.

### Things to consider when working with NS records

There are several important considerations to keep in mind when working with `NS` records and name servers for a DNS zone.

- When you copy an `NS` record (a DNS name server address), be sure to include the trailing period (`.`) at the end of the address. The trailing period indicates the end of a fully qualified domain name, such as `ns1-02.azure-dns.com.` and `ns3-02.azure-dns.org.`.

- To delegate your domain to Azure DNS, you must use the exact names of the DNS name servers as created by Azure DNS.

- We recommend that you always copy **all** DNS name server `NS` records for your domain to the parent domain, regardless of the actual domain name. In our sample scenario, suppose we don't expect traffic on the `ns4-02.azure-dns.info.` DNS name server. Although we don't expect traffic on this DNS name server address, the best practice is to also copy this `NS` record to the parent domain with the registrar along with the other name server addresses.

## How to delegate subdomains

You can delegate a subdomain for your domain in Azure DNS by setting up a separate child DNS zone.

Let's consider our sample Azure Administrator Incorporated Azure AD domain. We created a custom domain name for the instance as `azureadmininc.org`. We can configure a separate child DNS zone for the custom domain to support partners of the organization, such as `partners.azureadmininc.org`.

The configuration steps for delegating a child DNS zone are similar to the typical delegation process. The key difference is you don't work with your registrar to delegate a subdomain. You delegate the child DNS zone in the Azure portal.

Here are the steps to delegate a subdomain:

1. Go to the parent DNS zone for your domain in the Azure portal.
1. Find the existing `NS` records for your parent domain.
1. Create new `NS` records for your child DNS zone (subdomain).

   > [!NOTE]
   > The parent and child DNS zones can be in the same or different resource group.

In our example, notice that the `NS` record server name in child DNS zone is the same name as for the parent DNS zone, `azureadmininc.com`. The one difference that identifies the subdomain is the addition of the keyword _partners_ with the separating period (`.`).