A nodearray is a collection of identically configured nodes of an Azure CycleCloud cluster. Their purpose is to accommodate the horizontal scaling of the cluster compute resources as the number of queued jobs changes. Each nodearray has a name, a set of attributes which apply to each of its nodes, and optional attributes describing how the nodearray should scale.

Partitions group nodes into logical and potentially overlapping sets. Their purpose is to optimize processing of jobs, by accounting for their specific constraints such as resource or time limits. The scheduler allocates jobs to nodes within a partition until their resources are exhausted or all jobs are processed.

You want to modify your newly deployed Azure CycleCloud-managed cluster to account for job-specific resource needs. To accomplish this objective, you decide to apply additional changes to the underlying template and validate your approach. 

## Add a nodearray definition to the Azure CycleCloud template

You'll start by adding a definition of a nodearray within the Slurm template you customized in the previous exercise of this module. The sample template includes two partitions labeled hpc and htc. You will create another partition and the corresponding nodearray intended for jobs that benefit from the CUDA capabilities. 

1. If needed, from your computer, start any Azure portal-compatible web browser, navigate to [the Azure portal](https://portal.azure.com) and, when prompted, authenticate with a Microsoft account or an Azure Active Directory (Azure AD) account that has the Contributor or Owner role in the Azure subscription you are using in this module.
1. From the Azure portal, open the **Cloud Shell** by clicking its icon in the toolbar next to the search text box and ensure that you are running a Bash session.
1. Within the web browser window displaying the Bash session in the Azure Cloud Shell pane, run the following command to set the working directory to the one hosting the GitHub repository you fetched in the previous exercise:

    ```azurecli-interactive
    cd ~/cyclecloud-slurm/templates
    ```

1. Run the following command to open the downloaded template in the nano editor:

    ```azurecli-interactive
    nano slurm.txt
    ```

1. Within the nano editor interface, scroll to the `[parameters About]` section and add the following content directly before it:

    ```azurecli-interactive

    [[nodearray cuda]]
    MachineType = $CUDAMachineType
    ImageName = $CUDAImageName
    MaxCoreCount = $MaxCUDAExecuteCoreCount

    AdditionalClusterInitSpecs = $CUDAClusterInitSpecs

        [[[configuration]]]
        slurm.autoscale = true
        slurm.hpc = false

        [[[cluster-init cyclecloud/slurm:execute]]]

        [[[network-interface eth0]]]
        AssociatePublicIpAddress = $ExecuteNodesPublic

    ```

    > [!NOTE]
    > If you are using a Windows computer, you can paste the content of Clipboard by using the **Shift+Insert** key combination.

    > [!NOTE]
    > Your changes define an extra nodearray.


## Add graphical interface parameters to the Azure CycleCloud template

To provide the ability to modify the values of template parameters via the Azure CycleCloud graphical interface, you'll apply additional changes to the template. 

1. Within the web browser window displaying the Bash session in the Azure Cloud Shell pane, within the nano editor interface, scroll to the `[parameters Auto-Scaling]` section and add the following content directly before it:

    ```azurecli-interactive

        [[[parameter CUDAMachineType]]]
        Label = CUDA VM Type
        Description = The VM type for CUDA execute nodes
        ParameterType = Cloud.MachineType
        DefaultValue = Standard_NC24

    ```

1. Within the nano editor interface, scroll to the `[[[parameter HPCMaxScalesetSize]]]` section and add the following content directly before it:

    ```azurecli-interactive

        [[[parameter MaxCUDAExecuteCoreCount]]]
        Label = Max CUDA Cores
        Description = The total number of CUDA execute cores to start
        DefaultValue = 100
        Config.Plugin = pico.form.NumberTextBox
        Config.MinValue = 0
        Config.IntegerOnly = true

    ```

1. Within the nano editor interface, scroll to the `[[[parameter SchedulerClusterInitSpecs]]]` section and add the following content directly before it:

    ```azurecli-interactive

        [[[parameter CUDAImageName]]]
        Label = CUDA OS
        ParameterType = Cloud.Image
        Config.OS = linux
        DefaultValue = cycle.image.centos7
        Config.Filter := Package in {"cycle.image.centos7", "cycle.image.ubuntu18"}

    ```

1. Within the nano editor interface, scroll to the `[[parameters Advanced Networking]]` section and add the following content directly before it:

    ```azurecli-interactive

        [[[parameter CUDAClusterInitSpecs]]]
        Label = CUDA Cluster-Init
        DefaultValue = =undefined
        Description = Cluster init specs to apply to CUDA execute nodes
        ParameterType = Cloud.ClusterInitSpecs

    ```

1. Within the Nano editor interface, press **ctrl + o** key combination, press the **Enter** key, and then press **ctrl + x** key combination to save the changes you made and close the file.


## Export Azure CycleCloud cluster properties 

Before applying the configuration changes you made in the Azure CycleCloud template to the target cluster, you'll first need to export the cluster properties. 

1. Within the web browser window displaying the Bash session in the Azure Cloud Shell pane, run the following command to list the existing clusters:

    ```azurecli-interactive
    cyclecloud show_cluster
    ```

    > [!NOTE]
    > Verify that the output includes the **contoso-custom-slurm-lab-cluster** entry.


1. Run the following command to export into the file **params.json** the list of parameters of the **contoso-custom-slurm-lab-cluster** cluster and their values:

    ```azurecli-interactive
    cyclecloud export_parameters contoso-custom-slurm-lab-cluster > ~/params.json
    ```

1. Run the following command to review the exported list of parameters and their values:

    ```azurecli-interactive
    cat ~/params.json
    ```

## Edit the properties file to include the new parameters

While the edits you applied to the Azure CycleCloud template included default values for all newly introduced parameters, you might need to modify them to account for your specific requirements. In this task, you'll set the values of the **CUDAMachineType** and **MaxCUDAExecuteCoreCount** parameters.

1. Within the web browser window displaying the Bash session in the Azure Cloud Shell pane, run the following command to open the downloaded parameters file in the nano editor:

    ```azurecli-interactive
    nano ~/params.json
    ```

1. Within the nano editor interface, scroll to end of the file and add the following content starting with a new line before the closing braces (**}**):

    ```azurecli-interactive
       "CUDAMachineType" : "Standard_NC6",
       "MaxCUDAExecuteCoreCount" : 60
    ```

