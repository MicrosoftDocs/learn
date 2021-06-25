In this section, we discuss which connectivity option for Azure Sphere is the right solution for your choice for your scenario. Then, we'll list some criteria that indicate whether Azure Sphere will meet your performance and functional goals.

## Decision criteria

**Secure communication**

Do your devices need to connect to the network in a secure manner? Azure Sphere platform takes care of the security challenges for your internet devices. It provides security solutions for internet-connected devices with built-in communication and security features. In addition, when you configure Azure Sphere for networking, it starts to receive over-the-air OS and cloud updates from Azure Sphere Security Service, providing updated security.

**Connectivity support**

Do you have a variety of devices that have different connectivity mechanisms? Azure Sphere supports devices using different connectivity mechanisms such as Ethernet or Wi-Fi. In addition, Azure Sphere supports both LAN network connectivity and also allows customers to use cellular connectivity. 

**Deployment flexibility**

Do you need to bring benefits of connectivity to the legacy equipment? Azure Sphere helps you connect existing legacy equipment to the network and connect them (brownfield devices).

**Cellular connectivity**

Do you want to connect your devices to a cellular network? The first decision you should make is whether to use the MT3620 on-chip Wi-Fi or external Ethernet connectivity. The key advantages of each choice are presented below:

- **Wi-Fi** doesn't require additional chips on the Azure Sphere device side. Many components are off-the-shelf. This option does not need cables, and installation is simplified. You can share a single access point across multiple devices. This option preserves the wired Ethernet link for private connection scenarios.

- **Ethernet** is less susceptible to interference, and less configuration is required (on both router end and Azure Sphere device end). There are possibly fewer certification requirements (if building custom hardware) since radio is not used. Wired connection between Azure Sphere device and router removes wireless attack vector.