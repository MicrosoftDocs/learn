

Considering user profiles keep user state and users can modify their state, users must possess Write permissions to their user profiles. As long as users have Write permissions, they can write as much data as they want if there’s available free disk space unless an administrator limits them. Because user profiles contain user data, and user data can increase rapidly.

For example, if users store large graphic or multimedia files in their Documents folder, which is in their profile, an administrator often limits the space for storing user profiles.

Administrators can do this in several ways:

 -  Use quotas to limit the space that is available to a user on a volume or on a shared folder where the roaming user profile is stored.
 -  Redirect folders that typically contain large user files and are stored in the user profile by default, for example, the Documents folder, outside of the user profile.
 -  Use the Group Policy setting to limit user profile sizes. You can limit the size of local or roaming user profiles by configuring settings in the user part of Group Policy.

#### Use quotas

An option to limit user profile sizes is to use quotas. You can use the same approach to limit the disk space that a user consumes in general, and it applies to limiting user profile sizes. You can set a disk quota on a local Windows volume by using volume properties. By using File Server Resource Manager in Windows Server 2016, you can set a quota on a shared folder on the file server where roaming user profiles or redirected folders are stored. If you set a disk quota on a local volume, users won't be able to write more data when they reach their disk quota. If a quota is set on a shared folder, the local copy of a roaming user profile won't synchronize with the network share, and changes to the user profile won't copy to the file server until the user deletes some data and the local copy of the roaming user profile is smaller than the quota limit. In such cases, users will see a message during sign-out that their roaming user profiles didn't completely synchronize, and an entry will be added to Event Viewer.

#### Redirect folders out of user profiles

You can make user profiles smaller by redirecting folders that typically consume a large amount of storage space, out of the user profiles. When you do that, the redirected folders are available from any computer in AD DS even if the user is configured with a local user profile. You can configure Folder Redirection by using Group Policy, and several settings are available for each redirected folder. Even if you use Folder Redirection, you can also use quotas to limit the size of redirected folders.

#### Use Group Policy to limit user profile sizes

You can keep local and roaming user profile sizes in check by activating the Limit profile size setting in the user part of Group Policy. When you activate this, you can decide the max profile size and craft a unique message that users get when their profiles go over the limit. With local user profiles, users can be periodically reminded that their user profile exceeds the allowed size, but they can still write data to their profiles and sign out. Roaming user profiles means users can sign out, however, changes to their local copy won't sync up with the network. That means any changes to their local profile won't be copied to the file server until they delete some data and get the size of their local roaming user profile to be smaller than what's allowed in Group Policy.

Users can have smaller user profiles if they store data files outside of their user profiles, for example, in a dedicated shared folder or in the home folder.
