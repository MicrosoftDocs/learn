To tune the cluster configuration, a native configuration management feature comes handy. 

In this exercise, you'll use Azure portal to modify or add specific configurations in the Spark cluster created in the previous exercise management.

Note: When you update a configuration, the corresponding service is restarted in a rolling manner.


1. Sign in to [Azure portal](https://ms.portal.azure.com/#home).

1. In the Azure portal search bar, type "HDInsight on AKS cluster" and select "Azure HDInsight on AKS clusters" from the drop-down list.
 
 :::image type="content" source="./media/Picture13.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="./media/Picture13.png":::

1. Select your cluster name (mycluster) from the list page.

 :::image type="content" source="./media/Picture31.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="./media/Picture31.png":::
 
1. Go to the “Configuration management" blade in the left menu.

   :::image type="content" source="./media/Picture14.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="./media/Picture14.png":::


### Modifying the existing configuration

1.	Select spark-service -> livy-config

  :::image type="content" source="./media/Picture15.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="./media/Picture15.png":::

2.	Update “livy.server.session.timeout” to 5600000
3.	Select **OK** and then click **Save**.
4.	On successful update, you will see an alert in the notification pane and your configuration is updated

  :::image type="content" source="./media/Picture16.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="./media/Picture16.png":::

 
 
### Adding new configuration

1.	Select spark-service -> livy-config

  :::image type="content" source="./media/Picture17.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="./media/Picture17.png":::
 

2.	Click on Add button in the bottom right and add “livy.server.session.allow-custom-classpath” and set value as “true”.

  :::image type="content" source="./media/Picture18.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="./media/Picture18.png":::

 
3.	Select **OK** and then click **Save**.

4.	On successful update, you will see an alert in the notification pane and your configuration is updated

  :::image type="content" source="./media/Picture19.png" alt-text="Screenshot showing the stages during cluster creation for script action." lightbox="./media/Picture19.png":::

 
