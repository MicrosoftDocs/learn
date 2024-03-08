To install a scale-out SAP HANA, you need to perform the following high-level steps:

1. Create new or use an existing Azure virtual network.
2. Deploy virtual machines with managed Premium Storage disks.
3. Deploy new or use an existing highly available NFS cluster.
4. Validate that intra-node communication between virtual machines isn't routed through an NVA. The same must be true for traffic between the virtual machines and the highly available NFS cluster.
5. Install the SAP HANA leading node according to SAP's documentation.
6. After the installation, add the parameter `'basepath\_shared = no'` to the global.ini file. This parameter enables SAP HANA to run in scale-out without 'shared' **/hana/data** and **/hana/log** volumes between the nodes. Details are documented in [SAP Note \#2080991](https://me.sap.com/notes/2080991).
7. After changing the global.ini parameter, restart the SAP HANA instance.
8. Add more worker nodes.

For details, refer to [Add Hosts Using the Command-Line Interface](https://help.sap.com/viewer/6b94445c94ae495c83a19646e7c3fd56/2.0.00/0d9fe701e2214e98ad4f8721f6558c34.html).

Specify the internal network for SAP HANA inter-node communication during the installation or afterward using, for example, the local hdblcm. For details, refer to [SAP Note \#2183363](https://me.sap.com/notes/2183363).

Following this setup, the scale-out configuration you installed is going to use non-shared disks for running **/hana/data** and **/hana/log**. The **/hana/shared** volume is going to be placed on the highly available NFS share.
