The data communicated between a remote device and IoT Central is specified in a _device template_. The device template encapsulates all the details of the data so that both the device and IoT Central have all they need to make sense of the communication.

In this unit, you'll create a device template for a refrigerated truck.

## Create a device template

1. In the [Azure IoT Central](https://apps.azureiotcentral.com/?azure-portal=true) portal, in the menu on the left, select **Device templates**.

1. Select **New** to create a new template.

1. You'll next see a range of template options. Select **IoT device**. You're going to build the template from scratch.

    > [!TIP]
    > Review the other template options. You might want to use the prebuilt template options in a future project.

1. Select **Next: Customize**.

1. Name your device template *RefrigeratedTruck*. Don't select the **Gateway device** box.

1. Select **Next: Review**. Then select **Create**.

1. For **Create a capability model**, select **Custom**. Your view should now look similar to the following image.

    [![Screenshot showing the most important controls when creating a device template.](../media/refrigerated-trucks-new-template.png)](../media/refrigerated-trucks-new-template.png#lightbox)

    > [!TIP]
    > In the image, notice that the template is in **Draft** form. Also notice the locations of the **Add interface**, **Views**, and **Publish** controls.

1. You're now ready to add details for the device template. Select **Add interface**. Then select **Custom** to start building from a blank interface.

An interface defines a set of _capabilities_. You'll need to create several capabilities to define a refrigerated truck.

### Add sensor telemetry

Telemetry is made up of the data values that sensors transmit. The most important sensor in our refrigerated truck monitors the temperature of the contents.

To get started, select **Add capability**, and then enter the values in the following table.

| Entry summary | Value |
| --- | --- |
| Display name | Contents temperature |
| Name | ContentsTemperature |
| Capability type | Telemetry |
| Semantic type | Temperature |
| Schema | Double |
| Unit | <sup>o</sup>C |

Your screen should now look like the following image.

[![Screenshot showing how to create temperature telemetry for the simulated device.](../media/refrigerated-trucks-temperature.png)](../media/refrigerated-trucks-temperature.png#lightbox)

> [!NOTE]
> The names for the interface must be entered _exactly_ as shown in this unit. An exact match is needed between these names and entries in the code you'll add later in this module.

> [!IMPORTANT]
> In all locales, capability names can currently contain _only_ characters *A* through *Z*, uppercase or lowercase, digits 0 through 9, and the underscore character (`_`). No spaces, special characters, or localized characters are allowed.

Let's add the rest of the template.

### Add state telemetry

States are important. They let the operator know what's happening. A state in IoT Central is a name associated with a range of values. Later you'll choose a color to associate with each value.

1. Use the **Add capability** control to add a state for the truck's refrigerated contents: _empty_, _full_, or _melting_.

    | Entry summary | Value |
    | --- | --- |
    | Display name | Contents state |
    | Name | ContentsState |
    | Capability type | Telemetry |
    | Semantic type | State |
    | Value schema | String |

1. Now, select the plus sign (**+**). For **Display name** and **Value**, enter *empty*. The **Name** field should automatically be populated with **empty**. So all three fields are identical, containing **empty**.

1. Add two more state values: *full* and *melting*. Again, the same text should appear in the fields for **Display name**, **Name**, and **Value**.

    [![Screenshot showing how to create contents states for the simulated device.](../media/refrigerated-trucks-contents.png)](../media/refrigerated-trucks-contents.png#lightbox)

1. Carefully check each capability before you continue. 

1. To add some uncertainty to the simulation, add a failure state for the cooling system. If the cooling system fails, as you'll see in the following units, the chances of the contents melting increase considerably. To add _on_, _off_, and _failed_ entries for the cooling system. start by selecting **Add capability**. Then add another state.

    | Entry summary | Value |
    | --- | --- |
    | Display name | Cooling system state |
    | Name | CoolingSystemState |
    | Capability type | Telemetry |
    | Semantic type | State |
    | Value schema | String |

1. Now add three values: _on_, _off_, and _failed_. Make sure that each word appears in the **Display Name**, **Name**, and **Value** fields.

    [![Screenshot showing how to create cooling system state for the simulated device](../media/refrigerated-trucks-cooling.png)](../media/refrigerated-trucks-cooling.png#lightbox)

1. A more complex state is the state of the truck itself. If all goes well, a truck's normal routing might be: _ready_, _enroute_, _delivering_, _returning_, _loading_, and back to _ready_ again.  However, you should add the _dumping_ state to cater for when melted contents need to be disposed of! Using the same process as for the last two steps, create this new state.

    | Entry summary | Value |
    | --- | --- |
    | Display Name | Truck state |
    | Name | TruckState |
    | Capability Type | Telemetry |
    | Semantic type | State |
    | Value schema | String |

    [![Screenshot showing how to create truck state for the simulated device](../media/refrigerated-trucks-state.png)](../media/refrigerated-trucks-state.png#lightbox)

### Add event telemetry

Events are issues triggered by the device and communicated to the IoT Central app. Events can be one of three types: _Error_, _Warning_, or _Informational_.

One possible event a device might trigger is a conflicting command. An example might be a truck is returning empty from a customer but receives a command to deliver its contents to another customer. If a conflict occurs, it's a good idea for the device to trigger an event to warn the operator of the IoT Central app.

Another event might be just to acknowledge, and record, the customer ID that a truck is to deliver to.

1. Use **+ Add capability**, then create an event as follows.

    | Entry summary | Value |
    | --- | --- |
    | Display Name | Event |
    | Name | Event |
    | Capability Type | Telemetry |
    | Semantic type | Event |
    | Schema | String |

    [![Screenshot showing how to create an event for the simulated device](../media/refrigerated-trucks-conflict.png)](../media/refrigerated-trucks-conflict.png#lightbox)

### Add location telemetry

A location is probably the most important, and yet one of the easiest measurements to add to a device template. Under the hood, it consists of latitude, longitude, and an optional altitude, for the device.

1.  Use **+ Add capability** and add a location for our truck as follows.

    | Entry summary | Value |
    | --- | --- |
    | Display Name | Location |
    | Name | Location |
    | Capability Type | Telemetry |
    | Semantic type | Location |
    | Schema | Geopoint |

    [![Screenshot showing how to create a truck location for the simulated device](../media/refrigerated-trucks-location.png)](../media/refrigerated-trucks-location.png#lightbox)

### Add properties

A property of a device is typically a constant value, that is sent to the IoT Central app when communication is first initiated. In our refrigerated truck scenario, a good example of a property is the license plate of the truck or some similar unique truck ID.

Properties can also be device configuration data. We will define an _optimal temperature_ for the truck contents as a property. This optimal temperature might change with different types of content, different weather conditions, or whatever might be appropriate. This kind of property is called a _writable property_.

A property is a single value. If more complex sets of data need to be transmitted to a device, a **Command** (see below) is the more appropriate way of handling it.

1. Use **+ Add Capability**, and add the truck ID property.

    | Entry summary | Value |
    | --- | --- |
    | Display Name | Truck ID |
    | Name | TruckID |
    | Capability Type | Property |
    | Semantic type | None |
    | Schema | String |
    | Writable | Off |
    | Unit | None |

1. Add the optimal temperature property.

    | Entry summary | Value |
    | --- | --- |
    | Display Name | Optimal Temperature |
    | Name | OptimalTemperature |
    | Capability Type | Property |
    | Semantic type | Temperature |
    | Schema | Double |
    | Writable | On |
    | Unit |  <sup>o</sup>C  |

1. Confirm your properties have the following fields.

      [![Screenshot showing how to create a truck ID and optimal temperature properties for the simulated device](../media/refrigerated-trucks-properties.png)](../media/refrigerated-trucks-properties.png#lightbox)

### Add commands

Commands are sent by the operator of the IoT Central app, to the remote devices. Commands are similar to writable properties, but the command can contain any number of input fields, whereas a writable property is limited to a single value.

For refrigerated trucks, there are two commands you should add: a command to deliver the contents to a customer, and a command to recall the truck to base.

1. Use **Add Capability**, and add the first command.

    | Entry summary | Value |
    | --- | --- |
    | Display Name | Go to customer |
    | Name | GoToCustomer |
    | Capability Type | Command |

1. When you turn on the **Request** option, you'll be able to enter more details of the command.

    | Entry summary | Value |
    | --- | --- |
    | Request | On |
    | Display Name | Customer ID |
    | Name | CustomerID |
    | Schema | Integer |

1. Enter another new command, for recalling the truck.

    | Entry summary | Value |
    | --- | --- |
    | Display Name | Recall |
    | Name | Recall |
    | Capability Type | Command |

1. This time there are no additional parameters for the command, so leave **Request** off.

1. Validate that your two commands match the image below.

    [![Screenshot to help validate the two commands for the simulated device have been entered correctly](../media/refrigerated-trucks-commands.png)](../media/refrigerated-trucks-commands.png#lightbox)

1. Select **Save**. Before going any further carefully double-check your interface. After an interface has been published, there are limited editing options. It's important to get it right before publishing. If you select the name of the device template, in the menu that ends with the **Views** option, you'll get a summary of the capabilities.

    [![Screenshot to help validate the capabilities of the simulated device](../media/refrigerated-trucks-capabilities.png)](../media/refrigerated-trucks-capabilities.png#lightbox)

## Publish the template

1. Select **Save** again, if you've made any changes since the last time you saved.

1. Select **Publish** followed by **Publish** from the dialog that pops up. You should see that the annotation changes from **Draft** to **Published**.

Preparing a device template does take some care and some time.

In the next unit, you use the capabilities of the device template to prepare a controller's dashboard. Preparing views can be done before, or after, a device template is published.
