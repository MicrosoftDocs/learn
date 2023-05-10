


Windows 10 and 11 have similar requirements. Many computers in enterprises today easily meet the minimum hardware requirements.

### OS requirements

The following section lists the minimum recommended hardware requirements for the Windows client. Windows will still install with some of these requirements not being met. However, you might compromise the user experience and operating system performance if the computer doesn't meet or exceed the following specifications:

#### Windows 10

 -  **Processor**: 1 gigahertz (GHz) or faster processor, or system on a chip (SOC)
 -  **RAM:** 1 GB for 32-bit or 2 GB for 64-bit
 -  **Hard disk space**: 16 GB for 32-bit or 20 GB for 64-bit
 -  **Graphics card**: DirectX 9 or newer with Windows Display Driver Model (WDDM) 1.0 driver
 -  **Display**: 800x600 pixels

> [!NOTE]
> Beginning with Windows 10 version 2004, new computers are no longer sold with a 32-bit edition.

#### Windows 11

Devices must meet the following minimum hardware requirements to install or upgrade to Windows 11:

 -  **Processor**: 1 gigahertz (GHz) or faster with two or more cores on a compatible 64-bit processor or system on a chip (SoC).
 -  **RAM**: 4 gigabytes (GB) or greater.
 -  **Storage**: 64 GB or greater available storage
    
     -  Extra storage space might be required to download updates and enable specific features.
 -  **Graphics card**: Compatible with DirectX 12 or later, with a WDDM 2.0 driver.
 -  **System firmware**: UEFI, Secure Boot capable.
 -  **TPM**: Trusted Platform Module (TPM) version 2.0.
 -  **Display**: High definition (720p) display, 9" or greater monitor, 8 bits per color channel.
 -  **Internet connection**: Internet connectivity is necessary to perform updates, and to download and use some features.
    
     -  Windows 11 Home edition requires an internet connection and a Microsoft account to complete device setup on first use.

#### Feature-specific requirements

Windows client offers more options if the correct hardware is present. The following are some of the hardware and software requirements for various additional features:

 -  **Windows Hello:** Windows Hello requires a specialized illuminated infrared camera for facial recognition, iris detection, or a fingerprint reader that supports the Windows Biometric Framework.
 -  **Two factor authentication:** Two-factor authentication requires using a PIN, fingerprint reader, illuminated infrared camera, or a phone with Wi-Fi or Bluetooth capabilities.
 -  **Snap:** Windows might limit the number of simultaneously snapped applications depending on the monitor’s resolution. In Windows 11, three-column layouts require a screen that is 1920 effective pixels or greater in width.
 -  **Secure boot:** Secure boot requires firmware that supports Unified Extensible Firmware Interface (UEFI) and has the Microsoft Windows Certification Authority in the UEFI signature database. The secure boot process takes advantage of UEFI to prevent the launching of unknown or unwanted operating-system boot loaders between the system’s BIOS start and the Windows 10 operating system start. While the secure boot process isn't mandatory for Windows 10, it increases the integrity of the boot process.
 -  **DirectX:** Some applications may require a graphics card with a higher version of DirectX for optimal performance.
 -  **BitLocker to Go:** Requiring a USB flash drive. This feature is available in Windows Pro and above editions.
 -  **Client Hyper-V:** Client Hyper-V requires a processor with second-level address translation (SLAT) capabilities and 4 GB (if Windows 10). This feature is available in Windows Pro editions and above.
 -  **Miracast/Windows Projection:** Requires a display adapter that supports WDDM, and a Wi-Fi adapter that supports Wi-Fi Direct.
 -  **Wi-Fi Direct Printing:** Requires a Wi-Fi adapter that supports Wi-Fi Direct and a device that supports Wi-Fi Direct Printing.
 -  **InstantGo:** InstantGo works only with computers designed for connected standby. InstantGo allows network connectivity in standby mode and allows for receiving updates, mail, and Skype calls with the screen turned off.
 -  **DirectStorage:** DirectStorage requires an NVMe SSD to store and run games that use the Standard NVM Express Controller driver and a DirectX12 GPU with Shader Model 6.0 support.

### Device drivers

Windows will detect most hardware and install the driver to support the device. Many companies producing hardware have their drivers certified at the Windows Hardware Quality Labs and delivered through Windows updates.

However, you might not find a built-in driver for a specific piece of hardware. Depending on your deployment method, you may need the driver deployment to complete parts of the OS installation. The best way to find hardware drivers is to search the manufacturer’s website.

### Check for Hyper-V compatibility

To verify compatibility, open PowerShell window or a command prompt and run **systeminfo.exe**. If all listed Hyper-V requirements have a value of **Yes**, your system can run the Hyper-V role. Below, you can see that we verified the hardware requirements highlighted above when **systeminfo.exe** is executed.

:::image type="content" source="../media/system-information-hyperv-b7b8342d-ae01d6a6.png" alt-text="Diagram showing Hyper-V Requirements when running systeminfo.exe":::


You'll see the following message from systeminfo.exe if Hyper-V is already enabled on the system:

`Hyper-V Requirements: A hypervisor has been detected. Features required for Hyper-V will not be displayed.`