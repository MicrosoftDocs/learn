
The data communicated between a remote device, and IoT Central, is specified in a _device template_. The device template encapsulates all the details of the data, so that both the device and IoT Central have all they need to make sense of the communication.

In this unit, you'll create a device template for a refrigerated truck. 

## Create a device template

1. Within the [Azure IoT Central](https://apps.azureiotcentral.com/?azure-portal=true) portal (which you may still have open), select **Device Templates** from the menu on the left-hand side.

1. Click **+ New** to create a new template.

1. You'll next see a range  of template options, select **IoT device**. We are going to build the template from scratch.

    > [!TIP]
    > Take note of the other options. You may want to use those prebuilt template options in a future project!

1. Click **Next: Customize**, then **Next: Review**. Do not select the **Gateway device** box. Then click **Create**.

1. Enter the name for your device template: "RefrigeratedTruck", and click Enter.

1. For **Create a capability model**, click **Custom**. You should now see a screen similar to the following image.

    [![Screenshot showing the most important controls when creating a device template](../media/refrigerated-trucks-new-template.png)](../media/refrigerated-trucks-new-template.png#lightbox)

    > [!NOTE]
    > Take note of a few important elements of the above image. Including that the template is in Draft form, and the locations of the **+ Add interface**, **Views**, and **Publish** controls.

1. You are now ready to add the specifics of the device template. Click **Add interface**, then **Custom**, to start building from a blank interface.

An interface defines a set of _capabilities_. We have quite a few to create, to define a refrigerated truck.

### Add sensor telemetry

Telemetry is the data values transmitted by sensors. The most important sensor in our refrigerated truck, monitors the temperature of the contents.

1. Click **+ Add capability**, and enter the following values:

    | Entry summary | Value |
    | --- | --- |
    | Display Name | Contents temperature |
    | Name | ContentsTemperature |
    | Capability Type | Telemetry |
    | Semantic type | Temperature |
    | Schema | Double |
    | Unit | <sup>o</sup>C |

1. Your screen should now look like the following image.

    [![Screenshot showing how to create temperature telemetry for the simulated device](../media/refrigerated-trucks-temperature.png)](../media/refrigerated-trucks-temperature.png#lightbox)

    > [!IMPORTANT]
    > The names entered for the interface must be entered _exactly_ as shown in this unit. This is because an exact match is needed between these names, and entries in the code you'll be adding later in this module.

Let's add the rest of the template.

### Add state telemetry

States are important, they let the operator know what is going on. A state in IoT Central is a name associated with a range of values. In addition, you later get to choose a color to associate with each value.

1. Use the **+ Add capability** control to add a state for the truck's refrigerated contents: one of _empty_, _full_, or _melting_.

    | Entry summary | Value |
    | --- | --- |
    | Display Name | Contents state |
    | Name | ContentsState |
    | Capability Type | Telemetry |
    | Semantic type | State |
    | Value schema | String |

1. Now, click **+**, and enter "empty" for the **Display name**, and **Value**. The **Name** field should automatically be populated with "empty". So, all three fields are identical, containing "empty".

1. Add two more state values: "full" and "melting". Again, the same text should appear in the **Display name**, **Name**, and **Value**.

    [![Screenshot showing how to create contents state for the simulated device](../media/refrigerated-trucks-contents.png)](../media/refrigerated-trucks-contents.png#lightbox)

1. Carefully check each capability before moving on. 

1. Now, to add some uncertainty to our simulation, let's add a failure state for the cooling system. If the cooling system fails, as you'll see in the following units, the chances of the contents melting increase considerably! Add _on_, _off_ and _failed_ entries for a cooling system. Start by clicking **+ Add capability**, and add another state.

    | Entry summary | Value |
    | --- | --- |
    | Display Name | Cooling system state |
    | Name | CoolingSystemState |
    | Capability Type | Telemetry |
    | Semantic type | State |
    | Value schema | String |

1. Now add three values: on, off, and failed. Make sure that each word appears in the **Display name**, **Name**, and **Value** fields.

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

Events are issues triggered by the device, and communicated to the IoT Central app. Events can be one of three types: _Error_, _Warning_, or _Informational_.

One possible event a device might trigger is a conflicting command. An example might be a truck is returning empty from a customer, but receives a command to deliver its contents to another customer. If a conflict occurs, it's a good idea for the device to trigger an event to warn the operator of the IoT Central app.

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

A location is probably the most important, and yet one of the easiest measurements to add to a device template. Under the hood, it consists of a latitude, longitude, and an optional altitude, for the device.

1.  Use **+ Add capability**, and add a location for our truck as follows.

    | Entry summary | Value |
    | --- | --- |
    | Display Name | Location |
    | Name | Location |
    | Capability Type | Telemetry |
    | Semantic type | Location |
    | Schema | Geopoint |

    [![Screenshot showing how to create a truck location for the simulated device](../media/refrigerated-trucks-location.png)](../media/refrigerated-trucks-location.png#lightbox)

### Add properties

A property of a device is typically a constant value, that is communicated to the IoT Central app when communication is first initiated. In our refrigerated truck scenario, a good example of a property is the license plate of the truck, or some similar unique truck ID.

Properties can also be device configuration data. We will define an _optimal temperature_ for the truck contents as a property. This optimal temperature might change with different types of content, different weather conditions, or whatever might be appropriate. A setting has an initial default value, which may not need to be changed, but the ability to change it easily and quickly is there, if needed. This kind of property is called a _writable property_.

A property is a single value. If more complex sets of data need to be transmitted to a device, a Command (see below) is the more appropriate way of handling it.

1. Use **+ Add capability**, and add the truck ID property.

    | Entry summary | Value |
    | --- | --- |
    | Display Name | Truck ID |
    | Name | TruckID |
    | Capability Type | Property |
    | Semantic type | None |
    | Schema | String |
    | Writable | Off |
    | Unit | None |

1. Next, add the optimal temperature property.

    | Entry summary | Value |
    | --- | --- |
    | Display Name | Optimal Temperature |
    | Name | OptimalTemperature |
    | Capability Type | Property |
    | Semantic type | None |
    | Schema | Double |
    | Writable | On |
    | Unit |  <sup>o</sup>C  |

1. Confirm your properties have the following fields.

      [![Screenshot showing how to create a truck ID and optimal temperature properties for the simulated device](../media/refrigerated-trucks-properties.png)](../media/refrigerated-trucks-properties.png#lightbox)

### Add commands

Commands are sent by the operator of the IoT Central app to the remote devices. Commands are similar to writable properties, but a command can contain any number of input fields, whereas a writable property is limited to a single value.

For refrigerated trucks, there are two commands you should add: a command to deliver the contents to a customer, and a command to recall the truck to base.

1. Use **+ Add capability**, and add the first command.

    | Entry summary | Value |
    | --- | --- |
    | Display Name | Go to customer |
    | Name | GoToCustomer |
    | Capability Type | Command |
    | Command | Synchronous |

1. When you turn on the **Request** option, you'll be able to enter more details of the command.

    | Entry summary | Value |
    | --- | --- |
    | Request | On |
    | Display name | Customer ID |
    | Name | CustomerID |
    | Schema | Integer |
    | Unit | None |

1. Enter another new command, for recalling the truck.

    | Entry summary | Value |
    | --- | --- |
    | Display Name | Recall |
    | Name | Recall |
    | Capability Type | Command |
    | Command | Synchronous |

1. This time there are no additional parameters for the command, so leave **Request** off.

1. Validate that your two commands match the image below.

    [![Screenshot to help validate the two commands for the simulated device have been entered correctly](../media/refrigerated-trucks-commands.png)](../media/refrigerated-trucks-commands.png#lightbox)

1. Click **Save**. Before going any further carefully double check your interface. After an interface has been published, there are very limited editing options. It's important to get it right before publishing. If you click on the name of the device template, in the menu that ends with the **Views** option, you'll get a summary of the capabilities.

    [![Screenshot to help validate the capabilities of the simulated device](../media/refrigerated-trucks-capabilities.png)](../media/refrigerated-trucks-capabilities.png#lightbox)

## Publish the template

1. Click **Save** again, if you've made any changes since the last time you saved.

1. Click **Publish**. You should see that the annotation changes from **Draft** to **Published**.

Preparing a device template does take some care and some time.

In the next unit, you use the capabilities of the device template to prepare a controllers dashboard. Preparing views can be done before, or after, a device template is published.
