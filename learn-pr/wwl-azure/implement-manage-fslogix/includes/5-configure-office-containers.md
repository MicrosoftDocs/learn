FSLogix [ODFC containers](/fslogix/concepts-container-types#odfc-container) are a ***subset*** to the [profile container](/fslogix/concepts-container-types#profile-container) and are used to redirect-specific Microsoft 365 app data into a VHD stored on a storage provider. The most common storage provider is an [SMB file share](/fslogix/concepts-container-storage-options#smb-file-shares).<br>

All benefits of the ODFC Container are automatic when using profile containers in a single container configuration. There's no need or benefit to using the ODFC container when profile containers are your primary profile management solution. ODFC containers can optionally be used in with profile containers in a dual container configuration, to place Microsoft 365 app data in a different VHD from the rest of the profile data.

When pairing the ODFC container with third party roaming profile solutions, ensure to exclude the paths in the profile managed by the ODFC container. The paths to exclude depend on the ODFC configuration settings.

## ODFC container configuration

1.  **Verify** [FSLogix installation and version](/fslogix/how-to-install-fslogix#verify-product-installation-and-version).
2.  **Sign in** to the virtual machine as a local Administrator or an account with administrative privileges.
3.  **Type** Registry Editor into the Search box.
4.  **Select** Registry Editor from the Start Menu.
    
    :::image type="content" source="../media/fsl-start-registry-editor-c637b9f1.jpg" alt-text="Screenshot displays the Registry Editor in the Start Menu.":::
    
5.  **Go** to: HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Policies\\FSLogix\\ODFC.
6.  **Add** these settings:
    
    | **Key Name**                 | **Data Type**            | **Value**                                                                                                        | **Description** |
    | ---------------------------- | ------------------------ | ---------------------------------------------------------------------------------------------------------------- | --------------- |
    | **Enabled**                  | **DWORD**                | **1**                                                                                                            | **REQUIRED**    |
    | FlipFlopProfileDirectoryName | DWORD                    | 1                                                                                                                | Recommended     |
    | IncludeTeams                 | DWORD                    | 1                                                                                                                | Recommended     |
    | LockedRetryCount             | DWORD                    | 3                                                                                                                | Recommended     |
    | LockedRetryInterval          | DWORD                    | 15                                                                                                               | Recommended     |
    | ReAttachIntervalSeconds      | DWORD                    | 15                                                                                                               | Recommended     |
    | ReAttachRetryCount           | DWORD                    | 3                                                                                                                | Recommended     |
    | SizeInMBs                    | DWORD                    | 30000                                                                                                            | Default         |
    | **VHDLocations**             | **MULTI\_SZ or REG\_SZ** | \\\\&lt;storage-account-name&gt;.file.core.windows.net\\&lt;share-name&gt; | **Example**     |
    | VolumeType                   | REG\_SZ                  | VHDX                                                                                                             | Recommended     |

### Verify your ODFC container configuration

1.  **Sign in** as a standard user.
2.  **Select** Start and **Type** command prompt directly into the Start Menu.
3.  **Select** Command Prompt from the Start Menu.
    
    :::image type="content" source="../media/fsl-command-prompt-b525cc42.jpg" alt-text="Screenshot displays the Command prompt call.":::
    
4.  **Change** directory to `C:\Program Files\FSLogix\Apps`.
5.  **Type** frx list-redirects.
6.  **Select** Start.
7.  **Select** File Explorer.
8.  **Type** the full path from VHDLocations in the previous section.
9.  **Double-click** the folder for the standard user.
    
    
     -  %username%-%sid%
10. **Locate** the newly created Profile and ODFC VHDX containers.

## Exclusions for third party roaming profiles

When pairing the ODFC container with a third-party roaming profile solution, the folders managed by the ODFC container should NOT be roamed by the third-party provider. The folders to exclude depend on which [settings](/fslogix/reference-configuration-settings?tabs=odfc) are enabled.

| **ODFC configuration setting** | **Exclusion path**                                                                                                                                                                                           | **Type**    |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| IncludeOfficeActivation        | %userprofile%\\AppData\\Local\\Microsoft\\Office\\16.0\\Licensing                                                                                                                                            | **Default** |
| IncludeOneDrive                | %userprofile%\\AppData\\Local\\Microsoft\\OneDrive                                                                                                                                                           | **Default** |
| IncludeOneNote                 | %userprofile%\\Documents\\OneNote Notebooks<br>%userprofile%\\AppData\\Local\\Microsoft\\OneNote                                                                                                             | Optional    |
| IncludeOneNote\_UWP            | %userprofile%\\Microsoft                                                                                                                                                                                     | Optional    |
| IncludeOutlook                 | %userprofile%\\AppData\\Local\\Microsoft\\Outlook                                                                                                                                                            | **Default** |
| IncludeOutlookPersonalization  | %userprofile%\\AppData\\Roaming\\Microsoft\\Outlook                                                                                                                                                          | **Default** |
| IncludeSharepoint              |                                                                                                                                                                                                              | **Default** |
| IncludeSkype                   | %userprofile%\\AppData\\Local\\Microsoft\\Office\\15.0\\Lync<br>\\AppData\\Local\\Microsoft\\Office\\16.0\\Lync                                                                                              | **Default** |
| IncludeTeams                   | *classic* Teams<br>%userprofile%\\AppData\\Local\\Microsoft\\Teams<br>%userprofile%\\AppData\\Roaming\\Microsoft\\Teams<br><br>**new** Teams<br>%LocalAppData%\\Packages\\MSTeams\_8wekyb3d8bbwe\\LocalCache | Optional    |
