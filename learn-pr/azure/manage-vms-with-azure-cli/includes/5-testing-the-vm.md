When you create a virtual machine, it gets assigned a public IP address that is reachable over the Internet, and a private IP address used within the Azure data center. We can quickly test that the Linux VM is up and running using the `ssh` tool. Remember we set our admin name to `aldis` so we have to specify that.

```azurecli
ssh 168.61.54.62 -l aldis
```

> [!NOTE]
> We don't need a password because we generated an SSH key pair as part of the VM creation. The first time you shell into the VM, it wil give you a prompt about the authenticity of the host. 
> 
> This is because we are hitting an IP address directly instead of a host name. Answering "yes" will save the IP as a valid host for connection and allow the connection to proceed.

```
The authenticity of host '168.61.54.62 (168.61.54.62)' can't be established.
RSA key fingerprint is SHA256:hlFnTCAzgWVFiMxHK194I2ap6+5hZoj9ex8+/hoM7rE.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '168.61.54.62' (RSA) to the list of known hosts.
```

Then you'll be presented with a remote shell where you can enter Linux commands.

```
The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
aldis@SampleVM:~$
```

Try a few just to play around, and when you are finished, go ahead and sign out (type `logout` or `exit` in the shell).