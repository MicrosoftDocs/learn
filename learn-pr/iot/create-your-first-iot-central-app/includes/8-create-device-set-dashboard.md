A Device Set in IoT Central is a group of devices that match one Device Template (including, different versions of that template). The simplest Device Set would be all devices created using the template. However, there can be exceptions, based on device properties, to limit the Device Set to a concise subset of all the created devices.

## Create a device set

1. In [Azure IoT Central](https://apps.azureiotcentral.com/?azure-portal=true), click the **Device sets** left-hand menu entry.

1. Select your device template, and there should be a default device set, ending in **All devices**. Click this device set.

1. Verify the template (**RefrigeratedTruck 1.0.0**):

1. Click  **Dashboard** on the bar (to the right of **Configuration**), click **Edit**, then click **Map** in the library of options. Give the map a title, such as "Delivery Map". The **Location** entry should just have the one option (**Location**). And select one of the three states to be displayed, say **Truck state**.

1. Click **Save**.

1. Click **Grid** in the library options, name it something like "Trucks", and add **Truck ID** and **Optimal temperature** to the columns to be displayed. Close the **Show Columns** dialog, and click **Save**.

1. Click **Done** to save your device set dashboard.

1. You may need to zoom and scroll a bit on your Delivery Map; you should get a map with five trucks at base.

    ![Screenshot showing the Device Set dashboard, with a map showing the initial location of the five trucks at the base, and a table of the truck IDs and optimal temperatures](../media/refrigerated-trucks-deviceset-base.png)

1. In order to make commanding the trucks easier, you should add links to the commands page for each truck. Navigate through the **Devices** menu to the **Commands** for **RefrigeratedTruck - 1**. Copy the URL, which will be something like `https://refrigerated-trucks.azureiotcentral.com/details/device/<your device>/commands`. Now, navigate back to the device set dashboard, click **Edit**, and add a **Link** from the library. Call the link something like "Truck 1 commands", and paste in the URL.

1. Click **Done**.

1. Test out your link by ordering the truck to a customer.

## Completing the dashboard

You have almost completed this module, great job. This section provides a few optional ideas to develop your dashboard further.

1. Rather than have link text, if you enter the library **Image** option, you can attach a link to an image on the dashboard. Consider adding five images to your dashboard, each linking to the Commands page for one of the five trucks. In the following image, Truck number 4 has been directed to a customer, the others remain at base:

    ![Screenshot showing the complete Device Set dashboard, now with five truck icons that can be clicked to jump to the command screen for each truck](../media/refrigerated-trucks-deviceset-images.png)

1. Consider creating a _Job_, a command that applies to all devices (or, all devices with exceptions). Such a job could change the optimal temperature for all trucks, or perhaps recall all trucks. Consider adding a link to the job from the dashboard.

By building up the device set dashboard in this way, you can make controlling multiple devices a matter of a few clicks. You could add links, or images with links, to other device pages (the chart view, or table view, for example).

When you have completed your dashboard, order trucks to different customer IDs, and give any other commands or jobs you have created, and get a feel for IoT Central control of remote devices.

## Next steps

To finish the module, pass the following knowledge check!
