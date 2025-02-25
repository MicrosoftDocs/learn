From volume sizes to throughputs, Azure NetApp Files has numerous limits that you should understand and consult. Bookmark [Azure NetApp Files resources limits](/azure/azure-netapp-files/azure-netapp-files-resource-limits) to remain cognizant of these limits 

## Determine if a directory is approaching the limit size 

For a 320-MiB directory, the number of blocks is 655360, with each block size being 512 bytes. (That is, 320x1024x1024/512.) This number translates to approximately 4-5 million files maximum for a 320-MiB directory. However, the actual number of maximum files might be lower, depending on factors such as the number of files with non-ASCII characters in the directory.

You can use the `stat` command from a client to see whether a directory is approaching the maximum size limit for directory metadata (320 MB). If you reach the maximum size limit for a single directory for Azure NetApp Files, the error No space left on device occurs.

For a 320-MB directory, the number of blocks is 655,360, with each block size being 512 bytes. (That is, 320x1024x1024/512.) This number translates to approximately 4 million files maximum for a 320-MB directory. However, the actual number of maximum files might be lower, depending on factors such as the number of files with non-ASCII characters in the directory

## `maxfiles` limits in Azure NetApp Files

Azure NetApp Files volumes have a value called `maxfiles` that refers to the maximum number of files and folders (also known as inodes) a volume can contain. When the `maxfiles` limit is reached, clients receive "out of space" messages when attempting to create new files or folders. If you experience this issue, contact Microsoft technical support.

The `maxfiles` limit for an Azure NetApp Files volume is based on the size (quota) of the volume, where the service dynamically adjusts the `maxfiles` limit for a volume based on its provisioned size and uses the following guidelines.

- For regular volumes less than or equal to 683 GiB, the default `maxfiles` limit is 21,251,126.
- For regular volumes greater than 683 GiB, the default `maxfiles` limit is approximately one file (or inode) per 32 KiB of allocated volume capacity up to a maximum of 2,147,483,632.
- For [large volumes](/azure/azure-netapp-files/large-volumes-requirements-considerations), the default `maxfiles` limit is approximately one file (or inode) per 32 KiB of allocated volume capacity up to a default maximum of 15,938,355,048.
- Each inode uses roughly 288 bytes of capacity in the volume. Having many inodes in a volume can consume a non-trivial amount of physical space overhead on top of the capacity of the actual data.
    - If a file is less than 64 bytes in size, it's stored in the inode itself and doesn't use additional capacity. This capacity is only used when files are actually allocated to the volume.
    - Files larger than 64 bytes do consume additional capacity on the volume. For instance, if there are one million files greater than 64 bytes in an Azure NetApp Files volume, then approximately 274 MiB of capacity would belong to the inodes.

The following table shows examples of the relationship `maxfiles` values based on volume sizes for regular volumes. 

| Volume size | Estimated `maxfiles` limit |
| - | - |
| 0 – 683 GiB | 21,251,126 |
| 1 TiB (1,073,741,824 KiB) | 31,876,709 |
| 10 TiB (10,737,418,240 KiB) | 318,767,099 |
| 50 TiB (53,687,091,200 KiB)	| 1,593,835,519 |
| 100 TiB (107,374,182,400 KiB) | 2,147,483,632 |

The following table shows examples of the relationship `maxfiles` values based on volume sizes for large volumes. 

| Volume size | Estimated `maxfiles` limit |
| - | - |
| 50 TiB (53,687,091,200 KiB) |	1,593,835,512 |
| 100 TiB (107,374,182,400 KiB)	| 3,187,671,024 |
| 200 TiB (214,748,364,800 KiB)	| 6,375,342,024  |
| 500 TiB (536,870,912,000 KiB)	| 15,938,355,048 |

To see the `maxfiles` allocation for a specific volume size, check the **Maximum number of files** field in the volume’s overview pane.

You can't set `maxfiles` limits for data protection volumes via a quota request. Azure NetApp Files automatically increases the `maxfiles` limit of a data protection volume to accommodate the number of files replicated to the volume. 

## Request a limit increase 

Certain Azure NetApp Files limits can be increased by filing a request. For information on that process, see the [Azure NetApp Files documentation](/azure/azure-netapp-files/azure-netapp-files-resource-limits#request-limit-increase).