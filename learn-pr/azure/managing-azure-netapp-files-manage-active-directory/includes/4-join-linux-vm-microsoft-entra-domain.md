Joining a Linux virtual machine (VM) to a Microsoft Entra Domain Services managed domain enables users to sign into to VMs with one set of credentials. Once joined, the user accounts and credentials can be used to sign in, access, and manage servers.

A Domain Services managed domain lets you run legacy applications in the cloud that can't use modern authentication methods, or where you don't want directory lookups to always go back to an on-premises AD DS environment.

Domain Services integrates with your existing Microsoft Entra tenant. This integration lets users sign in to services and applications connected to the managed domain using their existing credentials.

Before starting you need to configure `/etc/resolv.conf` with the proper DNS server.

For example:

`[root@reddoc cbs]# cat /etc/resolv.conf`

`search contoso.com`

`nameserver 10.6.1.4(private IP)`

You need to add the NFS client record in the DNS server for the DNS forward and reverse lookup zone.

Once the DNS server is configured, install the packages:

`yum update`

`sudo yum -y install realmd sssd adcli samba-common krb5-workstation chrony nfs-utils`

And join the Active Directory domain:

`sudo realm join $DOMAIN.NAME -U $SERVICEACCOUNT --computer-ou="OU=$YOUROU"`

For example:

`sudo realm join CONTOSO.COM -U ad\_admin --computer-ou="CN=Computers"`
