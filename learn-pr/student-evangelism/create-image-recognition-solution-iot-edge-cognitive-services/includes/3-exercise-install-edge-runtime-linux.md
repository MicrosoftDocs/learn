Before you start, you'll need the following:
- A Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at [https://azure.microsoft.com/free ](about:blank). If you are a student, then sign up for an [Azure for Students](about:blank) account.

## Create cloud resources

### Create a resource group

Perform the following steps in the Azure Cloud Shell environment.

1. Select ‘Bash' from the top left as the environment for your Cloud Shell.

2. Add the Azure IoT extension to the Cloud Shell instance.

   ```
   az extension add --name azure-cli-iot-ext 
   ```

3. Create a resource group to hold the cloud infrastructure you'll use for the exercise. Use only lowercase alphabets and numbers in your unique string

   ```
   # Pick a unique string to append to your resources
   export UNIQUESTRING=<replace-with-your-unique-string>  
   export RGLOC=westus2   
   
   az group create \
   --name iot-resources-$UNIQUESTRING \
   --location $RGLOC   
   ```

### Create an IoT Edge device in the IoT hub

1. Create an IoT Hub resource.

   ```
   az iot hub create \
   --resource-group iot-resources-$UNIQUESTRING \
   --name iot-hub-$UNIQUESTRING \
   --sku S1 \
   --partition-count 2   
   ```

2. Create an edge-enabled device in your IoT Hub.  In this exercise, we only use a single device.

   ```
   az iot hub device-identity create \
   --device-id edge-device-$UNIQUESTRING \
   --hub-name iot-hub-$UNIQUESTRING \
   --edge-enabled   
   ```

## Install IoT Edge for Linux

1. Install the repository configuration that matches your device operating system.

   - **Ubuntu Server 18.04**:

     ```bash
     curl https://packages.microsoft.com/config/ubuntu/18.04/multiarch/prod.list > ./microsoft-prod.list
     ```

2. Copy the generated list to the sources.list.d directory.

   ```bash
   sudo cp ./microsoft-prod.list /etc/apt/sources.list.d/
   ```

3. Install the Microsoft GPG public key.

   ```bash
   curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
   sudo cp ./microsoft.gpg /etc/apt/trusted.gpg.d/
   ```

### Install a container engine

Update package lists on your device.

```bash
sudo apt-get update
```

Install the Moby engine.

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

Update package lists on your device.

```bash
sudo apt-get update
```

```bash
apt list -a iotedge
```

If you want to install the most recent version of the security daemon, use the following command that also installs the latest version of the **libiothsm-std** package:

```bash
sudo apt-get install iotedge
```

## Set edge workloads

1. Download the deployment configuration file that describes the Azure IoT Edge Modules and Routes for this solution. Open the [deployment.amd64.json](https://raw.githubusercontent.com/gloveboxes/Creating-an-image-recognition-solution-with-Azure-IoT-Edge-and-Azure-Cognitive-Services/master/config/deployment.arm32v7.json) link and save the deployment.arm32v7.json in a known location on your computer.
2. Open a command line console/terminal and change directory to the location where you saved the deployment.arm32v7.json file.
3. Finally, from the command line run the following command, be sure to substitute [device id] and the [hub name] values.

```
az iot edge set-modules --device-id [device id] --hub-name [hub name] --content deployment.amd64.json
```

The modules will now start to deploy to your Linux computer. Approximately 1.5 GB of Dockers modules will be downloaded and decompressed on the computer. This is a one off operation.