1. Within the nano editor interface, add a comma to the end of the line preceding the line you added in the previous step:

    ```azurecli-interactive
       "CUDAMachineType" : "Standard_NC6"
    ```

1. Within the Nano editor interface, press **ctrl + o** key combination, press the **Enter** key, and then press **ctrl + x** key combination to save the changes you made and close the file.

## Import the modified template and parameters file into the existing cluster

To conclude this exercise, you'll import the modified template and its parameters file into the existing cluster, overriding its current configuration. 

1. Within the web browser window displaying the Bash session in the Azure Cloud Shell pane, run the following command to import the modified template and its parameters file into the existing cluster:

    ```azurecli-interactive
    cyclecloud import_cluster contoso-custom-slurm-lab-cluster --file ~/cyclecloud-slurm/templates/slurm.txt -p ~/params.json -c Slurm --force
    ```

    > [!NOTE]
    > You must specify the name of the target cluster and the --force flag in order to overwrite configuration of the existing cluster.

1. On your computer, open another browser window and navigate to the **https://&lt;IP_address&gt;** URL (replace the **&lt;IP_address&gt;** placeholder with the public IP address of the Azure CycleCloud application server). If prompted, confirm that you want to proceed.
1. If prompted to authenticate, sign in by providing credentials of the same Azure CycleCloud application user account you used to configure Azure CycleCloud CLI.
1. In the Azure CycleCloud graphical interface, navigate to the **Clusters** page, in the list of clusters, select the **contoso-custom-slurm-lab-cluster** entry, and select **Edit**.
1. In the **Edit contoso-custom-slurm-lab-cluster** pop-up window, on the **About** page, select **Next**.
1. On the **Required settings** page, verify the presence of the **CUDA VM Type** entry set to **Standard_NC6** value and the corresponding auto-scaling options:

:::image type="content" source="../media/u4-cyclecloud-cluster-edit-required-settings.png" alt-text="The screenshot depicts the Required Settings page of the Edit contoso-custom-slurm-lab-cluster pop-up window." border="false":::

Congratulations! You successfully completed the second exercise of this module. In this exercise, you further customized your Azure CycleCloud cluster by using a modified template including the definition of a new nodearray with the corresponding partition. To accomplish this, after editing the template, you exported and edited the cluster parameters file and imported it, along with the modified template into the cluster. 
