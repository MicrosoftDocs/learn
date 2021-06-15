Before you start, you'll need the following:
- A Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at [https://azure.microsoft.com/free ](https://azure.microsoft.com/free ). If you are a student, then sign up for an [Azure for Students](https://signup.azure.com/studentverification?offerType=1&correlationId=3FCCAE4642E76FB009E6A1A1437E6E88) account.

## Create cloud resources

### Create a resource group

Perform the following steps in the Azure Cloud Shell environment.

1. Select ‘Bash' from the top left as the environment for your Cloud Shell.

2. Add the Azure IoT extension to the Cloud Shell instance.

   ```
   az extension add --name azure-iot
   ```

3. Create a resource group in the eastus2 location using the following command. Give a name to your resource group.

   ```
   az group create --name <resource-group-name> --location eastus2   
   ```

### Create an IoT Edge device in the IoT hub

1. Create an F1 Tier IoT Hub using the following command. Give a name to your IoT Hub and replace it with your resource group.

   ```
   az iot hub create --resource-group <resource-group-name> --name <iot-hub-name> --sku F1 --partition-count 2  
   ```

2. A device must be registered with your IoT Hub before it can connect. Run the following command to create a device identity in your IoT Hub. Give a name to your IoT device and replace it with your IoT Hub.

   ```
   az iot hub device-identity create --hub-name <iot-hub-name> --device-id <device-id>
   ```

## Install IoT Edge for Linux

> [!NOTE]
> Go to the [Microsoft page](https://azure.microsoft.com/services/iot-edge), if you would like to know more about installing IoT Edge for Linux. 

1. Open the terminal in your Linux computer. 

2. Install the repository configuration that matches your device operating system.

   **Ubuntu Server 18.04**:

     ```bash
     curl https://packages.microsoft.com/config/ubuntu/18.04/multiarch/prod.list > ./microsoft-prod.list
     ```

3. Copy the generated list to the sources.list.d directory.

   ```bash
   sudo cp ./microsoft-prod.list /etc/apt/sources.list.d/
   ```

4. Install the Microsoft GPG public key.

   ```bash
   curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
   sudo cp ./microsoft.gpg /etc/apt/trusted.gpg.d/
   ```

### Install a container engine

Azure IoT Edge relies on an OCI-compatible container runtime. For production scenarios, we recommended that you use the Moby engine. The Moby engine is the only container engine officially supported with Azure IoT Edge. Docker CE/EE container images are compatible with the Moby runtime.

1. Update package lists on your device.

   ```bash
   sudo apt-get update
   ```

2. Install the Moby engine.

   ```bash
   sudo apt-get install moby-engine
   ```

If you get errors when installing the Moby container engine, verify your Linux kernel for Moby compatibility. Some embedded device manufacturers ship device images that contain custom Linux kernels without the features required for container engine compatibility. Run the following command, which uses the [check-config script](https://github.com/moby/moby/blob/master/contrib/check-config.sh) provided by Moby, to check your kernel configuration:

```bash
curl -sSL https://raw.githubusercontent.com/moby/moby/master/contrib/check-config.sh -o check-config.sh
chmod +x check-config.sh
./check-config.sh
```

In the output of the script, check that all items under `Generally Necessary` and `Network Drivers` are enabled. If you are missing features, enable them by rebuilding your kernel from source and selecting the associated modules for inclusion in the appropriate kernel .config. Similarly, if you are using a kernel configuration generator like `defconfig` or `menuconfig`, find and enable the respective features and rebuild your kernel accordingly. Once you have deployed your newly modified kernel, run the check-config script again to verify that all the required features were successfully enabled.

## Install the IoT Edge security daemon

The IoT Edge security daemon provides and maintains security standards on the IoT Edge device. The daemon starts on every boot and bootstraps the device by starting the rest of the IoT Edge runtime.

1. Update package lists on your device.

   ```bash
   sudo apt-get update
   ```
2. Check to see which versions of IoT Edge are available.

   ```bash
   apt list -a iotedge
   ```

3. Install the most recent version of the security daemon, use the following command that also installs the latest version of the **libiothsm-std** package:

   ```bash
   sudo apt-get install iotedge
   ```

## Provision the device with its cloud identity

### Authenticate with symmetric keys

At this point, the IoT Edge runtime is installed on your Linux device, and you need to provision the device with its cloud identity and authentication information.

This section walks through the steps to provision a device with symmetric key authentication. You should have registered your device in IoT Hub, and retrieved the connection string from the device information. 

On the IoT Edge device, open the configuration file.

   ```bash
   sudo nano /etc/iotedge/config.yaml
   ```

Find the provisioning configurations of the file and uncomment the **Manual provisioning configuration using a connection string** section, if it isn't already uncommented.

    ```toml
    # Manual provisioning configuration using a connection string
    provisioning:
      source: "manual"
      device_connection_string: "<ADD DEVICE CONNECTION STRING HERE>"
    ```
Update the value of **device_connection_string** with the connection string from your IoT Edge device. Make sure that any other provisioning sections are commented out. Ensure the **provisioning**: line has no preceding whitespace, and that nested items are indented by two spaces.

To paste clipboard contents into Nano Shift+Right, Click or press Shift+Insert.

Save and close the file.

```
CTRL + X`, `Y`, `Enter
```

After entering the provisioning information in the configuration file, restart the daemon:

   ```
   sudo systemctl restart iotedge
   ```
## Verify successful configuration

Verify that the runtime was successfully installed and configured on your IoT Edge device.

Check to see that the IoT Edge system service is running.

   ```
   sudo systemctl status iotedge
   ```