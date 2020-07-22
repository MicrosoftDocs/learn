## Exercise - Use the Azure TCO Calculator

Tailwind Traders is interested in moving some of their on-premises workloads to the cloud, but the Chief Financial Officer is concerned about committing to an ongoing monthly cost.  You've been asked to investigate if there are any potential cost savings, taking into account all of the costs involved with operating a technology workload. 

Instead of writing a list of all the things you think may be included, you will use the Total Cost of Ownership as a basis, and you will adjust the provided cost assumptions to match the Tailwind Traders on-premises environment.     

> [!Note]
> This exercise does not require an Azure subscription. You will only need a web browser with internet access to complete this.

## Configure the TCO calculator

In this task, you will add the details of the existing on-premise servers - two physical servers hosting 50 virtual machines each and 60Tb of disk storage. 

1. In a browser, navigate to the [Total Cost of Ownership (TCO) Calculator](https://azure.microsoft.com/pricing/tco/calculator?azure-portal=true) page.

2. Click **+ Add server workload** in the **Define your workloads** pane.

    | Settings | Value |
    | -- | -- |
    | Name | **Servers: Windows VMs** |
    | Workload | **Windows/Linux server** |
    | Environment | **Virtual Machines** |
    | Operating system | **Windows** |  
    | VMs | **50** |
    | Virtualization | **Hyper-V** |
    | Core(s) | **8**|
    | RAM (GB) | **16** |
    | Optimize by | **CPU** |
    | Windows Server 2008/2008 R2 | **Off** |
    | | |

3. Select **+ Add server workload** to make a row for a new server workload definition. 

    | Settings | Value |
    | -- | -- |
    | Name | **Servers: Linux VMs** |
    | Workload | **Windows/Linux server** |
    | Environment | **Virtual Machines** |
    | Operating system | **Linux** |  
    | VMs | **50** |
    | Virtualization | **VMware** |
    | Core(s) | **8**|
    | RAM (GB) | **16** |
    | Optimize by | **CPU** |
    | | |

4. In the **Storage** pane, click **Add storage**.

    | Settings | Value |
    | -- | -- |
    | Name | **Server Storage** |
    | Storage type | **Local Disk/SAN** |
    | Disk type | **HDD** |
    | Capacity | **60 TB** |  
    | Backup | **120 TB** |
    | Archive | **0 TB** |
    | | |

5. In the **Networking** pane, add bandwidth. 

    | Settings | Value |
    | -- | -- |
    | Outbound bandwidth | 15 TB|
    | | |

6. Click **Next**.

7. Review the options and cost assumptions and make any adjustments that you would like. 

    | Settings | Value |
    | -- | -- |
    | Currency | **Euro** |
    | | |

8. Click **Next**.

## View the report and save a copy

1. Review the estimated cost savings in Azure, then change the timeframe and region to see the results.

    | Settings | Value |
    | -- | -- |
    | Timeframe| **Three years** |
    | Region | **North Europe** |
    | | |

2. Note the cost breakdown summary and review the details of each section under Estimated cost.

3. To modify any information you have provided, go to the bottom of the page, and click **Back**. 

4. To download or print a PDF copy of the report, click **Download**.

![Screenshot of the report pane of the TCO Calculator in Azure. The highlighted and completed input fields indicates how set the TCO Calculator timeframe to three years and the region to North Europe. A graph shows the cost of on-premises infrastructure and workloads off-set against the reduced cost of using Azure.](../media/2001.png)

Congratulations! You now have the information that the Chief Financial Officer needs, to compare the ongoing operating costs of your workloads on-premises to the costs of running them in Azure.