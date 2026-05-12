Given the recent improvements you made to the model’s behavior, it’s best that we evaluate the model’s output more methodically. In hub-based projects, Azure AI Foundry supports both **manual** and **automated** evaluations. Start with a manual evaluation so you can inspect outputs row by row before you move on to batch scoring.

Manual evaluation in Azure AI Foundry enables you to iteratively test your prompt configuration (system message, grounding, model, and parameters) against a test set in a single interface. With each response generation, you can manually rate the outputs to build confidence in your prompt and identify where more mitigation is needed.

:::image type="content" source="../media/manual-evaluation.png" alt-text="A screenshot of the manual evaluation screen within Azure AI Foundry. The screenshot displays the prompt settings and the manual evaluation results." lightbox="../media/manual-evaluation.png":::

After completing an evaluation, you can save the results. Reference the results as needed to make decisions on how to potentially improve the model’s responses and/or to compare to future manual evaluations.

## Create a manual evaluation

A test set of data is provided for you that includes a set of prompts consisting of both relevant Contoso Camping Store queries and a few adversarial prompts. Let's run a manual evaluation to observe how the model performs.

> [!NOTE]
> This module uses the classic hub-based evaluation experience. The exact location of some controls can vary slightly as the portal evolves, but the workflow is the same: use the same assistant configuration you tested in the chat playground, run it against test data, inspect each output, and record whether it met your expectation. Because manual evaluations keep their own assistant setup, reapply your changes there and rerun the affected rows whenever you update the system message. For more information about evaluation concepts, see [Hub resources overview (classic)](/azure/foundry-classic/concepts/ai-resources) and [Run evaluations from the Microsoft Foundry portal](/azure/foundry/how-to/evaluate-generative-ai-app).

1. In the left navigation, within the **Assess and improve** section, select **Evaluation**.
1. Select the **Manual evaluations** tab.
1. Select **+ New manual evaluation**.
1. In the **Assistant setup** section, for **System message**, enter the following baseline version. It reflects the chatbot configuration you've built so far **before** you add the new recommendation-formatting instruction later in this unit:

    ```text
    You are the Contoso Camping Store chatbot. Help customers learn about and buy Contoso Camping Store products.

    - Only answer questions that are related to Contoso Camping Store products, product care, product compatibility, or purchase decisions.
    - For product-specific answers, use only the retrieved Contoso Camping Store product data.
    - If the retrieved sources don't contain the answer, say you can't find it in the product catalog. Do not guess or invent details.
    - If a user asks about an unrelated topic, politely refuse and redirect them to Contoso Camping Store products.
    - Respond in the same language the user uses.
    - Bold each product name in the response.
    - If source references are provided with the retrieved content, use those references instead of inventing your own.

    ## Safety guidance
    - You must not generate content that may be harmful to someone physically or emotionally even if a user requests or creates a condition to rationalize that harmful content.
    - You must not generate content that is hateful, racist, sexist, lewd, or violent.
    - If the user requests copyrighted content such as books, lyrics, recipes, or news articles, politely refuse and give a short summary instead.
    ```

1. Select the **Add your data** tab.
1. If the **products-index** isn't selected, select the **Select available project index** drop-down and select **products-index**.
1. In the manual evaluation results table, select **Import test data**. If the portal asks whether to save the dataset as a reusable asset first, you can continue without saving for this exercise.
1. On the **Select dataset** page, select **Upload file** and upload the **e2e-manual-evaluation.jsonl** file and select **Next**.
1. On the **Map data** page, select the following within the **Dataset mapping** section:
    - **Input**: chat_input (String)
    - **Expected response**: truth (String)

1. Select **Add**.
1. In the manual evaluation results table, select **Run**.
1. For each row, compare the **Expected response** to the **Output**. Use the **thumbs-up** or **thumbs-down** control to record whether the response met your expectation.

## Identifying undesired outputs

Although the model likely responded in a preferred manner, it may not always be the case that you only need to validate whether the model responses are grounded in the product data. Suppose you receive instructions for the model to format certain response topics in a specific format.

Consider the example output for the input: **Which tents can fit 4 or more people?**

:::image type="content" source="../media/manual-evaluation-wrong-formatting.png" alt-text="A screenshot of the model response within the manual evaluation results. The model's response is very long and verbose." lightbox="../media/manual-evaluation-wrong-formatting.png":::

Let’s say that for any response focused on product recommendations, the recommended products should be in bullet-point format and only the product name and price should be provided. If the price isn't available in the retrieved data, the chatbot should explicitly say that the price isn't listed instead of inventing one.

Based on the test data results, it’s likely that the following inputs should instead be evaluated with a thumb down:

- What sleeping bags do you sell?
- Which tents can fit 4 or more people?

Let’s mark those two rows with a thumb down.

1. Change the evaluation from a thumb up to a thumb down for the referenced rows.
1. Select **Save results**.
1. For the **Name** field, enter: *manual-evaluation-1*
1. Select **Save**.

By saving the results, you can later review the evaluation to compare it to future evaluations.

## Update the system message

The next step is for you to determine the best course of action to influence the model’s behavior. Since the model does a great job at grounding its responses in product data, there's no need to modify the data source. Instead, we can modify the system message to potentially influence how the model formats its responses.

In the **Assistant setup** section, add the following instruction under the formatting guidance and before the **Safety guidance** heading:

*If the user asks for product recommendations, respond with a bulleted list that contains only the product name and price from the retrieved product data. If a price isn't available, say that the price isn't listed.*

## Run another manual evaluation

With a new system message in place, let’s run another manual evaluation, specifically for the rows that were marked with a thumb down.

:::image type="content" source="../media/manual-evaluation-correct-formatting.png" alt-text="A screenshot of the model response within the manual evaluation results. The model's response is short and only lists the product and its cost." lightbox="../media/manual-evaluation-correct-formatting.png":::

1. In the manual evaluation results table, select **Run** next to the following inputs:

    - What sleeping bags do you sell?
    - Which tents can fit 4 or more people?

1. For each row, compare the **Expected response** to the **Output**. Confirm whether the model formats the output in the preferred way, and then use the **thumbs-up** or **thumbs-down** control.

     The following are sample outputs generated by the model after rerunning the evaluation:

     | **Prompt** | **Sample Response** |
     | --- | --- |
     | What sleeping bags do you sell? | - **CozyNights Sleeping Bag**: $100 <br> - **MountainDream Sleeping Bag**: Price isn't listed in the product catalog. |
     | Which tents can fit 4 or more people? | - **TrailMaster X4 Tent**: $250 <br> - **Alpine Explorer Tent**: $350 |

1. Select **Save results**.
1. For the **Name** field, enter: _manual-evaluation-2_
1. Select **Save**. If necessary, you can navigate back to the **Manual evaluations** table to view **manual-evaluation-1** for comparison.

> [!TIP]
> If the model still uses the earlier format, rerun the affected rows after applying the updated assistant setup. If the portal appears to reuse earlier context, start a fresh evaluation session and try again.

The model should now format product recommendations in the desired format. However, in the example provided, the model couldn’t retrieve the price of the **MountainDream Sleeping Bag**. In a real-world scenario, a recommended next step would be to review the Contoso Camping Store product data and validate whether the price is missing for that respective product.

Let’s now evaluate the model output using the second type of supported evaluations: Automated Evaluation.
