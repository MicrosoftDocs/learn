Azure Sphere devices receive over-the-air OS and application updates via network connectivity. Applications can't program the connectivity mechanisms directly but can configure, use, and query the wireless communications subsystem.

There are two primary forms of connectivity for the Azure Sphere, that is, Wi-Fi connectivity and Ethernet connectivity.

Wi-Fi connectivity is achieved through 802.11 b/g/n Wi-Fi radio that operates at both 2.4 GHz and 5 GHz.

LAN connectivity is provided through an external Microchip ENC28J60 Ethernet chip connected over the SPI bus.

Two predefined network interfaces are provided to support these methods:

- **eth0** for ethernet
-  **wlan0** for Wi-Fi

An Azure Sphere device could have multiple active interfaces (*multihomed device)*. For multihomed devices, both Ethernet and Wi-Fi can connect to the internet. The specific interface it will use for communications is non-deterministic.

In addition to Ethernet and Wi-Fi connectivity, you could use an external hardware to route the Ethernet or Wi-Fi to the cellular network. However, this option has some security implications, which we discuss below.

We describe the three options in detail.

## Ethernet connectivity with Azure Sphere

Let’s first consider some descriptions:

**Ethernet controller**: an integrated circuit chip that controls Ethernet communications.

**Ethernet network interface**: allows a computer or mobile device to connect to a local area network (LAN) using **ethernet** as the transmission mechanism.

**eth0**: is an Ethernet interface supported Azure Sphere

**Board configuration image**: contains information that the Azure Sphere Security Service requires to add support for ethernet to the Azure Sphere OS.

You can enable the Azure Sphere to communicate on an Ethernet network via an external Ethernet controller. To use the ethernet, you need to create a board configuration image for the Ethernet controller and then deploy a board configuration image package to your device. When the board configuration is uploaded to the device, the Ethernet interface will be enabled automatically. Once your device is configured for networking, it can receive cloud updates from the Azure Security Service and communicate with Azure IoT Hub services.

## Wi-Fi connectivity with Azure Sphere

The other supported connectivity method is Wi-Fi. You can set up Wi-Fi on your Azure Sphere device by connecting Azure Sphere to your computer. If you integrate Azure Sphere with an existing manufactured product, your customers must set up Wi-Fi at the customer’s location. There are two ways to connect to the Azure Sphere device and configure Wi-Fi connectivity:

- Provide a physical control panel that the customer can access or
- Provide a mobile app via extra Bluetooth Low Energy (BLE) chip

In both cases, your Azure Sphere app will need to use the Azure Sphere Wi-Fi configuration API (wificonfig.h) to find available networks, then accept the user's network selection and Wi-Fi credentials.

## Cellular connectivity with Azure Sphere

The final connectivity method for the Azure Sphere is Cellular. Cellular connectivity is potentially applicable when your device doesn't have access to Ethernet or Wi-Fi. Cellular connectivity could also offer advantages even when ethernet and Wi-Fi are present (for instance, in device setup). Using a cellular-capable router device, you can introduce cellular connectivity to the Azure Sphere by pairing the Azure Sphere device with the router. Doing so allows you to take advantage of Azure Sphere’s software update infrastructure, certificate-based authentication, and Azure integration while connecting over cellular.

With the architecture of pairing the Azure Sphere device with a cellular-capable router, you introduce some risks if you don't appreciate the security boundary between the Azure Sphere elements and the cellular connectivity elements. Specifically, you should note that the Azure Sphere security doesn't extend beyond its own Wi-Fi or Ethernet interface.