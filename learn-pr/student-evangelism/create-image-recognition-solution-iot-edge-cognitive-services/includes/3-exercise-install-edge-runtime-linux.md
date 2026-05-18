Before you start, you'll need the following:
- A Microsoft Azure subscription. If you don't already have one, you can sign up for a [free trial](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn). If you are a student, then sign up for an [Azure for Students](https://signup.azure.com/studentverification?offerType=1&correlationId=3FCCAE4642E76FB009E6A1A1437E6E88) account.
- A supported Ubuntu Server 24.04 or 22.04 Linux device or VM to act as the IoT Edge device. This lab uses **amd64** packages and module images; if you intentionally use another supported architecture, verify the current IoT Edge OS/architecture support matrix and use compatible packages and images.
- Sudo/admin access to the Linux device or VM so you can install packages, configure the container engine and IoT Edge runtime, and restart services.
- Outbound internet access from the Linux device or VM, or an approved proxy/mirror configuration, for Ubuntu and Microsoft package downloads, container image pulls, and IoT Hub connectivity. If your admin workstation, Cloud Shell, Azure CLI, or browser runs from a restricted network, make sure that environment can also reach Azure sign-in and resource-management endpoints.

## Choose a lab topology

This lab supports these development and runtime layouts:

- **Same host (simplest)**: Use one supported Ubuntu Server 24.04 or 22.04 amd64 host as both the development environment and the IoT Edge device. The host has the camera and audio output, Moby engine, IoT Edge runtime, and Docker-compatible build access. If the host has a desktop UI, you can run VS Code on it directly. If the host is Ubuntu Server or otherwise headless, run VS Code on your workstation and connect to the host with Remote-SSH so the VS Code tasks use the host's container engine.
- **Separate development machine**: Use another machine for VS Code and container builds, then push module images to a container registry. The IoT Edge device must be able to reach that registry and authenticate to pull images. Configure those registry credentials later in the deployment/runtime configuration that references the registry; installing the IoT Edge runtime in this exercise doesn't configure registry access.

## Create cloud resources

> [!NOTE]
> This lab places the resource group and IoT Hub in `eastus2` and the Foundry resource for Speech in `southeastasia`. The IoT Hub region is your choice; the Foundry resource for Speech region is constrained by the linked sample's hardcoded `southeastasia` Speech REST endpoints.

### Create a resource group

Perform the following steps in the Azure Cloud Shell environment.

1. Select ‘Bash' from the top left as the environment for your Cloud Shell.

2. Install or update the Azure IoT extension in the Cloud Shell instance. The `--upgrade` option installs the extension if it isn't already installed, or updates it if it is.

   ```
   az extension add --upgrade --name azure-iot
   ```

3. Create a resource group in the eastus2 location using the following command. Give a name to your resource group.

   ```
   az group create --name <resource-group-name> --location eastus2
   ```

### Create an IoT Edge device in the IoT hub

1. Create an F1 tier IoT Hub using the following command. Choose a globally unique IoT Hub name. If the name is unavailable, choose another. Replace the resource group placeholder with your resource group. The `--partition-count 2` value is intentional for the F1/free tier, which supports exactly two device-to-cloud partitions. The Azure CLI default partition count is higher, so omitting or increasing this value while using `--sku F1` can cause hub creation to fail.

   > [!IMPORTANT]
   > Each Azure subscription can have at most one free-tier IoT Hub. If your subscription already has an F1 IoT Hub, use that existing hub for this lab or, after reviewing current pricing and quotas, create a paid tier such as S1 by replacing `--sku F1` with `--sku S1`.

   ```
   az iot hub create --resource-group <resource-group-name> --name <iot-hub-name> --sku F1 --partition-count 2
   ```

   > [!NOTE]
   > The Azure IoT extension for Azure CLI uses key-based authentication (`--auth-type key`) by default for many IoT Hub data-plane commands. In RBAC or least-privilege environments, add `--auth-type login` to commands such as `az iot hub device-identity create` and `az iot hub device-identity connection-string show` so the CLI uses the signed-in Microsoft Entra principal instead. That principal needs the appropriate IoT Hub data permissions at the IoT Hub scope; for these device registry steps, device `read` and `write` permissions are required as applicable, and the built-in **IoT Hub Registry Contributor** role includes full device registry access. Use a narrower custom role if your organization requires stricter least privilege.

