Profile Container is a full remote profile solution for non-persistent environments. Profile Container redirects the entire user profile to a remote location. Profile Container configuration defines how and where the profile is redirected.

Profile Container is inclusive of the benefits found in Office Container.

When using Profile Container, both applications and users see the profile as if it's located on the local drive.

In this unit, learn how to:

 -  Configure Profile Container Registry Settings.
 -  Set up Include and Exclude User Groups.

Before configuring Profile Container:

 -  [Download and install](/fslogix/install-ht) FSLogix Software.
 -  Consider the storage and network requirements for your users' profiles.
 -  Verify that your users have appropriate storage permissions where profiles will be placed.
 -  Profile Container is installed and configured after stopping use of other solutions used to manage remote profiles.
 -  Exclude the VHD(X) files for Profile Containers from Anti Virus (AV) scanning.

## Configure Profile Container Registry settings

The configuration of Profile Container is accomplished through registry settings and user groups. Registry settings may be managed manually, with GPOs, or using alternate preferred methods. Configuration settings for Profile Container are set in **HKLM\\SOFTWARE\\FSLogix\\Profiles**.

Below are settings **required** to enable Profile Container and to specify the location for the profile VHD to be stored. The minimum required settings to enable Profile Containers are:

:::row:::
  :::column:::
    **Value**
  :::column-end:::
  :::column:::
    **Type**
  :::column-end:::
  :::column:::
    **Configured Value**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Enabled (required setting)
  :::column-end:::
  :::column:::
    DWORD
  :::column-end:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    0: Profile Containers disabled. 1: Profile Containers enabled
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    VHDLocations (required setting)
  :::column-end:::
  :::column:::
    MULTI\_SZ or REG\_SZ
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    A list of file system locations to search for the user's profile VHD(X) file. If one isn't found, one will be created in the first listed location. If the VHD path doesn't exist, it will be created before it checks if a VHD(X) exists in the path. These values can contain variables that will be resolved.
  :::column-end:::
:::row-end:::


:::image type="content" source="../media/configure-profile-containters-image-1-ccc04778.png" alt-text="Screenshot of Profile Containers Registry Configuration.":::


**VHDLocations may be replaced by CCDLocations when using Cloud Cache.**

These settings below are helpful when configuring Profile Container but are not required.

:::row:::
  :::column:::
    **Value**
  :::column-end:::
  :::column:::
    **Type**
  :::column-end:::
  :::column:::
    **Configured Value**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    DeleteLocalProfileWhenVHDShouldApply
  :::column-end:::
  :::column:::
    DWORD
  :::column-end:::
  :::column:::
    0
  :::column-end:::
  :::column:::
    0: no deletion. 1: delete local profile if exists and matches the profile being loaded from VHD. Use caution with this setting. When the FSLogix Profiles system determines a user should have a FSLogix profile, but a local profile exists, Profile Container permanently deletes the local profile. The user will then be signed in with an FSLogix profile.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    FlipFlopProfileDirectoryName
  :::column-end:::
  :::column:::
    DWORD
  :::column-end:::
  :::column:::
    0
  :::column-end:::
  :::column:::
    When set to '1' the SID folder is created as `"%username%%sid%" instead of the default "%sid%%username%"`. This setting has the same effect as setting `SIDDirNamePattern = "%username%%sid%" and SIDDirNameMatch = "%username%%sid%".`
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    PreventLoginWithFailure
  :::column-end:::
  :::column:::
    DWORD
  :::column-end:::
  :::column:::
    0
  :::column-end:::
  :::column:::
    If set to 1 Profile Container will load FRXShell if there's a failure attaching to, or using an existing profile VHD(X). The user will receive the FRXShell prompt - default prompt to call support, and the users only option will be to sign out.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    PreventLoginWithTempProfile
  :::column-end:::
  :::column:::
    DWORD
  :::column-end:::
  :::column:::
    0
  :::column-end:::
  :::column:::
    If set to 1 Profile Container will load FRXShell if it's determined a temp profile has been created. The user will receive the FRXShell prompt - default prompt to call support, and the users only option will be to sign out.
  :::column-end:::
:::row-end:::


## Set up Include and Exclude User Groups

There are often users, such as local administrators, that have profiles that should remain local. During installation, four user groups are created to manage users who's profiles are included and excluded from Profile Container and Office Container redirection.

:::image type="content" source="../media/configure-profile-containters-image-2-19dd64bc.png" alt-text="Screenshot of the FSLogix Groups with exclude and include.":::


By default Everyone is added to the FSLogix Profile Include List group.

:::image type="content" source="../media/configure-profile-containters-image-3-1732033f.png" alt-text="Screenshot of Profile Containers Include list members..":::


Adding a user to the FSLogix Profile Exclude List group means that the FSLogix agent will not attach a FSLogix profile container for the user. In the case where a user is a member of both the exclude and include groups, exclude takes priority.

:::image type="content" source="../media/configure-profile-containters-image-4-c930a3fe.png" alt-text="Screenshot of Profile Containers Exclude list.":::


Profile Containers is now configured and ready to be used. In order to verify that Profile Container is working, sign in as a user in the Included List group. Using File Manager, navigate to the location specified in VHDLocations. Verify that a folder, with the user name and SID has been created.

:::image type="content" source="../media/configure-profile-containters-image-5-24dec7de.png" alt-text="Screenshot of Profile Containers validation name.":::
