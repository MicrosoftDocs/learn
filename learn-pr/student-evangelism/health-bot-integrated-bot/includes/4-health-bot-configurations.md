We have to connect the database to the bot so we can store and retrieve the data we're collecting from the user. To do so, we use the data-connect scenario step. We create the step in the editor and connect it to the steps that collect data from the user.

:::image type="content" source="../media/4-health-bot-data-connection-add.png" alt-text="Screenshot showing the health bot portal scenario." lightbox="../media/4-health-bot-data-connection-add.png":::

In the vitals bot we worked on in the previous module, the data-connect step for the POST method is added between the prompt for the weight variable and the yes-or-no step. The data-connect step has multiple fields that we need to fill. We add a separate data-connect step for the GET method. We add it between the thank-you statement and the final statement. This setup allows the bot to retrieve the name of the person who logged the data so the bot can thank them.

A data-connect cell must make three connections. We already made two connections for both of the data-connect cells. Next, we connect the left node of both data-connect cells to the step for the log error statement.

> [!NOTE]
> The left node of the data-connect step is always used to indicate to the error message.

:::image type="content" source="../media/4-final-prompt.png" alt-text="Screenshot showing the final prompt connection in the health bot.":::

To display some retrieved data, in the final-statement step, fill the **Display text** field with the following code:

`Thank you ${scenario.req.ResultSets.Table1[0].name}. You have checked in at ${scenario.req.ResultSets.Table1[0].ColumnDateTime}`

Select **OK** to save the code.

> [!NOTE]
> In Markdown format, the code in the **Display text** field must be surrounded by single back ticks (*`*), also called *back quotes*.

Configure the following parameters to set up the data-connect step:

- **Data connection**: Sets a reusable data connection object or provides specific connection details for the step.

- **Authentication provider**: Sets a provider to authenticate users or servers before calling the data connection.

- **Options**:

  - **JSON**: Sets the body to a JSON representation of value. It adds the content type `application/json header`. It also parses the response body as JSON.
  - **Resolve with full response**: Indicates whether the promise should be resolved with the full response or just the response body.

- **Base URL**: Must include the HTTPS protocol.

- **Headers**: Must be provided with a JSON or JavaScript object.

- **Payload**: Must be provided with a JSON or JavaScript object.

:::image type="content" source="../media/4-post-health-bot.png" alt-text="Screenshot showing the POST method data connection - connection step.":::

Make the following selections:

- **Data connection**: Select **Step specific connection details**.

- **Authentication provider**: Select **Don't require end-user authentication**.

- **HTTPS method**: Select **POST**.

- **Options**: Select **JSON**.

- **Base URL**: Get this URL from the workflow URL of the healthbot-post workflow we created earlier. In the workflow URL, the base URL is `https://healthbotlearn.azurewebsites.net.443`.

   :::image type="content" source="../media/4-post-url.png" alt-text="Screenshot showing the POST data connection - connection step." lightbox="../media/4-post-url.png":::

- **Path**: Add the remaining part of the workflow URL: `/api/healthbot-post/triggers/man...`

- **Payload**: Add the following code:

   ```
   {
       "name": scenario.name,
       "Age": scenario.Age,
       "Height": scenario.Height,
       "Weight": scenario.Weight
   }
   ```

- **Response variable name**: Provide any variable name, such as *res*.

   > [!Note]
   > The response variable is used in the watch window. On the lower-right side of the page, the watch window shows the structure of the database. It also shows how the data is stored in different variables.

We also have to configure the second data-connect cell for the GET method. We need this setup to retrieve data from the database.

:::image type="content" source="../media/4-get-health-bot.png" alt-text="Screenshot showing the GET data connection - connection step.":::

The configuration for this data-connect step is like the configuration for the POST method step.

- **Data connection**: Select **Step specific connection details**.

- **Authentication provider**: Select **Don't require end user authentication**.

- **HTTPS method**: Select **GET**.

- **Options**: Select **JSON**.

- **Base URL**: Get the base URL from the workflow URL of the healthbot-get workflow we created earlier. In the workflow URL, the base URL is `https://healthbotlearn.azurewebsites.net.443`.

    :::image type="content" source="../media/4-get-url.png" alt-text="Screenshot showing the GET workflow URL." lightbox="../media/4-get-url.png":::

- **Path**: Add the remaining part of the workflow URL: `/api/healthbot-get/triggers/manual...`  

- **Response variable name**: Add any variable name, such as *req*.

You've successfully connected the database to your healthcare bot. The database can now accept data and also display the data in the final message.
