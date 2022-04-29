The Device Provisioning Service supports the full lifecycle of a device, from initial provisioning by the manufacturer all the way through to retirement.

## Provisioning process

There are two distinct phases in the provisioning/deployment process for a device. These two phases can be done independently:

 -  The manufacturing phase in which the device is created and prepared at the factory.
 -  The cloud setup phase in which the Device Provisioning Service is configured for automated provisioning.

Both these phases fit in seamlessly with existing manufacturing and deployment processes. The Device Provisioning Service even simplifies some deployment processes that involve a lot of manual work to get connection information onto the device.

## Manufacturing phase

This step is all about what happens on the manufacturing line, and is concerned with creating the hardware itself.

The Device Provisioning Service does not introduce a new step in the manufacturing process; rather, it ties into the existing step that installs the initial software and (ideally) the hardware security module (HSM) on the device. Instead of creating a device ID in this step, the device is programmed with the provisioning service information, enabling it to call the provisioning service to get its connection info/IoT solution assignment when it is switched on.

Also in this step, the manufacturer supplies the device deployer/operator with the identifying key information for the device. Supplying that information could be as simple as confirming that all devices have an X.509 certificate generated from a signing certificate provided by the device deployer/operator, or as complicated as extracting the public portion of a trusted platform module (TPM) endorsement key from each TPM device. These services are offered by many silicon manufacturers today.

## Cloud setup phase

This step is about configuring the cloud for proper automatic provisioning. Generally there are two types of users involved in the cloud setup step: someone who knows how devices need to be initially set up (a device operator), and someone else who knows how devices are to be split among the IoT hubs (a solution operator).

There is a one-time initial setup of the provisioning service that must occur, which is usually handled by the solution operator. Once the provisioning service is configured, it does not have to be modified unless the use case changes.

After the service has been configured for automatic provisioning, it must be prepared to enroll devices. This step is done by the device operator, who knows the desired configuration of the device(s) and is in charge of making sure the provisioning service can properly attest to the device's identity when it comes looking for its IoT hub. The device operator takes the identifying key information from the manufacturer and adds it to the enrollment list. There can be subsequent updates to the enrollment list as new entries are added or existing entries are updated with the latest information about the devices.

## Registration and provisioning

Provisioning means various things depending on the industry in which the term is used. In the context of provisioning IoT devices to their cloud solution, provisioning is a two part process:

 -  The first part is establishing the initial connection between the device and the IoT solution by registering the device.
 -  The second part is applying the proper configuration to the device based on the specific requirements of the solution it was registered to.

Once both of those two steps have been completed, we can say that the device has been fully provisioned. Some cloud services only provide the first step of the provisioning process, registering devices to the IoT solution endpoint, but do not provide the initial configuration. The Device Provisioning Service automates both steps to provide a seamless provisioning experience for the device.