2. A device must be registered with your IoT Hub before it can connect. Run the following command to create an IoT Edge device identity in your IoT Hub. Give a name to your IoT Edge device and replace it with your IoT Hub.

   ```
   az iot hub device-identity create --hub-name <iot-hub-name> --device-id <device-id> --edge-enabled
   ```

3. Retrieve the device connection string. You'll use this value when you provision the IoT Edge runtime on the Linux device. Keep the connection string private.

   ```
   az iot hub device-identity connection-string show --hub-name <iot-hub-name> --device-id <device-id> --query connectionString --output tsv
   ```

## Install IoT Edge for Linux

> [!NOTE]
> The following steps install IoT Edge 1.5 LTS on supported Ubuntu Server 24.04 or 22.04 devices. IoT Edge 1.5 LTS is supported through November 10, 2026; before adopting this lab for maintained environments, and again as that date approaches or after it passes, revalidate the runtime version and installation guidance against the current [Azure IoT Edge version history](/azure/iot-edge/version-history) and supported-platforms documentation. If those docs show IoT Edge 1.6 LTS as generally available and supported for your target OS and architecture, consider using 1.6 LTS for new deployments. This lab assumes an **amd64** Ubuntu Server device. Ubuntu Server 24.04 and 22.04 are supported for IoT Edge 1.5 on amd64 and arm64; if you intentionally target another supported architecture, verify the current OS/architecture support matrix and use compatible packages and module images. For the latest supported operating systems and architectures, see [Azure IoT Edge supported platforms](/azure/iot-edge/support). The official Microsoft install steps list separate Ubuntu 24.04 and 22.04 Microsoft package repository configuration commands, but after you install the matching repository package, the runtime install command is the same for supported Ubuntu Server 24.04 and 22.04 devices: `sudo apt-get install aziot-edge`. No separate 24.04-specific `aziot-edge` install command is required. If you hit any package-resolution issue on 24.04, check the latest steps at /azure/iot-edge/how-to-provision-single-device-linux-symmetric.

