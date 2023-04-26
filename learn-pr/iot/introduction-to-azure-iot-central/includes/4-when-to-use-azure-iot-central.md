Use Azure IoT Central to quickly evaluate your IoT scenario and assess the opportunities it can create for your business.

Recall that in the retail company scenario you'll want to first demonstrate the business impact you can create with the IoT data stream in one store, and then potentially expand the scenario across all stores. If the IoT data can help maintain pleasant temperature conditions, you'll help your company differentiate their stores from their competitors' stores.

Here, you'll learn about the criteria used when deciding if IoT Central is right for your IoT scenario. Then you'll create and deploy an end-to-end solution using IoT Central *In-store Analytics - Checkout* application template.

## Decision criteria

IoT Central is a ready-made environment and its primary interface is a web UI. You can use application templates for everything from getting a feel for what is possible, to fully customizing your application to fit your scenario. Some users may find that IoT Central doesn't provide all the functionality their solution needs to evaluate the scenario, though it's worth considering the options to export data to other services and applications or extend it with the REST api. 

If you want to demonstrate the business impact you can create with the IoT data stream, before investing time in developing a production-ready solution, using IoT Central is the fastest and easiest way to achieve it. If your team has plenty of skills and experience developing IoT solutions, then you should start with a fully customizable solution using the platform as a service (PaaS) IoT services such as: *Azure IoT Hub* and *IoT Hub Device Provisioning Service (DPS)*. When using PaaS, the same solution you create for demonstration purposes can be easily migrated to production. Because IoT Central uses IoT Hub and DPS services internally, there are ways to move from aPaaS and PaaS solutions.

Let's take a look at some of the criteria you should consider when determining if IoT Central is best for you:

| Criteria | Analysis |
| --- | --- |
| **Experience** | A common obstacle to producing successful IoT solutions is a lack of skills and experience. Therefore, it's crucial that you consider the skills and abilities of your IoT team. IoT Central is intended for users and teams that may not be experienced IoT professionals. |
| **Customization** | Like most aPaaS solutions, IoT Central provides a ready-to-use application and there are fewer customization options available when compared with PaaS solutions. Before selecting IoT Central to evaluate your IoT scenario, ensure that you can leverage the built-in analytics for your needs or alternatively, export data to other services and applications or use the REST api. |
| **Production-ready** | IoT Central isn't meant to be used on a production environment. If your IoT solution already has a solid evidence of the business impact that the IoT data stream can create, then use the PaaS services such as: *Azure IoT Hub* and *IoT Hub Device Provisioning Service (DPS)*. If you started with IoT Central and now need to move to a production environment, then you can use the *IoT Central migrator tool* to migrate devices seamlessly from IoT Central to a PaaS solution that uses IoT Hub and DPS. |

## Apply the criteria

Let's apply these criteria to the requirements of the IoT solution from the example scenario introduced in the first unit. The following flowchart illustrates the decision process you'll use to determine if IoT Central can meet the needs of the retail company scenario. The decision process is based on the criteria defined in this unit.

> [[IMAGE OF DECISION CRITERIA CHART]]

Now that you have the list of criteria and an illustration of the decision process, you can apply the criteria to the requirements of the retail company scenario. This comparison allows you to determine if IoT Central can help you quickly evaluate the IoT scenario, and assess the opportunities it can create for the business.

| Criteria | Requirement | Use Azure IoT Central? |
| --- | --- | --- |
| **Experience** | As stated in our scenario, your team don't have experience working on IoT projects. Therefore, the solution you design has to account for lack of skills and experience. | Yes |
| **Customization** | You and your team would like to design a custom notification system for the cloud application to notify store managers with critical alerts. It needs to integrate with the current messaging system. | Yes - use rules to trigger external actions |
| **Production-ready** | The scenario is on it's experimental stage and device environment telemetry data will be enabled in one store only. If there's enough business impact, a dedicated team will then be assigned to develop a production-ready solution using PaaS IoT services to deploy on all stores. | Yes |

## Create a retail application

Based on the analysis of the decision criteria, IoT Central is the ideal platform to evaluate the retail company scenario and assess the opportunities it can create for the business. You also found that there's an industry-focused application template ready to be used and possible to customize afterwards.

Run the following IoT Central application that uses the *In-store Analytics - Checkout* template to get a feel for what is possible:

> [[ARM TEMPLATE HERE THAT WILL CREATE AZURE IOT CENTRAL WITH IN-STORE ANALYTICS - Checkout APPLICATION TEMPLATE]]

:::image type="content" source="../media/4-store-analytics-architecture-frame.png" alt-text="Diagram of the in-store analytics application architecture." border="false":::

As shown in the preceding application architecture diagram, you can use the application template to:

* **1**. Connect various IoT sensors to an IoT Central application instance.
* **2**. Monitor and manage the health of the sensor network and any gateway devices in the environment.
* **3**. Create custom rules around the environmental conditions within a store to trigger alerts for store managers.
* **4**. Transform the environmental conditions within the stores into insights that the store team can use to improve the customer experience.
* **5**. Export the aggregated insights into existing or new business applications to provide useful and timely information to retail staff.

For more details, you can follow the complete [tutorial on how to use and customize the IoT Central *In-store Analytics - Checkout* application template](/azure/iot-central/retail/tutorial-in-store-analytics-create-app).
