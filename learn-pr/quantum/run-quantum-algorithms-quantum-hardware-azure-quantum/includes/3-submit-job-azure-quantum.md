Now you are going to submit a job to Azure Quantum. 

---- This chapter is subjected to changes depending on the chosen framework----

## Pre-requisites

Check that you have an Azure subscription. If you don't have one, you can
create a [free account](https://azure.microsoft.com/free) before you begin.

### Create a quantum workspace

First, you need to create a Quantum Workspace in your Azure subscription and
select the providers you desire to use. To do it follow these steps:

1. Open the [Azure portal](https://ms.portal.azure.com/) and log in with your
   account.

1. Click **Create a resource** and then search for **Azure Quantum**. On the
   results page, you should see a tile for the **Azure Quantum**
   service.

   ![Tile for the Azure Quantum (preview)
   service](../media/azure-quantum-preview-search.png)

1. Click **Azure Quantum** and then click **Create**. This opens a
   form to create a Quantum Workspace.

   ![Create resource for the Azure Quantum (preview)
   service](../media/azure-quantum-preview-create.png)

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
   Workspace](..media/azure-quantum-preview-properties.png)

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

   ![Review and create the Workspace](..media/azure-quantum-preview-terms.png)

## Setup the project and write your program

Next, you'll use Visual Studio Code to create a Q# Project.

1. In VS Code open the **View** menu, and select **Command Palette**.

1. Type `Q#: Create New Project`.

1. Select **Standalone console application**.

1. Select a directory to hold your project, such as your home directory. Enter
   `MyFirstJob` as the project name, then select **Create Project**.

1. From the window that appears at the bottom, select Open new project.

1. You should see two files: the project file and Program.qs, which contains
   starter code. Open `Program.qs`.

1. Start by opening the `MyFirstJob.csproj` file and adding the
   `ExecutionTarget` property, which will give you design-time feedback on the
   compatibility of your program for IonQ's hardware in VS Code.

```xml
<Project Sdk="Microsoft.Quantum.Sdk/0.12.20100504">
  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>netcoreapp3.1</TargetFramework>
    <ExecutionTarget>ionq.qpu</ExecutionTarget>
  </PropertyGroup>
</Project>
```

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

1. Use `quantum workspace set` to select the workspace you created above as the
   default Workspace. Note that you also need to specify the resource group you
   created it in, for example:

   ```dotnetcli
   az quantum workspace set -g MyResourceGroup -w MyWorkspace -o table

   Location     Name                               ResourceGroup
   -----------  ---------------------------------  --------------------------------
   westus       ws-yyyyyy                          rg-yyyyyyyyy

   ```

1. In your quantum workspace, there are different targets available from the
   providers that you added when you created the workspace. You can display a
   list of all the available targets with the command `az quantum target list -o
   table`:

   ```dotnetcli
   az quantum target list -o table

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

   ```dotnetcli
   az quantum execute --target-id ionq.simulator -o table

   .........
   Result     Frequency
   ---------  -----------  -------------------------
   [0]  0.06250000   ▐█                      |
   [1]  0.06250000   ▐█                      |
   ```

This shows an equal frequency for each of the 16 possible states for measuring 4
qubits, which is what we expect from an idealized simulator. This means we're
ready to run it on the QPU.

## Run the program on hardware

To run the program on hardware, we'll use the asynchronous job submission
command `az quantum job submit`. Like the `execute` command this will compile
and submit your program, but it won't wait until the execution is complete. We
recommend this pattern for running against hardware, because you may need to
wait a while for your job to finish. To get an idea of how long you can run `az
quantum target list -o table` as described above.

   ```dotnetcli
   az quantum job submit --target-id ionq.qpu -o table

   Name        Id                                    Status    Target    Submission time
   ----------  ------------------------------------  --------  --------  ---------------------------------
   QuantumRNG  5aa8ce7a-25d2-44db-bbc3-87e48a97249c  Waiting   ionq.qpu  2020-10-22T22:41:27.8855301+00:00
   ```

The table above shows that your job has been submitted and is waiting for its
turn to run. To check on the status, use the `az quantum job show` command,
being sure to replace the `job-id` parameter with the Id output by the previous
command:

   ```dotnetcli
    az quantum job show -o table --job-id 5aa8ce7a-25d2-44db-bbc3-87e48a97249c 

   Name        Id                                    Status    Target    Submission time
   ----------  ------------------------------------  --------  --------  ---------------------------------
   QuantumRNG  5aa8ce7a-25d2-44db-bbc3-87e48a97249c  Waiting   ionq.qpu  2020-10-22T22:41:27.8855301+00:00 
   ```

Eventually, you will see the `Status` in the above table change to `Succeeded`.
Once that's done you can get the results from the job by running `az quantum job
output`:

   ```dotnetcli
   az quantum job output -o table --job-id 5aa8ce7a-25d2-44db-bbc3-87e48a97249c 

   Result     Frequency
   ---------  -----------  -------------------------
   [0,0,0,0]  0.05200000   ▐█                      |
   [1,0,0,0]  0.07200000   ▐█                      |
   [0,1,0,0]  0.05000000   ▐█                      |
   [1,1,0,0]  0.06800000   ▐█                      |
   [0,0,1,0]  0.04600000   ▐█                      |
   [1,0,1,0]  0.06000000   ▐█                      |
   [0,1,1,0]  0.06400000   ▐█                      |
   [1,1,1,0]  0.07600000   ▐██                     |
   [0,0,0,1]  0.04800000   ▐█                      |
   [1,0,0,1]  0.06200000   ▐█                      |
   [0,1,0,1]  0.07400000   ▐█                      |
   [1,1,0,1]  0.08000000   ▐██                     |
   [0,0,1,1]  0.05800000   ▐█                      |
   [1,0,1,1]  0.06800000   ▐█                      |
   [0,1,1,1]  0.05200000   ▐█                      |
   [1,1,1,1]  0.07000000   ▐█                      |
   ```

The histogram you receive may be slightly different than the one above, but you
should find that the states generally are observed with equal frequency.  


TODO
