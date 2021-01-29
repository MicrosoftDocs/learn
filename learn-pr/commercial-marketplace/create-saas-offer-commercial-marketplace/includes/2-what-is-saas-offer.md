## SaaS offers in the commercial marketplace

When you publish your SaaS application to the Microsoft commercial marketplace, it’s called a SaaS offer. Customers can find SaaS offers in both of the commercial marketplace online stores—[**Azure Marketplace**](https://azuremarketplace.microsoft.com/) and [**Microsoft AppSource**](https://appsource.microsoft.com/). Your application’s placement in one or both online stores depends on the kind of service the application provides and the industries it was built to serve.

IT-focused SaaS solutions are placed in Azure Marketplace, including the Azure Marketplace experience in the Azure portal. These applications help customers build, run, analyze, and manage their workloads in the cloud.

Business-oriented SaaS applications are typically found in Microsoft AppSource. These applications help customers run their businesses and include software built to serve specific industries such as financial services, healthcare, and manufacturing.

### Publishing options for your SaaS offer

Before you publish your SaaS offer to the commercial marketplace, you’ll need to decide how you want to use the commercial marketplace to engage with your customers and sell your application. When you create your SaaS offer in Partner Center, you’ll be asked if you want to sell your application through Microsoft. Your answer helps determine the way your offer will be published.

:::image type="content" source="../media/2-sell-through-microsoft.png" alt-text="Screenshot of the 'sell through Microsoft' question from the offer setup page in Partner Center.":::

When asked if you'd like to sell through Microsoft, you’ll have the following options:

- **No**: If you answer “no,” customers will be able to find information about your SaaS application in Microsoft AppSource and Azure Marketplace, but they won’t be able to purchase it directly through Microsoft. You’ll have to process transactions and manage customers independently. These offers are referred to as a “list” offers, which we’ll explain in more detail soon.

- **Yes**: If you answer “yes,” customers will be able to purchase your SaaS offer directly from Microsoft AppSource and/or Azure Marketplace. When you sell through Microsoft, we process customer transactions and invoicing on your behalf. Selling through Microsoft requires technical integration with the commercial marketplace.

> [!NOTE]
> You won’t be able to change your "sell through Microsoft" choice after your offer is published. To change the way your application is listed or sold through Microsoft, you’ll need to publish a new offer.

#### Listing through the commercial marketplace

If you decide not to sell through Microsoft, you’ll have three options to list your application in the online stores—[**Azure Marketplace**](https://azuremarketplace.microsoft.com/) and [**Microsoft AppSource**](https://appsource.microsoft.com/). Your choice will determine how customers can learn more about your offer and engage with you to purchase a subscription. The option you choose will be indicated to customers with a call-to-action (CTA), which is the blue button that customers will click on your product’s page in the online stores.

:::image type="content" source="../media/3-marketplace-cta.png" alt-text="Screenshot of a product listing from Azure Marketplace with emphasis on the free trial button":::

You'll have a few options to choose from for your listing type:

- **Contact me**: Customers can fill in a form to share their contact information with you through your connected Customer Relationship Management (CRM) system or HTTP endpoint you configure to receive leads from Microsoft.

- **Get it now (Free)**: Lets customers subscribe and start using your application for free. For SaaS acquired through Azure Marketplace, customers use their Azure account information to complete the subscription from the Azure portal before logging into your website to use the SaaS application.

- **Free trial**: Gives customers an opportunity to activate a free trial by redirecting them to your website, where they provide required user information and activate their product trial.

   > [!Note]
   > If you choose to sell through Microsoft, you’ll be able to offer a free 30-day trial for your application by checking a box in Partner Center. Free software trials for offers sold through Microsoft are different than the free trial listing described above. When you choose to sell through Microsoft and enable a free software trial for customers, trials are facilitated through the users Azure account.

#### Sell through Microsoft

When you choose to sell your offer through Microsoft, it’s called a **transact offer**. Customers acquire these offers directly from the commercial marketplace and Microsoft facilitates payments on your behalf. As the software provider, you set the price for your SaaS application, Microsoft bills your customers, and we automatically pay you after withholding the marketplace service fee.

Choosing to sell your offer through Microsoft is an important decision that has a significant impact on the following:

- **Technical configuration of your offer**: When you sell through Microsoft, you will be required to complete the technical configuration step of the publishing process in Partner Center. The technical information you provide integrates your offer with the commercial marketplace to provide a better experience for you and your customers. We’ll cover SaaS offer technical components in more detail later in this module.

- **Customer experience**: When you sell through Microsoft, it’s easier for your customers to try, buy, and deploy your application from the commercial marketplace. Customers can activate a free software trial and purchase your solution directly from Microsoft AppSource or Azure Marketplace, without having to get in touch with anyone from your organization. Because many customers use the commercial marketplace to streamline their software purchases, we recommend that software vendors sell through Microsoft to provide a better experience for your customers.

- **Other commercial marketplace benefits**: When you sell through Microsoft, you get access to other commercial marketplace benefits for publishers. You’ll get to take advantage of benefits including:

  - Cost savings and operational efficiencies as Microsoft takes on billing, collections, currency conversions, and taxation for purchases from the commercial marketplace.
  
  - More valuable [Marketplace Rewards](https://docs.microsoft.com/azure/marketplace/gtm-your-marketplace-benefits) program benefits that are unlocked when your offer reaches revenue milestones through marketplace.

  - The ability to take advantage of customers’ Azure [consumption commitment benefit](https://docs.microsoft.com/azure/marketplace/azure-consumption-commitment-benefit). This benefit makes it possible for customers to purchase qualified offers from the commercial marketplace and receive credit against their Microsoft Azure Consumption Commitment (MACC). This streamlines purchasing and budgeting for customers with existing enterprise agreements (EA) or Microsoft Customer Agreements (MCA).

### Summary

Now that you understand where customers can find your SaaS offer and the different ways that you can publish it to the commercial marketplace, we’ll turn our attention to some of the considerations you should take before you publish. We’ll discuss some important SaaS offer concepts that will help you determine how you want to use the commercial marketplace to sell your application.
