Complete the following steps:

1. In the Azure portal, in the **DNS servers** pane, make sure that your virtual network DNS servers option is set to **Custom DNS**. Select your settings based on the type of network you have:

     - **Corporate network connectivity (cross-premises)**: Add the IP addresses of the on-premises DNS servers. It's recommended that you can extend the on-premises DNS environment by installing extra DNS servers in Azure Virtual Machines. In such a case, add the IP addresses of these Azure Virtual Machines.
     - **Virtual machine deployments that are isolated in Azure**: Deploy an extra Azure Virtual Machine in the same virtual network and configure them as DNS servers. Add the IP addresses of the Azure Virtual Machines that you've set up to run the DNS service.
2. You need the following reserved host names and IP addresses:

     - SAP ASCS/SCS first cluster virtual host name (for cluster management)
     - SAP ASCS/SCS instance virtual host name
     - SAP DBMS second cluster virtual host name (cluster management)
3. When you create the cluster, create the virtual host names and the associated IP addresses. The clustered SAP ASCS/SCS instance and the clustered DBMS instance use these resources.
4. After you deploy the Azure Virtual Machines to use in your cluster, you need to configure them with static IP addresses. Perform this task in the Azure Virtual Machine networking configuration, not in the guest operating system.

> [!IMPORTANT]
> The IP address of the virtual host name of the SAP ASCS/SCS is the same as the IP address of the SAP ASCS/SCS internal load balancer. The IP address of the virtual name of the DBMS is the same as the IP address of the DBMS internal load balancer.

## Active Directory domain configuration

After you assign static IP addresses to the Azure Virtual Machines, add the virtual machines to the domain.
