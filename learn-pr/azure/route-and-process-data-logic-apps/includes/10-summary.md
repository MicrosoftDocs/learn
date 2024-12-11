Now that you created your news monitoring logic app, the marketing and public relations teams can better monitor the athletic shoe market. You can also evaluate the article sentiment and route articles to an Azure Storage container or to a team, based on sentiment.

You automated this business process by building a logic app workflow that integrated different services and systems using Azure Logic Apps. You mapped each step in the workflow to the following operations:

- The **Bing Search** trigger found articles about the shoe industry and launched the subsequent steps, based on the article sentiment. 

- The **Azure Cognitive Services** action analyzed whether the articles were positive, negative, neutral, or mixed.

- The **Condition** control action chose where to route the article, based on sentiment.

- The **Create blob** action added positive articles as blobs to a storage container.

- The **Outlook** action sent emails for non-positive articles.

Imagine the work necessary to create this app from scratch without prebuilt operations, a workflow designer, and the Azure cloud platform. Instead, we'd have to complete the following tasks ourselves:

- Write code to access each service's API.

- Build a polling infrastructure to monitor articles found through the **Bing Search** service, and trigger the logic app workflow when new relevant articles were available.

- Set up and maintain servers to host the app.

Azure Logic Apps made creating this monitoring app easier in the following ways:

- Connectors did the hard work of integrating systems that weren't ever designed to work together.

- Building the app took about an hour without having to write any code or set up any servers.

- You can now analyze new articles about the shoe industry, and business analytics can use the data to shape future products.

Congratulations, now that you created an example logic app workflow, you can try building other logic app workflows that use different operations.

## Clean up your resources

Resources that you leave running can continue to cost you money, so make sure to delete all the resources that you created for this module. If you used a single resource group to create all your resources, you only need to delete the group. If you didn't use the same resource group, you must find and delete individual resources.

### Delete your resource group

When you delete a resource group, you delete all the resources inside that group.

1. In the Azure portal search box, enter and select **Resource groups**.

1. From the resource group list, find and select the resource group that you created for this module.

1. On the resource group toolbar, select **Delete resource group**.

1. In the confirmation box, enter the resource group name, and select **Delete**.

1. Select **Delete** again to confirm deletion.
