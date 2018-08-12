The last thing we want to try on our VM is to install a web server. One of the easiest packages to install is `nginx`.

1. Locate the public IP address of your Linux virtual machine. Remember you can use the `vm list-ip-addresses` command to look it up.

2. Next, open an `ssh` connection to the machine like you did when we tested it. Remember you will need to pass in the admin name ("**aldis**").

3. In the presented shell, execute the following command to install the `nginx` web server.

```azurecli
sudo apt-get -y update && sudo apt-get -y install nginx
```

4. In the Cloud Shell, use `curl` to read the default page from your Linux web server. Alternatively, you can open a new browser tab and browse to the public IP address.

```azurecli
curl 168.61.54.62
```

It will fail because the Linux virtual machine doesn't expose port 80 (`http`) through the built-in firewall. Luckily, the Azure CLI has a command for that: `vm open-port`. 

5. Type the following into the Cloud Shell to open port 80:

```
az vm open-port --port 80 --resource-group ExerciseResources --name SampleVM
```

Finally, try `curl` again. This time it should return data - you can see the page in a browser as well.



