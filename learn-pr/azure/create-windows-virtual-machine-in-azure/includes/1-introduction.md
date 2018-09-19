Imagine you work for a company that does video data processing and pattern analysis. You are building a new prototype platform to process the video from traffic cameras, analyze trends, and provide actionable data for traffic and road improvements. 

To improve your algorithms, you have made arrangements with several new cities to collect their traffic camera data. However not all of the video data is in the same format, and many of the formats only have Windows codecs to decode the data. Because of this, you have decided to use Virtual Machines (VMs) to do the initial processing and then push the data onto Azure Functions that will process a standard format. This approach will allow you to bring on new data formats dynamically without stopping the entire system.

Azure provides a robust virtual machine hosting solution that can meet your needs. Let's explore how to create and work with Windows virtual machines in Azure.

## Learning objectives

In this module, you will:

- Understand the options that are available for virtual machines in Azure.
- Create a Windows virtual machine using the Azure portal.
- Connect to a running Windows virtual machine using Remote Desktop.
- Install software and change the network configuration on a VM using the Azure portal.

## Prerequisites

- Basic understanding of Azure Virtual Machines from **Introduction to Azure Virtual Machines**
- Remote Desktop client