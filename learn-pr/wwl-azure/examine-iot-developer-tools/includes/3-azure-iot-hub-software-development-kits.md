Azure IoT provides a set of open-source Software Development Kits (SDKs) to simplify and accelerate the development of IoT solutions built with Azure IoT Hub. Using the SDKs in prototyping and production enables you to:

 -  Develop a “future-proof” solution with minimal code: While you can use protocol libraries to communicate with Azure IoT Hub, you may regret this decision later. You may not have a chance to implement new features of IoT Hub, or you may spend time redeveloping code and functionality that you could get for free when using the SDKs. The SDKs support new features from IoT Hub, so you can incorporate them with minimal code and ensure your solution is up to date.
 -  Apply features designed for a complete software solution and focus on your specific need: The SDKs contain many libraries that address key problems and needs of IoT solutions such as security, device management, reliability, etc. You can speed up time to market by using these libraries directly so that you can focus on developing for your specific IoT scenario.
 -  Develop with your preferred language for different platform: You can develop with .NET, Java, Node, Python, or Node.js without worrying about protocol-specific intricacy. The SDKs provide out-of-box support for a range of platforms and the C SDK can be ported to new platforms.
 -  Benefit from the flexibility of open source with support from Microsoft and community: The SDKs are available open source on GitHub and Microsoft works in the open. You can modify, adapt, and contribute to the code that will run your devices and your applications.

There are two categories of software development kits (SDKs) for working with IoT Hub:

 -  IoT Hub Device SDKs enable you to build apps that run on your IoT devices using device client or module client. These apps send telemetry to your IoT hub, and optionally receive messages, job, method, or twin updates from your IoT hub. You can also use module client to author modules for Azure IoT Edge runtime.
 -  IoT Hub Service SDKs enable you to build backend applications to manage your IoT hub, and optionally send messages, schedule jobs, invoke direct methods, or send desired property updates to your IoT devices or modules.

## Azure IoT device SDKs platform support

Microsoft publishes open-source SDKs on GitHub for the following languages: .NET, Java, Node, Python, or Node.js.

Microsoft provides SDK support in the following ways:

 -  Continuously builds and runs end-to-end tests against the master branch of the relevant SDK in GitHub on several popular platforms. To provide test coverage across different compiler versions, Microsoft generally tests against the latest LTS (Long Term Support) version and the most popular version.
 -  Provides installation guidance or installation packages if applicable.
 -  Fully supports the SDKs on GitHub with open-source code, a path for customer contributions, and product team engagement with GitHub issues.

> [!NOTE]
> Microsoft also provides guidance on how to develop for mobile platforms such as iOS and Android.
