One of the main tasks you'll want to do to running virtual machines is to start and stop them.

## Stopping a VM

We can stop a running VM with the `vm stop` command. You must pass the name and resource group, or the unique ID for the VM:

```azurecli
az vm stop -n SampleVM -g ExerciseResources
```

We can verify it has stopped by attempting to ping the public IP address, using `ssh` or through the `vm get-instance-view` command which returns the same basic data as `vm show` but includes details about the instance itself.

```azurecli
az vm get-instance-view -n SampleVM -g ExerciseResources --query "instanceView.statuses[?starts_with(code, 'PowerState/') == `true`].displayStatus" -o tsv
```

This should return `VM stopped` as the result.

## Starting a VM

We can do the reverse through the `vm start` command.

```azurecli
az vm start -n SampleVM -g ExerciseResources
```

This will start a stopped VM. We can verify it through the `vm get-instance-view` query which should now return `VM running`.

## Restarting a VM

Finally, we can restart a VM if we have made changes that require a reboot. This is done with the `vm restart` command. You can add the `--no-wait` flag if you want the CLI to return immediately without waiting for the VM to reboot.

