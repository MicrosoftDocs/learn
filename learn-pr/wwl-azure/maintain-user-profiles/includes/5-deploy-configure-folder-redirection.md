

Folder Redirection is a Group Policy setting that is most often used for configuring user profiles. Administrators can use Folder Redirection to redirect individual folders from a user profile to a new location. For example, an administrator can redirect the Documents folder from a local or roaming user profile to a separate network location. Redirected folder content is available from any computer on a network, and it doesn't copy to the computer on which a user signs in, as with roaming user profiles. Folder Redirection also provides users with access to the same data from multiple domain computers without copying data locally, as is the case with roaming user profiles. You can configure Folder Redirection by modifying Policies\\Windows Settings\\Folder Redirection settings in the User Configuration part of Group Policy.

Redirected folders are stored on a network share only, and users access them transparently in the same way as when they're stored in a local user profile. The Offline Files feature, which is enabled by default when redirected folders are used, provides users with access to content in redirected folders even without network connectivity.

Administrators configure Folder Redirection by using user settings in Group Policy, and by doing so, can redirect individual folders in a user profile. In Windows, an administrator can redirect 13 folders in user profiles, including Desktop, Start Menu, and Documents. Administrators can redirect predefined folders and folders in a user profile only. For each user with redirected folders, Windows creates a new sub-folder with the user’s sign-in name, and folders can be redirected to the same location or to a different location based on user group membership.

When you configure Folder Redirection, you can configure what happens if Folder Redirection is no longer effective. The options are to leave the redirected content on the network location or to move the content to the original location to a user’s profile. Folder Redirection can redirect many parts of a user profile, but settings that are stored in Ntuser.dat can't be redirected. Because of this, some administrators use roaming user profiles with Folder Redirection.

Folder Redirection provides several advantages:

 -  Redirected folder content is available from any computer in the domain.
 -  Redirected folder content doesn't copy to local computers, which minimizes network traffic during user sign-in.
 -  Administrators can set quotas (limiting disk space) and permissions on redirected folders. By doing so, administrators can control how much space a user can utilize and whether the user can modify contents of that part of the folder - for example, Desktop.
 -  Redirected folders are stored on network locations (network shares) and not on local computers. If a local hard drive fails, users can still access data in redirected folders from a different computer.
 -  Redirected folder content can be backed up centrally because it isn't stored locally on user computers. If Shadow Copies for Shared Folders is configured on a network location, users can access previous versions of their redirected files.

#### Overview of Folder Redirection deployment

The following steps give you an overview of how to configure and test Folder Redirection. These steps contain mock details for the purposes of demonstration. You can change the details to fit your organization’s environment.

1.  On a client, verify that the location of the user’s **Desktop** folder is *C:\\Users\\username*.
2.  Verify that the location of the user’s **Documents** folder is *C:\\Users\\username*.
3.  Create a Group Policy that redirects the **Documents** folder for the user to a network folder.
4.  Verify that the network folder is empty.
5.  On the client, run **gpupdate /force**, and then sign out.
6.  Sign in to the client as a user that will be affected by the Group Policy.
7.  On the client, verify that the location of user’s Desktop folder is still *C:\\Users\\username*, as you didn't redirect it.
8.  Verify that the location of user’s **Documents** folder is now redirected to the network folder.
9.  In Notepad, create a file named **Demo Document** in which you type your name, and then save it in the **Documents** folder.
10. Verify that the network folder is no longer empty and that it has a sub-folder named username.
11. Sign in to another client as the same user.
12. On the other client, verify that the location of user’s **Desktop** folder is still *C:\\Users\\username*, as you didn't redirect it.
13. Verify that the location of the user’s **Documents** folder is the network folder.
14. View the content of the **Demo Document** file, and then verify that it has the same content that you typed on the first client.

For a detailed description on how to configure and deploy Folder Redirection, refer to Deploy Folder Redirection with Offline Files.
