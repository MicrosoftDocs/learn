When you started your cloud migration, your manager asked you to ensure costs remained within the company’s budget. Managing costs is challenging because your IT employees are spread across multiple lines of business, each of which needs autonomy to buy the solutions they need to get their part of the job done. You need a centralized and scalable way to manage spending for each group without having to micro-manage their budgets.

Azure and Azure Marketplace have several tools available to help you get a better understanding of cloud spend and how to effectively manage costs.

## Manage Azure Marketplace purchases

Microsoft gives you the ability to manage purchases by your users through your billing profile as the Azure subscription administrator. You can choose three options to manage software acquisitions by users from Azure Marketplace:

- **Free + Paid**: Lets users acquire all Azure Marketplace software applications

- **Free**: Users will only be able to deploy free software from Azure Marketplace

- **No**: Users won’t be able to deploy software from Azure Marketplace

:::image type="content" source="../media/15-on-off-big.png" alt-text="Screenshot of Azure Marketplace on/off/free toggle in the Azure portal.":::

These settings apply to all users with access to your Azure subscription, giving you the capability to control software procurement through the Azure portal.

## Manage procurement using Azure policy

Your organization might have policies that place guidelines on purchasing Azure services such as virtual machines. For example, you might need to ensure that virtual machines deployed in your subscription meet certain kinds of criteria, including:

- **Vendor specific**: Only letting virtual machines from certain software vendors be deployed on the subscription

- **Operating system**: Only letting either Windows or Linux resources be deployed on the subscription

- **Version**: Only allowing specific versions of resources be deployed on the subscription

- **Size**: Only letting users deploy virtual machines up to a certain size on the subscription

- **Location**: Only letting resources be deployed from specific global regions

You can use Azure policy to [manage virtual machine deployment](/azure/virtual-machines/windows/policy#images-for-virtual-machines) so only approved virtual machine images from the Azure Marketplace are deployed
into your Azure environment.

## Cost management

As you purchase products from Azure Marketplace, you want to get insights that will help you manage costs. Microsoft Cost Management is a free tool that you can use to view information on the products you've purchased. You can use Cost Management to see details of what services you're spending money on and how those costs track against the budgets that you’ve set. In addition to setting budgets on your subscription, you can schedule reports and analyze subscription costs. You can learn more about Microsoft Cost Management by completing the [Introduction to analyzing costs and creating budgets with Microsoft Cost Management](/training/modules/analyze-costs-create-budgets-azure-cost-management/) module.

You can view your Azure Marketplace charges and invoices on the cost analysis tool under Cost Management.

:::image type="content" source="../media/16-cost-management-big.png" alt-text="Screenshot of Cost Management with Azure Marketplace invoice from the Azure portal.":::

## Private Azure Marketplace

Managing procurement in any organization, regardless of size, can be complex. For example, your organization might have rules in place that restrict purchasing to only approved vendors. To adhere to these policies, you need a simple, scalable way to govern what your users can purchase and which vendors they can purchase from.

Private Azure Marketplace makes it easier for IT administrators to empower users while controlling costs and ensuring purchasing complies with your organizations’ governance and procurement policies.

### Create a Private Azure Marketplace

With Private Azure Marketplace, you can create a catalog of products from approved software vendors that users in your tenant can purchase. As a Marketplace Admin (assigned role), you can create a Private Azure Marketplace in the Azure portal.

Select the **Private Marketplace** link in Azure Marketplace inside the Azure portal to begin the configuration process. The Private Azure Marketplace admin must be assigned the Marketplace Admin role by the tenant global admin.

:::image type="content" source="../media/22-azure-private-marketplace-home.png" alt-text="Screenshot of the Private Azure Marketplace homepage in the Azure portal.":::

To add approved products to your Private Azure Marketplace, browse the product catalog by using the product filters at the top of the page. You can also use the Search field to find the product you want to add to your approved catalog. To add a product, check the box on the top-right corner of the product tile. When finished, select **Done**.

:::image type="content" source="../media/17-private-marketplace-build.png" alt-text="Screenshot of the Private Azure Marketplace product selection in the Azure portal.":::

### Managing purchases for specific product plans

Products in Azure Marketplace might contain multiple plans. Each plan can have specific technical and pricing characteristics to meet different customer requirements.

You can use Azure Private Marketplace to manage which plans under each product your users can purchase. This level of control might be useful to align purchases to your organization’s budget by restricting approved purchases to plans within a specific price range.

As you add products to your catalog, you can select the approved plans under each product:

- **Select all current and future plans**: Allow users to purchase existing plans and give them the option to purchase new plans if the software provider adds them to that product.

- **Select all current plans**: Restrict purchases to plans that the software vendor has currently made available for that product. If the software vendor makes new plans available, users won't be able to purchase them.

- **Select specific plans**: Choose the specific plan or subset of plans you want users to purchase.

:::image type="content" source="../media/18-private-marketplace-build-detail.png" alt-text="Screenshot of the Private Azure Marketplace selection process in the Azure portal.":::

### Purchasing approved products

When you access your Private Azure Marketplace, users are alerted that a Private Azure Marketplace has been enabled by their Marketplace Admin (assigned role). The action ensures purchases by users in your organization align to your company’s procurement and governance guidelines.

Once you've selected the set of products from your company’s approved software vendors, all users browsing in the Private Marketplace experience will see whether a product is approved for purchase. Approved products are marked with the "Approved" badge on the product tile card. Microsoft products will always be approved for purchase.

:::image type="content" source="../media/19-private-marketplace-approved-big.png" alt-text="Screenshot of approved products and services in the Azure portal.":::

Your Private Azure Marketplace administrator has the flexibility to select the products and associated plans that users can purchase. When a user tries to purchase an approved product, they'll see the plans the administrator has made available when viewing the plans and pricing for the product.

:::image type="content" source="../media/20-approved-plan-detail.png" alt-text="Screenshot of product plans on the plans and pricing page of a product in the Azure Marketplace experience in the Azure portal.":::

Users won't be able to purchase a plan that their Private Azure Marketplace administrator hasn't approved.

## Summary

With your newfound knowledge about the ways Azure Marketplace can help your organization manage software procurement, you're almost ready to finish your research and summarize what you learned for your manager. You're able to demonstrate how you can use Azure features like role-based access control (RBAC), Policy, and Private Azure Marketplace to control software purchasing for your organization. You've already started thinking about ways that you can use these features to adhere to company policies.

You're confident that Azure Marketplace is what you need to manage the complexities of finding, trying, and buying cloud software and services; you just need to convince your boss so you can move forward.
