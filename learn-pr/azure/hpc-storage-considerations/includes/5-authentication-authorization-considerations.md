# How does security impact HPC workflows?

After you understand the overall performance and traffic characteristics, you will need to consider *security* aspects of your workload. Your data may be sensitive, such as patient radiological images. You may want to restrict access to the data for many reasons. You may want to offer each of your researchers their own "home directory" from which they can load data and conduct HPC analysis and simulations.

When you select your cloud HPC storage, you must be aware of how it will integrate with your current security posture. You must understand the methods by which your file system will authenticate and authorize access to the files, whether the enforcement is local or remote (or both), where authentication and authorization is sourced. If using a remote shared file system, you will need to understand how to control access via standard NAS practices. Finally, if you are offering unique working spaces for users (home directories), you may need to understand how to allocate that space.

By the end of this module you will have gained understanding of these considerations and how they impact your storage architecture.

## Overview of authentication and authorization

**Authentication** - Access to file systems requires authenticating the requestor, using some trusted credential. Many client-server architectures will issue challenges for such credentials, such as user or machine accounts. Those credentials are then checked to ensure they are valid for that environment. Once authenticated the specific requestor (the user or the machine/process) would then be authorized. Note that authentication for your solution may be limited depending on which access protocols your environment requires. For example, if you have a Windows environment, you most likely are using Server Message Block (SMB) as the network file access protocol, which has different authentication requirements than NFS.

**Authorization** - Allowing a user or machine access to an environment is one thing, but what *level* of access? For example, user A may be able to read files on a file system while user B may be able to read and write files. Authorization can go deeper than reading and writing; for example user C may be able to modify files but not create new ones in a given directory.

The level of authorization is often expressed as *permissions* for a given file. These include reading, writing and execution. 

**Users and Groups** - Granting access to a set of resources can become cumbersome when you have a large amount of users. It also becomes complicated if you intend to grant different levels of access to multiple sets of users. The use of *groups* becomes necessary, where you can assign a user to a specific group or set of groups. You can then authorize access to a given set resources based on that group identification.

Taken together, authentication and authorization represent the user/group/machine level access you intend to grant to resources...in our case files.

The Linux OS assigns an *user identifier* (UID) to individual user accounts. The UID is an integer and is what the system uses determine which system resources, including files and folders, that a specific user can access.

Linux OS uses *group identifiers* (GIDs) for group assignments. A user is associated with a single primary group. Users can be associated with any number of additional, or supplemental, group assignments, up to 65536 on most modern Linux systems.

### Local and remote authentication and authorization 

Local authentication and authorization refers to the access of a local file system by a user/machine account that is also local to the machine. For example, I may create a user account that I then grant access to the `/data` directory located on my local file system. That user account is local, as is any grant of access to the directory. I may also use group assignment to control access. The combination of user and group authorization gives a user *effective* permissions over a file/folder.

If you look at a typical output of `ls -al` directory command, you will see something like this:

```
drwxr-xr-x  4 root root 4096 Dec 31 19:43.
drwxr-xr-x 13 root root 4096 Dec 11 05:53 ..
drwxr-xr-x  6 root root 4096 Dec 31 19:43 microsoft
drwxr-xr-x  8 root root 4096 Dec 31 19:43 omi
-rw-r--r--  1 root root    0 Jan 21 15:10 test.txt
```

The `drwxr-xr-x` represent the level of authorized access users/groups have to the file or directory. The `d` indicates the entry is a directory (if the first value is `-` then it's a file entry). The remaining characters represent permission group authorization of (r)ead, (w)rite and (x)execute: the first three values are reflect the "owner" of the file or directory, the second three values represent the group permissions assigned to the file or directory, and the final three values reflect permissions allowed to all other users on that system. For example, in the case of:

```-rw-r--r--  1 root root    0 Jan 21 15:10 test.txt```:

- '-' reflects this is a file
- 'rw-' indicates that the owner has read and write permissions
- 'r--' indicates that the assigned group has read permissions (only)
- 'r--' indicates that the remaining users have read permissions (only)
- Note also that the owning user and assigned group are represented by the two `root` columns.

An authenticated user on a local machine is represented by their UID and their primary/supplemental GIDs. Those values are **local** to that machine. What happens if you have five...or fifty machines? You would have to replicate the UID/GID assignments on each of those computers. The level of complexity around user management grows, as does the possibility of mistakenly granting file/folder access to the wrong user.

**Remote file access using NFS**

Local UID/GID assignment works fine if you are running everything as a single user/group assignment. What if you are running an HPC cluster that is consumed by multiple stakeholders, each of which have sensitive data and multiple consumers of that data? 

Locating data on a file server or NAS environment allows for remote access of the data. This approach helps to reduce the local disk cost, ensures that the data is up to date for all users, and reduces overall user and group management. 

![NAS and Directory Services](../media/nas-and-ds.png)

Centrally locating files may introduce the need for a *directory service* that contains the user and group configuration. Directory services, such as Active Directory or Lightweight Directory Access Protocol (LDAP) allow you to create a user/group mapping that can then be used by all remote systems. You configure your remote machines, and your NAS environment, as clients of the directory service. You may also use Active Directory mappings between your Windows user accounts and a specific UID/GID combination.

The typical method of accessing files remotely is to use a network file system such as NFS, SMB or a parallel file system such as Lustre. These protocols define the client and server API for accessing data. We discussed NFS operations in the "performance considerations" unit. The use of NFS will be discussed at length here.

NOTE: while a directory service is not mandatory when using NFS, the problem of UID/GID management will still present with larger numbers of users and systems. 

**Home directories**

Say you have a HPC environment that multiple researchers are using, but their unique data must be kept separate. Further, say those researchers are continuously modifying their own data and adding to their data. Offering them researchers their own home directories is an efficient way of segregating their data.

Permissions within the home directory would be handled by the researcher, allowing them the ability to collaborate when desired. 

One of the main challenges in this environment is storage space. Say you have a 500TB NAS environment. What stops one researcher from consuming it all?

That is where **quotas** are introduced. A quota can be assigned to an individual directory and reflects the maximum amount of data allowed. Once reached, the quota can reject further data, or warn you admins that the researcher has exceeded their limit. For example, if you have a NAS system, you would be able to assign quotas to each researcher. Further, if you isolate their access to the home directory it becomes quite simple to configure and monitor their usage.