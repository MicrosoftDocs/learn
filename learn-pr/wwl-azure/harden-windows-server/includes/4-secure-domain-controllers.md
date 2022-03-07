Domain controllers represent one of the most valuable targets on a network. This is because someone who compromises a domain controller has control of all domain identities. You can help secure your organization’s domain controllers by taking the following precautions:

- Ensure that domain controllers are running the most recent version of the Windows Server operating system and have current security updates.

- Deploy domain controllers by using the Server Core installation option rather than the Desktop Experience option. Deploying the Server Core installation option reduces the domain controller’s attack surface and minimizes the chance that someone might install malware inadvertently because they signed in to the domain controller on the same computer they used to navigate to an unsafe website.

- Keep physically deployed domain controllers in dedicated, secure racks that are separate from other servers.

- Deploy domain controllers on hardware that includes a Trusted Platform Module (TPM) chip and configure all volumes with BitLocker Drive Encryption. If you cannot physically isolate and secure domain controllers at a branch-office location, you should configure them as read-only domain controllers (RODC).

- Run virtualized domain controllers either on separate virtualization hosts or as a shielded virtual machine on a guarded fabric, which helps protect the domain controller.

- Use Windows Defender Device Guard to control the execution of scripts and executables on the domain controller. This minimizes the chance that unauthorized executables and scripts can run on the computer.

- Configure RDP (Remote Desktop Protocol) through Group Policy assigned to the Domain Controllers' OU to limit RDP connections so that they can occur only from jump servers and privileged access workstations.

- Configure the perimeter firewall to block outbound connections to the internet from domain controllers. If an update management solution is in place, it might also be prudent to block domain controllers from communicating with hosts on the internet entirely.

- Review Center for Internet Security (CIS) benchmark for Windows Server operating systems, for security guidance specific to domain controllers.

Additional reading: For more information, see [Securing Domain Controllers Against Attack](/windows-server/identity/ad-ds/plan/security-best-practices/securing-domain-controllers-against-attack).

