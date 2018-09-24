One of the main tasks you'll want to do while running virtual machines is to start and stop them.

## Stopping a VM

We can stop a running VM with the `vm stop` command. You must pass the name and resource group, or the unique ID for the VM:

```azurecli
az vm stop -n SampleVM -g <rgn>[sandbox resource group name]</rgn>
```

We can verify it has stopped by attempting to ping the public IP address, using `ssh`, or through the `vm get-instance-view` command. This final approach returns the same basic data as `vm show` but includes details about the instance itself. Try typing the following command into Azure Cloud Shell to see the current running state of your VM:

```azurecli
az vm get-instance-view -n SampleVM -g <rgn>[sandbox resource group name]</rgn> --query "instanceView.statuses[?starts_with(code, 'PowerState/')].displayStatus" -o tsv
```

This command should return `VM stopped` as the result.

## Starting a VM

We can do the reverse through the `vm start` command.

```azurecli
az vm start -n SampleVM -g <rgn>[sandbox resource group name]</rgn>
```

This command will start a stopped VM. We can verify it through the `vm get-instance-view` query, which should now return `VM running`.

## Restarting a VM

Finally, we can restart a VM if we have made changes that require a reboot using the `vm restart` command. You can add the `--no-wait` flag if you want the Azure CLI to return immediately without waiting for the VM to reboot.

