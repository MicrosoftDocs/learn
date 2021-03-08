At some point, many Microsoft enterprise customers will most likely need to respond to DSRs under GDPR, CCPA, or both. Sometimes cloud-based services such as Azure will host multiple tenants. When the data subject's personal information is in a cloud-based multi-tenancy, it’s helpful to understand the scope of or boundaries to a DSR response. Having a multi-tenancy response process in place will help create a timely response to a DSR.

## Scope of DSR for Azure AD and Microsoft service accounts

The following image details three scenarios in which a Microsoft customer might receive a DSR.<!-- ID/SME: What about the fourth tenant (Enterprise customer 2) that doesn't receive the DSR? If it's in there, we should mention it - in the alt text as well.-->

:::image type="content" source="../media/4-dsr-scope.png" alt-text="Three scenarios depicting the scope of Microsoft DSR fulfillment. 1. An enterprise customer receives a DSR. 2. A Microsoft service account with an Azure AD tenant receives a DSR. 3. A Microsoft service account outside an Azure AD tenant <!-- ID/SME: Should we say something about the privacy dashboard? -->receives a DSR." border="false":::

### Scenario 1
<!-- ID/SME: I like the scenario numbers here, but they don't correspond to numbers on the graphic. We should either add numbers to the graphic, or change these headings  to map them more clearly to the graphic. Perhaps "Microsoft service account 1," "Enterprise customer 1," "Enterprise customer 2," and "Microsoft service account 2?"-->
If an enterprise customer receives a DSR, then the DSR fulfillment is performed only in that customer's Azure AD tenant; it won’t affect any other tenants.

### Scenario 2

If a Microsoft service account receives a DSR and that Microsoft service account has created an Azure AD tenant, then the scope of the DSR fulfillment is also the Azure AD tenant.

### Scenario 3

If a Microsoft service account receives a DSR and the account is outside of an Azure AD tenant, then the DSR fulfillment will occur in the consumer privacy portal.<!-- ID/SME: We have a consumer privacy dashboard on the graphic. Can we change portal to dashboard, or vice versa? -->

> [!NOTE]
> It's possible that a user submitting a DSR participates in multiple tenants. If this happens, the DSR is only fulfilled in the tenant that receives the DSR.

## DSR response processes for Azure

The process for fulfilling a DSR in Azure consists of two parts. However, the high-level fulfillment tasks will differ based on the data type.

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
