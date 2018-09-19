When you create a virtual machine, it gets assigned a public IP address that is reachable over the Internet, and a private IP address used within the Azure data center. You get both of those values in the returning JSON block from the `create` command:

```json
{
   ...
  "privateIpAddress": "10.0.0.4",
  "publicIpAddress": "40.83.165.85",
   ...
}
```

## Connecting to the VM with SSH

With the public IP address we can quickly test that the Linux VM is up and running using the Secure Shell (`ssh`) tool. Remember that we set our admin name to `aldis`, so we have to specify that. Make sure to use the public IP address from _your_ running instance.

```azurecli
ssh <public-ip-address> -l aldis
```

> [!NOTE]
> We don't need a password because we generated an SSH key pair as part of the VM creation. The first time you shell into the VM, it will give you a prompt about the authenticity of the host. 
> 
> This is because we are hitting an IP address directly instead of a host name. Answering "yes" will save the IP as a valid host for connection and allow the connection to proceed.

```output
The authenticity of host '40.83.165.85 (40.83.165.85)' can't be established.
RSA key fingerprint is SHA256:hlFnTCAzgWVFiMxHK194I2ap6+5hZoj9ex8+/hoM7rE.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '40.83.165.85' (RSA) to the list of known hosts.
```

Then you'll be presented with a remote shell where you can enter Linux commands.

```output
The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
aldis@SampleVM:~$
```

Try a few commands as practice and when you are finished, sign out of the shell (type `logout` or `exit` in the shell).