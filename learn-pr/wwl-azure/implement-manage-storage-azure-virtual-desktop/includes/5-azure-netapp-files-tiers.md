Azure NetApp Files volumes are organized in capacity pools. Volume performance is defined by the service level of the hosting capacity pool. Three performance levels are offered, ultra, premium and standard.

For more information, see [Storage hierarchy of Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-understand-storage-hierarchy).

Azure NetApp Files performance is [a function of tier times capacity](/azure/azure-netapp-files/azure-netapp-files-performance-considerations). More provisioned capacity leads to higher performance budget, which likely results in a lower tier requirement, providing a more optimal TCO.

The table lists our recommendations for which performance tier to use based on workload defaults.

| **Workload** | **Example Users**                                                 | **Azure NetApp Files**                                                                             |
| ------------ | ----------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| Light        | Users doing basic data entry tasks                                | Standard tier                                                                                      |
| Medium       | Consultants and market researchers                                | Premium tier: small-medium user count<br>Standard tier: large user count                           |
| Heavy        | Software engineers, content creators                              | Premium tier: small-medium user count<br>Standard tier: large user count                           |
| Power        | Graphic designers, 3D model makers, machines learning researchers | Ultra tier: small user count<br>Premium tier: medium user count<br>Standard tier: large user count |

In order to provision the optimal tier and volume size, consider using [this calculator](https://github.com/ANFTechTeam/Fslogix-Calculator) for guidance.
