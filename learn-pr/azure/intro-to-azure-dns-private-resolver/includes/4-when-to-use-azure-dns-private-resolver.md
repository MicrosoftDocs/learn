## When to use Azure DNS Private Resolver


In a hybrid environment, is the name resolution required from on-premises VMs to the Azure services hosted privately using private endpoint and private DNS? If yes, the Azure DNS Private Resolver managed service is the right tool for you.

Imagine you have hybrid environment where users in on-premises would like to perform a name resolution to connect to the SQL database running in Azure SQL with private endpoint enabled (query Azure private DNS from on-premises). Or an infrastructure running in Azure using Azure private DNS would like to perform name resolution for a service with fqdn running on-premises. 

Azure DNS private resolver enables users to query Azure DNS private zones from on-prem environment and vice versa without deploying VM based DNS servers.

