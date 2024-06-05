This module guides you through the creation of the basic environment used in hybrid scenarios. This module consists of creating the following environments:

- An on-premises Active Directory environment
- A cloud based Microsoft Entra environment

:::image type="content" source="../media/prepare-6.png" alt-text="Diagram that shows a basic Microsoft Entra ID and on-premises environment." lightbox="../media/prepare-6.png":::

You can use the environment you create in this module to test various aspects of hybrid identity scenarios. This environment is also part of learning paths for identity technologies.

## Project overview

:::image type="content" source="../media/prepare-3.png" alt-text="Diagram shows progression of this module with introduction, prepare, three exercises with validation, a knowledge check, and summary.":::

As an IT administrator and decision maker you're often tasked with:

- Evaluating cloud solutions.
- Advising on moving current infrastructure to the cloud.
- Drafting plans and procedures for moving to the cloud.

In order to evaluate these solutions and scenarios, you need an environment that mimics your corporate environment. With this module, you build out a small sandbox environment that can be used to test for your environment. This environment allows you to:

- Make decisions about cloud solutions and deployments.
- Test solutions and scenarios for moving to the cloud.
- Familiarize yourself with various cloud technologies.

In order to complete this module, you need to perform a series of tasks. The key tasks are:

1. Create the folder structure used in the PowerShell scripts.
1. Download the PowerShell scripts.
1. Install Hyper-V.
1. Create a virtual machine that is your Active Directory domain controller.
1. Install Windows Server Active Directory.
1. Create a test user in Windows Server AD.
1. Create a Microsoft Entra tenant.

This article covers the first two tasks. These tasks allow you to prepare to run the PowerShell scripts and build the virtual machine.

## Create folder structure

This module uses PowerShell scripts to accomplish the goals of quickly setting up an on-premises environment. These scripts include hardcoded paths to specific files. You need to use either of the following approaches:

- Change the paths to ones that reflect your environment. For example: *$VHDPath = 'D:\\VM\\DC1\\DC1.vhdx'* might become *$VHDPath = 'C:\\VM\\DC1\\DC1.vhdx'* if you move the *VM* folder to the *C:\\* drive.
- Recreate the folder structure that is used in the scripts using the following table.

| Name    | Location | Description |
|:--------|:---------|:------------|
| ISO     | D:\      | Used to store the ISO images used for this module. |
| VM      | D:\      | Target location for the creation of the virtual machine used in this module. |
| Scripts | D:\      | Used to store the initial PowerShell script used to create the VM. |

## Download the scripts

This module uses PowerShell scripts so that you can create the environment in the quickest amount of time. Each of the scripts uses variables that are declared at the beginning of the scripts. These variables are explained in tables that introduce the exercise. You can change the variables to reflect your environment.

Versions of the PowerShell scripts that are used in this module are available on GitHub in [learn-module-basic-ad-azure-ad-scripts](https://github.com/billmath/learn-module-basic-ad-azure-ad-scripts). You should download the zip files and the ISO image.

The following table describes each of the PowerShell scripts contained both the *.iso* file and the *.zip* file.

| Script Name | Description |
|:------------|-------------|
| 1_CreateVM_LEARN.ps1   | Creates the virtual machine in Hyper-V. |
| 2_ADPrep_LEARN.ps1     | Renames the virtual machine, installs remote server administration tools, and sets the network settings. |
| 3_InstallAD_LEARN.ps1  | Install Active Directory on the server and setups the *contoso.com* domain. |
| 4_CreateUser_LEARN.ps1 | Creates a test user that can be used in various scenarios. |

Download the *.zip* file and extract the contents to the *D:\Scripts* folder. Download the *.iso* image to the *D:\ISO* folder.

> [!VIDEO https://msit.microsoftstream.com/embed/video/8e890840-98dc-b478-2c31-f1ecf1b0a78a?autoplay=false&amp;showinfo=true]
