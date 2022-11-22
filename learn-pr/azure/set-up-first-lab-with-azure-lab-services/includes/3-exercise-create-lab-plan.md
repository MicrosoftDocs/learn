A lab plan for Azure Lab Services can be created through the Azure portal.  In this unit you, as the admin, use the Azure portal to create a lab plan. Lab plans are used when creating labs for Azure Lab Services.

During the process, you'll:

- Create a resource group.
- Create a lab plan.
- Select virtual machine images that can be used for labs.

If you want to perform the steps in the Azure portal as you read along, you need an Azure subscription. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/) and add a subscription before you begin. If you are a student, you can take advantage of the [Azure for students](https://azure.microsoft.com/free/students/) offer.

When you complete the exercises, be sure to delete the resources you created.

## Create a lab plan

The following steps show how to use the Azure portal to create a lab plan.

1. Sign into the [Azure portal](https://portal.azure.com).
1. In the top left of the screen, select **Create a resource**.
1. Search for **Lab plans**.
1. Select **Lab plan**, and then select **Create**.

    :::image type="content" source="../media/select-lab-plans-service.png" alt-text="Screenshot that shows the Lab plan tile for Azure Marketplace.":::

1. On the **Basics** tab of the **Create a lab plan** page:

    |Setting  |Value |Description  |
    |---------|---------|---------|
    |Subscription     | *Your Azure subscription* | The lab plan must belong to a resource group. Here you select the Azure subscription to which the resource group belongs. |
    |Resource group     | Select *Your resource group* | The resource group to which the lab plan will belong. All Azure resources must belong to a resource group. |
    |Lab name     | *Enter a unique name*| Enter the name of your lab plan, such as *MyLabPlan*. The name must be unique within the subscription. |
    |Location     | Accept default value | The geographical region where the lab plan will be hosted. (Region for the lab plan is also the default region where your labs will be created.)|

    :::image type="content" source="../media/Create-lab-plan-basics-tab.png" alt-text="Screenshot that shows the Basics tab of the Create a new lab plan experience.":::

1. Review the summary and select **Create**.

    :::image type="content" source="../media/Create-lab-plan-review-create-tab.png" alt-text="Screenshot that shows the Review and Create tab of the Create a new lab plan experience.":::

## Verify your resource creation

1. When the deployment is complete, expand **Next steps**, and select **Go to resource**.

    :::image type="content" source="../media/Create-lab-plan-deployment-complete.png" alt-text="Screenshot that the deployment of the lab plan resource is complete.":::

1. Confirm that you see the **Overview** page for *MyLabPlan*.

## Configure automatic shutdown of VMs for a lab plan

1. In the [Azure portal](https://portal.azure.com/), navigate to the **Lab Plan** page.
1. Select **Labs settings** on the left menu.
1. Select the auto-shutdown setting(s) that is appropriate for your scenario.  

    :::image type="content" source="../media/automatic-shutdown-vm-disconnect.png" alt-text="Screenshot that shows automatic shutdown setting at lab plan.":::

    To disable the setting(s), uncheck the checkbox(s) on this page.

## Select Marketplace images available for labs

As an admin, you can specify the Marketplace images that educators can use when creating labs.

1. In the lab plan page, select **Marketplace images** on the menu to the left. By default, you can see the full list of images (both enabled and disabled). You can filter for **Status** to be equal to **Enabled** or **Disabled**.

   :::image type="content" source="../media/marketplace-images-page.png" alt-text="Screenshot that shows the Marketplace images page for a lab plan. The Marketplace images menu and status filter are highlighted.":::

1. Select the **Windows 11 Pro** image to enable the lab creation exercise in the following units.

## Designate the Lab Creator

Owners of a lab plan can automatically create labs and do not need to be assigned the Lab Creator role. In the example scenario we're using here, the lab plan owner also has the role of educator, so we don't need to add a Lab Creator role.
