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

Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the same credentials you used to start the sandbox.

1. In the resource menu, select All **Resources**.

1. Select **LabClientVM**.

1. On the top row of the **LabClientVM Overview** page, select **Connect** and select **SSH**.

   :::image type="content" source="../media/7-exercise-1-connect.png" alt-text="screen shot showing the connect option for a virtual machine.":::

1. Notice that there is a **Test your connection** link. This provides a troubleshooter to test connections between resources, but this functionality is not available in this sandbox and we will view the settings manually.
  
   :::image type="content" source="../media/7-exercise-1-test-connection.png" alt-text="Screen shot showing the test your connection option.":::

1. Select **Networking**.

1. In the **Network security group** section, notice that there is a rule at the top of the priority list that will allow TCP connections on port 22.

    :::image type="content" source="../media/7-exercise-1-network-rule-allow.png" alt-text="Screenshot of rule to allow SSH" lightbox="../media/7-exercise-1-network-rule-allow.png":::

1. At the top of the screen, select **All resources**.

1. Select **LabVM**.
1. Select **Networking**.

1. In the **Network security group** section, notice that there is not a rule at the top of the priority list that will allow TCP connections on port 22.

    :::image type="content" source="../media/7-exercise-1-network-rule-deny.png" alt-text="Screenshot showing that there is no rule to allow SSH connections." lightbox="../media/7-exercise-1-network-rule-deny.png":::

1. Notice that, except for load balancers and virtual networks, the highest priority rule will deny all inbound traffic. This will cause connectivity problems.

1. Keep the tab open to the Azure portal for the next exercise. 