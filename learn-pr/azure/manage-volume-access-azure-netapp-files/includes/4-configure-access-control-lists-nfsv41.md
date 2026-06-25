Azure NetApp Files supports access control lists (**ACLs**) on NFSv4.1 volumes.

ACLs contain access control entities (**ACEs**), which specify the permissions (read, write, etc.) of individual users or groups.

When assigning user roles, provide the user email address if you're using a Linux VM joined to an Active Directory Domain. Otherwise, provide user IDs to set permissions.

### Requirements

ACLs can only be configured on NFS4.1 volumes. You can [convert a volume from NFSv3 to NFSv4.1](https://learn.microsoft.com/azure/azure-netapp-files/convert-nfsv3-nfsv41).

- You must have two packages installed:
  - nfs-utils to mount NFS volumes
  - nfs-acl-tools to view and modify NFSv4 ACLs.
- To install them on a Red Hat Enterprise Linux or SuSE Linux instance run:
  - sudo yum install -y nfs-utils
  - sudo yum install -y nfs4-acl-tools
- To install them on Ubuntu or Debian instance:
  - sudo apt-get install nfs-common
  - sudo apt-get install nfs4-acl-tools

### Configure ACLs

1. If you want to configure ACLs for a Linux VM joined to Active Directory, complete the steps in [Join a Linux VM to a Microsoft Entra Domain](https://learn.microsoft.com/azure/azure-netapp-files/join-active-directory-domain).

2. [Mount the volume](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-mount-unmount-volumes-for-virtual-machines).

3. Use the command `nfs4_getfacl <path>` to view the existing ACL on a directory or file.

    The default NFSv4.1 ACL is a close representation of the POSIX permissions of 770.

4. To modify an ACE for a user, use the `nfs4_setfacl` command.

    Command format: `nfs4_setfacl -a|x A|D::<user|group>:<permissions_alias> <file>`

    - Use -a to add permission. Use -x to remove permission.
    - A creates access; D denies access.
    - In an Active Directory-joined set up, enter an email address for the user. Otherwise, enter the numerical user ID.
    - Permission aliases include read, write, append, execute, etc.
