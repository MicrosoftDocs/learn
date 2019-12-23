Azure IoT Central enables the easy monitoring and management of a fleet of remote devices.

Azure IoT Central encompasses a range of underlying technologies that work great, but can be complicated to implement when many technologies are needed. These technologies include Azure IoT Hub, the Azure Device Provisioning System (DPS), Azure Maps, Azure Time Series Insights, Azure IoT Edge, and others. It's only necessary to use these technologies directly, if more granularity is needed than available through IoT Central.

One of the purposes of this module is to help you decide if there's enough features in IoT Central to support the scenarios you are likely to need. So, let's investigate what IoT Central can do with a fun and involved scenario.

## Learning objectives

In this module you will:

- Create an Azure IoT Central custom app, using the IoT Central portal
- Create a device template for a custom device, using the IoT Central portal
- Create a programming project to simulate a refrigerated truck, with routes selected by Azure Maps, using Visual Studio Code, or Visual Studio
- Monitor and command the simulated device, from an IoT Central dashboard

## Prerequisites

- An introductory knowledge of the purpose of Azure IoT
- Ability to navigate Azure IoT portal
- Ability to use Node.js, or C#, at the beginner level
- Experience using Visual Studio, or Visual Studio Code, at the beginner level
- Must have, or can open, an Azure Maps account

## The scenario

Suppose you run a company that operates a fleet of refrigerated trucks.

You've a number of customers within a city, and a base that you operate from. You command each truck to take its contents and deliver it to any one customer. However, the cooling system may fail on any one of your trucks, and if the contents does start to melt, you'll need the option of instructing the truck to return to base, and then dump the contents. Alternatively, you can deliver the contents to another customer who might be nearer to the truck when you become aware the contents are melting.

In order to make these decisions, you'll need an up-to-date picture of all that is going on with your trucks. You'll need to know the location of each truck on a map, the state of the cooling system, and the state of the contents.

IoT Central provides all you need to handle this scenario. In the following image, the colored circles show the location of the truck, on its way to a customer.

![Image of the finished app, showing Trucks on routes in an IoT Central dashboard](../media/refrigerated-trucks-intro-map.png)

In this module, you'll build the app displayed in the above image.

## Create a custom IoT Central app

1. Navigate to [Azure IoT Central](https://apps.azureiotcentral.com/?azure-portal=true). It's a good idea to bookmark this URL, as it's the home for all your IoT Central apps.

1. Click on **Build**, then **Custom apps**.

1. Your **Application name** can be any friendly name, such as "Refrigerated Trucks". However, the **URL** _must_ be unique, which is why you'll add a unique ID to the end of the URL for the app. For example, `refrigerated-trucks-<your id>`, replacing `<your id>` with some unique ID.

1. Leave the **Application template** as **Preview application**.

1. Select the free **7 day free trial** option. Seven days is plenty of time to complete the scenario.

    ![Screenshot showing how to create a new IoT Central app, using the IoT Central portal](../media/refrigerated-trucks-my-apps.png)

1. Fill out your contact info, and click **Create**. Wait a few seconds whilst the app resource is built.

1. You should now see a **Dashboard** with a few default links.

The next time you visit your Azure central home page, select **My apps** in the left-hand menu, and an icon for your  **Refrigerated Trucks** app should appear.

You've now created the app. The next step is to specify a _device template_.
