All tasks in this lab are performed from the Azure portal (including the PowerShell Cloud Shell session).

> [!NOTE]
> When not using Cloud Shell, the lab virtual machine must have the [Az PowerShell](/powershell/azure/install-az-ps-msi) module installed.

Lab files: none

## Scenario

In preparation for deployment of SAP NetWeaver on Azure, with SQL Server as the database management system, Adatum Corporation wants to explore the process of implementing clustering on Azure Virtual Machines running Windows Server 2019.

## Objectives

After completing this lab, you'll be able to:

- Provision Azure compute resources necessary to support highly available SAP NetWeaver deployments.
- Configure the operating system of Azure Virtual Machines running Windows Server 2019 to support a highly available SAP NetWeaver deployment.
- Provision Azure network resources necessary to support highly available SAP NetWeaver deployments.

## Requirements

- A Microsoft Azure subscription with the sufficient number of available DSv2 and Dsv3 vCPUs (one Standard\_DS1\_v2 virtual machine with 1 vCPU and 4 Standard\_D4s\_v3 virtual machines with 4 vCPUs each) in the Azure region you intend to use for this lab.
- A lab computer with an Azure Cloud Shell-compatible web browser and access to Azure.

> [!NOTE]
> Consider using **East US** or **East US2** regions for deployment of your resources.

## Exercises

During this lab ([full instructions on GitHub](https://go.microsoft.com/fwlink/?linkid=2261021&clcid=0x409)) you complete the following exercises:

- Exercise 1: Provision Azure compute resources necessary to support highly available SAP NetWeaver deployments
- Exercise 2: Configure operating system of Azure Virtual Machines running Windows Server 2019 to support a highly available SAP NetWeaver installation
- Exercise 3: Provision Azure network resources necessary to support highly available SAP NetWeaver deployments
- Exercise 4: Remove lab resources
