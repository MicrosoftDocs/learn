Microsoft Azure IoT helps leverage the skills, technology, and resources you already have, to create an IoT solution.  Your solution can easily capture data from your connected devices, and then create valuable insights into your business.

With Azure IoT, you can build intelligence across your organization by bringing machine learning and artificial intelligence (AI) to the solution. These advanced technologies lead to faster predictions, smarter actions, and a secure and trusted platform.

### Business Challenges

For organizations across all industries, Azure IoT can help solve a common set of business challenges, to fuel innovation and digital transformation.

|Business Challenge |Business Challenge Description |Why Microsoft and Azure IoT?|
|----------|-----------|-----------|
|**Complexity** | IoT implementation and operations can be complex because of changing requirements, technology updates, business expansion, and security requirements. This complexity can impact business operations. | Azure IoT reduces complexity by providing services that can securely add, and connect devices, and ingest, store, and analyze your data. Azure IoT also offers _Build with Azure IoT Central_, a managed app platform, to rapidly build an IoT solution. |
|**Cost** | Implementing an IoT solution can be expensive. The biggest concern is understanding the TCO (Total Cost of Ownership), and the ROI (Return on Investment) of the implementation.  | With Azure IoT, customers can choose a fully managed or finished solution, from a partner. Another option is building with Azure IoT Central, a fully-managed SaaS offering, with per device pricing, that makes the cost to start and upgrade clear, and predictable, for your proposed solution. A third option is to build from an Azure IoT Hub. Azure IoT Hub has the same predictable pricing, with great flexibility, though might require greater technical expertise.|
|**Security** |  Without proper planning and oversight, IoT can be prone to security vulnerabilities in areas like device control and data privacy.   | Azure IoT is built for security, with an end-to-end approach to maintain control and trust, for data, devices, messaging, and cloud applications. The Microsoft Defender for Cloud provides automated support right to your Azure portal. |

-----------------------------

### What does an Azure IoT architecture look like?

The diagram illustrates a recommended IoT solution architecture that will work for many businesses.

[![Azure IoT reference architecture illustration](../media/ic-gm07-diagram.png)](../media/ic-gm07-diagram.png#lightbox)

An IoT application consists of the following subsystems:

1. **Devices** that can securely register with the cloud, and send telemetry data. These devices might have settings that can be specified from the cloud. Alternatively, multiple devices might communicate locally with an _Edge Gateway_ device. The edge device can perform some local optimization, and communicates with the cloud for the global picture.

1. A cloud gateway service, or **hub**, to securely read the incoming data, and provide some device management capabilities.

1. **Stream processors** that consume the telemetry data, integrate with **business processes**, and place the data into **storage**.

1. A **user interface** to visualize data, and enable easy device management.

>[!TIP]
>For details beyond those described above, see the Microsoft Azure IoT Reference Architecture in the "Summary and resources" unit at the end of the module.

Let's look at the capabilities that can help businesses meet their objectives, along with examples of innovation across different industries.
