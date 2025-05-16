<!-- markdownlint-disable MD041 -->

Complex or repetitive tasks can be time-consuming and error-prone when performed manually.
Organizations prefer to automate these tasks to reduce costs and avoid mistakes.

Automation is essential in the Customer Relationship Management (CRM) example where you're testing
your software on multiple virtual machines. These machines might need to be continuously deleted and
re-created. Using an Azure CLI script to automate VM creation is much more efficient and reliable
than manually creating them each time.

Beyond the core operation of creating a VM, your script needs to meet a few other requirements:

- **Create multiple VMs**: Use `az vm create` to create multiple uniquely named VMs.
- **Resource group parameter**: Allow the script to accept the name of the resource group as a parameter.

In this unit, you learn how to write and execute an Azure CLI script in a Bash environment that meets these
requirements.

## What is az Azure CLI Bash script?

An Azure CLI script is a text file containing commands and control constructs. The script
executes reference commands, and the control constructs are programming features like loops, variables,
parameters, comments, etc. supplied by Bash.

Azure CLI Bash script files have a `.sh` file extension. You can create and save these files using any
text editor.

Once you create a script, you can execute it from the command line by passing the name of
the file. Precede the file name with a dot for the current directory and a backslash:

```bash
.\myScript.sh
```

## Bash techniques

Bash includes features commonly found in programming languages. For the script you're focusing on in this exercise, you're using three key features: variables, loops, and parameters.

### Variables

In Azure CLI, assigning a value to a variable automatically creates the variable. For example:

```bash
location="eastus"
```

To determine the value stored in a variable, use the `$` prefix and its name:

```bash
echo $location
```

### Loops

Bash has several loop structures, including `until`, `while`, and `for`. The `for` loop is a good choice for scenarios where you need to execute a loop over a set number of values in a collection.

```bash
#!/bin/bash
for i in 1 2 3
do
   echo "Loop $i times"
done
```

### Parameters

When you create an Azure CLI script, you can add parameters to the script and then specify values
for these parameters when executing the script. For example:

```azurecli
.\setupEnvironment.sh parameter1 parameter2 parameter3
```

Inside the script, capture the values into variables. In this example, the parameters are
**loopCount** and **name**:

```azurecli
#!/bin/bash

loopCount=3
name="msdocs"

for i in $(seq 1 $loopCount)
do
    loopName="loop $i for $name"
    echo $loopName
done
```

The output looks like this:

```output
loop 1 for msdocs
loop 2 for msdocs
loop 3 for msdocs
```

You can use parameters as input and a loop to create a set of VMs based on the given
parameters. This approach keeps the script generic and avoids repeating the same code.

## Example script

Here's an example script that demonstrates using variables, loops, and parameters to create multiple
VMs:

```azurecli
#!/bin/bash
    
# Assign parameters to variables
vmCount=$1
adminUserPrefix=$2
shift 2
images=("$@")
    
# Loop 
for i in $(seq 1 $vmCount)
do
    let "randomIdentifier=$RANDOM*$RANDOM"
    resourceGroupName="msdocs-rg-$randomIdentifier"
    location="westus"
    adminUserName="msdocs-$randomIdentifier"
    vmName="msdocs-vm-$randomIdentifier"
    vmImage=${images[$((i-1)) % ${#images[@]}]}

    echo "Creating VM $vmName on $mvImage with admin $adminUserName in resource group $resourceGroupName"

    # create the resource group
    az group create --name $resourceGroupName --location $location

    # create the VM
    az vm create \
        --resource-group $resourceGroupName \
        --location $location \
        --admin-username $adminUserName \
        --name $vmName \
        --image $vmImage \
        --generate-ssh-keys

done

```

### Execute the script

Save the script as `msdocs-script.sh` and run it from a Bash command line, providing the
required parameters:

```bash
./msdocs-script.sh 3  Debian11 Debian11 Ubuntu2204
```

Using this script, you can efficiently create multiple VMs in different resource groups, automate repetitive tasks, and ensure consistency across your Azure environment. In the next unit, let's build out this script to include additional parameters, and check for successful completion.
