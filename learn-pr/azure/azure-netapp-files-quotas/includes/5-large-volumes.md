The following requirements and considerations apply to large volumes.

* A regular volume can’t be converted to a large volume.
* You must create a large volume at a size of 50 TiB or larger. A single volume can't exceed 1 PiB.  
* You can't resize a large volume to less than 50 TiB.
    A large volume cannot be resized to more than 30% of its lowest provisioned size. 
* Large volumes are currently not supported with Azure NetApp Files backup.
* You can't create a large volume with application volume groups.
* Currently, large volumes aren't suited for database (HANA, Oracle, SQL Server, etc.) data and log volumes. For database workloads requiring more than a single volume’s throughput limit, consider deploying multiple regular volumes.
* Throughput ceilings for the three performance tiers (Standard, Premium, and Ultra) of large volumes are based on the existing 100-TiB maximum capacity targets. You're able to grow to 1 PiB with the throughput ceiling per the following table:  

    | Capacity tier	| Volume size (TiB) | Throughput (MiB/s) |
    | -- | -- | -- |
    | Standard	| 50-2048 | 12,800 |
    | Premium | 50 to 2048 | 12,800 |
    | Ultra | 50 to 2048 | 12,800 |

>[!NOTE]
>Regular volumes use 32-bit file IDs, large volumes employ 64-bit file IDs. File IDs are unique identifiers that allow Azure NetApp Files to keep track of files in the file system. 64-bit IDs are utilized to increase the number of files allowed in a single volume, enabling a large volume able to hold more files than a regular volume.