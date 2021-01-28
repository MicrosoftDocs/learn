As the administrator for the autonomous vehicle company, you need an easy, secure, and relatively inexpensive way to regularly import the enormous amounts of telemetry data that your vehicles generate every day. But you can't dedicate your entire network bandwidth to the task. You decide to look at the Azure Data Box family, an ensemble of physical and virtual devices that aims to solve this type of problem. Each device is designed to meet the slightly different needs and priorities of customers looking for a solution in this space.

In this unit, you'll learn about the five products in the Azure Data Box family.

## Azure Data Box products

The Azure Data Box family can be divided into two groups, for *offline* and *online* data transfer. Offline data transfer allows you to move large amounts of data to Azure whenever you have time, network bandwidth, or cost constraints. Because your organization doesn't want to tie up its network bandwidth while shifting the vehicle data to Azure, this solution might be ideal.

### Offline data transfer

The devices in the offline grouping include:

- **Data Box Disk**: Provides one ~35-TB transfer to Azure. Connect and copy data over USB.
- **Data Box**: Provides one ~80-TB transfer to Azure per order. Connect and copy data to the device over standard network interface protocols like SMB and NFS.
- **Data Box Heavy**: Provides one ~800-TB transfer to Azure. Use high-throughput network interfaces to connect and copy data to the device. This process uses standard network interface protocols like SMB and NFS. Data Box Heavy is like two Data Boxes, each with an independent node.

### Online data transfer

Online data transfer enables a link between your on-premises assets and Azure. Transferring huge amounts of data to Azure is similar to copying data to a networking share. Online data transfer is ideal when you need a continuous link to transfer a massive amount of data.

- **Data Box Gateway**: This device is an entirely virtual appliance. It's based on a virtual machine that you provision in your on-premises environment.

Having considered all these devices, you decide to focus on Azure Data Box Disk. It's a physical device that enables you to send terabytes of data quickly, cheaply, and securely. You can install the devices in the autonomous vehicles and upload data even while the car sensors are generating it.
