Cloud Cache is an optional type of configuration to profile or ODFC containers. The primary function of Cloud Cache is to mitigate short-term or intermittent connectivity problems with the remote storage providers.

## Profile container configuration with Cloud Cache

> [!NOTE]
> Includes all Microsoft 365 application data. No need for an ODFC container.

1.  **Verify** [FSLogix installation and version](/fslogix/how-to-install-fslogix#verify-product-installation-and-version).
2.  **Sign in** to the virtual machine as a local Administrator or an account with administrative privileges.
3.  **Select** Start.
4.  **Type** registry editor directly into Start Menu.
5.  **Select** Registry Editor from Start Menu.
6.  **Go** to: HKEY\_LOCAL\_MACHINE\\SOFTWARE\\FSLogix\\Profiles.
7.  **Add** these settings:
    
    | **Key Name**                            | **Data Type**            | **Value**                                                                                                                                                                                                                                   | **Description** |
    | --------------------------------------- | ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
    | **CCDLocations**                        | **MULTI\_SZ or REG\_SZ** | type=smb,name="WINDOWS SMB PROVIDER",connectionString=\\\\&lt;server-name&gt;\\&lt;share-name&gt;;type=Azure,name="AZURE PROVIDER",connectionString="\|fslogix/&lt;key-name&gt;\|" | **Example**     |
    | **ClearCacheOnLogoff**                  | DWORD                    | 1                                                                                                                                                                                                                                           | Recommended     |
    | **Enabled**                             | **DWORD**                | **1**                                                                                                                                                                                                                                       | **REQUIRED**    |
    | DeleteLocalProfileWhenVHDShouldApply    | DWORD                    | 1                                                                                                                                                                                                                                           | Recommended     |
    | FlipFlopProfileDirectoryName            | DWORD                    | 1                                                                                                                                                                                                                                           | Recommended     |
    | **HealthyProvidersRequiredForRegister** | DWORD                    | 1                                                                                                                                                                                                                                           | Recommended     |
    | LockedRetryCount                        | DWORD                    | 3                                                                                                                                                                                                                                           | Recommended     |
    | LockedRetryInterval                     | DWORD                    | 15                                                                                                                                                                                                                                          | Recommended     |
    | ProfileType                             | DWORD                    | 0                                                                                                                                                                                                                                           | Default         |
    | ReAttachIntervalSeconds                 | DWORD                    | 15                                                                                                                                                                                                                                          | Recommended     |
    | ReAttachRetryCount                      | DWORD                    | 3                                                                                                                                                                                                                                           | Recommended     |
    | SizeInMBs                               | DWORD                    | 30000                                                                                                                                                                                                                                       | Default         |
    | VolumeType                              | REG\_SZ                  | VHDX                                                                                                                                                                                                                                        | Recommended     |
    
    :::image type="content" source="../media/fsl-ccd-registry-entries-78deace4.jpg" alt-text="Screenshot displays the Cloud Cache Registry entries.":::
    

## Verify your Cloud Cache profile container configuration

Cloud Cache creates and mounts a local container ([local cache](/fslogix/concepts-fslogix-cloud-cache#local-cache)) for the user's profile. Verifying your Cloud Cache configuration requires reviewing the Windows Event Viewer, File Explorer or the FSLogix profile logs. The steps in this outline show Windows Event Viewer and File Explorer.

1.  **Select** Start.
2.  **Type** event viewer directly into the Start Menu.
3.  **Select** Event Viewer from Start Menu.
    
    :::image type="content" source="../media/fsl-event-viewer-start-dfcefad9.jpg" alt-text="Screenshot displays the Registry Editor in the Start Menu.":::
    
4.  **Expand** Applications and Services Logs.
5.  **Expand** Microsoft.
6.  **Expand** FSLogix.
7.  **Expand** CloudCache.
8.  **Select** Operational.
    
    :::image type="content" source="../media/fsl-ccd-event-viewer-81e3cced.jpg" alt-text="Screenshot displays the Windows Event Viewer.":::
    
9.  **Look** for **Event ID 56** that shows which providers are online.
10. **Look** for **Event ID 5** that shows the lock on the proxy file.
11. **Select** Start.
12. **Select** File Explorer.
13. **Go** to: C:\\ProgramData\\FSLogix\\Cache\\%username%\_%sid%.
