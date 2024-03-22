As the administrator for the autonomous vehicle company, you need an easy, secure, and relatively inexpensive way to regularly import the enormous amounts of telemetry data that your vehicles generate every day. However, you can't dedicate your entire network bandwidth to the task. You decide to look at the Azure Data Box family, an ensemble of physical and virtual devices that aims to solve this type of problem. Each device is designed to meet the slightly different needs and priorities of customers looking for a solution in this space.

In this unit, you learn about the products in the Azure Data Box family.

## Azure Data Box products

Data Box devices let you send terabytes of data into and out of Azure in a quick, inexpensive, and reliable way.

The Azure Data Box family can be divided into two groups, for *offline* and *online* data transfer. Offline data transfer allows you to move large amounts of data to Azure when you have time, network bandwidth, or cost constraints. Because your organization doesn't want to tie up its network bandwidth while shifting the vehicle data to Azure, this solution might be ideal.

### Offline data transfer

The devices in the offline grouping include:

- **Data Box Disk**: Provides one ~35-TB transfer to Azure. You connect and copy data over USB.
- **Data Box**: Provides one ~80-TB transfer to Azure per order. You connect and copy data to the device over standard network-interface protocols like SMB and NFS.
- **Data Box Heavy**: Provides one ~800-TB transfer to Azure. You use high-throughput network interfaces to connect and copy data to the device. This process uses standard network-interface protocols like SMB and NFS. Data Box Heavy is like two Data Boxes, each with an independent node.

### Online data transfer

Online data transfer enables a link between your on-premises assets and Azure. Transferring huge amounts of data to Azure is similar to copying data to a networking share. Online data transfer is ideal when you need a continuous link to transfer a massive amount of data.

- **Data Box Gateway**: This device is an entirely virtual appliance. It's based on a virtual machine that you provision in your on-premises environment.

## Security protections

Data Box devices have built-in security protections for the device, data, and the service.

Data Box Disk has the following security protections:

- The disks are tamper-resistant and support secure update capability.
- The data on the disks is secured with an AES 128-bit encryption at all times.
- The disks can only be unlocked with a key provided in the Azure portal.
- The service is protected by the Azure security features.
- Once your data is uploaded to Azure, the disks are wiped clean in accordance with NIST 800-88r1 standards.

Data Box and Data Box Heavy have the following security protections:

- The device has a rugged casing secured by tamper-resistant screws and tamper-evident stickers.
- The data on the device is secured with an AES 256-bit encryption at all times.
- The device can only be unlocked with a password provided in the Azure portal.
- The service is protected by the Azure security features.
- Once the data from your import order is uploaded to Azure, the disks on the device are wiped clean in accordance with NIST 800-88r1 standards.

For Data Box export orders, the disks are erased after the device reaches the Azure datacenter.

## Track and audit your orders

At each step in the ordering process, you can take actions to control the access to the order, audit the events, track the order, and interpret the various logs that are generated.

The following table shows a summary of the Data Box or Data Box Heavy import-order steps and the tools available to track and audit the order during each step.

| Data Box import order stage       | Tool to track and audit                                                                        |
|----------------------------|------------------------------------------------------------------------------------------------|
| Create order               | Set up access control on the order by using Azure role-based access control (Azure RBAC)                                                   |
| Order processed            | Track the order through <ul><li> Azure portal </li><li> Shipping carrier website </li><li>Email notifications</ul> |
| Set up device              | View Activity logs to see device credentials access                                             |
| Data copy to device        | View *error.xml* files for data copy                                                           |
| Prepare to ship            | Inspect the BOM files or the manifest files on the device                                      |
| Data upload to Azure       | Review copy logs for errors during data upload at Azure datacenter                      |
| Data erasure from device   | View chain-of-custody logs including audit logs and order history|
