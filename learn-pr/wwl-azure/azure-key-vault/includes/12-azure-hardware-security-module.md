Azure Dedicated HSM is an Azure service that provides cryptographic key storage in Azure. Dedicated HSM meets the most stringent security requirements. It's the ideal solution for customers who require FIPS 140-2 Level 3-validated devices and complete and exclusive control of the HSM appliance.

## Best fit

Azure Dedicated HSM is most suitable for “lift-and-shift” scenarios that require direct and sole access to HSM devices. Examples include:

 -  Migrating applications from on-premises to Azure Virtual Machines
 -  Migrating applications from Amazon AWS EC2 to virtual machines that use the AWS Cloud HSM Classic service
 -  Running shrink-wrapped software such as Apache/Ngnix SSL Offload, Oracle TDE, and ADCS in Azure Virtual Machines

## Not a fit

Azure Dedicated HSM is not a good fit for the following type of scenario: Microsoft cloud services that support encryption with customer-managed keys (such as Azure Information Protection, Azure Disk Encryption, Azure Data Lake Store, Azure Storage, Azure SQL Database, and Customer Key for Office 365) that are not integrated with Azure Dedicated HSM.
