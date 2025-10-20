Azure Local's hyperconverged infrastructure platform includes built-in security and performance features. These features are designed to protect and optimize virtualized workloads running on-premises. 

## Security features for HCI

Secured-core server support enhances security across the entire HCI stack by using hardware-based protections that reduce attack surfaces in virtualized environments.

- **Virtualization-based security (VBS)** isolates critical system components inside secure containers within the CPU, protecting virtual machines (VMs) and the host OS from attacks originating elsewhere in the environment.

- **Trusted Platform Module (TPM 2.0)** provides secure storage for encryption keys and certificates, enabling trusted communication between VMs and physical hardware to prevent unauthorized access.

- **Secure Boot** ensures only trusted, signed boot components run during startup, preventing rootkits and other boot-level attacks that could compromise the HCI infrastructure.

![A photograph of medical professionals talking around a table with tablets and papers.](../media/medical.png)

## Performance and availability features for HCI

Azure Local simplifies the deployment and management of HCI clusters to ensure high availability and resilience for virtualized workloads.

- Simple cluster deployment through Windows Admin Center provides a streamlined, graphical experience for setting up HCI clusters.

- Stretch cluster capability allows Azure Local to span clusters across two physical sites, ensuring workloads stay available even if one site experiences hardware failure or power loss—helping maintain business continuity.

- Cloud backup integrates on-premises HCI workloads with Azure Backup, enabling secure recovery options that combine local performance with cloud resiliency.