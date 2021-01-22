
You are ready to connect to Earth's Azure Quantum services and start solving problems on a real quantum computer. The programs you created in Q#  in previous modules, such as the quantum random number generator, will run using real qubits rather than simulated ones like you did in the module [Create your first Q# program by using the Quantum Development Kit](https://docs.microsoft.com/en-us/learn/modules/qsharp-create-first-quantum-development-kit/).

To do so, in this part you learn how to submit a job to Azure Quantum.

## Install the quantum extension

Azure Quantum uses the Azure CLI quantum extension to enable submitting Q# programs from the command line. Now you are going to install and configure the Azure CLI extension on your system to use Azure Quantum. To install it, follow these steps:

1. Ensure you have installed the latest version of [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest) (version 2.5.0 or higher).

1. Open a command prompt, and then run the following command:

```azurecli
az extension add --source https://msquantumpublic.blob.core.windows.net/az-quantum-cli/quantum-latest-py3-none-any.whl
```

## Create a quantum workspace

First, you need to create a Quantum Workspace in your Azure subscription and
select the providers you desire to use, in case you haven't already. To do it follow these steps:

1. Open the [Azure portal](https://ms.portal.azure.com/) and log in with your
   account.

1. Click **Create a resource** and then search for **Azure Quantum**. On the
   results page, you should see a tile for the **Azure Quantum**
   service.

   ![Tile for the Azure Quantum (preview)
   service](../media/3-azure-quantum-preview-search.png)

1. Click **Azure Quantum** and then click **Create**. This opens a
   form to create a Quantum Workspace.

   ![Create resource for the Azure Quantum (preview)
   service](../media/3-azure-quantum-preview-create.png)

1. Fill out the details of your Workspace:
   - **Subscription:** The subscription that you want to associate with this
     Workspace.
   - **Resource group:** The resource group that you want to assign this
     Workspace to.
   - **Name:** The name of your Quantum Workspace.
   - **Region:** The region for the Workspace.
   - **Storage Account**: The Azure storage account to store your jobs and
     results. If you don't have an existing storage account, click **Create a
     new storage account** and complete the necessary fields. We recommend using
     the default values.

   ![Properties for the Azure Quantum
   Workspace](../media/3-azure-quantum-preview-properties.png)

   > [!NOTE]
   > You must be an Owner of the selected resource group to create a
   > new storage account. For more information about how resource groups work in
   > Azure, see [Control and organize Azure resources with Azure Resource
   > Manager](https://docs.microsoft.com/learn/modules/control-and-organize-with-azure-resource-manager/).

1. After completing the information, click the **Providers** tab to add
   providers to your Workspace. A provider gives you access to a quantum
   service, which can be quantum hardware, a quantum simulator, or an
   optimization service. In this case we are interested in quantum hardware and
   we will use the IonQ provider example, but the steps should be valid for
   other quantum hardware provider.

1. Add at least the IonQ provider, then click **Review + create**.

1. Review the settings and approve the *Terms and Conditions of Use* of the
   selected providers. If everything is correct, click on **Create** to create
   your Quantum Workspace.

   ![Review and create the Workspace](../media/3-azure-quantum-preview-terms.png)

## Setup the project and write your program

Next, you'll use Visual Studio Code to create a Q# Project.

1. In VS Code open the **View** menu, and select **Command Palette**.

1. Type `Q#: Create New Project`.

1. Select **Standalone console application**.

1. Select a directory to hold your project, such as your home directory. Enter
   `MyFirstJob` as the project name, then select **Create Project**.

1. From the window that appears at the bottom, select **Open new project**.

1. You should see two files: the project file and `Program.qs`, which contains
   starter code.

1. Start by opening the `MyFirstJob.csproj` file and adding the
   `ExecutionTarget` property, which will give you design-time feedback on the
   compatibility of your program for IonQ's hardware in VS Code.

    ```xml
    <PropertyGroup Sdk="Microsoft.Quantum.Sdk/y.yy.yyyyyyyy">
        <OutputType>Exe</OutputType>
        <TargetFramework>netcoreapp3.1</TargetFramework>
        <ExecutionTarget>ionq.qpu</ExecutionTarget>
      </PropertyGroup>
    </Project>
    ```

   with `yy.yy.yyyyyyyy` being the number of the last version of the Quantum
   Development Kit. If your QDK Visual Studio Code extension is updated, the
   version should already be up to date.

1. Replace the contents of `Program.qs` with the program:

    ```qsharp
    namespace MyFirstJob {
        open Microsoft.Quantum.Intrinsic;
        open Microsoft.Quantum.Measurement;
        open Microsoft.Quantum.Canon;
    
        @EntryPoint()
        operation TestSuperposition() : Result {
            using (q = Qubit())  {
                H(q);
                return M(q);
            }
        }
    }
    ```

This program prepares a qubit in an even superposition and then measures
it. It's simple but enough to show how to submit a job.

## Prepare the Azure CLI

Next, you prepare your environment to submit the job using the workspace
you created.

1. Use `az quantum workspace set` to select the workspace you created above as the
   default Workspace. Note that you also need to specify the resource group you
   created it in, for example:

   ```dotnetcli
   az quantum workspace set -g MyResourceGroup -w MyWorkspace -o table
   ```

   You should obtain the data of your workspace as output.

   ```output
   Location     Name         ProvisioningState    ResourceGroup    Usable  
   -----------  -----------  -------------------  ---------------  --------
   westus       MyWorkspace  Succeeded            MyResourceGroup  Yes  

   ```

1. In your quantum workspace, there are different targets available from the
   providers that you added when you created the workspace. You can display a
   list of all the available targets with the command `az quantum target list -o
   table`:

   ```azurecli
   az quantum target list -o table
   ```

   You should obtain a list like this one:

   ```output
   Provider    Target-id                                       Status     Average Queue Time
   ----------  ----------------------------------------------  ---------  --------------------
   ionq        ionq.qpu                                        Available  0
   ionq        ionq.simulator                                  Available  0
   ```

    > [!NOTE]
    > When you submit a job in Azure Quantum it will wait in a queue
    > until the provider is ready to run your program. The `Average Queue Time`
    > column of the target list command shows you how long other jobs which have
    > been run recently waited to be execute. This can give you an idea of how
    > long you might have to wait.

In this case, we see that IonQ has two different targets, a quantum processing
unit (QPU) and a simulator. The quantum processing unit is a trapped ion quantum
computer with 11 qubits. The simulator is a GPU-accelerated simulator
supporting up to 29 qubits with the same characteristics than the QPU, making it
perfect to test jobs before running them on actual quantum hardware.

## Simulate the program

Before you run a program against real hardware, we recommend simulating it first
(if possible, based on the number of qubits required) to help ensure that your
algorithm is doing what you want.

Run your program with `az quantum execute --target-id ionq.simulator -o table`.
This command will compile your program, submit it to Azure Quantum, and wait
until IonQ has finished simulating the program. Once it's done it will output a
histogram which should look like the one below:

   ```azurecli
   az quantum execute --target-id ionq.simulator -o table

   ..
   Result    Frequency
   --------  -----------  -------------------------
   0         0.50000000   ▐██████████             |
   1         0.50000000   ▐██████████             |
   ```

This shows an equal frequency for each of the 2 possible qubit measurement results,
which is what we expect from an idealized simulator. This means we're
ready to run it on the QPU.

## Run the program on hardware

To run the program on hardware, we'll use the asynchronous job submission
command `az quantum job submit`.

1. Run in the Azure command line:

   ```azurecli
   az quantum job submit --target-id ionq.qpu -o table
   ```

   Like the `execute` command, this will compile
   and submit your program, but it won't wait until the execution is complete. We
   recommend this pattern for running against hardware, because you may need to
   wait a while for your job to finish. To get an idea of how long you can run `az
   quantum target list -o table` as described above. You should obtain something
   like this:

   ```output
   Name        Id                                    Status    Target    Submission time
   ----------  ------------------------------------  --------  --------  ---------------------------------
   QuantumRNG  yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy  Waiting   ionq.qpu  2020-10-22T22:41:27.8855301+00:00
   ```

1. Track the status of your job using `az quantum job show` command. To check on
   the status, use the `az quantum job show` command, being sure to replace the
   `job-id` parameter with the `Id` output by the previous command:

   ```azurecli
    az quantum job show -o table --job-id yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy
   ```

   You should obtain an output like this:

   ```output
   Name        Id                                    Status    Target    Submission time
   ----------  ------------------------------------  --------  --------  ---------------------------------
   QuantumRNG  yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy  Waiting   ionq.qpu  2020-10-22T22:41:27.8855301+00:00 
   ```

1. Eventually, you will see the `Status` in the above table change to `Succeeded`.
   Once that's done you can get the results from the job by running `az quantum job output`:

   ```azurecli
   az quantum job output -o table --job-id yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy
   ```

   And the output should be similar to this:

   ```output
   Result    Frequency
   --------  -----------  ------------------------
   0         0.47200000   ▐█████████             |
   1         0.52800000   ▐██████████            |
   ```

The histogram you receive is the averaged results over the number of **shots**
or iterations that the computer has run the program. Remember that quantum
programs are probabilistic, and thus we need to run them many times to see
output of the relevant statistics. In this case, the quantum computer has run
the program above 500 times, because the default value of the argument `shots`
is 500.

### Set the number of shots

To change the number of shots you need to specify a different value for the
argument `--shots`. For example, if you want to run the program only once:

1. Set the number of shots to 1:

```azurecli
az quantum job submit --target-id ionq.qpu --shots 1 -o table
```

1. After the status of the job changes to `Succeeded`, extract the output of the job:

```azurecli
az quantum job output -o table --job-id yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy
Result    Frequency
--------  -----------  -------------------------
1         1.00000000   ▐████████████████████   |
```

In this case, we obtained `1` as the result of the bit generated by measuring the
superposed qubit in the ion trapped quantum computer.

Congratulations, you learned how to use Azure Quantum to create a true quantum random bit generator! However, we don't want quantum computers just to
generate random numbers.

In the next sections, you'll learn about the different targets available to run your algorithms.
