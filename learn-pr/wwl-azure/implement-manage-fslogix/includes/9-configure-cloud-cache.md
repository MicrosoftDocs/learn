Cloud Cache is an optional add-on to Profile Container and Office Container.

In this unit you will:

 -  Configure Cloud Cache for Server Message Block (SMB).
 -  Configure Cloud Cache for page blobs.

Below are required ahead of time.

 -  Install FSLogix.
 -  Verify that users have appropriate access to network file storage.
 -  If using page blobs for Cloud Cache, verify that an appropriate Azure storage service is being used.

## Configure Cloud Cache for SMB

To configure Cloud Cache for Profile Container, refer to the following.

All settings are applied to **HKLM\\SOFTWARE\\FSLogix\\Profiles.**

Add or verify:

| **Configuring Cloud Cache for Profile Container** |                     |                                                                                                 |
| ------------------------------------------------- | ------------------- | ----------------------------------------------------------------------------------------------- |
| Registry Value                                    | Type                | Value                                                                                           |
| CCDLocations                                      | `REG_SZ / MULTI_SZ` | `type=smb,connectionString=<\Location1\Folder1>;type=smb,connectionString=<\Location2\folder2>` |
| Enabled                                           | DWORD               | One                                                                                             |

Other considerations include:

 -  `<Location for Cloud Cache Provider>`
 -  Each Provider is separated by;``

This sample is for two SMB Providers.

## Configuring Cloud Cache for Office Container

All settings are applied to **HKLM\\SOFTWARE\\Policies\\FSLogix\\ODFC.**

Remove any setting for VHDLocations.

Add or verify the values below:

| **Registry Value** | **Type**            | **Value**                                                                                       |
| ------------------ | ------------------- | ----------------------------------------------------------------------------------------------- |
| CCDLocations       | `REG_SZ / MULTI_SZ` | `type=smb,connectionString=<\Location1\Folder1>;type=smb,connectionString=<\Location2\folder2>` |
| Enabled            | DWORD               | 1                                                                                               |

 -  `<Location for Cloud Cache Provider`

## Configure Cloud Cache for page blobs

The instructions below may expose sensitive credentials to any user with access to the host registry if implemented in production.

## Configuring Cloud Cache for Profile Container

All settings are applied to **HKLM\\SOFTWARE\\FSLogix\\Profiles.**

Remove any settings for VHDLocations.

Add or verify the values below:

| **Registry Value** | **Type**            | **Value**                                                                                               |
| ------------------ | ------------------- | ------------------------------------------------------------------------------------------------------- |
| CCDLocations       | `REG_SZ / MULTI_SZ` | `type=Azure,connectionString="DefaultEndpointsProtocol=https;AccountName=;AccountKey=;EndpointSuffix="` |
| Enabled            | DWORD               | 1                                                                                                       |

 -  `<Location for Cloud Cache Provider>`
 -  Each provider is separated by;``
 -  This sample is for one page blob provider.
 -  Page blob connection string should be enclosed in `""`
 -  These settings are used to create the connection string:
 -  `DefaultEndpointsProtocol=[http or https]`
 -  `AccountName=myAccountName`
 -  `AccountKey=myAccountKey`
 -  `EndpointSuffix=mySuffix`

Azure account keys are sensitive and may be protected using Credential Manager.
