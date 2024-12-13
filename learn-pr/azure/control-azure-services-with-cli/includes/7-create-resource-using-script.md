<!-- markdownlint-disable MD041 -->

Complex or repetitive tasks can be time-consuming and error-prone when performed manually.
Organizations prefer to automate these tasks to reduce costs and avoid mistakes.

Automation is essential in the Customer Relationship Management (CRM) example, where you're testing
your software on multiple Linux virtual machines (VMs) that need to be continuously deleted and
re-created. Using a PowerShell script to automate VM creation is much more efficient and reliable
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

> [!TIP]
> If you're writing Azure CLI scripts, consider using Visual Studio Code (VS Code), which is free
> and supported on Windows, Linux, and macOS. The `Azure CLI tools` extension for VS Code offers features
> like syntax highlighting and a list of available commands.

The following screenshot is an example of VS Code with a sample script to connect to Azure and
create a virtual machine:

![Screenshot of VS Code with a PowerShell script to create a virtual machine in Azure.](../media/7-vs-code-azure-cli-extension-screenshot.png)

Once you create a script, you can execute it from the command line by passing the name of
the file preceded by a dot for the current directory and a backslash:

```bash
.\myScript.sh
```

## Bash techniques

Bash includes features commonly found in programming languages. For the script you're focusing on in this exercise, you will be using three key features: variables, loops, and parameters..

### Variables

In Azure CLI, assigning a value to a variable automatically creates the variable. For example:

```powershell
location="eastus"
```

To determine the value stored in a variable, use the `$` prefix and its name:

```bash
echo $location
```

### Loops

Bash has several loop structures, including `until`, `while`, and `for`. The `for` loop is a good choice for scenarios where you need to execute a loop over a set number of values in a collection.

```powershell
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

# Variable block
loopCount=3
name="msdocs"

for i in $(seq 1 $loopCount)
do
    loopName="loop $i for $name"
    echo $loopName
done
```

Your output should look similar to this:

```output
loop 1 for msdocs
loop 2 for msdocs
loop 3 for msdocs
```

You can use parameters as input and a loop to create a set of VMs based on the given
parameters. This approach keeps the script generic and avoids repeating the same code.

### Create an Azure CLI script

Here's an example script that demonstrates using variables, loops, and parameters to create multiple
VMs:

```azurecli
#!/bin/bash
    
# Assign parameters to variables
vmCount=$1
resourceGroup=$2
location=$3
vmNamePrefix=$4
adminUserPrefix=$5
shift 5
images=("$@")
    
# Loop 
for i in $(seq 1 $vmCount)
do
    let "randomIdentifier=$RANDOM*$RANDOM"
    adminUserName=$adminUserPrefix-$randomIdentifier
    name=$vmNamePrefix-$randomIdentifier
    image=${images[$((i-1)) % ${#images[@]}]}

    echo "Creating VM $name on $image with admin $adminUserName"

    az vm create \
        --resource-group $resourceGroup \
        --location $location \
        --name $name \
        --generate-ssh-keys \
        --admin-username $adminUserName \
        --image $image

done

```

### Execute the script

Save the script as `msdocs-script.sh` and run it from a Bash command line, providing the
required parameters:

```powershell
# make your file executable
chmod +x msdocs-script.sh

# remove Windows line continuation characters
sed -i -e 's/\r$//' msdocs-script.sh

# Run the script
./msdocs-script.sh 3 msdocs-rg-12345 eastus2 msdocsvm msdocsadmin Debian11 Debian11 Ubuntu2204

# Wait for completion

# List the new VMs
az vm list -o table
```

Using Azure CLI scripts, you can efficiently create multiple VMs in different resource groups, automating
repetitive tasks and ensuring consistency across your Azure environment.
