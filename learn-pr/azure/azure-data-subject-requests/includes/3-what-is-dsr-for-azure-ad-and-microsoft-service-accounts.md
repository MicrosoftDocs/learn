Many Microsoft enterprise customers will be required to respond to DSRs under GDPR and/or CCPA. Cloud-based services like Microsoft Azure host multiple tenants. Therefore, it is important to understand the scope or boundaries to any DSR response when the data subject's personal information is stored in the Microsoft Cloud. Responses to DSRs need to be provided in a timely fashion. Having a response process in place will help expedite the response times. 

## Scope of DSR for Azure AD and Microsoft service accounts

The following image shows three scenarios where a DSR is received by a Microsoft customer.

:::image type="content" source="../media/4-dsr-scope.png" alt-text="Image shows Microsoft's DSR execution scope." border="false":::

**Scenario 1**
If a DSR is received by an enterprise customer the execution of the DSR is only performed in that customer's Azure Active Directory tenant. It will have no affect on any other tenants.

**Scenario 2**
If a DSR is received by a Microsoft Service Account (MSA) and that MSA has created an Azure Active Directory tenant than the scope of the DSR execution is also the Azure Active Directory tenant.

**Scenario 3**
If a DSR is received by an MSA and the account is outside of an Azure Active Directory tenant than the DSR execution will occur in the Consumer Privacy Portal.

It is possible that a user submitting a DSR participates in multiple tenants. If this happens, the DSR is only executed in the tenant that received the DSR.

## DSR response processes for Azure
The process for executing a DSR in Azure is broken into two parts. The high-level execution tasks differ based on the data type:

**Part 1: Customer data**

1. Discover
2. Access
3. Rectify
4. Restrict
5. Delete
6. Export

**Part 2: System-Generated Logs**

1. Access
2. Delete
3. Export


