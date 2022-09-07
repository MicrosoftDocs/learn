We’ve covered VM offer basics and concepts to help create your VM. Now we’ll spend some time on an overview of the Partner Center publishing process. In this process, you’ll put all the pieces together, providing the information needed to create and publish your offer.

The publishing process is broken down into several steps, each of which requires that you provide different information about your offer.

### Offer setup

After clicking **+ New offer** on the commercial marketplace overview page in Partner Center, you’ll be taken to the offer setup page. This page is where you’ll configure your CRM or HTTP endpoint to receive [customer leads](/azure/marketplace/partner-center-portal/commercial-marketplace-get-customer-leads) from Microsoft.

### Configuring your offer’s properties

:::image type="content" source="../media/7-vm-offer-properties.png" alt-text="Screenshot of the offer properties step of the publishing process in Partner Center.":::

When you get to the properties tab of the publishing process, you’ll be asked to define the categories and subcategories that will be used to place your product in Azure Marketplace. You’ll select your choices from a pre-populated list of options.

The properties tab is also where you’ll provide the legal terms and conditions that govern the use of your software by customers. You can use the commercial marketplace Standard Contract, or define your own terms and conditions. If you choose the standard contract, you’ll be given the option to supplement it with amendments from your company. For more detail on terms and conditions, reference our [standard contract for Microsoft commercial marketplace documentation](/azure/marketplace/standard-contract).

### Providing information for your offer listing

:::image type="content" source="../media/8-vm-offer-listing.png" alt-text="Screenshot of the offer listing step of the publishing process in Partner Center.":::

In the offer listing tab, you’ll provide product information that gets displayed to customers in Azure Marketplace. This information includes descriptions of your VM-based software, user instructions, links to useful product information, and support & engineering contacts for customers. This page is also where you'll provide media—such as logos, screenshots, and videos—that will be displayed on your products page in Azure Marketplace.

For guidance to help you complete this step, reference our documentation on [offer listing best practices](/azure/marketplace/gtm-offer-listing-best-practices) and [marketing best practices](/azure/marketplace/gtm-marketing-best-practices).

### Adding a preview audience

When you publish your offer, you’ll be able to identify a preview audience that gets access to review your VM offer before it's available in Azure Marketplace. For more information, review our [documentation on adding a preview audience for your VM offer](/azure/marketplace/azure-vm-create-preview).

### Creating VM offer plans

:::image type="content" source="../media/9-vm-offer-plan-overview.png" alt-text="Screenshot of the plan overview page of the publishing process in Partner Center. This step is where publishers create new plans for their offer.":::

In the plan overview, you’ll create your VM offer’s plans. Remember, all VM offers must have at least one plan. Your VM offer’s plans define the pricing and availability of your product to customers.

You’ll choose the Azure regions in which your plan should be available on the plan setup page. Your plan must be available in at least one of the two following Azure regions:

:::image type="content" source="../media/10-vm-offer-plan-setup.png" alt-text="Screenshot of the plan setup page of the publishing process in Partner Center. This step is where publishers choose the Azure regions in which their plan will be available.":::

- **Azure Global**: Makes your plan available to customers in all Azure Global regions that have commercial marketplace integration.

- **Azure Government**: Makes your plan available in the [Azure Government](/azure/azure-government/documentation-government-welcome) region, which provides controlled access for customers from US federal, state, local, or tribal entities. If you want to make your plan available to these entities, you’ll need to ensure that your company and offer meet all required compliance controls, security measures, and other Azure Government criteria.

On the pricing and availability tab, you’ll choose in which markets your VM offer will be available from a list of more than 140 countries. Most markets are selected by default. For additional information to help you select market availability, check out our [documentation on the topic](/azure/marketplace/azure-vm-plan-pricing-and-availability#markets).

:::image type="content" source="../media/11-vm-offer-markets.png" alt-text="Screenshot of the market selection step of the publishing process in Partner Center. This step is part of the pricing and availability step of the plan creation process.":::

This is also where you'll select your offer’s license model. As a reminder, the license model dictates whether your customers can purchase a license to use your software through Microsoft. You’ll have two licensing options:

- **Usage-based monthly billed plan**: Customers can purchase a license for your software from Azure Marketplace and Microsoft processes payments from customers on your behalf.

- **Bring your own license (BYOL)**: Customers have to purchase a subscription to your application outside of Azure Marketplace. You’ll be responsible for validating customer subscriptions, facilitating payments, managing active subscriptions, metering usages (if applicable), and invoicing over the life of the subscription.

After selecting your license model and entering pricing information, you'll tell us whether you want to enable free trials and whether this is a public or private plan. As a refresher, public plans are made available to all customers, while private plans will only be made available to specific customers you choose.

>[!TIP]
>To publish a private plan, you'll need to know the Azure tenant IDs of your customers.

For more detailed guidance on creating plans for your VM offer, reference our [documentation on VM offer plans](/azure/marketplace/azure-vm-create-plans).

### Completing your offer’s technical configuration

:::image type="content" source="../media/12-vm-offer-technical-configuration.png" alt-text="Screenshot of the technical configuration step of the publishing process in Partner Center.":::

When you get to your offer's technical configuration, you'll be prompted to provide the following information about your VM offer:

- Your VM's operating system, either Windows or Linux

- Operating-system information for your VM image, including:

  - For Windows VMs, you'll select the version of Windows Server you used to create your image in the **Release** field.
  
  - For Linux VMs, you'll select the version of the Linux OS in the **Vendor** field.
  
  - An OS-friendly name for the operating system, which will be visible to customers that deploy your VM offer. As an example, if you used Ubuntu 18.04 LTS to create your base image, you could use "Ubuntu 18.04 LTS" as the OS-friendly name.

- Recommended VM sizes to deploy your software. Customers will see in these recommendations before they deploy your software from Azure Marketplace. You'll be able to provide up to six recommended VM sizes for your offer's plan.

- Public or private open ports used to access your VM. Your offer might require open ports in addition to the default ports required for all VM offers. Any other ports needed will depend on your VMs configuration and operations.

- The VM generation type that you want to publish. This decision should be based on your customers' needs. You can publish a generation 1 VM, a generation 2 VM, or both. For help with understanding the difference between generation 1 and 2 VMs, reference our [documentation on support for generation 2 VMs on Azure](/azure/virtual-machines/generation-2).

- To wrap up the technical configuration, you'll provide the VM image that customers will use to deploy your offer. This step is where you'll select your VM image from the shared image gallery (SIG) that's associated with your Azure tenant. If you don't see your image, make sure that you have access to the SIG. For help with accessing your SIG, reference [this documentation](/azure/marketplace/azure-vm-create-using-approved-base#capture-image).

When creating your plans, you can reuse the technical configuration from another one of your offer's plans. If you choose to reuse a technical configuration from another plan, the technical configuration tab will not be shown for the plan you’re creating. The reused technical configuration, including any updates you make in the future, will be used for this plan. You won't be able to change this setting after you publish the offer.

>[!NOTE]
>You should reuse the technical configuration whenever two or more of your offer's plans use the same VM image. Doing so makes it easier to keep your images up to date; just update the image once and all plans based on that technical configuration will also get updated.
