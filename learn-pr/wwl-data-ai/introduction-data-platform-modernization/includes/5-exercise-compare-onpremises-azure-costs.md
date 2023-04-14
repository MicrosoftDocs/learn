The Total Cost of Ownership (TCO) is one tool that you can use during a data platform modernization project to assess the cost difference the migration can make.

In your global retailer, Data Platform Modernization is expected to realize significant savings but the board of directors has asked you to estimate the savings as precisely as possible.

Here, you'll calculate the Total Cost of Ownership (TCO) of migrating to Azure by using the TCO calculator.

## Calculate the TCO

1. Open a new browser tab and navigate to [Azure TCO Calculator](https://azure.microsoft.com/pricing/tco/calculator/).
1. Under **Define your workloads**, delete any existing workloads in the **Servers** section.

### Enter the database workload

1. Under **Databases**, select **+ Add database**.
1. In the **Name** textbox, type **Accounting**.
1. In the **Source** section, choose these values:

    | Property | Value |
    | --- | --- |
    | Database | **Microsoft SQL Server** |
    | License | **Enterprise** |
    | Environment | **Physical Servers** |
    | Operating system | **Windows** |
    | Operating System License | **Datacenter** |
    | Servers | **1** |
    | Procs per server | **1** |
    | Core(s) per proc | **4** |
    | RAM (GB) | **64** |
    | Optimize by | **CPU** |
    | SQL Server 2008/2008R2 | **Toggle to select this value** |

1. In the **Destination** section, choose these values:

    | Property | Value |
    | --- | --- |
    | Service | **SQL Server VM** |
    | Disk type | **SSD** |
    | IOPS | **5000** |
    | SQL Server storage | **32 GB** |
    | SQL Server Backup | **32 GB** |

    > [!NOTE]
    > SSDs are recommended for production workloads in Azure.

### Enter the storage and networking workloads

1. Under **Storage**, select **+ Add storage**.
1. In the **Name** textbox, type **Accounting Local Disks**, and then enter these values:

    | Property | Value |
    | --- | --- |
    | Storage Type | **Local Disk/SAN** |
    | Disk Type | **HDD** |
    | Capacity | **3 TB** |
    | Backup | **1 TB** |
    | Archive | **0 TB** |

1. Under **Networking**, in the **Outbound bandwidth** controls, select **1 GB**.
1. At the bottom of the page, select **Next**.

### Adjust assumptions

1. In the **Adjust assumptions** section, in the **Currency** list, select your preferred currency.
1. Under **Software Assurance coverage (provides Azure Hybrid Benefit)**, select **Windows Server Software Assurance coverage** by enabling the toggle.
1. Select **SQL Server Software Assurance coverage** by enabling the toggle.

    > [!NOTE]
    > You can use the links provided in the **Software Assurance** section to learn more about the assurance that is available. 

1. Under **Geo-redundant storage (GRS)**, ensure that **GRS replicates your data to a secondary region that is hundreds of miles away from the primary region** isn't enabled.
1. Under **Virtual Machine costs**, ensure that **Enable this for the Calculator to not recommend Bs-series virtual machines** is enabled.

    > [!NOTE]
    > The B-series virtual machines don't have the memory-to-vCore ratio of 8 that is recommended for SQL Server workloads.

1. Under **Electricity costs**, in the **Price per KW hour** textbox, enter a realistic value for your location.

    > [!NOTE]
    > You can find approximate electricity prices at [Global electricity prices](https://www.statista.com/statistics/263492/electricity-prices-in-selected-countries/). These prices are in USD ($). Convert them to an approximate value in your preferred currency.

1. Under **Storage costs**, leave all the values at their defaults, or adjust them if they seem unreasonable.
1. Under **IT labor costs**, leave all the values at their defaults, or adjust them if they seem unreasonable.
1. Under **Other assumption**, expand each section and look at the associated costs.
1. At the bottom of the page, select **Next**.

### Investigate the five-year report

1. On the **View report** page, note that the **Timeframe** defaults to **5 years**.
1. Scroll down the report and investigate the estimated breakdown of costs for on-premises systems and Azure. Make a note of this information:

    - What is the most significant cost component of on-premises?
    - What are the largest costs saving if you decide to migrate to Azure?

1. Expand each section in turn and investigate the breakdown of costs.

### Investigate the three-year report

1. Scroll to the top of the page and then, in the **Timeframe** textbox, select **3 years**.
1. Scroll down the report and investigate the estimated breakdown of costs for on-premises systems and Azure. Make a note of this information:

    - What is the most significant cost component of on-premises?
    - What are the largest costs saving if you decide to migrate to Azure?

1. Expand each section in turn and investigate the breakdown of costs.

You've used the Azure TCO calculator to identify cost differences between on-premises and Azure deployments for Adatum Corporation's Accounting server and its associated databases.
