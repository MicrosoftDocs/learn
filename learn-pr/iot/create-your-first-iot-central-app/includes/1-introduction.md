Azure IoT Central enables the easy monitoring and management of a fleet of remote devices.

Azure IoT Central encompasses a range of underlying technologies that work great, but can be complicated to implement when many technologies are needed. These technologies include Azure IoT Hub, the Azure Device Provisioning System (DPS), Azure Maps, Azure Time Series Insights, Azure IoT Edge, and others. It's only necessary to use these technologies directly, if more granularity is needed than available through IoT Central.

One of the purposes of this module is to help you decide if there is enough features in IoT Central to support the scenarios you are likely to need. So, let's investigate what IoT Central can do with a fun and involved scenario.

## Learning objectives

In this module you will:

- Create an Azure IoT Central custom app, using the IoT Central portal
- Create a device template for a custom device, using the IoT Central portal
- Create a programming project to simulate refrigerated trucks, with routes selected by Azure Maps, using Visual Studio Code, or Visual Studio
- Monitor and command the simulated devices, from an IoT Central dashboard

## Prerequisites

- An introductory knowledge of the purpose of Azure IoT
- Ability to navigate Azure IoT portal
- Ability to use Node.js, or C#, at the beginner level
- Experience using Visual Studio, or Visual Studio Code, at the beginner level
- Must have, or can open, an Azure Maps account

## The scenario

Suppose you run a company that operates a fleet of refrigerated trucks.

You have a number of customers within a city, and a base that you operate from. You command each truck to take its contents and deliver it to any one customer. However, the cooling system may fail on any one of your trucks, and if the contents does start to melt, you will need the option of instructing the truck to return to base, and then dump the contents. Alternatively, you can deliver the contents to another customer who might be nearer to the truck when you become aware the contents are melting.

In order to make these decisions, you will need an up-to-date picture of all that is going on with your trucks. You will need to know the location of each truck on a map, the state of the cooling system, and the state of the contents.

IoT Central provides all you need to handle this scenario. In the following image, the colored circles show the locations of the trucks; truck 4 has been selected to receive a new command, and the exact location of truck 3 is being highlighted.

![Image of the finished app, showing Trucks on routes in an IoT Central dashboard](../media/refrigerated-trucks-intro-map.png)

In this module, you will build the app displayed in the above image.

## Create a custom IoT Central app

1. Navigate to [Azure IoT Central](https://apps.azureiotcentral.com/?azure-portal=true). It is a good idea to bookmark this URL, as it is the home for all your IoT Central apps.

1. In the left-hand menu, click on **Build**, then select **Custom app**.

1. Enter "Refrigerated Trucks" for the **Application name**.

1. Add your own unique ID to the end of the **URL** entry.

    > [!IMPORTANT]
    > Your **Application name** can be any friendly name. However, the **URL** _must_ be unique. For example, `refrigerated-trucks-<your id>`, replacing `<your id>` with appropriate text.

1. Change the **Application template** to **Custom application**. Setting the **Application template** is an important step. The default **Preview application** will enable preview features that are not used in this module.

1. Click the **7 day free trial** switch, so that the **Billing info** goes away, and is replaced by **Contact info**. Seven days gives you plenty of time to complete, and evaluate, the scenario.

    ![Screenshot showing how to configure the new IoT Central app](../media/refrigerated-trucks-new-app.png)

1. Fill in your contact information.

1. Click **Create**, and wait a few seconds whilst the app resource is built.

1. You should now see a **Dashboard** with a few default links. 

The next time you visit your Azure central home page, select **My apps** in the left-hand menu, and an icon for your  **Refrigerated Trucks** app should appear.

You've now created the app. The next step is to specify a _device template_.
