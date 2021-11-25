The Device Provisioning Service (DPS) automates many of the manual steps that are traditionally involved in provisioning devices. This reduces the time to deploy IoT devices and lowers the risk of manual error.

The following information describes what goes on behind the scenes to get a device provisioned. The first step is manual, all of the other steps are automated.

:::image type="content" source="../media/m03-l01-device-provisioning-service-provisioning-flow-a8e493e4.png" alt-text="Diagram that shows what goes on behind the scenes to get a device provisioned.":::


1.  Device manufacturer adds the device registration information to the enrollment list in the Azure portal.
2.  Device contacts the provisioning service endpoint set at the factory. The device passes the identifying information to the provisioning service to prove its identity.
3.  The provisioning service validates the identity of the device by validating the registration ID and key against the enrollment list entry using either a nonce challenge (Trusted Platform Module) or standard X.509 verification (X.509).
4.  The provisioning service registers the device with an IoT hub and populates the device's desired twin state.
5.  The IoT hub returns device ID information to the provisioning service.
6.  The provisioning service returns the IoT hub connection information to the device. The device can now start sending data directly to the IoT hub.
7.  The device connects to IoT hub.
8.  The device gets the desired state from its device twin in IoT hub.
