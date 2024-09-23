Azure Automanage best practices includes default configuration profiles that can be applied to most of your virtual machines. You can select from the set of services and settings by creating a custom configuration profile. For example, you can create a configuration that excludes Microsoft Defender for Cloud from your Automanage machines.

Custom profiles can be created using the Azure portal or an Azure Resource Manager (ARM) template. In this module, you learn how to use the Azure portal to create a custom profile.

## Create a custom configuration profile in the Azure portal

1. Sign in to the [Azure portal](https://portal.azure.com/).
1. In the search bar, search for and select **Automanage**.
1. In the menu, select **Configuration profiles**.
1. The existing default configuration profiles appear on the page:
:::image type="content" source="../media/default-configuration-profiles.png" alt-text="Screenshot of default configuration profiles.":::
1. Select the **+ Create** button.
1. In the **Create a custom profile** window, fill out the following fields:
    1. *Name*
    1. *Subscription*
    1. *Resource group*
    1. *Region*
:::image type="content" source="../media/custom-profile.png" alt-text="Screenshot of window for creating custom profile.":::
1. Adjust the profile by selecting the desired services and settings and then select the **Create** button.
