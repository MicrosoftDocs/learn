
Before the Contoso infrastructure team starts deploying Windows Server, it's important that you verify that the target computers meet the minimum hardware requirements for Windows Server 2019. This requirement applies whether you intend to run Windows Server on physical hosts, or you intend to virtualize Windows Server.

## Hardware requirements for Windows Server 2019

The hardware requirements for Windows Server depend on the services that the server is hosting, the load on the server, and how responsive you want the server to be. The services and features of each role put a unique load on network, disk I/O, processor, and memory resources. The following table displays the absolute minimum required for a Server Core installation on a physical machine.

| Component              | Requirement                                                  |
| ---------------------- | ------------------------------------------------------------ |
| Processor architecture | 64-bit                                                       |
| Processor speed        | 1.4 Gigahertz (GHz)                                          |
| RAM                    | 512 MB. VMs require at least 800 MB of RAM during installation. You can reduce it to 512 MB after the installation is complete. |
| Hard drive space       | 32 GB                                                        |

Virtualized deployments of Windows Server require the same hardware specifications for physical deployments. However, during installation, you'll need to allocate extra memory to the VM, which you can then deallocate after installation, or you'll need to create an installation partition during the boot process.

### Other hardware requirements

In addition to the previously listed requirements, there are various other hardware requirements to consider, depending on your specific organizational needs and installation scenarios:

- Greater disk space is needed for network installations or for computers with more than 16 GB of RAM.
- Storage and network adapters must be PCI Express compliant.
- A Trusted Platform Module (TPM) is needed to implement several security features.
