All tasks in this lab are performed from the Azure portal (including a PowerShell Cloud Shell session).

> [!NOTE]
> When not using Cloud Shell, the lab virtual machine must have the [Az PowerShell](/powershell/azure/install-az-ps-msi) module installed.

Lab files: none

## Scenario

In preparation for deployment of SAP NetWeaver on Azure, Adatum Corporation wants to implement a demo that illustrates highly available implementation of SAP NetWeaver on Azure Virtual Machines running Windows Server 2016.

## Objectives

After completing this lab, you'll be able to:

- Provision Azure resources necessary to support a highly available SAP NetWeaver deployment.
- Configure operating system of Azure Virtual Machines running Windows to support a highly available SAP NetWeaver deployment.
- Configure clustering on Azure Virtual Machines running Windows to support a highly available SAP NetWeaver deployment.

## Requirements

- A Microsoft Azure subscription with the sufficient number of available DSv2 and Dsv3 vCPUs (four Standard\_DS1\_v2 virtual machines with 1 vCPU and 6 Standard\_D4s\_v3 virtual machines with 4 vCPUs each) in an Azure region that supports availability zones.
- A lab computer with an Azure Cloud Shell-compatible web browser and access to Azure.

## Exercises

During this lab ([full instructions on GitHub](https://go.microsoft.com/fwlink/?linkid=2261023&clcid=0x409)) you complete the following exercises:

- Exercise 1: Provision Azure resources necessary to support highly available SAP NetWeaver deployments
- Exercise 2: Configure operating system of Azure Virtual Machines running Windows to support a highly available SAP NetWeaver deployment
- Exercise 3: Remove lab resources
