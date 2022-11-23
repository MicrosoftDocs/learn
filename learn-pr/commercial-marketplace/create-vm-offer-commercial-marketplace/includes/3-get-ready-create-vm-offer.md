We just covered the way virtual machine (VM) offers are sold in Azure Marketplace and the different licensing models to sell your software. Now we’ll review the different ways you can price and package your software for Azure Marketplace. You’ll learn how the license model you choose helps to define your marketplace business.

## VM offer considerations for all publishing options

Regardless of your license-model choice, you’ll need to provide the following information to publish your offer:

- Customer Relationship Management (CRM) connection to receive [customer leads](/azure/marketplace/partner-center-portal/commercial-marketplace-get-customer-leads)

- Offer categories that describe your application and help customers find your software in Azure Marketplace

- Legal terms and conditions that dictate the terms of use for your software

- Descriptions of your software and details about the ways customers can use it

>[!TIP]
>To help you provide the information listed above, we’ve created a separate learning module that covers information and best practices that will help you make the most of your company’s presence in the Microsoft commercial marketplace. To learn more, complete the [Go to market through the Microsoft commercial marketplace](https://aka.ms/learnmarketplacegtm) module.

We’ll spend the rest of our time reviewing considerations for publishers that sell their software through Microsoft using the usage-based license model.

## Providing information to sell through Microsoft

When you choose the usage-based license model and publish your offer to Azure Marketplace, it will be integrated with Microsoft’s commerce platform. Customers will be able to purchase licenses to your software and deploy it to their Azure subscription in one brief process. Selling licenses through Microsoft streamlines the purchasing experience because customers won’t need to leave Azure Marketplace to acquire a license to use your software.

To facilitate this experience, you’ll be asked to provide all the information customers need to decide if they want to purchase your product. Let’s spend some time reviewing concepts that will help you decide how you want to package your VM offer for Azure Marketplace customers.

### VM offer plans and pricing

VM offers must have at least one plan. You can create various plans for the same offer to give your customers choices to purchase your application. Plans can differ in price, availability, billing terms, and levels of software functionality. For more detailed information on offer plans and available VM pricing models, check out our [documentation on planning a virtual machine offer](/azure/marketplace/marketplace-virtual-machines).

#### VM offer pricing

When you publish a VM offer customers can purchase through Azure Marketplace, you’ll need to provide pricing details for each of your offer’s plans. Since VM offers are deployed to customers’ Azure subscriptions, Microsoft bills customers directly for Azure infrastructure costs from using the application. This is an important characteristic of the VM software delivery model; it means that you don’t need to include Azure infrastructure costs as a component of your price to customers.

VM offer pricing is hourly in Azure Marketplace. Your customers will see your software’s price split into two components in the Azure Marketplace online store: Azure infrastructure cost and your software's price per hour.

- **Infrastructure cost**: The hourly cost for Azure VMs used to deploy your application. This cost component varies by the Azure VM type and size that a customer chooses to deploy.

- **Software cost**: The hourly price you charge customers to license your software. This price can vary based on the VM size that customers choose to deploy your software.

When you publish your offer, you’ll only be asked to provide price information for your software. Infrastructure costs are automatically calculated based on the Azure VM type and size the customer uses to deploy your software.

#### Selecting a price entry option

:::image type="content" source="../media/4-vm-price-entry-options-1.png" alt-text="Screenshot of the price entry options in Partner Center. This selection appears in the 'pricing and availability' step of the publishing process.":::

When you create your VM offer in Partner Center and configure its plans, you’ll be asked to select a price entry option. The different price entry options give you varying levels of flexibility to structure your software’s price. You’ll have three price entry options:

- **Per core**: You provide one hourly per core price, which is used to calculate pricing for all available core sizes automatically.

- **Per core size**: You provide pricing for each of the available core sizes for Azure VMs. This entry option gives you more control to specify your software’s pricing structure.

- **Per market and core size**: You provide pricing for each available core size, with the added flexibility to customize prices for each geographic market.

>[!NOTE]
>If you choose either the per core or per core size price entry option, Microsoft will automatically convert your software pricing into local currencies for global customers by using the current exchange rate.

#### Enabling VM offer free trials

When you select the usage-based license model for your VM offer, you can also offer free trials for your customers. You can offer customers one-, three-, or six-month free trials so they can evaluate your application. If you choose to enable free trials, Microsoft will automatically forego billing customers for software costs through the trial period. At the end of the trial period, Microsoft automatically converts the customer to the paid software plan that's associated with the free trial.

Adding a free trial to your offer is as easy as checking a box when configuring your offer in Partner Center. The option appears on the pricing and availability page of the process, and you can add free trials for each of your offer’s plans.

:::image type="content" source="../media/5-vm-free-trial-option.png" alt-text="Screenshot of the free trial options in Partner Center. These options appear in the 'pricing and availability' step of the publishing process.":::

#### Selecting plan visibility

When you set up your VM offer plans in Partner Center, you’ll be able to dictate whether each plan is public or private. Public plans are made available to all Azure Marketplace customers. Private plans will only be made available to specific customers that you choose. Private plans can be used to negotiate custom terms and pricing with specific customers.

:::image type="content" source="../media/6-vm-plan-visibility.png" alt-text="Screenshot of the plan visibility toggle in Partner Center. This toggle appears in the 'pricing and availability' step of the publishing process.":::

>[!NOTE]
>To publish a private plan, you’ll need to provide the Azure tenant IDs of the customers that want to use your software. Only those customers will see your private offer in the Azure portal.

For more information on private offers, reference our [documentation on private offers in the commercial marketplace](/azure/marketplace/private-offers).
