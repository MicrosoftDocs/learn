When you create a virtual machine, it automatically gets both a public IP address which is reachable over the Internet, and a private IP address which is used within the Azure data center. We can quickly test that the Linux VM is up and running using the `ssh` tool. Remember we set our login name to `aldis` so we have to specify that.

```azurecli
ssh 168.61.54.62 -l aldis
```

We don't need a password because we generated an SSH keypair as part of the VM creation. The first time you shell into the VM, it wil give you a prompt about the authenticity of the host - this is because we are hitting an IP address directly, answering "yes" will save the IP as a valid host for connection.

```
The authenticity of host '168.61.54.62 (168.61.54.62)' can't be established.
RSA key fingerprint is SHA256:hlFnTCAzgWVFiMxHK194I2ap6+5hZoj9ex8+/hoM7rE.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '168.61.54.62' (RSA) to the list of known hosts.
```

Then you will be presented with a shell.

```
The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
aldis@SampleVM:~$
```

You can issue Linux commands here - try a few just to play around and when you are finished, go ahead and logout (type `logout` or `exit` in the shell).