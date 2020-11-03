In this unit you will learn about Azure Sphere security.

Applications on Azure Sphere are locked down by default. You must grant capabilities to the application. Granting capabilities is key to Azure Sphere security and is also known as the [principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege). You should grant only the capabilities that the Azure Sphere application needs to run correctly, and no more.

Application capabilities include what hardware can be accessed, what network endpoints can be called, and what inter-core communications is allowed.

## Iot Central network endpoints

You must declare all network endpoints your application will use. When connecting to IoT Central this includes the global device provisioning service endpoint as well as the endpoints for you IoT Central application. Otherwise, your Azure Sphere application will not be able to connect to IoT Central.

## Application access to hardware

Like network endpoints you must declare access to hardware peripherals your application requires. You can think of this as a silicon firewall. If you do not declare what hardware your application needs then your application will fail when it tries to access the hardware. As an extra layer of security, the silicon firewall is "sticky", silicon firewall settings remain in place until the device is restarted.
