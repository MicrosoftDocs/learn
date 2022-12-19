Azure Automanage can be enabled on existing or new virtual machines using the Azure portal, Azure Resource Manager (ARM), or Azure Policy.

## Enable Azure Automanage on a VM using the Azure portal

If you don't have an Azure subscription, [create an account](https://azure.microsoft.com/pricing/purchase-options/pay-as-you-go/) before you begin.

> [!NOTE]
> Free trial accounts do not have access to the virtual machines used in this tutorial. Please upgrade to a Pay-As-You-Go subscription.

> [!IMPORTANT]
> You need to have the **Contributor** role on the resource group containing your VMs to enable Automanage. If you are enabling Automanage for the first time on a subscription, you need the following permissions: **Owner** role or **Contributor** along with **User Access Administrator** roles on your subscription.

1. Sign in to the [Azure portal](https://portal.azure.com/).
1. In the search bar, search for an select **Automanage**.
1. In the menu, select **Automanage machines**.
1. Select **Enable on existing machine**.
    :::image type="content" source="../media/zero-vm-list-view.png" alt-text="machine":::
1. On the **Basics** tab, select your profile type: **Azure best practices: Production** or **Azure best practices: Dev/Test**:
    :::image type="content" source="../media/existing-vm-quick-create.png" alt-text="profiles":::
    The profile type you select will determine the services and settings applied to your machine(s). To view the details for the different profiles, select **View Azure best practices profiles**:
    :::image type="content" source="../media/browse-production-profile.png" alt-text="profile":::
1. Select the **Machines** tab, then check the box for the machine(s) you want to enable for Automanage:
    :::image type="content" source="../media/existing-vm-select-machine.png" alt-text="machines":::
1. Select the Review + Create tab to review the machine(s) you've chose, then select the **Create** button.
