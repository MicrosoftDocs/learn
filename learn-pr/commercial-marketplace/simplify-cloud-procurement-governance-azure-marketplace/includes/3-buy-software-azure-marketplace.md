You start your research again, focused on learning how you can purchase software from Azure Marketplace after a trial. Your team moves quickly, so you want to understand how Azure Marketplace reduces the friction that's normally associated with IT procurement.

## Getting software from Azure Marketplace

Azure Marketplace has thousands of software applications you can get directly through Microsoft. These applications have a **Get it now** button and fall into three pricing models:

- Free

- Bring your own license (BYOL)

- Pay as you go

### Free

Free applications don't have associated software costs. You only pay for the underlying Azure infrastructure costs, if applicable. Once you've found a free application, select the **Plans + Pricing** tab on the product detail page to learn more about available free plans and see estimates for Azure infrastructure costs associated with the product, if it uses underlying cloud services.

### Bring your own license (BYOL)

Your organization might have spent considerable amounts of time and money buying software licenses from providers before you started your cloud migration. If possible, you want to take advantage of those investments as you migrate your workloads and applications from on-premises to Azure.

Azure Marketplace allows you to find software that lets you bring your own license (BYOL), giving you the flexibility you need to use subscriptions that you purchased outside of Azure Marketplace. With BYOL software applications, you pay the software vendor directly for licenses, while Azure infrastructure costs appear on your Microsoft invoice.

### Pay as you go

Pay-as-you-go applications have software costs and Azure infrastructure costs if they utilize underlying cloud services. In cloud computing, costs typically include software licensing and infrastructure usage. Software licensing fees are the costs for using the software product, while infrastructure costs refer to the amount for the use of the underlying services the solution needs to run. This is a common scenario for products that run on virtual machines. When purchasing pay-as-you-go software from Azure Marketplace, all costs are billed to you directly by Microsoft and appear on a consolidated invoice.

To view all costs associated with an application (software fees and infrastructure costs) select the **Plans + Pricing** tab on the product description page.

:::image type="content" source="../media/6-plans-pricing.png" alt-text="Screenshot of Plans + Pricing tab of a software product in the Azure Marketplace online store.":::

You can use the **Pricing Model** filter to narrow your search for solutions that correspond to each pricing model.

:::image type="content" source="../media/7-pricing-model-filter.png" alt-text="Screenshot of Pricing Model filter in the Azure Marketplace online store.":::

## Purchasing options and considerations

Azure Marketplace helps you simplify the procurement process through different purchasing options. You can purchase products using a credit card associated with your Azure account. All purchases are consolidated on a single invoice and billed to the credit card of choice. If you're a large customer, you can purchase from Azure Marketplace using an Enterprise Agreement. Any software purchases from the Azure Marketplace with an Enterprise Agreement are automatically included in your Azure invoice. Your invoice will contain Azure usage charges first, followed by Azure Marketplace charges.

### Simplify legal procurement

Before you purchase software, you'll want to make sure the terms and conditions set forth in the license agreement meet your company's legal requirements. Traditionally, you might have had to reach out to each individual provider, request terms and conditions for each software application, evaluate them separately, and conduct individual negotiations. Purchasing solutions through Azure Marketplace simplifies this process.

Software applications in Azure Marketplace are either subject to terms and conditions set by the provider or subject to the Standard Contract template that helps reduce friction for customers and providers. In either case, terms are between the software provider and the customer. Microsoft is not a party to these agreements.

### Standard Contract

The [Standard Contract](/azure/marketplace/standard-contract) helps simplify the procurement process by reducing legal complexity. All solutions that use the Standard Contract contain the same terms and conditions, so your legal team only needs to review the contract once.

You can find the applicable terms and conditions on the product detail page in the **Legal** section. Here, you'll see either the terms set by the provider or terms under the Standard Contract.

:::image type="content" source="../media/8-legal.png" alt-text="Screenshot of links to legal agreements on a product.":::

### Amendments to the Standard Contract

Software vendors can add amendments to the Standard Contract. If you've previously reviewed and accepted terms of the Standard Contract, you can save time by only reviewing the amendment.

