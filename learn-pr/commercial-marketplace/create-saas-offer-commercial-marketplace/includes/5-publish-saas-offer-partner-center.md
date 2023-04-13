Now that we’ve covered SaaS offer basics and technical considerations for your offer, we’ll spend some time reviewing the commercial marketplace publishing process in Partner Center. In this process, you’ll put the concepts we discussed in previous units together, providing the business and technical information needed to create and publish your offer.

The publishing process is broken down into several steps, each of which requires that you provide different information about your offer.

### Offer setup

After selecting **+ New offer** on the overview page of the commercial marketplace section of Partner Center, you’ll be taken to the offer-setup page. This step is where you'll indicate whether you want to sell through Microsoft. It's also where you'll configure your CRM or HTTP endpoint to receive [customer leads](/azure/marketplace/partner-center-portal/commercial-marketplace-get-customer-leads) from Microsoft.

The "sell through Microsoft" selection you make in this step determines the information required throughout the rest of the publishing process.

### Configure your offer properties

:::image type="content" source="../media/8-offer-properties.png" alt-text="Screenshot of the offer properties fields that are required to publish any SaaS offer to the commercial marketplace.":::

When you get to the **Properties** tab of the publishing process, you’ll be asked to define the categories and industries that will be used to index your offering in the commercial marketplace. You’ll select your choices from a pre-populated list of options.

> [!IMPORTANT]
> The categories you select to describe your offer will determine your SaaS offer’s placement in Azure Marketplace or Microsoft AppSource. As a reminder, business applications are published to Microsoft AppSource, while IT and Developer applications are published to Azure Marketplace.

The **Properties** tab is also where you provide the legal terms and conditions that govern the use of your SaaS application by customers. You can use the commercial marketplace standard contract, or you can define your own terms and conditions. If you choose the standard contract, you’ll be given the option to supplement it with amendments that you define. For more detail on terms and conditions, you can reference our [standard contract for Microsoft commercial marketplace documentation](/azure/marketplace/standard-contract).

### Provide information for your offer listing

:::image type="content" source="../media/9-offer-listing.png" alt-text="Screenshot of Offer listing fields from Partner Center.":::

In the **Offer listing** tab, you’ll provide the information that'll be displayed to customers in the commercial marketplace, including descriptions of your SaaS application, getting started instructions, links to useful product information, and support and engineering contacts for customers. This page is also where you'll provide media (such as logos, screenshots, and videos) that'll be displayed on your products page in Microsoft AppSource or Azure Marketplace.

For tips to help you complete this step, reference our documentation on [offer listing best practices](/azure/marketplace/gtm-offer-listing-best-practices) and [marketing best practices](/azure/marketplace/gtm-marketing-best-practices).

### Add a preview audience

When you publish your offer, you’ll be able to identify a preview audience that can access the offer and review it before it’s live in the commercial marketplace. For more information, review our [documentation on adding a preview audience for your SaaS offer](/azure/marketplace/create-new-saas-offer-preview).

### Complete your offer’s technical configuration

:::image type="content" source="../media/7-technical-configuration.png" alt-text="Screenshot of the technical configuration fields required to publish a transact offer.":::

The Technical configuration step, which is only required for transact offers, is where you enter the technical information we discussed in the previous unit of this module. You’ll be prompted to provide the URL for your offer’s landing page, the URL for the connection webhook, and Azure Active Directory (Azure AD) information.

### Create SaaS offer plans

:::image type="content" source="../media/4-plans-pricing-setup.png" alt-text="Screenshot of the pricing and availability configuration page in Partner Center.":::

In the plan overview, you’ll create your SaaS offer’s plans. Remember, your SaaS offer’s plans define the pricing and availability of your solution to customers. All SaaS offers must have at least one plan.

You’ll choose in which markets your SaaS offer will be available from a list of more than 140 countries/regions. This page is also where you’ll choose a pricing model for your offer. As a reminder, you’ll be able to choose between the following pricing models:

- **Flat rate**: Customers are charged a certain amount to use your software across their entire organization.
- **Per user**: Customers are charged a certain amount for each unique user that has access to log in and use your solution.

> [!TIP]
> If you choose the flat-rate pricing model, you’ll also be given the opportunity to add meters to your plan.

You'll finish this page by telling us whether or not you want to offer customers a one-month free trial and indicating whether this plan is public or private. As a refresher, public plans are made available to all customers, while private plans will only be made available to specific customers that you choose.

For more detailed guidance on creating plans for your SaaS offer, reference our [documentation on SaaS offer plans](/azure/marketplace/create-new-saas-offer-plans).
> [!TIP]
> To publish a private plan, you’ll need to know the Azure tenant IDs of the customer that wants to use your software.
