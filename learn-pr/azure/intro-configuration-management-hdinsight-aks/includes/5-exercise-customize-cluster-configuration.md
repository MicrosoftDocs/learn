To tune the cluster configuration, a native configuration management feature comes handy. 

In this exercise, you'll use Azure portal to modify or add specific configurations in the Spark cluster created in the previous exercise management.

Note: When you update a configuration, the corresponding service is restarted in a rolling manner.


1. Sign in to [Azure portal](https://ms.portal.azure.com/#home).

1. In the Azure portal search bar, type "HDInsight on AKS cluster" and select "Azure HDInsight on AKS clusters" from the drop-down list.
 
   :::image type="content" source="../media/azure-portal.png" alt-text="Screenshot shows Azure portal." lightbox="../media/azure-portal.png":::

1. Select your cluster name (mycluster) from the list page.

   :::image type="content" source="../media/select-your-cluster-name.png" alt-text="Screenshot shows select your cluster name (mycluster) from the list page." lightbox="../media/select-your-cluster-name.png":::
 
1. Go to the “Configuration management" blade in the left menu.

   :::image type="content" source="../media/configuration-management.png" alt-text="Screenshot shows go to the Configuration management." lightbox="../media/configuration-management.png":::


### Modifying the existing configuration

1.	Select spark-service -> livy-config
   
    :::image type="content" source="../media/select-spark-service.png" alt-text="Screenshot shows select spark-service." lightbox="../media/select-spark-service.png":::
  	
1.	Update “livy.server.session.timeout” to 5600000
1.	Select **OK** and then click **Save**.
1.	On successful update, you will see an alert in the notification pane and your configuration is updated

     :::image type="content" source="../media/notification-pane.png" alt-text="Screenshot shows alert in the notification pane." lightbox="../media/notification-pane.png":::

 
 
### Adding new configuration

1.	Select spark-service -> livy-config

    :::image type="content" source="../media/shows-spark-service.png" alt-text="Screenshot shows spark-service." lightbox="../media/shows-spark-service.png":::
 
1.	Click on Add button in the bottom right and add “livy.server.session.allow-custom-classpath” and set value as “true”.

    :::image type="content" source="../media/allow-custom-classpath.png" alt-text="Screenshot shows add livy.server.session.allow-custom-classpath." lightbox="../media/allow-custom-classpath.png":::
 
1.	Select **OK** and then click **Save**.

1.	On successful update, you will see an alert in the notification pane and your configuration is updated

    :::image type="content" source="../media/configuration-updated.png" alt-text="Screenshot shows configuration is updated." lightbox="../media/configuration-updated.png":::

 
