[!INCLUDE [Sandbox explanation](../../includes/azure-template-exercise-sandbox-subscription.md)]

You have been tasked with validating if Azure Cache for Redis can serve as your overall communication middleware for your solutions for your retail development team.

In this exercise, you create a new Azure Cache for Redis instance. You then use this instance in the remaining exercises throughout this module.

## Create an Azure Cache for Redis instance

Use the Azure portal to create a new Azure Cache for Redis instance.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. Within the **Azure services** category, select **Create a resource**, select the **Databases** category and then select **Azure Cache for Redis**.

    > [!TIP]
    > Alternatively; expand the **&#8801;** menu, select **All Services**, in the **Databases** category, select **Azure Cache for Redis**, and then select **Create**.

1. Within the **Basics** tab of the **New Redis Cache** pane, enter the following values for each setting:

    | **Setting** | **Value** |
    | -- | -- |
    | **Subscription** | *Concierge Subscription* |
    | **Resource group** | *<rgn>[sandbox resource group name]</rgn>* |
    | **DNS name** | *Enter any globally unique name. The portal checks the name in real time.* |
    | **Location** | *Select a region* |
    | **Cache type** | *Basic C0 (250 MB Cache, No SLA)*  |

1. Select the **Advanced** tab.

1. Within the **Advanced** tab of the **New Redis Cache** pane, enter the following values for each setting:

    | **Setting** | **Value** |
    | -- | -- |
    | **Redis version** | *Latest - 6* |

1. Select **Review + Create** to navigate to the **Review + Create** tab, and then select **Create**.

    > [!NOTE]
    > It can take upwards of fifteen minutes to create a new Azure Cache for Redis instance.

1. Observe the **Deployment** pane. When the deployment is complete, the pane updates with a **Deployment successful** message.

## View the Azure Cache for Redis instance

At this point, Azure Cache for Redis is running. Use the Azure portal to view details about the instance.

1. Within the **Deployment** pane, select **Go to resource** to view the Azure Cache for Redis instance.

1. Observe the **Host name** and **Status** properties. The host name should have a valid URI for your instance and the status should be *Running*.

    :::image type="content" source="../media/3-validate.png" lightbox="../media/3-validate-full.png" alt-text="Screenshot of the Essentials section within the Azure Cache for Redis instance Overview pane.":::

    > [!WARNING]
    > Do not delete the instance after you have created it. This Azure Cache for Redis instance will be used for the remaining exercises in this module.