> [!IMPORTANT]
> Before you install and provision IoT Edge, make sure the device can make outbound connections to required endpoints. Inbound ports aren't required for this exercise.
> 
> **IoT Edge device outbound access**
>
> Allow outbound access for package downloads, package dependency resolution, and container registry/image pulls. Use the ports required by the URLs in your environment; Microsoft package and registry endpoints use HTTPS `443`, while Ubuntu mirrors might use HTTP or HTTPS:
> 
> - Microsoft package downloads: `packages.microsoft.com`
> - Ubuntu APT repositories and mirrors configured on the device for Ubuntu OS packages and dependencies. Check the URIs in `/etc/apt/sources.list.d/ubuntu.sources` on Ubuntu 24.04, or `/etc/apt/sources.list` and files under `/etc/apt/sources.list.d/` on systems that use the older source-list format. Allow the configured Ubuntu mirror hosts, such as `archive.ubuntu.com`, `security.ubuntu.com`, regional mirrors, or organization-selected mirrors, or configure an internal APT mirror/proxy before you run `sudo apt-get update` or `sudo apt-get install`. Access to `packages.microsoft.com` alone isn't enough because dependency resolution can still require Ubuntu packages.
> - Microsoft Container Registry image pulls: `mcr.microsoft.com` and `*.data.mcr.microsoft.com`
> - Any configured module registry. For Azure Container Registry scenarios, allow the registry login server such as `*.azurecr.io` and backing storage endpoints such as `*.blob.core.windows.net`. The IoT Edge production checklist also lists `*.cdn.azcr.io` for some registry/image delivery paths; include it only when your scenario requires it and confirm the current list in the docs.
> - Conditional endpoints listed in the IoT Edge production checklist, such as `aka.ms` and `raw.githubusercontent.com`, if your installation automation, samples, or deployment process downloads files from those hosts. Check the current docs before finalizing strict firewall rules.
> - Optional Docker Hub pulls, such as the `registry:3` image if you use Docker Hub. Microsoft's IoT Edge production checklist lists `*.docker.io` for Docker Hub registry access, but strict-firewall environments shouldn't treat that as exhaustive. Test the exact `docker pull` commands you use and consult Docker's current allowlist if Docker Hub pulls fail.
>
> If the IoT Edge device uses a proxy, configure installation-time tools before this exercise's `wget`, `apt-get update`, and `apt-get install` commands. APT proxy or mirror settings (for example, APT `Acquire::http::Proxy`/`Acquire::https::Proxy` settings or admin-shell `http_proxy`/`https_proxy` variables) and `wget` proxy settings are separate from the IoT Edge/Moby daemon and module proxy configuration used after installation. Configuring the IoT Edge runtime or Moby daemon doesn't automatically make APT or `wget` work through a restricted network.
> 
> Allow outbound IoT Hub protocol traffic from the IoT Edge device to your hub endpoint, such as `<iot-hub-name>.azure-devices.net` or `*.azure-devices.net`: AMQP over port `5671` by default, or MQTT over port `8883` if configured. If your network blocks 5671 or 8883, configure IoT Edge to use AMQP or MQTT over WebSockets on outbound HTTPS `443`. Outbound 443 is also used by the IoT Edge device for plain HTTPS calls during installation and operation, including package downloads, MCR token/manifest fetches, and IoT Hub HTTPS. If you use Device Provisioning Service (DPS), also allow outbound HTTPS `443` to `global.azure-devices-provisioning.net`.
> 
> Allow outbound HTTPS `443` from the IoT Edge device and its modules to the Azure AI Speech REST endpoints used by this solution at runtime. The Camera Capture module calls Speech for text-to-speech synthesis. This lab uses a Speech resource in Southeast Asia, so restricted networks must allow:
>
> - Text-to-speech synthesis: `https://southeastasia.tts.speech.microsoft.com/cognitiveservices/v1`
> - Bearer-token exchange, if your configuration uses `Authorization: Bearer`: `https://southeastasia.api.cognitive.microsoft.com/sts/v1.0/issueToken`
>
> If you use a different Speech region, replace `southeastasia` with the selected Speech region identifier in both endpoints, such as `https://<speech-region>.tts.speech.microsoft.com/cognitiveservices/v1` and `https://<speech-region>.api.cognitive.microsoft.com/sts/v1.0/issueToken`. The Speech endpoint region must match the region of the Speech resource key or bearer token.
> 
> **Admin workstation, Azure CLI, Cloud Shell, and browser access**
>
> If you run Azure CLI, Cloud Shell, or the Azure portal from a restricted admin network, that admin environment also needs outbound access for sign-in and resource management. Examples include Microsoft Entra ID sign-in at `login.microsoftonline.com`, Azure Resource Manager at `management.azure.com`, and the Azure portal or Cloud Shell endpoints you use. These admin endpoints are separate from the IoT Edge runtime requirements on the device.
>
> For current IoT Edge firewall guidance, check the networking table in the [production checklist](/azure/iot-edge/production-checklist) and the [troubleshoot firewall and port configuration rules](/azure/iot-edge/troubleshoot#check-your-firewall-and-port-configuration-rules) guidance. If you use a proxy, also review [proxy support](/azure/iot-edge/how-to-configure-proxy-support).

1. Open the terminal on your Linux computer.

2. Install the Microsoft package repository configuration that matches your Ubuntu version.

   **Ubuntu Server 24.04**:

   ```bash
   wget https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
   sudo dpkg -i packages-microsoft-prod.deb
   rm packages-microsoft-prod.deb
   ```

   **Ubuntu Server 22.04**:

   ```bash
   wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
   sudo dpkg -i packages-microsoft-prod.deb
   rm packages-microsoft-prod.deb
   ```

### Install a container engine

Azure IoT Edge relies on an OCI-compatible container runtime. For production scenarios, use the Moby engine. The Moby engine is the container engine officially supported with Azure IoT Edge. Docker CE and Docker EE container images are compatible with the Moby runtime.

1. Update package lists on your device.

   ```bash
   sudo apt-get update
   ```

2. Install the Moby engine.

   ```bash
   sudo apt-get install moby-engine
   ```

3. Verify that Moby is reachable through the Docker-compatible CLI.

   ```bash
   docker version
   ```

   If `docker version` reports permission denied for `/var/run/docker.sock`, Moby is installed but your current user can't access the Docker-compatible daemon socket. For one-off, CLI-only Docker commands, you can rerun the command with `sudo`, such as `sudo docker version`. For the VS Code build-and-push workflow, `sudo` isn't enough because VS Code tasks and extensions need Docker access as the signed-in user. Configure user-level Docker access before building module images: add the account to the `docker` group, for example with `sudo usermod -aG docker $USER`, then sign out and sign back in, or reconnect your Remote-SSH session; or use an organization-approved rootless Docker-compatible development engine on a separate development machine. Membership in the `docker` group grants root-equivalent access to the host, so follow your organization's security policy. This lab's IoT Edge runtime still uses Moby as installed in this exercise.

### Optional: limit container log growth

For persistent devices, configure the container engine default logging driver so module logs don't grow without bounds. For short-lived lab VMs, you can skip this optional step.

```bash
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json > /dev/null <<'EOF'
{
  "log-driver": "local",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}
EOF
sudo systemctl restart docker
```

The `moby-engine` package registers as the `docker` systemd service, so `sudo systemctl restart docker` is the correct command to apply daemon.json changes.

Restarting the container engine stops running containers. In this exercise, do this before applying the IoT Edge configuration.

## Install the IoT Edge runtime

The IoT Edge service provides and maintains security standards on the IoT Edge device. The service starts on every boot and bootstraps the device by starting the rest of the IoT Edge runtime. Current IoT Edge packages use `aziot-edge`, which also uses the Azure IoT identity service for device identity provisioning and management.

1. Update package lists on your device.

   ```bash
   sudo apt-get update
   ```

2. Install the latest IoT Edge runtime.

   ```bash
   sudo apt-get install aziot-edge
   ```

## Provision the device with its cloud identity

### Authenticate with symmetric keys

At this point, the IoT Edge runtime is installed on your Linux device, and you need to provision the device with its cloud identity and authentication information. Use the device connection string that you retrieved from IoT Hub earlier in this exercise.

> [!IMPORTANT]
> This lab uses manual provisioning with a symmetric-key device connection string to keep setup simple for a single device. Treat the connection string as a secret: keep it private, don't paste it into shared logs, and don't commit it to source control. For production or fleet scenarios, use DPS with X.509 certificates or another production-ready attestation approach instead of manually copying device connection strings.

1. Configure manual provisioning with the device connection string.

   ```bash
   sudo iotedge config mp --connection-string '<device-connection-string>'
   ```

   Replace `<device-connection-string>` with the full connection string from the `az iot hub device-identity connection-string show` command. Keep the single quotation marks around the connection string so Bash doesn't interpret semicolons in the value.

2. Apply the configuration.

   ```bash
   sudo iotedge config apply
   ```

## Verify successful configuration

Verify that the runtime was successfully installed and configured on your IoT Edge device.

> [!TIP]
> Use `sudo` with `iotedge` commands until you sign out of the device and sign back in after installing the runtime.

1. Check that the IoT Edge system services are running.

   ```bash
   sudo iotedge system status
   ```

   A successful status response shows the `aziot` services as running or ready.

2. Run the IoT Edge troubleshooting checks to verify configuration and connection.

   ```bash
   sudo iotedge check
   ```

   On a newly provisioned device, `iotedge check` might report that the deployment configuration isn't set or that the edgeHub container isn't running yet. These messages are expected until you deploy IoT Edge modules.

3. List the modules running on the device.

   ```bash
   sudo iotedge list
   ```

   Before you deploy modules, the device usually shows only the `edgeAgent` module. After modules are deployed, rerun `sudo iotedge list` to confirm that `edgeAgent`, `edgeHub`, and your solution modules are running.
