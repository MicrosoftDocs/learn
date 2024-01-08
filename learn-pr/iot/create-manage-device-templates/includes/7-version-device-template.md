A device template includes a model that describes how a device interacts with IoT Central. This model defines the capabilities of the device and how to IoT Central interacts with them. Changes to the model in a device template can affect your entire application, including any connected devices. Changes to a capability that's used by rules, exports, device groups, or jobs may cause them to behave unexpectedly or not work at all. For example, if you remove a telemetry definition from a template:

- IoT Central is no longer able interpret that value. IoT Central shows device data that it can't interpret as **Unmodeled data** on the device's **Raw data** page.
- IoT Central no longer includes the value in any data exports.

## Modify a device template

Additive changes, such as adding a capability or interface to a model are non-breaking changes. You can make additive changes to a model at any stage of the development life cycle.

Breaking changes include removing parts of a model, or changing a capability name or schema type. These changes could cause application features such as rules, exports, or dashboards to display error messages and stop working.

In early device development phases, while you're still designing and testing the model, there's greater tolerance for making changes directly to your device model. Before you connect production devices to a device template, you can edit the device template directly. IoT Central applies those changes automatically to devices when you publish the device template.

After you attach production devices to a device template, evaluate the impact of any changes before you edit a device template. Don't make breaking changes to a device template in production. To make such changes, create a new version of the device template. Test the new device template and then migrate your production devices to the new template at a scheduled downtime.

## Edit and publish actions

The following actions are useful when you edit a device template:

- Save. When you change part of your device template, saving the changes creates a draft that you can return to. These changes don't yet affect connected devices. Any devices created from this template won't have the saved changes until you publish it.
- Publish. When you publish the device template, it applies any saved changes to existing device instances. Newly created device instances always use the latest published template.
- Version a template. When you version a device template, it creates a new template with all the latest saved changes. Existing device instances aren't impacted by changes made to a new version.
- Version an interface. When you version an interface, it creates a new interface with all the latest saved capabilities. You can reuse an interface in multiple locations within a template. That's why a change made to one reference to an interface changes all the places in the template that use the interface. When you version an interface, this behavior changes because the new version is now a separate interface.
- Migrate a device. When you migrate a device, the device instance swaps from one device template to another. Device migration can cause a short delay while IoT Central processes the changes.

## Version numbers

Both device models and interfaces have version numbers. Different version numbers let models or interfaces share an @id value, while providing a history of updates. Version numbers only increment if you choose to version the template or interface, or if you deliberately change the version number. You should change a version number when you make a major change to a template or interface.

## Version a device template

To version a device template:

1. Go to the **Device templates** page.
2. Select the device template you want to version.
3. Select *Version* at the top of the page and give the template a new name. IoT Central suggests a new name, which you can edit.
4. Select **Create**.

:::image type="content" source="../media/version-device-template.png" alt-text="Screenshot that shows device template versioning.":::

Now you've created a new template with a unique identity that isn't attached to any existing devices.

## Version an interface

To version an interface:

1. Go to the **Device templates** page.
2. Select the device template you have in a draft mode.
3. Select the published interface that you want to version and edit.
4. Select **Version** at the top of the interface page.
5. Select **Create**.

Now you've created a new interface with a unique identity.

## Migrate a device across versions

You can create multiple versions of the device template. Over time, you'll have multiple connected devices using these device templates. You can migrate devices from one version of your device template to another. The following steps describe how to migrate a device:

1. Go to the **Devices** page.
2. Select the device you need to migrate to another version.
3. Choose **Migrate**.
4. Select the device template with the version you want to migrate the device to and select **Migrate**.
