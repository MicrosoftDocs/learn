We have to connect the database to the bot, to store/retrieve the data being collected from the user. To do so, we need to use the 'Data Connect' scenario step. We can do this by dragging it to the Designer window and connecting it to the steps that collect the data from the user.

:::image type="content" source="../media/4-health-bot-portal-scenario.png" alt-text="Healthbot portal scenario":::

In the vitals bot that we previously worked on during the 'Enhanced Healthcare Bot' module, the data connect step for POST method gets added between the prompt with weight variable and the Yes or No step. The data connection step has multiple fields that need to be filled by us. A separate data connect step needs to be added for Get method that will be added between Thank you statement step and Final statement step. This helps the bot to retrieve the name of the person who logged in their data and greet them Thank you.

A data connect cell has three connections to make. We have already made two connections for both the data connect cells. For the last connection, connect the left of the both data connect cells to the Log error statement step.

> [!Note]
> The left node of the data connect step is always used to indicate to the error message.

:::image type="content" source="../media/4-final-prompt.png" alt-text="Final prompt connection step Healthbot":::

To display some retrieved data, the display text field from the Final Statement step needs to be filled with the following code:

`Thank you ${scenario.req.ResultSets.Table1[0].name}.You have checked in at ${scenario.req.ResultSets.Table1[0].ColumnDateTime} `

Select **Ok** to save it.

> [!Note]
> While entering the code in the Display text field, it is must for the code to be within two left quotes/backtick (`<code>`)

- **Data Connection:** Gives the users a choice to select a reusable data connection object or to provide specific connection details for this step.

- **Authentication provider:** Gives the users a choice in selecting a provider for authenticating end-users or servers before calling this data connection.

- **Options:**

  - **JSON:** Sets body to JSO representation of value and adds Content-type: application/json header. Additionally, it parses the response body as JSON.
  - **Resolve with full response:** Set whether the promise should be resolved with the full response or just the response body.

- **Base URL:** It must include the HTTPS protocol.

- **Headers:** Needs to be provided with a JSON or JavaScript object.

- **Payload:** Needs to be provided with a JSON or JavaScript object.

:::image type="content" source="../media/4-post-health-bot.png" alt-text="POST method Data connection - connection step":::

The configuration of the data connection step needs to be done in the following way:

- **Data connection:** Select 'Step specific connection details' from the dropdown.

- **Authentication provider:** Select 'Don't require end-user authentication' .

- **HTTPS Method:** Select 'POST'.

- **Options:** Select the 'JSON' checkbox.

- **Base URL:** We can get the base URL from the Workflow URL of the healthbot-post workflow which we created earlier.

:::image type="content" source="../media/4-post-url.png" alt-text="POST Data connection - connection step":::

From the Workflow URL, take 'https://healthbotlearn.azurewebsites.net.443' for the Base URL.

- **Path:** The remaining part of the workflow URL goes into path, i.e, '/api/healthbot-post/triggers/man...'

- **Payload:** Give the following code in the payload section

   ```
   {
       "name": scenario.name,
       "Age": scenario.Age,
       "Height": scenario.Height,
       "Weight": scenario.Weight
   }
   ```

- **Response Variable name:** : Give it any variable name. We have used 'res'

We also have to configure our second data connect cell for the GET method (to retrieve data from the database).

:::image type="content" source="../media/4-get-health-bot.png" alt-text="GET Data connection - connection step":::

The configuration for this data connect step is similar to that of the POST method.

- **Data connection:** Select 'Step specific connection details' from the dropdown.

- **Authentication provider:** Select 'Don't require end user authentication' .

- **HTTPS Method:** Select 'GET'.

- **Options:** Select the 'JSON' checkbox.

- **Base URL:** We can get the base URL from the Workflow URL of the healthbot-get workflow which we created earlier.

:::image type="content" source="../media/4-get-url.png" alt-text="GET workflow url":::

From the Workflow URL, take 'https://healthbotlearn.azurewebsites.net.443' for the Base URL

- **Path:** The remaining part of the workflow URL goes into path, i.e, '/api/healthbot-get/triggers/manual...'  

- **Response Variable name:** : Give it any variable name. We have used 'req'.

With this you have successfully connected the database to your healthcare bot. The database can now accept data and also display the data in the final message.

> [!Note]
> The response variable name is given to a variable used in the watch window. The watch window on the right-side bottom of the page, is the place where you can view the structure of the database and also see how the data is stored into different variables.
