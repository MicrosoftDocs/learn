Security Copilot is a generative AI security product that empowers security and IT professionals respond to cyber threats, process signals, and assess risk exposure at the speed and scale of AI.

Understand what you need to get started such as the minimum requirements, identifying your customer category, and setting up your environment.

Get recommendations on next steps to take to get you on your way to maximizing the capabilities in Security Copilot.

> [!NOTE]
> **Disclaimer:** This documentation is only intended for customers using commercial clouds. Currently, Security Copilot is not designed for use by customers using US government clouds, including but not limited to GCC, GCC High, DoD, and Microsoft Azure Government. For more information, consult with your Microsoft representative.

## Step 1: Identify your customer category

Before you begin onboarding to Microsoft Security Copilot, you must first determine what type of Security Copilot customer you are. Your onboarding experience depends on this license status:

- **Microsoft 365 E5 customers** might already have Security Copilot included and automatically provisioned.
- **Non–Microsoft 365 E5 customers** must provision Security Compute Units (SCUs) to enable Security Copilot.

> [!IMPORTANT]
> Don't begin onboarding until you've confirmed whether your organization has a Microsoft 365 E5 license. The steps you follow and whether you need to purchase capacity depend on this determination.

## Step 2: Follow the path for your organization

| Microsoft 365 E5 Security Copilot included customers | Non–Microsoft 365 E5 Security Copilot customers |
|------------------------------------------------------|--------------------------------------------------|
| Microsoft has auto provisioned Security Copilot. You can start using Security Copilot in your workflows. For more information, see [Understand how Security Copilot is auto provisioned for Microsoft 365 E5 customers](/copilot/security/auto-provisioning-security-copilot). | Follow the manual onboarding steps. For more information, see [Onboarding for non-Microsoft 365 E5 customers](/copilot/security/manual-onboarding). |

## Microsoft 365 E5 included customers

Microsoft Security Copilot is included with your Microsoft 365 E5 license. However, eligibility alone does not enable access—Security Copilot must be rolled out in your tenant. Microsoft sends a 30-day advance notification, and your tenant is auto provisioned after the notification period ends. Once provisioning is complete, Security Copilot is ready for use. No Azure setup or capacity provisioning is required.

## Onboarding for non-Microsoft 365 E5 customers

If you're not a Microsoft 365 E5 customer, you need to provision Security Compute Units (SCUs).

### Minimum requirements

#### Subscription

In order to purchase security compute units, you need to have an Azure subscription. For more information, see [Create your Azure free account](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).

#### Security compute units

Security compute units are the required units of resources that are needed for dependable and consistent performance of Microsoft Security Copilot.

Security Copilot is sold in a provisioned capacity model and is billed by the hour. You can provision Security Compute Units (SCUs) and increase or decrease them at any time. Billing is calculated on an hourly basis with a minimum of one hour. You can also specify overage units, which offer the flexibility to have additional security compute units available when the initially provisioned SCUs are depleted during usage spikes.

