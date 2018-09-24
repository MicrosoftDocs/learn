The last thing we want to try on our VM is to install a web server. One of the easiest packages to install is `nginx`.

## Install NGINX web server

1. Locate the public IP address of your Linux virtual machine. Remember you can use the `vm list-ip-addresses` command to look it up.

1. Next, open an `ssh` connection to the machine like you did when we tested it. Remember you will need to pass in the admin name ("**aldis**").

1. In the presented shell, execute the following command to install the `nginx` web server.

```bash
sudo apt-get -y update && sudo apt-get -y install nginx
```

1. Exit the Secure Shell.

```bash
exit
```

## Retrieve our default page

1. In Azure Cloud Shell, use `curl` to read the default page from your Linux web server. Alternatively, you can open a new browser tab and browse to the public IP address.

```azurecli
curl 40.83.165.85
```

It will fail because the Linux virtual machine doesn't expose port 80 (`http`) through the built-in firewall. Luckily, the Azure CLI has a command for that: `vm open-port`. 

1. Type the following into Cloud Shell to open port 80:

```azurecli
az vm open-port --port 80 --resource-group <rgn>[sandbox resource group name]</rgn> --name SampleVM
```

It will take a moment to add the network rule and open the port through the firewall. Try `curl` again. This time it should return data. You can see the page in a browser as well.

```output
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx on Debian!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx on Debian!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working on Debian. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a></p>

<p>
      Please use the <tt>reportbug</tt> tool to report bugs in the
      nginx package with Debian. However, check <a
      href="http://bugs.debian.org/cgi-bin/pkgreport.cgi?ordering=normal;archive=0;src=nginx;repeatmerged=0">existing
      bug reports</a> before reporting a new bug.
</p>

<p><em>Thank you for using debian and nginx.</em></p>


</body>
</html>
```
