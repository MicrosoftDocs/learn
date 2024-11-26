Throughput ceilings for the three Azure NetApp Files performance tiers (Standard, Premium, and Ultra) of large volumes are based on the existing 100-TiB maximum capacity targets. You can increase to 1 PiB with the throughput ceiling per the following table:

<table><thead>
    <tr>
    <th></th>
    <th colspan="2">Capacity</th>
    <th colspan="2">Linear performance scaling per TiB up to maximum allowed capacity tier throughput (large volume) </th>
    </tr></thead>
<tbody>
    <tr>
    <td>Capacity tier</td>
    <td>Minimum volume size<br>(TiB)</td>
    <td>Maximum volume size (TiB)</td>
    <td>Minimum throughput for capacity tier (MiB/s)</td>
    <td>Maximum throughput for capacity tier (MiB/s)</td>
    </tr>
    <tr>
    <td>Standard (16 MiB/s per TiB)</td>
    <td>50</td>
    <td>1,024</td>
    <td>800</td>
    <td>12,800</td>
    </tr>
    <tr>
    <td>Premium (64 MiB/s per TiB)</td>
    <td>50</td>
    <td>1,024</td>
    <td>3,200</td>
    <td>12,800</td>
    </tr>
    <tr>
    <td>Ultra (128 MiB/s per TiB)</td>
    <td>50</td>
    <td>1,024</td>
    <td>6,400</td>
    <td>12,800</td>
    </tr>
</tbody>
</table>

For the latest performance benchmark numbers conducted on Azure NetApp Files Large volumes, see [Azure NetApp Files large volume performance benchmarks for Linux](/azure/azure-netapp-files/performance-large-volumes-linux) and [Benefits of using Azure NetApp Files for Electronic Design Automation (EDA)](/azure/azure-netapp-files/performance-large-volumes-linux).

## 64-bit file IDs

Whereas regular volumes use 32-bit file IDs, large volumes employ 64-bit file IDs. File IDs are unique identifiers that allow Azure NetApp Files to keep track of files in the file system. 64-bit IDs are utilized to increase the number of files allowed in a single volume, enabling a large volume able to hold more files than a regular volume.
