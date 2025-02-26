FSLogix profile containers are a complete roaming profile solution for virtual environments. The [profile container](/fslogix/concepts-container-types#profile-container) (*single container*), redirects the entire Windows user profile into a VHD stored on a storage provider. The most common storage provider is an [SMB file share](/fslogix/concepts-container-storage-options#smb-file-shares).

The profile container is inclusive of all the benefits and uses found in the [ODFC container](/fslogix/concepts-container-types#odfc-container).

## Profile container configuration

> [!NOTE]
> Includes all Microsoft 365 application data. No need for an ODFC container.

1.  **Verify** [FSLogix installation and version](/fslogix/how-to-install-fslogix#verify-product-installation-and-version).
2.  **Sign in** to the virtual machine as a local Administrator or an account with administrative privileges.
3.  **Select** Start and **Type** Registry Editor directly into the Start Menu.
4.  **Select** Registry Editor from the Start Menu.
    
    :::image type="content" source="../media/fsl-start-registry-editor-c637b9f1.jpg" alt-text="Screenshot displays the Registry Editor in the Start Menu.":::
    
5.  Go to: HKEY\_LOCAL\_MACHINE\\SOFTWARE\\FSLogix\\Profiles.
6.  **Add** these settings:
    
    | **Key Name**                         | **Data Type**            | **Value**                                                                                                        | **Description** |
    | ------------------------------------ | ------------------------ | ---------------------------------------------------------------------------------------------------------------- | --------------- |
    | **Enabled**                          | **DWORD**                | **1**                                                                                                            | **REQUIRED**    |
    | DeleteLocalProfileWhenVHDShouldApply | DWORD                    | 1                                                                                                                | Recommended     |
    | FlipFlopProfileDirectoryName         | DWORD                    | 1                                                                                                                | Recommended     |
    | LockedRetryCount                     | DWORD                    | 3                                                                                                                | Recommended     |
    | LockedRetryInterval                  | DWORD                    | 15                                                                                                               | Recommended     |
    | ProfileType                          | DWORD                    | 0                                                                                                                | Default         |
    | ReAttachIntervalSeconds              | DWORD                    | 15                                                                                                               | Recommended     |
    | ReAttachRetryCount                   | DWORD                    | 3                                                                                                                | Recommended     |
    | SizeInMBs                            | DWORD                    | 30000                                                                                                            | Default         |
    | **VHDLocations**                     | **MULTI\_SZ or REG\_SZ** | \\\\&lt;storage-account-name&gt;.file.core.windows.net\\&lt;share-name&gt; | **Example**     |
    | VolumeType                           | REG\_SZ                  | VHDX                                                                                                             | Recommended     |

### Verify your profile container configuration

1.  **Sign in** as a standard user.
2.  **Select** Start and **Type** command prompt directly into the Start Menu.
3.  **Select** Command Prompt from the Start Menu.
    
    :::image type="content" source="../media/fsl-command-prompt-b525cc42.jpg" alt-text="Screenshot displays the Command prompt.":::
    
4.  **Change** directory to C:\\Program Files\\FSLogix\\Apps.
5.  **Type** frx list-redirects.
6.  **Select** Start.
7.  **Select** File Explorer.
8.  **Type** the full path from VHDLocations in the previous section.
9.  **Double-click** the folder for the standard user.
    
    
     -  %username%-%sid%
10. **Locate** the newly created VHDX container.
