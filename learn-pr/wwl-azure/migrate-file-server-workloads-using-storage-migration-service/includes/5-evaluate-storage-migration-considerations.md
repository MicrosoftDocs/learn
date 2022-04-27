Using Storage Migration Service to migrate data works well for most, but not all, scenarios. When using Storage Migration Service, you should consider the following:

- Locked files aren't migrated. If apps lock the files, the files won't be migrated when in use.

- You can't migrate the identity of domain controllers. If you're migrating file shares on a domain controller and want to migrate the domain controller identity, you should demote that domain controller to be a member server.

- Windows system files won't move to the PreExistingData folder on the destination server. For example, if you migrate a J:\Windows folder on the source server to C:\Windows on the destination server, Storage Migration Service won't migrate the folder. Other system files and folders, such as Program Files, Program Data, and Users are also protected.

- Server consolidation isn't supported. Storage Migration Service doesn't include logic to understand the dependencies involved in migrating shares from multiple servers to a single server. For example, there's no mechanism to support multiple source identities being applied to the target server.Data on New Technology File Systems (NTFS) must be migrated to NTFS on the target server. You can't migrate data from NTFS to Resilient File Systems (ReFS).

- Previous file versions aren't migrated. Many file servers have volume shadow copy enabled to allow easy restores of deleted or accidentally modified files. The previous versions retained in the volume shadow copies aren't migrated by Storage Migration Service.

In most cases, Storage Migration Service provides good performance for data transfer. However, to optimize performance you can do the following:

- Use Windows Server 2022 and Windows Server 2019 with the Storage Migration Service Proxy service installed as the destination. This allows file transfers to be performed directly from source to destination instead of being copied through the orchestrator server.

- If you have enough network bandwidth, processor performance, and memory, increasing the number of threads used by Storage Migration Service Proxy might increase performance. By default, eight threads are allocated. You can increase the allocated threads by creating a FileTransferThreadCount value in the HKEY_Local_Machine\Software\Microsoft\SMSProxy key and setting a value up to 128.

- Add processor cores and memory. Monitor source, destination, and orchestrator computers to identify whether processor and memory capacity are bottlenecks.

- Create multiple jobs. Within a single job, source servers are processed one after the other. If you create multiple jobs, they can be performed in parallel. This is most effective when the Storage Migration Service Proxy is used on Windows Server 2022 and Windows Server 2019 destination servers.

- Use high-performance networking. High-performance networking features such as Server Message Block version 3.0 (SMB3) with Remote Direct Memory Access (RDMA) and SMB3 multichannel ensure that network performance doesn't become a bottleneck.

- Use high-performance storage. The type of disk being used affects storage performance. Ensure that the disk subsystem has enough performance to avoid being a bottleneck. In some cases, the antivirus software can cause poor disk performance.

