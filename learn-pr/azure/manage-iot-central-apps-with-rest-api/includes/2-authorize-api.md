To protect your IoT Central application, all REST API calls must be authorized.

The current fleet management solution for a logistics company includes a fleet management application with dashboards for managing vehicles. You plan to add an IoT Central application to receive telemetry from monitoring devices in vehicles. The IoT Central application will also enable you to manage and control the devices remotely. The goal is to use the IoT Central REST API to integrate device management into your existing fleet management application. Your IoT Central application must verify that the user of the fleet management application is authorized to make those REST API calls.

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

In this module, you'll use the Azure CLI to create your application. In this module, this is the only control plane operation you'll perform. All the other operations are REST API data plane operations.

All three options require you to provide information such as the country or region for the deployment, an application name, a payment plan, and an application template.

## What is an application template?

Application templates are industry-focused sample IoT solutions that are pre-populated with dashboards, simulated devices, and device templates. You can choose from the retail, energy, government, healthcare, or custom application templates. In this module, you use the **Custom application** template to create an application and use the REST API.
## How IoT Central authorizes REST API calls

Every REST API call that's made against an IoT Central application must include an **Authorization** header. The **Authorization** header must contain either an _API token_ or a _bearer token_.

An API token is issued by your IoT Central application and isn't associated with a user account. This module uses an API token from IoT Central. The API token determines the level of access to be granted to the caller. The access levels map to the built-in and custom roles in an IoT Central application:

- **Application administrator** grants access to all API calls
- **Application builder** grants access to API calls that create, edit, and delete device templates and devices.
- **Application operator** grants access to API calls that create, edit, and delete devices.
- Administrators can create custom roles that grant access to a selected set of features in the application.

A bearer token is associated with an Azure Active Directory user account. You can generate a bearer token using the `az account get-access-token --resource https://apps.azureiotcentral.com` CLI command. The caller is granted the same level of access that the Azure Active Directory user has in the IoT Central application.

## IoT Central API token

You can generate an IoT Central API token in two ways:

- In the **Administration** section in your application's web UI on the IoT Central portal.
- Using the IoT Central REST API.

To generate an API token using the REST API, you must already have an **Application administrator** API token or a bearer token to authorize the call.

The [IoT Central REST API](/rest/api/iotcentral/1.0dataplane/api-tokens) lets you:

- Get the list of API tokens in an application.
- Create a new API token in the application.
- Get an API token by ID.
- Delete an API token.
