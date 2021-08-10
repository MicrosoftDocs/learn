When an administrator adds a custom domain name to an Azure AD, it is initially in an unverified state. Azure AD won't allow any directory resources to use an unverified domain name. Only one directory can use a domain name, the organization that owns the domain name.

After adding the custom domain name, you must verify ownership of the domain name. Verification is performed by adding a DNS record. The DNS record can be MX or TXT. Once the DNS record is added, Azure will query the DNS domain for the presence of the record. This could take several minutes or several hours. When Azure verifies the presence of the DNS record, it will then add the domain name to the subscription.

:::image type="content" source="../media/verify-custom-domain-2a02fdb3.png" alt-text="Screenshot of the custom domain name page. The TXT record is shown.":::
