Until now, you've been running Bash commands on their own. Bash is powerful when combined with other tools, so let's get some practice by using Bash to filter output from the Azure CLI.

1. Let's say you want to see an up-to-date list of the virtual machine (VM) sizes available in the westus region of Azure. You can do that with this command:

    ```bash
    az vm list-sizes --location westus --output table
    ```

1. You should see a long list of VM types as an output. To narrow down this list to the VM sizes that interest you, you can  use `grep`, Linux's universal pattern-matching program. To find the "DS" sizes, popular for use in data science, use the following command:

    ```bash
    az vm list-sizes --location westus --output table | grep DS
    ```

    This pipes output from the `az` command to `grep`, which filters out lines that lack the "DS" string.

1. That's still a lot of VMs. You know that DS V2 VMs are a more recent series. Let's adjust the `grep` command to use a more intricate regular expression:

    ```bash
    az vm list-sizes --location westus --output table | grep DS.*_v2
    ```

    This filters out lines that don't match the regular expression `DS.*_v2`. You might recognize some of the characters in that expression from our discussion of "wildcards" in an earlier unit. Regular expressions make great use of wildcards.

    Regular expressions are a topic for another module, but come in handy for Bash scripting.

Using Bash with other CLI commands makes the latter easier to work with. And because a sysadmin's work never ends, any tool that reduces the workload is welcome.