You can also ask the provider to include a custom amendment for your specific needs. A custom amendment is a change to the Standard Contract negotiated between the customer and the software vendor that only applies to that purchase. You can review the custom amendment when acquiring the software application in the Azure portal.

### Negotiating custom deals with software providers

When procuring software, you might want to negotiate custom pricing or special configurations.

A private offer gives you and the software vendor the ability to negotiate special terms, custom pricing, and special product configurations. For example, a vendor can customize an Azure Virtual Machine, an Azure Application, or a Software as a Service subscription to your specific needs using a private offer.

Once a vendor has created a private offer for you, you can view the offer in the Azure Marketplace experience in the Azure portal. Private offers are not visible in the online store.

Sign in to the Azure portal and navigate to the Azure Marketplace, where you'll see a notification at the top of the screen and a link to view your private offers.

:::image type="content" source="../media/9-private-offer-notification.png" alt-text="Screenshot of a private offer notification in the Azure Marketplace experience in the Azure portal.":::

### Consolidated invoicing

Your employees in IT need multiple software applications from different vendors to achieve their individual team objectives. Managing individual vendor relationships and processing invoices for each software application can be a big administrative burden.

By purchasing through Azure Marketplace, you eliminate the complexity of dealing with individual invoices. You get a single, consolidated monthly bill from Microsoft that includes your purchases from Azure Marketplace along with charges for your Azure cloud services.

### Use Azure Marketplace for Azure Consumption Commitments

You want to make sure that any solution you purchase for your cloud infrastructure and software requirements meets the guidelines and budget set by your finance department. For example, some organizations have signed a contractual commitment with Microsoft for specific amounts of Azure spend over time.

With Azure Marketplace, it’s easy to find solutions that accrue towards your company’s Microsoft Azure Consumption Commitment (MACC).

If your organization has signed a Microsoft Azure Consumption Commitment (MACC), you can filter for Azure benefit eligible software in the Azure portal marketplace experience. Eligible offers will also have an “Azure benefit eligible” badge on the product details page.

:::image type="content" source="../media/10-macc.png" alt-text="Screenshot of Azure benefit eligible filter in the Azure Marketplace experience in the Azure portal.":::

:::image type="content" source="../media/21-macc-eligible-detail.png" alt-text="Screenshot of Azure benefit eligible badge in Azure Marketplace.":::

### Completing your purchase

After you’ve found the right software application, completing the purchase is simple. You’ll need to have appropriate permissions within the Azure subscription. Because Azure operates on a [Role Based Access Control](/azure/role-based-access-control/overview) (RBAC) model, your account needs subscription owner or contributor rights for the purchase to be completed.

In the Azure portal, find the software application you want to buy and Select **Create** or **Set up + subscribe**. You’ll be prompted to provide some information before being able to use your new solution.

:::image type="content" source="../media/11-purchase-create.png" alt-text="Screenshot of the Create button in the Azure Marketplace experience in the Azure portal.":::

:::image type="content" source="../media/12-save-subscribe-purchase.png" alt-text="Screenshot of Set up + subscribe button in Azure Marketplace in the Azure portal.":::

If you want to get a solution from the Azure Marketplace online store, you'll need to log in using your Azure account credentials after selecting **Get it now** on the product description page.

:::image type="content" source="../media/13-signin-purchase.png" alt-text="Screenshot of user sign-in after selecting get it now button in the Azure Marketplace online store.":::

Once you log in, you'll be redirected to the product in the Azure portal to complete your purchase.

:::image type="content" source="../media/14-taking-you-to-sql.png" alt-text="Screenshot of user redirection after signing into their Azure account from the Azure Marketplace online store.":::

## Summary

At this point, you have a solid understanding of how Azure Marketplace can help your organization purchase software more efficiently.

Legal reviews and contract negotiations are simpler with the flexibility created by the Standard Contract, custom amendments, and private offers. Adhering to budget constraints is easier with the flexible pricing models including free software, bring your own license (BYOL) products, and pay-as-you-go applications. Plus, managing monthly invoices and payments is less complicated with consolidated invoices.

You're also responsible for limiting risk for your organization by implementing management, security, and governance processes that can scale as your company grows. You start to research ways that Azure Marketplace can help you with that, too.
