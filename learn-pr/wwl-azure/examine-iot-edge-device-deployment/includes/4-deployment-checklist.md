When you're ready to take your IoT Edge solution from development into production, having a checklist will help you to ensure that your solution is configured for ongoing performance.

> [!NOTE]
> Each section below begins by dividing associated work into two sections: **important** to complete before going to production, or **helpful** for you to know. This distinction is helpful when prioritizing efforts.

## Device configuration

IoT Edge devices can be anything from a Raspberry Pi to a laptop to a virtual machine running on a server. You may have access to the device either physically or through a virtual connection, or it may be isolated for extended periods of time. Either way, you want to make sure that it's configured to work appropriately.

 -  Important
    
     -  Install production certificates.
     -  Have a device management plan.
     -  Use Moby as the container engine.
 -  Helpful
    
     -  Choose upstream protocol.

### Install production certificates

Every IoT Edge device in production needs a device certificate authority (CA) certificate installed on it. That CA certificate is then declared to the IoT Edge runtime in the config.yaml file. To make development and testing easier, the IoT Edge runtime creates temporary certificates if no certificates are declared in the config.yaml file. However, these temporary certificates expire after three months and aren't secure for production scenarios.

The steps for configuring the certificates are the same whether the device is going to be used as a gateway or not.

You can generate sample certificates for testing, but never use sample certificates in production.

### Have a device management plan

Before you put any device in production you should know how you're going to manage future updates. For an IoT Edge device, the list of components to update may include:

 -  Device firmware.
 -  Operating system libraries.
 -  Container engine, like Moby.
 -  IoT Edge daemon.
 -  CA certificates.

The current methods for updating the IoT Edge daemon require physical or SSH access to the IoT Edge device. If you have many devices to update, consider adding the update steps to a script or use an automation tool like Ansible.

### Use Moby as the container engine

A container engine is a prerequisite for any IoT Edge device. Only moby-engine is supported in production. Other container engines, like Docker, do work with IoT Edge and it's ok to use these engines for development. The moby-engine can be redistributed when used with Azure IoT Edge, and Microsoft provides servicing for this engine.

### Choose upstream protocol

The protocol (and therefore the port used) for upstream communication to IoT Hub can be configured for both the IoT Edge agent and the IoT Edge hub. The default protocol is AMQP, but you may want to change that depending on your network setup.

The two runtime modules both have an **UpstreamProtocol** environment variable. The valid values for the variable are:

 -  MQTT
 -  AMQP
 -  MQTTWS
 -  AMQPWS

Configure the UpstreamProtocol variable for the IoT Edge agent in the config.yaml file on the device itself. For example, if your IoT Edge device is behind a proxy server that blocks AMQP ports, you may need to configure the IoT Edge agent to use AMQP over WebSocket (AMQPWS) to establish the initial connection to IoT Hub.

