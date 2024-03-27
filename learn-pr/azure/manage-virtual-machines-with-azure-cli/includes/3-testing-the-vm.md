When you create a virtual machine, it's assigned a public IP address that's reachable over the Internet and a private IP address used within the Azure data center. Both of these values appear in the JSON block the `create` command returns, like the following:

```json
{
   ...
  "privateIpAddress": "10.0.0.4",
  "publicIpAddress": "40.83.165.85",
   ...
}
```

## Connecting to the VM with SSH

We can quickly test that the Linux VM is up and running by using the public IP address in the Secure Shell (`ssh`) tool. Remember that we set our admin name to `azureuser`, so we need specify that. Make sure to use the public IP address from *your* running instance.

```azurecli
ssh azureuser@<public-ip-address>
```

> [!NOTE]
> We don't need a password because we generated an SSH key pair as part of the VM creation. The first time you shell into the VM, you will receive a prompt regarding the authenticity of the host.
> 
> This is because we are attempting to access an IP address directly instead of through a host name. Answering "yes" will save the IP address as a valid host for connection and allow the connection to proceed.

```output
The authenticity of host '40.83.165.85 (40.83.165.85)' can't be established.
RSA key fingerprint is SHA256:hlFnTCAzgWVFiMxHK194I2ap6+5hZoj9ex8+/hoM7rE.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '40.83.165.85' (RSA) to the list of known hosts.
```

Then, you'll be presented with a remote shell where you can enter Linux commands.

```output
Welcome to Ubuntu 18.04.3 LTS (GNU/Linux 5.0.0-1014-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Wed Aug 21 20:32:04 UTC 2019

  System load:  0.0               Processes:           108
  Usage of /:   4.2% of 28.90GB   Users logged in:     0
  Memory usage: 9%                IP address for eth0: 10.0.0.5
  Swap usage:   0%

0 packages can be updated.
0 updates are security updates.

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

azureuser@SampleVM:~$
```

Try a few commands, such as `ps` or `ls` as practice. When you're finished, sign out of the virtual machine by typing `exit` or `logout`.
