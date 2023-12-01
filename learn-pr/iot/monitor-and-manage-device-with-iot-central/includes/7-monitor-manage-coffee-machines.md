An Azure IoT Central application lets you monitor and manage your devices, letting you quickly evaluate your IoT scenario. IoT Central is an application platform that:

- Includes rich functionality such as device monitoring and management at scale.
- Provides many built-in features that help you to reduce the burden and cost of developing an IoT solution.
- Has extensibility and integration points that let you use its features and capabilities in your wider solution.

![Diagram that shows IoT Central solution architecture.](../media/7-architecture.png)

In the IoT enabled coffee machines example you'll need to monitor and manage issues remotely.

Here, you'll see how administrators who manage the Coffee Maker application can monitor application health, automate device management tasks and extract business value from the coffee machines data.

## Monitor application health

An administrator can use IoT Central metrics to assess the health of connected devices and the health of running data exports.

To view the metrics, an administrator can use charts in the Azure portal, a REST API, or PowerShell or Azure CLI queries.

To learn more, see [Monitor application health](/azure/iot-central/core/howto-manage-iot-central-from-portal).

## Automate

To automate device management tasks, you can use:

- Rules to trigger actions automatically when device data that you're monitoring reaches predefined thresholds. To learn more, see [Configure rules](/azure/iot-central/core/howto-configure-rules).
- [Job scheduling](/azure/iot-central/core/howto-manage-devices-in-bulk) for regular device management tasks.
- The Azure CLI to manage your devices from a scripting environment. To learn more, see [az iot central](/cli/azure/iot/central).
- The IoT Central REST API to manage your devices programmatically. To learn more, see [How to use the IoT Central REST API to manage devices](/azure/iot-central/core/howto-manage-devices-with-rest-api).
Rules, CLI, REST API, job schedule

## Extract business value

IoT Central provides a rich platform to help you extract business value from your IoT data. IoT Central has many built-in features that you can use to gain insights and take action on your IoT data. However, some IoT solution scenarios need more specialized business processes outside of IoT Central to extract value from your IoT data.

Built-in features of IoT Central you can use to extract business value include:

- Configure dashboards and views:

  An IoT Central application can have one or more dashboards that operators use to view and interact with the application. You can customize the default dashboard and create specialized dashboards:

  - To learn more about dashboards, see [Create and manage dashboards](/azure/iot-central/core/howto-manage-dashboards).

  - Like we saw on previous exercise, when the coffee machine connects to the IoT Central application it's assigned to a device template. You can create and customize the available views for each device type.

- Use built-in rules and analytics:

  You can add rules to an IoT Central application that run customizable actions. Rules evaluate conditions, based on data coming from a device, to determine when to run an action. In the next exercise, we'll create a rule to send an email when the coffee machine is outside the optimal temperature. To learn more about rules, see:
  
  - [Configure rules](/azure/iot-central/core/howto-configure-rules)
  
  IoT Central has built-in analytics capabilities that an operator can use to analyze the data flowing from the connected devices. To learn more, see [How to use data explorer to analyze device data](/azure/iot-central/core/howto-create-analytics).