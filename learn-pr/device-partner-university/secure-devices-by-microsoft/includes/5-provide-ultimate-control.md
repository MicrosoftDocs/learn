Surface devices give IT departments powerful tools to manage and protect their organization's devices:

- Surface works smoothly with Microsoft security and management solutions, like Microsoft Intune and Configuration Manager, making it easy to set up, secure, and monitor devices.
- There are special tools just for Surface, such as the Surface Management Portal, Surface Support Portal, and Surface IT Toolkit. These tools help IT teams configure, secure, and keep track of all their Surface devices.
- Features like Surface Data Eraser allow IT to safely wipe data from SSDs, and with Autopilot, devices can be quickly redeployed or remotely erased—even if they change hands.
- These capabilities help IT departments keep devices secure and operations running smoothly, from the moment a device is deployed until it's retired.

## Surface Enterprise Manager Mode (SEMM)

Surface Enterprise Management Mode (SEMM) makes it easy for IT administrators to keep Surface devices secure and consistent. With SEMM, you can centrally set and lock important firmware settings (UEFI) on all Surface devices in your organization. This helps prevent unauthorized changes and keeps devices compliant with company policies.

The key benefits of SEMM include:

- **Security:** Only approved changes can be made to UEFI settings.
- **Consistency:** All Surface devices can have the same settings, making management simple.
- **Compliance:** Helps your organization meet security and regulatory requirements.

**How SEMM works:**

- Use the UEFI Configurator in the Surface IT Toolkit or Microsoft Config Manager to create a settings package.
- Deploy the package using Windows Installer, WinPE, or PowerShell.
- SEMM uses certificates to protect settings from tampering.

## Device Firmware Configuration Interface (DFCI)

:::image type="content" border="true" source="../media/device-firmware-configuration.png" alt-text="Screenshot of Device Firmware Configuration Interface (DFCI) settings in Microsoft Intune.":::

DFCI lets IT administrators manage Surface device firmware settings directly from the Microsoft Intune admin center. With DFCI, you can control hardware features—like cameras, boot options, and other device components—remotely and securely, without needing to set UEFI passwords or physically access the device. DFCI also supports zero-touch provisioning, making it easy to apply security settings across many devices at once.

For example, a government organization needed to disable cameras in a secure facility. In the past, this would have required ordering special hardware or physically removing cameras from devices. With Surface and DFCI, IT was able to remotely turn off cameras and apply different settings to different teams, all without handling the devices directly.
