Estimated time: 120 minutes

All tasks in this lab are performed from the Azure portal (including the PowerShell Cloud Shell session).

> [!NOTE]
> When not using Cloud Shell, the lab virtual machine must have the [Az PowerShell](/powershell/azure/install-az-ps-msi) module installed.

Lab files: none

## Scenario

In preparation for deployment of SAP NetWeaver on Azure, with SQL Server as the database management system, Adatum Corporation wants to explore the process of implementing clustering on Azure VMs running Windows Server 2019.

## Objectives

After completing this lab, you will be able to:

 -  Provision Azure compute resources necessary to support highly available SAP NetWeaver deployments.
 -  Configure the operating system of Azure VMs running Windows Server 2019 to support a highly available SAP NetWeaver deployment.
 -  Provision Azure network resources necessary to support highly available SAP NetWeaver deployments.

## Requirements

 -  A Microsoft Azure subscription with the sufficient number of available DSv2 and Dsv3 vCPUs (one Standard\_DS1\_v2 VM with 1 vCPU and four Standard\_D4s\_v3 VMs with 4 vCPUs each) in the Azure region you intend to use for this lab.
 -  A lab computer with an Azure Cloud Shell-compatible web browser and access to Azure.

> [!NOTE]
> Consider using **East US** or **East US2** regions for deployment of your resources.

## Exercises

During this lab ([full instructions on GitHub](https://github.com/MicrosoftLearning/AZ-120-Planning-and-Administering-Microsoft-Azure-for-SAP-Workloads/blob/master/Instructions/AZ-120_Lab01b-Azure_VM_Windows_Clustering.md)) you will complete the following exercises:

 -  Exercise 1: Provision Azure compute resources necessary to support highly available SAP NetWeaver deployments
 -  Exercise 2: Configure operating system of Azure VMs running Windows Server 2019 to support a highly available SAP NetWeaver installation
 -  Exercise 3: Provision Azure network resources necessary to support highly available SAP NetWeaver deployments
 -  Exercise 4: Remove lab resources
