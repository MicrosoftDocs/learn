Contoso Camping Store provides customers with the ability to speak with an AI-powered customer support agent and post product reviews. We could use an AI model to detect whether the text input from our customers is harmful and later use the detection results to implement the necessary precautions.

## Safe content

Let’s first test positive customer feedback.

1. In the notebook, go to the `SAFE CONTENT` cell.
1. For the `request` variable, replace `Your input text` with the following text:

   *I recently used the Contoso PowerBurner Camping Stove on my camping trip, and I must say, it was fantastic! It was easy to use, and the heat control was impressive Great product!*

1. Run the cell.

The severity level is **0** across all categories. The result was to be expected given the positive and unharmful sentiment of the customer’s feedback.

## Harmful content

But what would happen if we tested a harmful statement? Let’s test with some negative customer feedback. While it's OK to dislike a product, we don't want to condone any name calling or degrading statements.

1. In the notebook, go to the `HARMFUL CONTENT` cell.
1. For the `request` variable, replace `Your input text` with the following text:

   *I recently bought a tent, and I have to say, I'm really disappointed. The tent poles seem flimsy, and the zippers are constantly getting stuck. It's not what I expected from a high-end tent. You all suck and are a sorry excuse for a brand.*

1. Run the cell.

The **Severity level** for **Hate** is **2** but **0** for all other categories.

## Violent content with misspelling

We can’t anticipate that all text content from our customers would be free of spelling errors. Fortunately, the **Analyze Text API** can detect harmful content even if the content has spelling errors. Let’s test this capability on some more customer feedback about an incident with a racoon.

1. In the notebook, go to the `VIOLENT CONTENT WITH MISSPELLING` cell.
1. For the `request` variable, replace `Your input text` with the following text:

   *I recently purchased a campin cooker, but we had an acident. A racon got inside, was shocked, and died. It's blood is all over the interior. How do I clean the cooker?*

1. Run the cell.

The **Severity level** for **Violence** is **2**. Should we block such content? Consider a scenario where the customer is asking this question in a conversation with the AI-powered customer support agent in hopes of receiving guidance on how to clean the cooker. There may be no ill-intent in submitting this question and therefore, it may be a better choice not to block such content. As the developer, consider various scenarios where such content may be OK.