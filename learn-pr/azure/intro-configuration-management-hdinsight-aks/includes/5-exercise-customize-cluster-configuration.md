To tune the cluster configuration, a native configuration management feature comes handy. 

In this exercise, you'll use Azure portal to modify or add specific configurations in the Spark cluster created in the previous exercise management.

Note: When you update a configuration, the corresponding service is restarted in a rolling manner.


1. Sign in to [Azure portal](https://ms.portal.azure.com/#home).

1. In the Azure portal search bar, type "HDInsight on AKS cluster" and select "Azure HDInsight on AKS clusters" from the drop-down list.
 
   :::image type="content" source="../media/picture-13.png" alt-text="Screenshot shows Azure portal." lightbox="../media/picture-13.png":::

1. Select your cluster name (mycluster) from the list page.

   :::image type="content" source="../media/picture-31.png" alt-text="Screenshot shows select your cluster name (mycluster) from the list page." lightbox="../media/picture-31.png":::
 
1. Go to the “Configuration management" blade in the left menu.

   :::image type="content" source="../media/picture-14.png" alt-text="Screenshot shows go to the Configuration management." lightbox="../media/picture-14.png":::


### Modifying the existing configuration

1.	Select spark-service -> livy-config
   
    :::image type="content" source="../media/picture-15.png" alt-text="Screenshot shows select spark-service." lightbox="../media/picture-15.png":::
  	
1.	Update “livy.server.session.timeout” to 5600000
1.	Select **OK** and then click **Save**.
1.	On successful update, you will see an alert in the notification pane and your configuration is updated

     :::image type="content" source="../media/picture-16.png" alt-text="Screenshot shows alert in the notification pane." lightbox="../media/picture-16.png":::

 
 
### Adding new configuration

1.	Select spark-service -> livy-config

    :::image type="content" source="../media/picture-17.png" alt-text="Screenshot shows spark-service." lightbox="../media/picture-17.png":::
 
1.	Click on Add button in the bottom right and add “livy.server.session.allow-custom-classpath” and set value as “true”.

    :::image type="content" source="../media/picture-18.png" alt-text="Screenshot shows add livy.server.session.allow-custom-classpath." lightbox="../media/picture-18.png":::
 
1.	Select **OK** and then click **Save**.

1.	On successful update, you will see an alert in the notification pane and your configuration is updated

    :::image type="content" source="../media/picture-19.png" alt-text="Screenshot shows configuration is updated." lightbox="../media/picture-19.png":::

 
