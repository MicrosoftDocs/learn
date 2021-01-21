### NFS Overview ###

There are two main version of the NFS protocol: NFSv3 and NFSv4.x. The full scope of these two protocols lies outside the scope of this module, but there are a handful of issues related to authentication and authorization that we will identify here.

First, NFSv3 is very widely deployed today. It is a simple file system protocol that passes API requests to NFS servers for data. We mentioned earlier that a user is represented by their UID and have a primary group GID association. We also mentioned that a user may be associated with a larger number of groups. For NFS purposes, these additional group assignments are known as *auxiliary groups*. The UID and GID information are passed with requests, which the NFS server will use to determine the appropriate level of access.

NFSv3 has a limit in terms of the total number of GID values it passes. NFSv3 only supports the passing of 16 auxiliary groups for any given UID. The implication is that if you are currently using greater than 16 group assignments in meaningful ways (such as fine-grained access management), you may run into this limitation. NAS vendors such as NetApp have added an extension to the NFS protocol that supports the communication of all group mappings, known as **extended group** support. If you are assessing hpc storage and are using large numbers of GID assignments, you should very whether or not the proposed solution supports this capability.

NFSv4.x




    NFS v3 versus v4.x security

    Use of directory authentication/authorization
    LDAP
    Active Directory

    Using Kerberos

**NAS Security**

    security styles
    export rules and policies
    RFC2307 mapping

