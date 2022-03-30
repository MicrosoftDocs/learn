> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still read along.

1. Select **Home** to return to the Azure portal home screen.

1. In the resource menu, select All **Resources**.

1. Select **LabVM**.

1. In Settings, **select Networking.**

   :::image type="content" source="../media/8-exercise-1-settings-networking.png" alt-text="Screen shot showing the networking option.":::

1. Select **Add inbound port rule**.

   :::image type="content" source="../media/8-exercise-1-add-inbound-port-rule.png" alt-text="Screen shot showing the add inbound rule button.":::

1. On the Add inbound security rule blade, type or select the following values:

   1. **Destination port ranges: 22**

   1. **Action: Allow**

   1. **Priority: 100**

   1. **Name: SSH_port_22**

1. Select **Add**.

1. Wait until the security rule has been deployed.

1. In **Settings**, select **Connect**.

1. Select **Test your connection.**

   :::image type="content" source="../media/8-exercise-1-test-connection-button.png" alt-text="screen shot showing the test connection button.":::

1. Select **Test connection.**

1. Notice that connectivity is now allowed and you've resolved the connectivity issue.

:::image type="content" source="../media/8-exercise-1-network-connectivity-allowed.png" alt-text="Screen shot showing that connectivity is now allowed.":::

