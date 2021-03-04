One of your R&D team's tightly coupled HPC applications uses hybrid parallelization (MPI+threads) for performance. They've determined that HB120_v2 is the best SKU for this application, and they need to determine where is the optimal place to pin the process and threads.

In the following exercise, you'll follow the procedure that your R&D team used to determine the HB120_v2 NUMA topology, and discover which CPU IDs correspond to which NUMA domains.

[!INCLUDE [azure-optional-exercise-subscription-note](../../../includes/azure-optional-exercise-subscription-note.md)]

1. Open a command prompt where you have the Azure CLI installed.

1. Sign into your Azure account; this will ensure that you have permission to deploy resources.

   ```bash
   az login
   ```

1. Create a resource group; you'll deploy the HB120_v2 VM into this resource group.

   ```bash
   az group create \
      --name <RESOURCE-GROUP_NAME> \
      --location <LOCATION>
   ```

1. Create an HB120_v2 VM that uses the CentOS-HPC 7.8 image from the Azure Marketplace.

   ```bash
   az vm create \
      --resource-group <RESOURCE-GROUP-NAME> \
      --name <VM-NAME> \
      --admin-username azureuser \
      --generate-ssh-keys \
      --image OpenLogic:CentOS-HPC:7_8:latest \
      --size Standard_HB120rs_v2
   ```

   It might take some time for this command to complete. When your VM has been created, take note of the VM's *publicIpAddress*, which will be part of the JSON output. You'll use this IP address in the next step.

1. Log into your HB120_v2 VM using the ssh keys that were automatically generated.

   ```bash
   ssh azureuser@<VM-PUBLIC-IP-ADDRESS>
   ```

1. Install lstopo-no-graphics (from hwloc rpm).

   ```bash
   sudo yum install -y hwloc
   ```

1. Run lstopo-no-graphics to determine the NUMA topology.

   ```bash
   lstopo-no-graphics 2>&1 | tee lstopo-no-graphics.out
    ```

1. Take note of the core IDs and in which NUMA domain nodes they are members.

The mappings of HB120v2 core IDs to the 30 NUMA domains are: 0-3, 4-7, 8-11, 12-15, 16-19, 20-23, 24-27, 28-31, 32-35, 36-39, 40-43, 44-47, 48-51, 52-55, 56-59, 60-63, 64-67, 68-71, 72-75, 76-79, 80-83, 84-87, 88-91, 92-95, 96-99, 100-103, 104-107, 108-111, 112-115, and 116-119.

With this NUMA mapping information, we know where to pin processes and threads. Each process should be mapped to its own NUMA domain. For MPI processes only, try running one, two, three or four processes per NUMA domain and see which mapping gives the best performance (for example: a lower wall clock time). For hybrid parallel applications, group process and its threads in the same NUMA domain. The next MPI unit shows what MPI command-line arguments to use to pin processes to NUMA domains.
