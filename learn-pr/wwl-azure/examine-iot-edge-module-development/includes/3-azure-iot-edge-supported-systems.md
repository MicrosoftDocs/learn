It is important to understand which systems and components are supported by IoT Edge, whether officially or in preview.

For the full list of IoT Edge releases and support documentation, see: [https://docs.microsoft.com/azure/iot-edge/support](/azure/iot-edge/support)

## Container engines

Azure IoT Edge modules are implemented as containers, so IoT Edge needs a container engine to launch them. Microsoft provides a container engine, moby-engine, to fulfill this requirement. This container engine is based on the Moby open-source project. Docker CE and Docker EE are other popular container engines. They're also based on the Moby open-source project and are compatible with Azure IoT Edge. Microsoft provides best effort support for systems using those container engines; however, Microsoft can't ship fixes for issues in them. For this reason, Microsoft recommends using moby-engine on production systems.

:::image type="content" source="../media/m07-l01-edge-modules-containers-only-moby-production-addd36ef.png" alt-text="Diagram that shows container engine support for IoT Edge.":::


## Operating systems

Azure IoT Edge runs on most operating systems that can run containers; however, all of these systems are not equally supported. Operating systems are grouped into tiers that represent the level of support users can expect.

 -  Tier 1 systems are supported. For tier 1 systems, Microsoft:
    
     -  Has this operating system in automated tests.
     -  Provides installation packages for them.
 -  Tier 2 systems are compatible with Azure IoT Edge and can be used relatively easily. For tier 2 systems:
    
     -  Microsoft has done some preliminary testing on the platforms or knows of a partner successfully running Azure IoT Edge on the platform.
     -  Installation packages for other platforms may work on these platforms.

The family of the host OS must always match the family of the guest OS used inside a module's container. In other words, you can only use Linux containers on Linux and Windows containers on Windows. When using Windows, only process isolated containers are supported, not Hyper-V isolated containers.

:::image type="content" source="../media/m07-l01-edge-modules-containers-edge-device-8fc429bd.png" alt-text="Diagram that shows operating system support for IoT Edge.":::


## Virtual machines

Azure IoT Edge can be run in virtual machines. Using a virtual machine as an IoT Edge device is common when customers want to augment existing infrastructure with edge intelligence. The family of the host VM OS must match the family of the guest OS used inside a module's container. This requirement is the same as when Azure IoT Edge is run directly on a device. Azure IoT Edge is agnostic of the underlying virtualization technology and works in VMs powered by platforms like Hyper-V and vSphere.

:::image type="content" source="../media/m07-l01-edge-modules-containers-edge-virtual-machine-59b23c11.png" alt-text="Diagram that shows virtual machine support for IoT Edge.":::


## Minimum system requirements

Azure IoT Edge runs great on devices as small as a Raspberry Pi3 to server grade hardware. Choosing the right hardware for your scenario depends on the workloads that you want to run. Making the final device decision can be complicated; however, you can easily start prototyping a solution on traditional laptops or desktops.

Experience while prototyping will help guide your final device selection. Questions you should consider include:

 -  How many modules are in your workload?
 -  How many layers do your modules’ containers share?
 -  In what language are your modules written?
 -  How much data will your modules be processing?
 -  Do your modules need any specialized hardware for accelerating their workloads?
 -  What are the desired performance characteristics of your solution?
 -  What is your hardware budget?