Once your IoT Edge device connects, be sure to continue configuring the UpstreamProtocol variable for both runtime modules in future deployments. An example of this process is provided in Configure an IoT Edge device to communicate through a proxy server [https://docs.microsoft.com/azure/iot-edge/how-to-configure-proxy-support](/azure/iot-edge/how-to-configure-proxy-support).

## Deployment

For your Deployment checklist, the following items fall into the **helpful** category.

### Be consistent with upstream protocol

If you configured the IoT Edge agent on your IoT Edge device to use a different protocol than the default AMQP, then you should declare the same protocol in all future deployments. For example, if your IoT Edge device is behind a proxy server that blocks AMQP ports, you probably configured the device to connect over AMQP over WebSocket (AMQPWS). When you deploy modules to the device, configure the same AMQPWS protocol for the IoT Edge agent and IoT Edge hub, or else the default AMQP will override the settings and prevent you from connecting again.

You only have to configure the UpstreamProtocol environment variable for the IoT Edge agent and IoT Edge hub modules. Any other modules adopt whatever protocol is set in the runtime modules.

### Set up host storage for system modules

The IoT Edge hub and agent modules use local storage to maintain state and enable messaging between modules, devices, and the cloud. For better reliability and performance, configure the system modules to use storage on the host filesystem.

### Reduce memory space used by IoT Edge hub

If you're deploying constrained devices with limited memory available, you can configure IoT Edge hub to run in a more streamlined capacity and use less disk space. These configurations do limit the performance of the IoT Edge hub, however, so find the right balance that works for your solution.

Three guidelines that you can follow are:

 -  Don't optimize for performance on constrained devices.
 -  Disable unused protocols.
 -  Do not use debug versions of module images.

## Container management

For your Container management checklist, the following items fall into the **important** category.

### Use tags to manage versions

A tag is a docker concept that you can use to distinguish between versions of docker containers. Tags are suffixes like 1.0 that go on the end of a container repository. For example, mcr.microsoft.com/azureiotedge-agent:1.0. Tags are mutable and can be changed to point to another container at any time, so your team should agree on a convention to follow as you update your module images moving forward.

Tags also help you to enforce updates on your IoT Edge devices. When you push an updated version of a module to your container registry, increment the tag. Then, push a new deployment to your devices with the tag incremented. The container engine will recognize the incremented tag as a new version and will pull the latest module version down to your device.

### Tags for the IoT Edge runtime

The IoT Edge agent and IoT Edge hub images are tagged with the IoT Edge version that they are associated with. There are two different ways to use tags with the runtime images:

 -  Rolling tags - Use only the first two values of the version number to get the latest image that matches those digits. For example, 1.1 is updated whenever there's a new release to point to the latest 1.1.x version. If the container runtime on your IoT Edge device pulls the image again, the runtime modules are updated to the latest version. Deployments from the Azure portal default to rolling tags. This approach is suggested for development purposes.
 -  Specific tags - Use all three values of the version number to explicitly set the image version. For example, 1.1.0 won't change after its initial release. You can declare a new version number in the deployment manifest when you're ready to update. This approach is suggested for production purposes.

## Networking

For your Networking checklist, the following items fall into the **helpful** category.

### Review outbound/inbound configuration

Communication channels between Azure IoT Hub and IoT Edge are always configured to be outbound. For most IoT Edge scenarios, only three connections are necessary. The container engine needs to connect with the container registry (or registries) that holds the module images. The IoT Edge runtime needs to connect with IoT Hub to retrieve device configuration information, and to send messages and telemetry. And if you use automatic provisioning, the IoT Edge daemon needs to connect to the Device Provisioning Service.

### Allow connections from IoT Edge devices

If your networking setup requires that you explicitly permit connections made from IoT Edge devices, review the following list of IoT Edge components:

 -  IoT Edge agent opens a persistent AMQP/MQTT connection to IoT Hub, possibly over WebSockets.
 -  IoT Edge hub opens a single persistent AMQP connection or multiple MQTT connections to IoT Hub, possibly over WebSockets.
 -  IoT Edge daemon makes intermittent HTTPS calls to IoT Hub.

In all three cases, the DNS name would match the pattern \*.azure-devices.net.

Additionally, the Container engine makes calls to container registries over HTTPS. To retrieve the IoT Edge runtime container images, the DNS name is mcr.microsoft.com. The container engine connects to other registries as configured in the deployment.

### Configure communication through a proxy

If your devices are going to be deployed on a network that uses a proxy server, they need to be able to communicate through the proxy to reach IoT Hub and container registries.

## Solution management

For your Solution management checklist, the following items fall into the **helpful** category.

### Set up logs and diagnostics

On Linux, the IoT Edge daemon uses journals as the default logging driver. You can use the command-line tool `journalctl` to query the daemon logs. On Windows, the IoT Edge daemon uses PowerShell diagnostics. Use `Get-IoTEdgeLog` to query logs from the daemon. IoT Edge modules use the JSON driver for logging, which is the default.

When you're testing an IoT Edge deployment, you can usually access your devices to retrieve logs and troubleshoot. In a deployment scenario, you may not have that option. Consider how you're going to gather information about your devices in production. One option is to use a logging module that collects information from the other modules and sends it to the cloud.

### Place limits on log size

By default the Moby container engine does not set container log size limits. Over time this can lead to the device filling up with logs and running out of disk space.

### Consider tests and CI/CD pipelines

For the most efficient IoT Edge deployment scenario, consider integrating your production deployment into your testing and CI/CD pipelines. Azure IoT Edge supports multiple CI/CD platforms, including Azure DevOps.
