In this module, we look at the ability of an IoT Central app to continuously export data.

The data in this case is telemetry data from one or more IoT devices. The continuous stream can be along a warm path for data analysis, or visualization, or along a cold path into storage. Or both.

This module builds on the app developed in the [Your first Azure IoT Central app](https://docs.microsoft.com/learn/modules/create-your-first-iot-central-app/) module, by adding data export, and a data viewing app. It's not a _requirement_ that you've completed the earlier module, but it may help your understanding of IoT Central if you do complete it.

The earlier module explains how to monitor and command the movements of a refrigerated truck. This module adds to the realism of the scenario, by archiving all the incoming data. Also, an external app is added to the mix. This app enables a remote viewer to easily check on the temperature of the contents of the refrigerated truck, on their mobile phone.

We build the IoT Central app from a pre-prepared JSON file defining all the device capabilities. The device app code is loaded and run. A more detailed explanation of the sections of code is available in the earlier module.

You may notice that the next two units are identical to those units in the [Set up rules and take action on telemetry data in Azure IoT Central](https://docs.microsoft.com/learn/modules/set-up-rules-take-actions-telemetry-data-azure-iot-central/) module, which also builds on the refrigerated trucks scenario, in this case to add rules and actions. If it has not been deleted, you can reuse the app you built for the rules and actions module, and go straight to Unit 4. Otherwise, start here!

## Learning objectives

In this module you will:

- Create an Azure IoT Central custom app, using the IoT Central portal
- Import a capability model for a custom device, using the IoT Central portal
- Create a programming project to simulate a refrigerated truck, using Visual Studio Code, or Visual Studio
- Create a storage account, and export all the incoming data into that account, using the IoT Central portal
- Create an Azure Event Hub, to route data through an Azure Stream Analytics job, using the IoT portal
- Create an external app to view the data, using Power BI

## Prerequisites

- An introductory knowledge of the purpose of Azure IoT
- Ability to navigate the Azure IoT portal
- Ability to use Node.js, or C#, at the beginner level
- Experience using Visual Studio, or Visual Studio Code, at the beginner level
- Must have, or can open, an Azure Maps account

## The scenario

 You've already built an IoT Central app to monitor and control a simulated refrigerated truck. You now need to make the process more realistic, archiving the telemetry data, and enabling remote viewing of the data.

[![Image of the finished app, showing a truck en route in the IoT Central dashboard](../media/refrigerated-trucks-intro-map.png)](../media/refrigerated-trucks-intro-map.png#lightbox)

You'll construct the app displayed in the above image, from supplied components. Then, you'll add data export, so that the truck contents temperature is archived, and viewable on your mobile:

[![Image of a Power BI dashboard on a mobile phone](../media/continuous-data-phone-view-1.png)](../media/continuous-data-phone-view-1.png#lightbox)

## Create a custom IoT Central app

1. Right-click on [Azure IoT Central](https://apps.azureiotcentral.com/?azure-portal=true), and select **Open link in new window**. It's a good idea to bookmark this URL, as it's the home for all your IoT Central apps.

1. Click on **My apps**, then **+ New application**. 
1. Click **Custom apps**. 

1. Select **Custom application**, and configure the app as shown in the following image:

    [![Screenshot showing how to configure the new IoT Central app](../media/refrigerated-trucks-new-app.png)](../media/refrigerated-trucks-new-app.png#lightbox)

    > [!IMPORTANT]
    > Your **Application Name** can be any friendly name, such as "Refrigerated Trucks". However, the **URL** _must_ be unique, which is why you'll add a unique ID to the end of the URL for the app. For example, `refrigerated-trucks-<your id>`, replacing `<your id>` with some unique ID.

1. Select the **Free** payment plan.
1. Enter the rest of the required fields (your contact information) appropriately.

1. Click **Create**, and wait a few seconds while the app resource is built.

1. You should now see a **Dashboard** with a few default links.

The next time you visit your Azure central home page, select **My apps** in the left-hand menu, and an icon for your  **Refrigerated Trucks** app should appear.
