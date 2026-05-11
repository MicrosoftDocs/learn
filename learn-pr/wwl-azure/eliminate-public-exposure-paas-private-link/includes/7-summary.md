In this module, you addressed Contoso's critical pen test finding by eliminating public endpoint exposure across several categories of platform as a service (PaaS): Azure SQL Database, Blob Storage, Key Vault, and Azure OpenAI. Each service now uses private endpoints with public access disabled, and Azure Policy enforces the standard at management group scope. The exfiltration path the pen tester discovered no longer exists—storage Fully Qualified Domain Names (FQDNs) resolve to private IPs inside the virtual network (virtual network), and requests from outside the virtual network receive no route. Azure Policy flags new resources deployed without private endpoints in the compliance dashboard.

## Learn more

- [Azure Private Link overview](/azure/private-link/private-link-overview)
- [Private endpoint DNS configuration](/azure/private-link/private-endpoint-dns)
- [Azure Private Link Service](/azure/private-link/private-link-service-overview)
- [Azure Policy built-in definitions for Private Link](/azure/private-link/azure-policy-overview-private-link)
- [Microsoft Defender for Cloud network recommendations](/azure/defender-for-cloud/recommendations-reference-networking)
