Azure IoT Hub integrates with [Azure Service Health](/azure/service-health/overview) to enable service-level health monitoring of the Azure IoT Hub service and individual IoT hubs. Azure Service Health helps you monitor service-level events like outages and upgrades that may affect the availability of the Azure IoT Hub service and your individual IoT hubs. You can also set up alerts to be notified when the status of the Azure IoT Hub service or an Azure IoT hub instance changes.

Azure Service Health is a combination of three smaller services:
* Resource health
* Service health
* Azure status

The sections in this unit describe each service and its relationship to Azure IoT Hub.

## Check Azure IoT hub health with Azure Resource Health

Azure Resource Health is part of Azure Service Health and tracks the health of individual resources. You can check the health status of your IoT hub directly from the portal.

To see status and status history of your IoT hub using the portal, follow these steps:

1. In the Azure portal, navigate to your IoT hub.

1. In the menu, under **Help**, select **Resource Health**.

To learn more about Azure Resource Health and how to interpret health data, see [Resource Health overview](/azure/service-health/resource-health-overview) in the Azure Service Health documentation.

You can also select **Add resource health alert** to configure alerts to trigger when the health status of your IoT hub changes. To learn more, see [Create activity log alerts on service notifications using the Azure portal](/azure/service-health/alerts-activity-log-service-notifications-portal) and related topics in the Azure Service Health documentation.

## Check all IoT hubs' health with Azure Service Health

With Azure Service Health, you can check the health status of all IoT hubs in your subscription.

1. In your Azure portal search bar, enter **Service health**.

1. Select **Service Health** from the results list.

1. From the **Subscription** drop-down menu, select your subscription.

1. From the **Service** drop-down menu, select **Azure IoT Hub**.

1. You see a list all IoT hubs in your subscription.

To learn more about Azure Service Health and how to interpret health data, see [Service Health overview](/azure/service-health/service-health-overview) in the Azure Service Health documentation.

To learn how to set up alerts with Azure Service Health, see [Create activity log alerts on service notifications using the Azure portal](/azure/service-health/alerts-activity-log-service-notifications-portal) and related topics in the Azure Service Health documentation.

## Check health of the IoT Hub service by region on Azure status page

To check the status of Azure IoT Hub and other services by region worldwide, view the [Azure status page](https://azure.status.microsoft/status). For more information about the Azure status page, see [Azure status overview](/azure/service-health/azure-status-overview) in the Azure Service Health documentation.
