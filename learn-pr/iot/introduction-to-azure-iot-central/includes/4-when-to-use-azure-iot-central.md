Here, we'll help you decide if Azure IoT Central is right for your IoT needs. We'll help you make your decision by analyzing the following criteria:

- Experience
- Customization

## Decision criteria

Azure IoT Central lets users take advantage of a pre-built, production-ready IoT solution. Some users may find that Azure IoT Central doesn't provide all the functionality their solution needs. For custom-built IoT solutions, you should first consider using Azure IoT Central along with companion applications. If that solution doesn't fit your needs, consider making the switch to a fully customized solution using *Azure IoT Hub* and the *Azure IoT device SDKs*.

Let's take a look at some of the criteria you should consider when determining which of these options is best for you:

| Criteria | Analysis |
| --- | --- |
| **Experience** | A common obstacle to producing successful IoT solutions is a lack of skills and experience. Therefore, it's crucial that you consider the skills and abilities of your IoT team. Fortunately, the Azure IoT Central platform is intended for users and teams that may not be experienced IoT professionals. |
| **Customization** | Like most aPaaS solutions, the Azure IoT Central platform provides a ready-to-use application but there are a few customization options available as well. Before abandoning the Azure IoT Central platform for a custom-built solution from scratch, we'd recommend using companion applications with Azure IoT Central. Companion applications are often much easier to build than the alternative and can provide more functionality to your application. However, experienced professionals may find that they want or need full control over their IoT solution. In this case, Azure IoT Hub is the better option. |

## Apply the criteria

Azure IoT Central helps users scale their IoT solutions to hundreds of millions of devices, ensure high availability and estimate long-term costs. These capabilities are some of the benefits of having a pre-built solution. Pre-built solutions also come with limitations, so it's important for you to consider these criteria when deciding if Azure IoT Central is right for you. Let's apply these criteria to the requirements of our IoT solution from the example scenario introduced in the first unit.

The following flowchart illustrates the decision process we'll use to determine if Azure IoT Central can meet the needs of our fictional IoT solution. Our decision process is based on the criteria defined in this unit.

:::image type="complex" source="../media/4-decision-flow-chart.svg" alt-text="Diagram that summarizes the decision process for determining if Azure IoT Central is a good option for an IoT solution." border="false" lightbox="../media/4-decision-flow-chart-expanded.svg":::
    Diagram of a flowchart that shows the decision process for deciding to use Azure IoT Central. The first criterion is **Requires custom features?** If users decide that their IoT application requires custom features, then they should consider using companion apps with Azure IoT Central. If this option doesn't meet their needs, then other options should be investigated. If the IoT solution doesn't require any custom features or the option to use companion apps with Azure IoT Central will work, then the next criterion, **IoT skills and experience?**, should be considered. Users with experience must then ask themselves if they need full control of the application. If so, Azure IoT Hub is a better option for their IoT needs. If not, then Azure IoT Central is a good choice for both non-experienced users and experienced users who don't need full control.
:::image-end:::

Now that we have our list of criteria and an illustration of the decision process, we can apply the criteria to the requirements of the example scenario. This comparison will allow us to determine if Azure IoT Central can help us develop a solution to improve the overall customer experience.

| Criteria | Fictitious Requirement | Use Azure IoT Central? |
| --- | --- | --- |
| **Experience** | As stated in our scenario, you and your team don't have much experience working on an IoT project. Therefore, the solution you design has to account for your lack of skills and experience. | Yes |
| **Customization** | You and your team would like to design a custom notification system for the cloud application to notify store managers with critical alerts. | Maybe |

## Guidance summary

Based on our analysis of the decision criteria, it appears that Azure IoT Central is a promising solution for our fictional grocery store chain's IoT needs. Some of the top features of the platform are the ability to connect different types of devices and scale the solution to millions of devices. These features will allow you to do just that with the proximity, optical, and accelerometer sensors from our example and then scale the solution to each of the thousands of stores.

Likewise, Azure IoT Central is a great choice for development teams with little to no IoT experience. The aPaaS solution will save you time and money since most of the work is done for you. Using features like IoT Plug and Play and Device Connect, your team can start capturing IoT data from your devices with little to no code required.

The only requirement that Azure IoT Central can't satisfy is the custom notification system. APaaS solutions typically provide fewer opportunities for fully customized features because you usually don't have access to the underlying code. However, the custom notification system can be added to the solution using Azure IoT Central's built-in notification features or a companion application. So, it isn't a total deal breaker for our scenario. T We'd recommend reviewing these options with your team to reconsider the design of the custom notification system.