For more information, see [Microsoft Security Copilot pricing](https://aka.ms/CopilotforSecurity_Pricing).

#### Supported roles

The following Microsoft Entra roles automatically inherit **Copilot owner** access:

- Billing Administrator
- Entra Compliance Administrator
- Global Administrator
- Intune Administrator
- Security Administrator

For capacity provisioning, you need an Azure Contributor or Owner role on the subscription/resource group, and a Security Administrator or higher role in the tenant.

### Provisioning capacity

You can choose from the following options to provision capacity:

- [Option 1 (Recommended): Provision capacity within Security Copilot](#option-1-recommended-provision-capacity-through-security-copilot)
- [Option 2: Provision capacity through Azure](#option-2-provision-capacity-in-azure)

>[!NOTE]
>Regardless of the method you choose, you will need to purchase a minimum of 1 and a maximum of 100 provisioned SCUs. The recommended number of units to conduct an introductory exploration of Security Copilot is 3 units with overage set to unlimited overage. You can use the usage monitoring dashboard to keep track of usage and adjust capacity based on workload.

#### Option 1 (Recommended): Provision capacity through Security Copilot

When you first open Security Copilot (https://securitycopilot.microsoft.com), you're guided through the steps in setting up capacity for your organization.

**Required role**

You need to be an Azure subscription owner or contributor to create capacity.

> [!NOTE]
> A global administrator in Microsoft Entra ID doesn't necessarily have the Azure subscription owner or contributor role by default. Microsoft Entra role assignments don't grant access to Azure resources. As a global admin in Entra, you can enable access management for Azure resources through Azure portal.

1. Sign in to Security Copilot (https://securitycopilot.microsoft.com).

2. Select **Get started**.

     :::image type="content" source="../media/get-started.png" alt-text="Screenshot of get started." lightbox="../media/get-started.png":::

3. Set up a workspace. A workspace is a scoped, tenant-bound environment where users, automations, and agents operate. Enter a workspace name, then select **Continue**.

4. Set up your security capacity:
   Select the Azure subscription, associate capacity to a resource group, add a name to the capacity, select the prompt evaluation location, and specify the number of Security Compute Units (SCUs). You can also specify the number of overage units.

    :::image type="content" source="../media/set-up-capacity.png" alt-text="Screenshot of set up your security capacity." lightbox="../media/set-up-capacity.png":::

    > [!NOTE]
    > The number of SCUs is provisioned on an hourly basis, and the estimated monthly cost is displayed.
    >
    > If your selected geo location is too busy, you can also evaluate the prompts anywhere in the world. This can be done by selecting the appropriate option in the capacity creation screen.

5. Select among the data sharing options. Select **Continue**.

6. Confirm that you acknowledge and agree to the terms and conditions, then select **Continue**.

After you've created the capacity, it will take a few minutes to deploy the Azure resource on the backend.

   :::image type="content" source="../media/setting-up-capacity.png" alt-text="Screenshot of setting up your security capacity." lightbox="../media/setting-up-capacity.png":::

7. Review the roles that can access Security Copilot. You can choose to select other recommended owner roles or add contributors. Select **Continue**.

8. A confirmation page is displayed. Select **Finish**.

#### Option 2: Provision capacity in Azure

The initial setup in this method starts in the Azure portal. Then, you need to complete the setup in the Security Copilot portal.

**Required role**

You need to be an Azure subscription owner or contributor to create capacity.

1. Sign in to the [Azure portal](https://portal.azure.com).

2. Search for Security compute in the list of services, then select **Microsoft Security compute capacities**.

3. Select **Resource groups**.

4. Under **Plan**, select **Microsoft Security Copilot**. Then select **Create**.

   :::image type="content" source="../media/create-capacity-azure.png" alt-text="Screenshot showing creating capacity in the Azure portal." lightbox="../media/create-capacity-azure.png":::

5. Select a subscription and resource group, add a name to the capacity, select the prompt evaluation location, and select the number of Security Compute Units (SCUs). You can also specify the number of overage units. Data is always stored in your home tenant geo.

    :::image type="content" source="../media/set-up-copilot-for-security-azure.png" alt-text="Screenshot of setting up Security Copilot in Azure." lightbox="../media/set-up-copilot-for-security-azure.png":::

   > [!NOTE]
   > The number of SCUs is provisioned on an hourly basis, and the estimated monthly cost is displayed.
   > 
   > If your selected geo location is too busy, you can also evaluate the prompts anywhere in the world. This can be done by selecting the appropriate option in the capacity creation screen.

5. Confirm that you acknowledge and have read the terms and conditions, then select **Review + create**. 

6. Verify that all the information is correct, then select **Create**. A confirmation page is displayed.

7. Select **Finish setup in the Security Copilot portal**. 

### Recommended next steps

1. [Assign roles to users](/copilot/security/authentication#assign-roles)
2. [Try out standalone and embedded experiences](/copilot/security/experiences-security-copilot)
3. [Learn about integrations](/copilot/security/manage-plugins)
4. [Check out primary use cases](https://adoption.microsoft.com/en-us/security-copilot/)
5. [Discover agents](/copilot/security/discover-agents)
