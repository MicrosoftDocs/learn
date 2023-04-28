

Windows has different types of user profiles for the various different scenarios in how user configurations might be applied. The four common different types of user profiles are:

 -  **Local User Profile:** This type is available on a single computer only.
 -  **Roaming User Profile:** This type can roam between computers that are domain members.
 -  **Mandatory User Profile:** This is a special type of pre-configured user profile that doesn't store user changes between sign-ins.
 -  **Temporary User Profiles:** A temporary profile is issued each time that an error condition prevents the user's profile from loading.

#### Local user profiles

When a user signs in for the first time, the Windows operating system automatically creates a local user profile for all subsequent sign-ins to the same computer. A local user profile is used only when a user signs in to the computer where the profile was created, and it’s useful when a user is using a single computer. If a user roams between multiple computers, then by default, separate local user profiles will be created on each computer. This means that modifications and documents that a user creates on one computer won't be available on other computers. Therefore, administrators should avoid local profiles if users sign in to multiple devices.

#### Roaming user profiles

In a domain environment, administrators can configure a user with a roaming user profile by configuring his or her profile path. With roaming user profiles, user settings and data are stored on a network location and locally on the computer where a user signs in. When a user signs in, the local copy of the user profile is compared to the copy that is stored on the network location, and only newer files are copied locally. The user can change settings and create data files, which are stored in the local user profile copy. These changes copy to the network location when the user signs out. If users roam between multiple computers, their documents and settings follow them. If a user profile contains a lot of data, or if a user stores large files on the desktop, then signing in to the computer might take a long time. If a user signs in to multiple computers at the same time, changes performed on one computer override changes performed on a second computer because user profile changes copy to the network location only when the user signs out. Some parts of a user profile, such as Temporary Internet Files or AppData\\Local, never copy to the network location even if roaming user profiles are used. You should be aware that roaming user profiles are incompatible between different versions of Windows operating systems.

#### Mandatory user profiles

A mandatory user profile is a type of roaming user profile that administrators can configure. With mandatory user profiles, user changes are stored in the local copy of a user profile but aren't preserved after a user signs out from the computer. When the user signs in again, the mandatory user profile downloads from the network location, and it overrides the local user profile copy. The two types of mandatory user profiles are normal mandatory profiles and super-mandatory profiles. Administrators can configure users with mandatory user profiles first by configuring them with roaming user profiles and then by renaming the Ntuser.dat file in their profiles to Ntuser.man. The .man extension causes user modifications to the profile to be discarded at the next sign-in and user profiles to behave as read-only.

#### Temporary User Profiles

A temporary profile is issued each time that an error condition prevents the user's profile from loading. Temporary profiles are deleted at the end of each session, and changes made by the user to desktop settings and files are lost when the user logs off.

#### Profile extension for each Windows version

The name of the folder in which you store the profile must use the correct extension for the operating system it will be applied to. The following table lists the correct extension for each operating system version.

| **Client operating system version**                              | **Server operating system version**         | **Profile extension** |
| ---------------------------------------------------------------- | ------------------------------------------- | --------------------- |
| Windows 10, versions 1507 and 1511                               | N/A                                         | V5                    |
| Windows 10, versions 1607, 1703, 1709, 1803, 1809, 1903 and 1909 | Windows Server 2016 and Windows Server 2019 | V6                    |

For example, if a profile is being creating for Windows v20H2, the path to the profile folder might be *\\\\server\\share\\profile.v6*, with the extension indicating which version.
