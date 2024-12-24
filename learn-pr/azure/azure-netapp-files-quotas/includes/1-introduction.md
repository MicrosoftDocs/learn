Understanding volume quotas is essential to managing your Azure NetApp Files workloads. The storage capacity of an Azure NetApp Files volume is limited to the set size (quota) of the volume. Understand these key qualities of volume quotas:

* When volume consumption maxes out, neither the volume nor the underlying capacity pool grows automatically. Instead, the volume receives an "out of space" condition. You can resize the capacity pool or a volume as needed. You should actively monitor the capacity of a volume and the underlying capacity pool.
* Depending on the capacity pool type, the size (quota) of an Azure NetApp Files volume has an impact on its bandwidth performance and the provisioned capacity.  
* The capacity consumed by volume snapshots counts towards the provisioned space in the volume.
* Volume quota doesn't apply to a replication destination volume.