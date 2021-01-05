Many Microsoft enterprise customers will be required to respond to DSRs under GDPR and/or CCPA. Cloud-based services such as Azure host multiple tenants. Therefore, it’s important to understand the scope or boundaries to any DSR response when the data subject's personal information is stored in a Microsoft cloud-based service. Responses to DSRs should be timely and having a response process in place will help expedite the process. 

## Scope of DSR for Azure AD and Microsoft service accounts

The following image depicts three scenarios where a Microsoft customer receives a DSR. <!--Richard, could you add a couple of short sentences to the alt-text to explain what the image is conveying? What are the the differences between each scenario?-->

:::image type="content" source="../media/4-dsr-scope.png" alt-text="Three scenarios depicting the scope of Microsoft DSR fulfillment." border="false":::

### Scenario 1

If an enterprise customer receives a DSR, then the fulfillment of the DSR is only performed in that customer's Azure AD tenant. It won’t affect any other tenants.

### Scenario 2

If a Microsoft service account receives a DSR and that Microsoft service account has created an Azure AD tenant, then the scope of the DSR fulfillment is also the Azure AD tenant.

### Scenario 3

If a Microsoft service account receives a DSR and the account is outside of an Azure AD tenant, then the DSR fulfillment will occur in the consumer privacy portal. 

> [!NOTE]
> It is possible that a user submitting a DSR participates in multiple tenants. If this happens, the DSR is only fulfilled in the tenant that received the DSR.

## DSR response processes for Azure

The process for fulfilling a DSR in Azure consists of two parts. The high-level fulfillment tasks differ, based on the data type.

### Part one: Customer data

For customer data, the high-level fulfillment tasks are: 

1. Discover
2. Access
3. Rectify
4. Restrict
5. Delete
6. Export

### Part two: System-generated logs

For system-generated logs, the high-level fulfillment tasks are: 

1. Access
2. Delete
3. Export

 
