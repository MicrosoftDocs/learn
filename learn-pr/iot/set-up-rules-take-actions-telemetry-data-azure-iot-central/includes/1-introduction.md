Azure IoT Central enables the easy monitoring and management of a fleet of remote devices.

This module builds on the app developed in the [Your first Azure IoT Central app](/learn/modules/create-your-first-iot-central-app/) module, by adding rules and actions. It's not a requirement that you have completed the earlier module, but it may help your understanding of IoT Central if you do complete it.

The earlier module explains how to monitor and command the movements of a refrigerated truck. This module adds _rules and actions_ to the IoT Central app. Rules enable greater automation. A rule is triggered when one or more conditions are met. One or more actions are the result. These actions include sending an email, and sending data to a website (a _webhook_ action). This website could be your own custom app, or a productivity tool such as Microsoft Flow.

In this module, we build the IoT Central app from a pre-prepared JSON file defining all the device capabilities. The device app code is loaded and run. A more detailed explanation of the sections of code is available in the earlier module. The focus here is on creating a range of rules, and testing the rules trigger the specified actions.

## Learning objectives

In this module you will:

- Create an Azure IoT Central custom app, using the IoT Central portal
- Import a capability model for a custom device, using the IoT Central portal
- Create a programming project to simulate a refrigerated truck, using Visual Studio Code, or Visual Studio
- Monitor and command the simulated truck, from an IoT Central dashboard
- Create a range of rules and actions, responding to truck telemetry, using the IoT Central portal

## Prerequisites

- An introductory knowledge of the purpose of Azure IoT
- Ability to navigate Azure IoT portal
- Ability to use Node.js, or C#, at the beginner level
- Experience using Visual Studio, or Visual Studio Code, at the beginner level
- Must have, or can open, an Azure Maps account

## The scenario

 You have already built an IoT Central app to monitor and control a simulated refrigerated truck. You now need to make the process more communicative, which you intend to do by adding IoT Central rules and actions.

[![Image of the finished app, showing a truck en route in the IoT Central dashboard.](../media/refrigerated-trucks-intro-map.png)](../media/refrigerated-trucks-intro-map.png#lightbox)

You'll construct the app displayed in the above image, from supplied components. Then, you'll add several rules and corresponding actions, and test that the rules trigger as expected.

## Create a custom IoT Central app

1. Navigate to [Azure IoT Central](https://apps.azureiotcentral.com/?azure-portal=true). It's a good idea to bookmark this URL, as it's the home for all your IoT Central apps.

1. Click on **Build** on the left-hand menu, then **Custom apps**.

1. Your **Application name** can be any friendly name, such as "Refrigerated Truck". However, the **URL** _must_ be unique, which is why you'll add a unique ID to the end of the URL for the app. For example, `refrigerated-trucks-<your id>`, replacing `<your id>` with some unique ID.

1. The **Application template** should be **Custom application**.

1. Select the free **7 day free trial** option.

    [![Screenshot showing how to create a new IoT Central app, using the IoT Central portal.](../media/refrigerated-trucks-new-app.png)](../media/refrigerated-trucks-new-app.png#lightbox)

    > [!NOTE]
    > Click on any image to display a full-sized image.

1. Fill out your contact info, and click **Create**. Wait a few seconds while the app resource is built.

1. You should now see a **Dashboard** with a few default links.

The next time you visit your Azure IoT Central home page, select **My apps** in the left-hand menu, and an icon for your  **Refrigerated Truck** app should appear.