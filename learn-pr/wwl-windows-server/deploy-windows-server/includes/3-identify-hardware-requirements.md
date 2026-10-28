Before the Contoso infrastructure team starts deploying Windows Server, it's important that you verify that the target computers meet the minimum hardware requirements for Windows Server 2025. This requirement applies whether you intend to run Windows Server on physical hosts, or you intend to virtualize Windows Server.

## Hardware requirements for Windows Server 2025

The hardware requirements for Windows Server depend on the services that the server is hosting, the load on the server, and how responsive you want the server to be. The services and features of each role put a unique load on network, disk I/O, processor, and memory resources. The following table displays the absolute minimum required for a Server Core installation on a physical machine.

| Component              | Requirement                                                  |
| ---------------------- | ------------------------------------------------------------ |
| Processor architecture | 64-bit                                                       |
| Processor speed        | 1.4 Gigahertz (GHz)                                          |
| RAM                    | 2 GB for Server Core. Physical host deployments require error-correcting code (ECC) memory or similar technology. |
| Hard drive space       | 32 GB                                                        |

For a Windows Server 2025 Server Core VM, use the documented 2-GB RAM minimum as the baseline and allocate more memory for the server's roles and applications. Setup can also require additional memory, particularly when the boot image includes extra languages or updates. Don't size a production VM around the lower-memory setup workaround described in the hardware documentation or assume that you can reduce its allocation to 512 MB after installation.

Minimum installation requirements aren't workload sizing recommendations. Check the version-specific [Windows Server hardware requirements](/windows-server/get-started/hardware-requirements?view=windows-server-2025&preserve-view=true) before deployment, and test the configuration with the roles and applications you intend to run.

### Other hardware requirements

In addition to the previously listed requirements, there are various other hardware requirements to consider, depending on your specific organizational needs and installation scenarios:

- Greater disk space is needed for network installations or for computers with more than 16 GB of RAM.
- Storage and network adapters must be PCI Express compliant.
- A Trusted Platform Module (TPM 2.0) is needed to implement several security features. Windows Server 2025 can be installed if a TPM 2.0 chip isn't present, but these extra security capabilities won't be available.
