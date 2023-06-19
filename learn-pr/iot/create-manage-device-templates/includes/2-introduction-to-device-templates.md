A device template in Azure IoT Central is a blueprint that defines the characteristics and behaviors of a type of device that connects to your application. For example, the device template defines the telemetry that a device sends so that IoT Central can create visualizations that use the correct units and data types.

A solution builder adds device templates to an IoT Central application. A device developer writes the device code that implements the behaviors defined in the device template.

A device template includes the following sections:

- A device model. This part of the device template defines how the device interacts with your application. A device developer implements the behaviors defined in the model.
  - Root component. Every device model has a root component. The root component's interface describes capabilities that are specific to the device model.
  - Components. A device model may include components in addition to the root component to describe device capabilities. Each component has an interface that describes the component's capabilities. Component interfaces may be reused in other device models. For example, several phone device models could use the same camera interface.
  - Inherited interfaces. A device model contains one or more interfaces that extend the capabilities of the root component.
- Views. This part of the device template lets the solution developer define visualizations to view data from the device, and forms to manage and control a device. The views use the device model, cloud properties, and customizations. Views don't affect the code that a device developer writes to implement the device model.

## Device template example

As an example, a builder could create a device template for a connected fan that has the following characteristics:

- Sends temperature telemetry.
- Sends location property.
- Sends fan motor error events.
- Sends fan operating state.
- Provides a writable fan speed property.
- Provides a command to restart the device.
- Gives you customized views of the device.
- Gives you customized views that let you manage the device.

From this device template, a developer can write the device code, and an operator can create and connect real fan devices. All these fans have telemetry, properties, and commands that operators use to monitor and manage them. Operators use the device views and forms to interact with the fan devices.

> [!NOTE]
> Only builders and administrators can create, edit, and delete device templates. Any user can create devices on the **Devices** page from existing device templates.

## Creating a device template

As a builder, you have several options for creating device templates:

- Design the device template in IoT Central, and then implement its device capability model in your device code.
- Import a device capability model from the Azure Certified for IoT device catalog. Then add any cloud properties, customizations, and views that your IoT Central application needs.
- Create a device capability model by using Visual Studio Code. Implement your device code from the model. Manually import the device capability model into your IoT Central application, and then add any cloud properties, customizations, and views that your IoT Central application needs.
- Create a device capability model by using Visual Studio Code and add it to the public repository. Implement your device code from the model, and connect your real device to your IoT Central application by using a device-first connection. IoT Central finds and imports the device capability model from the public repository for you. You can then add any cloud properties, customizations, and views that your IoT Central application needs to the device template.

### Create a device template from the device catalog

As a builder, you can quickly start building out your solution by using an IoT Plug and Play certified device. See the list in the Azure IoT Device Catalog. IoT Central integrates with the device catalog so you can import a device capability model from any of these IoT Plug and Play certified devices. To create a device template from one of these devices in IoT Central:

1. Go to the **Device templates** page in your IoT Central application.
1. Select **+ New**, and then select any of the IoT Plug and Play certified devices from the catalog. IoT Central creates a device template based on this device capability model.

  :::image type="content" source="../media/device-catalog.png" alt-text="Screenshot that shows the device catalog browser in IoT Central.":::

1. Add any cloud properties, customizations, or views to your device template.
1. Select **Publish** to make the template available for operators to view and connect devices.

### Create a device template from scratch

To create a device template in IoT Central:

1. Go to the **Device templates** page in your IoT Central application.
1. Select **+ New** &gt; **IoT device** &gt; **Next: Customize**.

  :::image type="content" source="../media/new-custom-device-template.png" alt-text="A screenshot that shows creating a new device template from scratch.":::

1. Enter a name for your template, such as *Environmental Sensor*.
1. Press **Enter**. IoT Central creates an empty device template.

## Publish and manage a device template

Before you can connect a device that implements your device model, you must publish your device template.

To publish a device template, go to you your device template, and select **Publish**.

After you publish a device template, an operator can go to the **Devices** page, and add either real or simulated devices that use your device template. You can continue to modify and save your device template as you're making changes. When you want to push these changes out to the operator to view under the **Devices** page, you must select **Publish** each time.

You can rename or delete a template from the template's editor page.
