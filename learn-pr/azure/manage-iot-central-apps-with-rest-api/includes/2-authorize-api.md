To protect your IoT Central application, all REST API calls must be authorized.

The current store management solution for a retail company includes a store management application that includes dashboards for analyzing stock levels and transactions. You plan to add an IoT Central application to receive telemetry from environmental monitoring  devices in stores. The IoT Central application will also enable you to manage and control the devices remotely. The goal is to use the IoT Central REST API to integrate device management and data export functionality into your existing store management application. Your IoT Central application must verify that the store management application is authorized to make those REST API calls.

Here, you'll review some core IoT Central concepts, learn how IoT Central authorizes REST API calls, and how to generate and use an API token.

## What is IoT Central?

IoT Central is a fully managed IoT software-as-a-service solution that makes it easy to create solutions that connect the physical and digital worlds. IoT Central enables you to:

- Connect to and control IoT devices.
- Collect and analyze telemetry from the connected devices.
- Send data from the connected devices to other applications or services for further processing or storage.

## How do you create an IoT Central application?

You have three options to create an IoT Central application:

- Visit the [My applications](https://apps.azureiotcentral.com/) IoT Central site.
- Use the [Azure portal](https://portal.azure.com/).
- Use Azure CLI.

In this module, you use the Azure CLI to create your application.

All three options require you to provide information such as the country or region for the deployment, an application name, a payment plan, and an application template.

## What is an application template?

You use an application template to pre-populate your application with dashboards and device templates. In this module you use the **Preview Application** template. This application template enables support for the IoT Central REST API.

## How IoT Central authorizes REST API calls

Every REST API call that's made against an IoT Central application must include an **Authorization** header. The **Authorization** header contains an API token, issued by IoT Central, that determines the level of access to be granted to the caller in the application. The access levels map to the standard roles in an IoT Central application:

- **Application administrator** grants access to all API calls
- **Application builder** grants access to API calls that create, edit, and delete device templates and devices.
- **Application operator** grants access to API calls that create, edit, and delete  devices.

## IoT Central API token

You can generate an IoT Central API token in two ways:

- In the **Administration** section in your application's web UI.
- Using the REST API.

In the second case, you must already have an **Application administrator** API token to authorize the call. In other words, you must sign in to IoT Central web UI to get the first **Application administrator** API token, you can then generate additional tokens using the REST API.

The IoT Central REST API lets you:

- Get the list of API tokens in an application.
- Create a new API token in the application.
- Get an API token by ID.
- Delete an API token.
