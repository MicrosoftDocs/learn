Connect your Azure Sphere device developer kit to your PC through a USB port. When plugged in, the device exposes three COM ports. Open **Device Manager** on your PC, and make sure that three COM ports are installed. COM ports might be different from those shown here.

![Screenshot of Device Manager, with three COM ports highlighted.](../media/comports.png)

Alternatively, you can download the drivers from [Future Technology Devices International](https://www.ftdichip.com/Drivers/VCP.htm). Choose the driver that matches your Windows installation (32-bit or 64-bit).

## Install the Azure Sphere SDK

1. [Download the SDK](https://aka.ms/AzureSphereSDKDownload). Save the downloaded file on your PC.
2. Run the downloaded .exe to install the SDK. Agree to the license terms, and then select **Next**.
3. Select **Install** to begin installation.
4. Accept the elevation prompt if one appears.
5. When setup completes, restart your PC if the setup application requests it.

## Sign in to Azure Sphere

1. Press the Windows key and type **Azure Sphere Developer Command prompt**.

2. Select and start the **Azure Sphere Developer Command Prompt**.

3. If you've never signed in to Azure Sphere before or have installed the SDK, add the `--newuser` parameter to create a new tenant user. Replace `<email@address.com>` with your account, and run the command.

   ```
   azsphere login --newuser <email@address.com>
   ```

   Type the following command to sign in to Azure Sphere by using a Microsoft account.

   ```
   azsphere login
   ```

## Create a new tenant

> [!NOTE]
> If you have access to a single tenant or multiple tenants, you can proceed to the next step.

1. Now that you have successfully signed in, you'll create a new tenant. Type the following command. Replace <tenant_name> with a name that other users can recognize. You can create only one Azure Sphere tenant with each device.

   ```
   azsphere tenant create -n <tenant_name>
   ```

2. After that, you're prompted to sign in again for the Azure Sphere tenant credentials.

## Select the default Azure Sphere tenant

1. If you have access to a single tenant, it's selected by default.

   If you have access to more than one tenant, run the following command to list Azure Sphere tenants.

   ```
   azsphere tenant list
   ```

2. Copy the ID from the list above and replace <tenant_id> with it. Run the following command to set the default tenant.

   ```
   azsphere tenant select -i <tenant_id>
   ```

## Claim your device

> [!NOTE]
> If you have already claimed your Azure Sphere device, you can proceed to the next step.

> [!NOTE]
> Claiming an Azure Sphere device is a one-time operation. You can't move the device to another Azure Tenant after it has been claimed. However, you can add additional users and roles to the Azure Sphere tenant, including users with Admin rights.

Run the following command to claim the device.

   ```
   azsphere device claim
   ```

## Configure the Azure Sphere Wi-Fi network

Configure the Azure Sphere for networking. You can receive cloud updates from the Azure Sphere security service, and communicate with services such as Azure IoT Hub.

1. Scan for Wi-Fi access points by using the following command.

   ```
   azsphere device wifi scan
   ```

2. Run the following command to add your Wi-Fi network to the device. Replace <yourwifissid> with the name of your network, and replace <yourwifipassword> with your network password.

   ```
   azsphere device wifi add -s <yourwifissid> -p <yourwifipassword>
   ```

3. Run the following command to check your Wi-Fi connection status.

   ```
   azsphere device wifi show-status
   ```

## Update the Azure Sphere operating system

1. Run the following command to check the device operating system version.

   ```
   azsphere device show-os-version
   ```

2. If the device isn't up-to-date, run the following command to restart to trigger the update process.

   ```
   azsphere device restart
   ```

3. It will take a few minutes for the update to be applied. Then recheck the version.

   ```
   azsphere device show-os-version
   ```

4. Run the following command to check that the Wi-Fi network connection is active after you've updated the operating system.

   ```
   azsphere device wifi show-status
   ```

## Delete any existing applications on Azure Sphere

1. Run the following command to delete existing application on the device.

   ```
   azsphere device sideload delete
   ```

2. Restart Azure Sphere.

   ```
   azsphere device restart
   ```

## Enable high-level core device debugging

Run the following command to enable app development on the device.

   ```
   azsphere device enable-development
   ```

## Clone the Azure Sphere Learning Path

> [!NOTE]
> On Windows, clone the **Azure Sphere Learning Path** to a directory close to the root directory on your computer. For example: **c:\lab**. The reason for this is that the Azure Sphere build process uses `CMake`, which doesn't support long path and folder names.

```
git clone --depth 1 https://github.com/MicrosoftDocs/Azure-Sphere-Developer-Learning-Path.git
```

## Clone the Azure Sphere samples

The Azure Sphere samples repository includes a tool required for listing Azure IoT Central network endpoints.

Clone this repository into the same directory that you cloned the Azure Sphere Developer Learning Path into.

```
git clone https://github.com/Azure/azure-sphere-samples.git
```
