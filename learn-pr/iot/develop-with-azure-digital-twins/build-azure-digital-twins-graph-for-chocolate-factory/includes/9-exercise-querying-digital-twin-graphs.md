
In this final exercise, you create custom queries for your digital twins graph. Before creating the custom queries, you enter a range of property values into the digital twins. Entering these values gives you a bit more data to query.

## Edit the digital twin properties

With all the digital twins in view on the graph, set the production step properties. To set a property:

1. Select the digital twin so that its properties appear in the right pane.

1. Select one or more properties, and enter values by using the keyboard.

1. Select the **Save** icon at the top right. Verify that the properties have been updated in the dialog box that shows the new values.

    :::image type="content" source="../media/explorer-graph-save-properties.png" alt-text="Screenshot of where to find the icon to save properties for a digital twin." lightbox="../media/explorer-graph-save-properties.png":::

Go through this process for each of the three production steps (roasting, grinding, and molding).

### Set the roasting step properties

:::image type="content" source="../media/roasting.png" alt-text="Image of the roasting step." lightbox="../media/roasting.png":::

1. Set **ChasisTemperature** to **120**.

1. Set **RoastingTime** to **35**.

1. Set **PowerUsage** to **150**.

1. Set **FanSpeed** to **3000**.

1. Save the settings.

### Set the grinding step properties

:::image type="content" source="../media/grinding.png" alt-text="Image of the grinding step." lightbox="../media/grinding.png":::

1. Set **ChasisTemperature** to **40**.

1. Set **GrindingTime** to **45**.

1. Set **PowerUsage** to **250**.

1. Set **Force** to **200**.

1. Save the settings.

### Set the molding step properties

:::image type="content" source="../media/molding.png" alt-text="Image of the molding step." lightbox="../media/molding.png":::

1. Set **ChasisTemperature** to **55**.

1. Set **PowerUsage** to **80**.

1. Set **FinalStep** to **true**.

1. Save the settings.

## Query the graph

Now run through a range of queries. Copy and paste the following queries into the query text box, and select **Run Query** each time:

- Verify the final step of the production line:

    ```sql
    SELECT  *  FROM DIGITALTWINS T   WHERE T.FinalStep = true
    ```

    :::image type="content" source="../media/explorer-query-finalstep.png" alt-text="Screenshot showing a query to show a twin based on a Boolean property." lightbox="../media/explorer-query-finalstep.png":::

- You should now only see the molding step. To recover all the models in a graph, you can enter the following query:

    ```sql
    SELECT  *  FROM DIGITALTWINS T   WHERE IS_DEFINED(T.$dtId)
    ```

    :::image type="content" source="../media/explorer-query-all-models.png" alt-text="Screenshot showing a query to show all twins in the graph." lightbox="../media/explorer-query-all-models.png":::

- You can query the `$dtId` value for equality:

    ```sql
    SELECT  *  FROM DIGITALTWINS T   WHERE T.$dtId = 'factory'
    ```

    :::image type="content" source="../media/explorer-query-equality.png" alt-text="Screenshot showing a query based on an equality comparison." lightbox="../media/explorer-query-equality.png":::

- You can use the string comparison function `ENDSWITH` to locate the production steps:

    ```sql
    SELECT  *  FROM DIGITALTWINS T   WHERE ENDSWITH(T.$dtId,'ing')
    ```

    :::image type="content" source="../media/explorer-query-endswith.png" alt-text="Screenshot showing a query based on the ENDSWITH function." lightbox="../media/explorer-query-endswith.png":::

- String comparisons will work with a single letter:

    ```sql
    SELECT  *  FROM DIGITALTWINS T   WHERE STARTSWITH(T.$dtId,'f')
    ```

    :::image type="content" source="../media/explorer-query-startswith.png" alt-text="Screenshot showing a query based on the STARTSWITH function." lightbox="../media/explorer-query-startswith.png":::

- Use `AND` or `OR` to combine elements:

    ```sql
    SELECT  *  FROM DIGITALTWINS T   WHERE STARTSWITH(T.$dtId,'prod') OR ENDSWITH(T.$dtId,'r')
    ```

    :::image type="content" source="../media/explorer-query-or.png" alt-text="Screenshot showing a query that uses OR to combine elements." lightbox="../media/explorer-query-or.png":::

- When you're looking for whether an item is within a list, use the `IN` keyword:

    ```sql
    SELECT  *  FROM DIGITALTWINS T   WHERE T.$dtId IN ['factory','grinding']
    ```

    :::image type="content" source="../media/explorer-query-in.png" alt-text="Screenshot showing a query based on searching in a list." lightbox="../media/explorer-query-in.png":::

- To test the property settings, use numerical comparisons:

    ```sql
    SELECT  *  FROM DIGITALTWINS T   WHERE T.ChasisTemperature > 50
    ```

    :::image type="content" source="../media/explorer-query-numerical.png" alt-text="Screenshot showing a query based on a numerical value." lightbox="../media/explorer-query-numerical.png":::

- Combine numerical comparisons:

    ```sql
    SELECT  *  FROM DIGITALTWINS T   WHERE T.PowerUsage > 100 AND T.ChasisTemperature >= 55
    ```

    :::image type="content" source="../media/explorer-query-and.png" alt-text="Screenshot showing a query that uses AND to combine elements." lightbox="../media/explorer-query-and.png":::

## Next steps

Great work! You've completed all the exercises in this module. The next unit summarizes what you've learned.

To finish this module and earn your rewards, complete a final knowledge check.
