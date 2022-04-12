The Microsoft Azure cloud offers many Virtual Machine sizes with various features.  [GPU optimized VM sizes](https://docs.microsoft.com/azure/virtual-machines/sizes-gpu) are specialized virtual machines available with single, multiple, or fractional GPUs. These sizes are designed for compute-intensive, graphics-intensive, and visualization workloads. In this section, we'll deploy a GPU Accelerated Virtual Machine to host an installation of the NVIDIA Triton Inference Server.  

## Create a GPU Accelerated Virtual Machine

>[!NOTE]
>
> Depending on your Azure Subscription configuration, you may not have the capability to deploy a GPU accelerated Virtual Machine.  If that is the case, you may still proceed with this module by deploying any CPU based Virtual Machine. 

1. Sign in to the [Azure portal](https://portal.azure.com/) and select the menu drop-down in the upper-left, then select **Create a resource**.

    :::image type="content" source="../media/2-create-a-resource.png" alt-text="The create a resource item is shown selected." lightbox="../media/2-create-a-resource.png":::

1. In the resulting screen, look for the **virtual machine** section, then select **create**.

    :::image type="content" source="../media/2-create-virtual-machine.png" alt-text="The create a virtual machine item is shown selected." lightbox="../media/2-create-virtual-machine.png":::

1. In the **Basics** section:
    1. Create a new resource group 
    1. Supply a **Virtual machine name** (must be globally unique)
    1. Choose an appropriate **Region**
    1. Leave **Availability options** as default (No infrastructure redundancy required)
    1. Leave **Security type** as default (Standard)
    1. For **Image** select **Configure VM generation**, then select **Generation 1** then **Apply**
             :::image type="content" source="../media/2-vm-generation.png" alt-text="The virtual machine generation options are shown." lightbox="../media/2-vm-generation.png":::           
        1. Next, select **Ubuntu Server 18.04 LTS - Gen1** in the **Image** section.
    1. Leave **Azure Spot instance** unchecked
    1. For **Size**, if you wish to use a CPU instance then leave this option as-is, to select a GPU accelerated offering select the **See all sizes** option.
        1. To view available GPU offerings in your subscription, select **Add filter** then select **Family**, then select only the **GPU** option and the list will update.
        
            :::image type="content" source="../media/2-gpu-filter.png" alt-text="The GPU filter is shown selected." lightbox="../media/2-gpu-filter.png":::
    
        1. Select an appropriate N-Series option under **Non-premium storage VM sizes** (**NC6** is suggested), then choose **Select**

            :::image type="content" source="../media/2-select-n-series-vm.png" alt-text="The NC6 virtual machine option is shown selected." lightbox="../media/2-select-n-series-vm.png":::
    
    1. In the **Administrator Account** section, select **Password**

    1. The selected options at this point should look like the following.
    
    :::image type="content" source="../media/2-basic-options-1.png" alt-text="The basic options up to this point are shown." lightbox="../media/2-basic-options-1.png":::

    1. Supply a **Username** and **Password** for the **Administrator Account**.
    
    1. In the **Inbound port rules** section, select **Allow selected ports**,  then verify that **Select inbound ports** shows **SSH (22)** is enabled.
    
1. The remaining options should look like the following.  When you've verified your options look correct, select **Review + create**
    
    :::image type="content" source="../media/2-basic-options-2.png" alt-text="The additional basic options up to this point are shown." lightbox="../media/2-basic-options-2.png":::

    1. The resulting screen should show a **Validation passed** message and will present a summary of your virtual machine configuration.  If everything looks good, select **Create** to begin the virtual machine deployment.
    
        :::image type="content" source="../media/2-create-deployment.png" alt-text="The virtual machine summary and create button are shown." lightbox="../media/2-create-deployment.png":::

1. The deployment will create several resources: the virtual machine, a network security group, and a public ip address.  When provisioning is complete, select the **Go to resource** button or navigate to your virtual machine using the Azure portal.

    :::image type="content" source="../media/2-deployment-complete.png" alt-text="The completed deployment options are shown." lightbox="../media/2-deployment-complete.png":::  

1. Copy the **Public IP address** within the virtual machine Overview, and save this value to your text editor of choice.  We'll use this value to access the virtual machine via a terminal emulator such as TeraTerm or [Windows Terminal](https://www.microsoft.com/p/windows-terminal/9n0dx20hk701).

    :::image type="content" source="../media/2-vm-overview.png" alt-text="The virtual machine overview screen is shown with the public ip address highlighted." lightbox="../media/2-vm-overview.png":::
