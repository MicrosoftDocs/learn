In this exercise you'll troubleshoot connection issues between virtual machines running in Azure.

## Create the exercise environment
Using the Cloud Shell on the right, run these commands to create the example topology.  The environment will take approximately 5 minutes to build.

1. Clone the setup script from GitHub.

   ```bash
   git clone https://github.com/MicrosoftDocs/mslearn-troubleshoot-platform-as-service-issues networking
   ```

1. Run the setup script.

   ```bash
   bash networking/setup.sh

   ```

## Exercise

You need to find the causes of connectivity problems to an Azure virtual machine using SSH.

Sign in to the [Azure portal](https://portal.azure.com/) with the same credentials you used to start the sandbox.

1. In the resource menu, select All **Resources**.

1. Select **LabClientVM**.

1. On the top row of the **LabClientVM Overview** page, select **Connect** and select **SSH**.

   :::image type="content" source="../media/7-exercise-1-connect.png" alt-text="screen shot showing the connect option for a virtual machine.":::

1. Select **Test your connection**.
  
   :::image type="content" source="../media/7-exercise-1-test-connection.png" alt-text="Screen shot showing the test your connection option.":::

1. Select Use Network Watcher for detailed connection tracing.

1. In Destination, in Virtual machine, select LabVM.

1. In Preferred IP Version, select IPv4.

1. In Protocol, select TCP.

1. In Destination port type 22 (the port for SSH).

   :::image type="content" source="../media/7-exercise-1-network-watcher.png" alt-text="Screen shot showing the TCP protocol setting.":::

1. Select **Check**.

1. Wait until the connectivity check completes.

1. If the **Status** is **Reachable**, a connection can be made from a virtual machine in the same virtual network.

   :::image type="content" source="../media/7-exercise-1-reachable.png" alt-text="Screen shot showing the status of the connectivity check as reachable.":::

1. At the top of the screen, select **All resources**.

1. Select **LabVM**.

1. Select **Connect** and select **SSH**.

1. Select **Test your connection**.

1. Select **Test connection**.

   :::image type="content" source="../media/7-exercise-1-test-connection-button.png" alt-text="Screen shot showing the test connection button.":::

1. Notice that there's a warning that connectivity is blocked by a security group rule.

   :::image type="content" source="../media/7-exercise-1-connectivity-error.png" alt-text="Screen shot showing the warning that connectivity is blocked due to a security group rule.":::

1. Keep the tab open to the Azure portal for the next exercise.