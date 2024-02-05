If you host an API that includes its original URL in responses, clients may be able to bypass your API Management policies by connecting directly to the API. You can prevent that by masking the original URL in API responses.

The Census API example includes its URL in this way. You want to make sure that all requests go through API Management.

In this unit, you learn how to mask some of the data returned in the body of the Census API. You use a transformation policy to rewrite the URL data exposed in the body of the response.

## Mask URLs

The following exercise demonstrates how to apply the **Mask URL** transformation policy within API Management.

:::image type="content" source="../media/3-remove-header.png" alt-text="Screenshot of the Design tab with the Policies icon highlighted in the Outbound processing section.":::

1. Sign into the [Azure portal](https://portal.azure.com/) using the same account you used in the previous exercise.

1. On the Azure portal menu or from the **Home** page, select **All Resources**, and then select your API Management instance.

1. In the left menu pane, Under **APIs**, select **APIs**, and in the middle pane, select **Census Data**.

1. In the top menu bar, select the **Design** tab, and then select **All operations**.

1. In the **Outbound** processing section, select the **</>** icon. The XML policy editor appears.

1. Inside the `<outbound>` element, below the `<set-header-name>` element you added previously, add the following element:

    ```XML
    <redirect-content-urls />
    ```

1. Select **Save**.

## Test the new policy

We can use the **Test** tool in the Azure portal to check that the policy behaves as we want:

1. Select **Census Data** again, and in the top menu bar, select the **Test** tab.

1. Select **GetLatestCensus**, and then select **Send**.

   :::image type="content" source="../media/5-test-mask-url.png" alt-text="Screenshot of the test screen for the GetLatestCensus operation of the Census Data API. The Send button is  highlighted.":::

You should now see how the **Mask URL** transformation policy has altered the links within the response body to the API Management endpoints. You should see the name of your API Management instance in the URL.

:::image type="content" source="../media/5-test-results.png" alt-text="Screenshot of an HTTP response with the href value highlighted, showing that the URL has been masked.":::
