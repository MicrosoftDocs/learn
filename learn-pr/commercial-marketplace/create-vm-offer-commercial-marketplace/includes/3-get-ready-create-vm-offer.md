We just covered the way virtual machine (VM) offers are sold in Azure Marketplace and the different licensing models to sell your software. Now, let's review the different ways you can price and package your software for Azure Marketplace. Learn how the license model you choose helps to define your marketplace business.

## VM offer considerations for all publishing options

Regardless of your license-model choice, you need to provide the following information to publish your offer:

- Customer Relationship Management (CRM) connection to receive [customer leads](/partner-center/marketplace/partner-center-portal/commercial-marketplace-get-customer-leads)
- Offer categories that describe your application and help customers find your software in Azure Marketplace
- Legal terms and conditions that dictate the terms of use for your software
- Descriptions of your software and details about the ways customers can use it

>[!TIP]
>To help you provide that information, we've created a separate learning module that covers information and best practices that will help you make the most of your company's presence in the Microsoft commercial marketplace. To learn more, complete the [Go to market through the Microsoft commercial marketplace](https://aka.ms/learnmarketplacegtm) module.

Let's spend the rest of our time reviewing considerations for publishers that sell their software through Microsoft using the usage-based license model.

## Providing information to sell through Microsoft

When you choose the usage-based license model and publish your offer to Azure Marketplace, it's integrated with Microsoft's commerce platform. Customers can purchase licenses to your software and deploy it to their Azure subscription in one brief process. Selling licenses through Microsoft streamlines the purchasing experience because customers don't need to leave Azure Marketplace to acquire a license to use your software.

To facilitate this experience, you're asked to provide all the information customers need to decide if they want to purchase your product. Let's spend some time reviewing concepts that help you decide how you want to package your VM offer for Azure Marketplace customers.

### VM offer plans and pricing

VM offers must have at least one plan. You can create various plans for the same offer to give your customers choices to purchase your application. Plans can differ in price, availability, billing terms, and levels of software functionality. For more detailed information on offer plans and available VM pricing models, check out our [documentation on planning a VM offer](/partner-center/marketplace/marketplace-virtual-machines).

#### VM offer pricing

When you publish a VM offer customers can purchase through Azure Marketplace, you need to provide pricing details for each of your offer's plans. Since VM offers are deployed to customers' Azure subscriptions, Microsoft bills customers directly for Azure infrastructure costs from using the application. This is an important characteristic of the VM software delivery model; it means that you don't need to include Azure infrastructure costs as a component of your price to customers.

VM offer pricing is hourly in Azure Marketplace. Your customers see your software's price split into two components in the Azure Marketplace online store: Azure infrastructure cost and your software's price per hour.

- **Infrastructure cost**: The hourly cost for Azure VMs used to deploy your application. This cost component varies by the Azure VM type and size that a customer chooses to deploy.
- **Software cost**: The hourly price you charge customers to license your software. This price can vary based on the VM size that customers choose to deploy your software.

When you publish your offer, you're only asked to provide price information for your software. Infrastructure costs are automatically calculated based on the Azure VM type and size the customer uses to deploy your software.

#### Selecting a price entry option

When you create your VM offer in Partner Center and configure its plans, you're asked to select a price entry option. The different price entry options give you varying levels of flexibility to structure your software's price. You have the following price entry options:

- **Free**: You provide the VM for free.
- **Flat rate**: You assign the same hourly price, regardless of the hardware it runs on.
- **Per vCPU**: You assign the price for one vCPU, and we increment the pricing based on the size of the hardware.
- **Per vCPU size**: You assign the price based on the number of vCPUs on the hardware they're  deployed on.
- **Per market and vCPU size**: You assign prices based on the number of vCPUs on the hardware they're deployed on, and for all markets. Currency conversion is done by you, the publisher. This option is easier if you use the import pricing feature.

> [!NOTE]
> If you choose one of the flat rate, per vCPU, or per vCPU size price entry options, Microsoft automatically converts your software pricing into local currencies for global customers by using the current exchange rate.

#### Configuring reservation pricing (optional)

When you select the *Flat rate*, *Per vCPU*, or *Per vCPU size* price option, the **Reservation pricing** section appears. You can choose to offer savings for a one-year commitment, three-year commitment, or both. For more information about reservation pricing, including how prices are calculated, see [Plan a VM offer](/partner-center/marketplace/marketplace-virtual-machines#reservation-pricing-optional).

These steps assume you already selected either the *Flat rate*, *Per vCPU*, or *Per vCPU size* price option and entered a per hour price.

1. Under **Reservation pricing**, select **Yes, offer reservation pricing**.
1. To offer a one-year discount, select the **1-year saving %** check box and then enter the percentage discount you want to offer.
1. To offer a three-year discount, select the **3-year saving %** check box and then enter the percentage discount you want to offer.
1. To see the discounted prices, select **Price per vCPU size**. A table with the one-year and three-year prices for each vCPU size is shown. These prices are calculated based on the number of hours in the term with the percentage discount subtracted.

   > [!TIP]
   > For Per vCPU size plans, you can optionally change the price for a particular vCPU size in the **Price/hour** column of the table.

1. Make sure to select **Save draft** before you leave the page. The changes are applied once you publish the offer.

#### Enabling VM offer free trials

When you select the usage-based license model for your VM offer, you can also offer free trials for your customers. You can offer customers one-, three-, or six-month free trials so they can evaluate your application. If you choose to enable free trials, Microsoft automatically foregoes billing customers for software costs through the trial period. At the end of the trial period, Microsoft automatically converts the customer to the paid software plan associated with the free trial.

Adding a free trial to your offer is as easy as checking a box when configuring your offer in Partner Center. The option appears on the pricing and availability page of the process, and you can add free trials for each of your offer's plans.

#### Selecting plan visibility

When you set up your VM offer plans in Partner Center, you can dictate whether each plan is **public** or **private**.

:::image type="content" source="../media/6-vm-plan-visibility.png" alt-text="Screenshot of the plan visibility toggle in Partner Center. This toggle appears in the 'pricing and availability' step of the publishing process.":::

- **Public**: Make your plan visible to all Azure Marketplace customers.
- **Private**: Make your plan visible to only a preselected audience. Private plans can be used to negotiate custom terms and pricing with specific customers.

   > [!IMPORTANT]
   > Private plans are still visible to everyone in the CLI, but only deployable to those customers configured in the private audience.

  - Once you publish a private plan, you can still adjust the private audience or change it to public.
  - But after you make a plan public, it can't be changed back to a private plan.
  
  If the plan is private, you can specify the private audience that has access to this plan using *Azure tenant IDs*, *subscription IDs*, or both. Optionally, include a **Description** of each Azure tenant ID or subscription ID that you assign. Add up to 10 subscription IDs and tenant IDs manually or import a CSV spreadsheet if more than 10 IDs are required. For a published offer, select **Sync private audience** for the changes to the private audience to take effect automatically without needing to republish the offer.

> [!NOTE]
> A private audience is different from the preview audience that you defined on the **Preview audience** pane. A preview audience can access and view all private and public plans for validation purposes before it's published live to Azure Marketplace. A private audience can only access the specific plans that they're authorized to have access to once the offer is live.

Private offers aren't supported with Azure subscriptions established through a reseller of the Cloud Solution Provider (CSP) program.

##### Hiding a plan

Hide a plan if you don't want it to be visible on Azure Marketplace but still deployable through another Solution Template, Managed Application, Azure CLI, or Azure PowerShell. Hiding a plan is useful when trying to limit exposure to customers that would normally be searching or browsing for it directly via Azure Marketplace. By selecting this checkbox, all VM images associated with your plan are hidden from Azure Marketplace storefront.

> [!NOTE]
> A hidden plan is different from a private plan. When a plan is publicly available but hidden, it is still available for any Azure customer to deploy via Solution Template, Managed Application, Azure CLI or Azure PowerShell. However, a plan can be both hidden and private, in which case only the customers configured in the private audience can deploy via these methods. If you wish to make the plan available to a limited set of customers, then set the plan to **Private**.

For more information on private offers, see our [documentation on private offers in the commercial marketplace](/partner-center/marketplace/isv-customer-faq).
