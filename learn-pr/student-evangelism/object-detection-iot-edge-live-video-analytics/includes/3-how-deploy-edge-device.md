In this module, the original lab used an Ubuntu-based virtual machine to act as an IoT Edge device. You can still use Azure IoT Edge for supported workloads, but current deployments should use IoT Edge 1.5 LTS and a supported platform from the IoT Edge support matrix. Tier 1 Linux-container hosts include Debian 12 on AMD64, ARM32v7, or ARM64; Debian 11 on ARM32v7; Red Hat Enterprise Linux 8 or 9 on AMD64; Ubuntu Server 22.04 or 24.04 on AMD64 or ARM64; and Ubuntu Core on AMD64 or ARM64. IoT Edge for Linux on Windows is the supported option for Windows hosts. Some combinations, such as Ubuntu Server ARM32v7 or Debian 11 on AMD64 or ARM64, are Tier 2 and are community-supported with best-effort Microsoft support. Windows containers are no longer supported.

> [!NOTE]
> The video analytics workload in this module is historical and non-runnable because it depends on retired services and archived sample assets. The IoT Edge device concepts in this unit remain useful when aligned with current IoT Edge 1.5 LTS guidance.

## Overview

First, configure the device as an IoT Edge device and set up communication between IoT Edge and IoT Hub. To set up the communication between IoT Hub and IoT Edge, the original lab used a device connection string during configuration. This string associates your physical or virtual device with the IoT Edge device identity in Azure.

> [!CAUTION]
> Treat an IoT Hub device connection string as a secret. It contains authentication information for the device. Don't share it, screenshot it, write it to logs, or commit it to source control. Store it only temporarily in a secure location, rotate the device keys after a lab, or delete the lab device identity. For production, prefer X.509 certificate authentication or Device Provisioning Service patterns where appropriate.

The original lab opened TCP port 8181 for a web application on the edge VM. Exposing an unauthenticated HTTP endpoint on a public IP address is risky. If you use a similar lab-only web UI, reach it through a VPN or private network, SSH local port forwarding over an approved SSH path, or a tightly scoped temporary network security group (NSG) rule from a trusted source. Azure Bastion provides SSH/RDP connectivity to the VM; it isn't a direct HTTP relay for browsing `http://<vm>:8181`. Production web endpoints should use TLS, authentication, and a private or otherwise controlled network path.

The VM management path needs the same protection. Don't leave SSH (TCP 22) open to **Any** on a public IP address. Prefer Azure Bastion, VPN, a private IP path, or Microsoft Defender for Cloud just-in-time VM access. If public SSH is unavoidable for a short lab, restrict the source to your current public IP address or CIDR range at VM creation time, remove the rule when you finish, and avoid password authentication.

If you deploy the VM on a private IP address, it still needs outbound internet access for package download commands such as `wget` and `apt-get` unless you use a validated offline installation path. Provide controlled egress through a NAT Gateway, firewall or network virtual appliance route, or a deliberately configured Standard public IP address, and keep inbound management access restricted.

Before you begin, if you don't have an active Azure subscription, create a free account or use a pay-as-you-go subscription.

## Steps to follow

You'll complete the following steps to deploy an edge device for the historical lab:

1. Define the resource group or use a pre-existing one
2. Create an Azure IoT Hub or use an existing one
3. Register the IoT Edge device to IoT Hub
4. Create an Azure IoT Edge device on a supported IoT Edge 1.5 LTS host, with SSH restricted to a trusted source or reached through private access
5. Configure an IoT Edge device by using a device credential securely
6. If required for a temporary lab, open TCP port 8181 only from a trusted source, or use VPN/private network access or SSH local port forwarding instead

## What's a resource group?

A resource group is a container that holds related resources for a solution. The resource group includes resources that you want to manage as a group. You logically group related resources such as storage accounts, virtual networks, and virtual machines to deploy, manage, and maintain them as a single entity.

## How to create IoT Hub

Azure IoT Hub enables communication between the virtual device and the cloud. Creating an IoT Hub involves the following required properties:

- Define a unique name of the IoT Hub
- Choose the resource group to be deployed

To create a new Azure IoT Hub with the Azure CLI, use the **az iot hub create** command set. Only one free IoT hub instance is allowed in each subscription. The free tier of IoT Hub works for simple exercises. If you've used IoT Hub in the past and already have a free hub created, you can use that IoT hub or select a paid tier.

## Register the IoT Edge device to IoT Hub

The registration process of an IoT device involves creating a device identity in IoT Hub for your edge device. This device identity enables you to communicate with your IoT Hub. The device identity lives in the cloud and uses credentials to associate a physical or virtual device with a device identity. You'll need the following properties:

- Define a unique name of the device
- Choose the IoT Hub to be deployed

To create a device in your hub, use the **az iot hub device-identity create** command set. Then use the **az iot hub device-identity connection-string show** command to retrieve a connection string for symmetric-key test scenarios. Copy the value only into a secure, temporary location. Rotate or delete the device credentials when you finish the lab.

## How to configure your IoT Edge device

The configuration of your IoT Edge device involves creating a virtual machine and installing the IoT Edge runtime on it. Use current IoT Edge 1.5 LTS installation guidance and select a supported operating system and architecture. In the original scenario, the edge device template took the following parameters:

- Choose a subscription
- Choose the resource group to be deployed
- Choose the region to deploy the virtual machine
- Define the DNS label prefix
- Define an admin username
- Enter the IoT Edge device credential that you retrieved in the previous step
- Enter the admin password or key

After deployment completes, connect to your edge device and check that the IoT Edge runtime is active.

## Add an inbound security rule

Only add an inbound rule for TCP port 8181 if you're intentionally running a temporary lab web UI and have no private access option. Use VPN/private network access or SSH local port forwarding for private browser access. Azure Bastion is useful for SSH/RDP management of the VM, but it doesn't directly proxy the HTTP lab UI. To create a safer rule, specify these parameters:

- **Source:** Your trusted public IP address, a specific CIDR range, or a private network range. Don't use **Any** for a public VM.
- **Source port ranges:** `*`
- **Destination:** The VM or network interface
- **Destination port ranges:** `8181`
- **Protocol:** `TCP`
- **Action:** `Allow`
- **Name:** A clear name such as `Allow_8181_From_MyIP_Temporary`

Delete the rule when the lab is complete. For production, use TLS, authentication, private connectivity, and a supported video analytics architecture instead of exposing the historical web UI to the internet.

