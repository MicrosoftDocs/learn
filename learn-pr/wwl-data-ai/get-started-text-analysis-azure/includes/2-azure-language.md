::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=df0656a1-e7d4-47fe-9e5e-3c57ec44564f]

> [!NOTE]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

**Microsoft Foundry** is the platform for building AI apps and agents on Azure. **Azure Language in Foundry tools** is a natural language processing service in Foundry that is built in models for common text analysis tasks. Azure Language can perform advanced NLP over unstructured text. 

Core text analysis tasks Azure Language supports include: 

- **Key phrase extraction** lists the main concepts from unstructured text.
- **Named entity recognition** identifies people, places, events, and more. This feature can also be customized to extract custom categories. 
- **Entity linking** identifies known entities together with a link to Wikipedia.
- **Sentiment analysis and opinion mining** identifies whether text is positive or negative.
- **Summarization** summarizes text by identifying the most important information.
- **Personal identifying information (PII) detection** identifies personally sensitive information, including personal health information (PHI). 
- **Language detection** evaluates text and detects the language and dialect.

## Get started with text analysis in Foundry portal

To test out Azure Language features in the Foundry portal, you need to create a *Foundry resource* and *Foundry project*. 

> [!NOTE]
> The Foundry portal has a *classic* user interface (UI) and a *new* UI.

A Foundry resource and project is sufficient for testing Azure Language capabilities in the *classic* Foundry portal **Language Playground**. The Language Playground is a built‑in workspace in the *classic* portal that lets you use natural language models directly in the browser.  

Let’s explore some text analysis tasks in the classic Foundry portal. 

#### Key phrase extraction

First, we might want to extract the keywords and phrases used in some text, which can be helpful in processes like indexing and searching for relevant documents. **Key phrase extraction** identifies the main points from text. 

For example, you might receive a review such as:

> "*I had a fantastic meal at the diner in Seattle on Saturday. The mushroom risotto was perfectly prepared, and really tasty. Our waiter, Pete, was friendly and efficient; and gave us a great recommendation for a dessert (strawberry cheesecake). I'd definitely recommend this place for a casual dinner.*"

Key phrase extraction can provide some context to this review by extracting the following phrases:
- casual dinner
- dessert
- fantastic meal
- diner
- great recommendation
- mushroom risotto
- Pete
- place
- Saturday
- Seattle
- strawberry cheesecake
- waiter

In the classic Foundry portal, you can test out Azure Language's key phrase extraction feature in the Language Playground. 

:::image type="content" source="../media/playground-key-phrases.png" alt-text="Screenshot of the Language playground's key phrase extraction capability." lightbox="../media/playground-key-phrases.png":::

#### Entity recognition and linking

Additionally, we might want to use **named entity recognition** to find people, places, dates, and other specific entities mentioned in the text.

You can provide Azure Language with unstructured text and it returns a list of *entities* in the text that it recognizes. An entity is an item of a particular type or a category; and in some cases, subtype, for example: 

|Type|SubType|Example|
|---|---|---|
|Person||"Bill Gates", "John"|
|Location||"Paris", "New York"|
|Organization||"Microsoft"|
|Quantity|Number|"6" or "six"|
|Quantity|Percentage|"25%" or "fifty percent"|
|Quantity|Ordinal|"1st" or "first"|
|Quantity|Age|"90 day old" or "30 years old"|
|Quantity|Currency|"10.99"|
|Quantity|Dimension|"10 miles", "40 cm"|
|Quantity|Temperature|"45 degrees"|
|DateTime||"6:30PM February 4, 2012"|
|DateTime|Date|"May 2nd, 2017" or "05/02/2017"|
|DateTime|Time|"8am" or "8:00"|
|DateTime|DateRange|"May 2nd to May 5th"|
|DateTime|TimeRange|"6pm to 7pm"|
|DateTime|Duration|"1 minute and 45 seconds"|
|DateTime|Set|"every Tuesday"|
|US-based Phone Number||"(312) 555-0176"|

In the classic Foundry portal, you can test out Azure Language's named entity recognition feature in the Language Playground. 

:::image type="content" source="../media/playground-named-entities.png" alt-text="Screenshot of the Language playground's named entity recognition capability." lightbox="../media/playground-named-entities.png":::

Azure Language also supports **entity linking** to help disambiguate entities by linking to a specific reference. For recognized entities, the service returns a URL for a relevant *Wikipedia* article.

For example, suppose you use Azure Language to detect entities in the following restaurant review extract:

> "*I ate at the restaurant in Seattle last week.*"

|Entity|Type|SubType|Wikipedia URL|
|---|---|---|---|
|Seattle|Location||https://en.wikipedia.org/wiki/Seattle|
|last week|DateTime|DateRange||

#### Sentiment analysis and opinion mining

We can also use **sentiment analysis** to classify a document as positive, negative, or negative, with an overall rating for the document as well as a sentence-by-sentence breakdown. 

The text analytics capabilities in Azure Language can evaluate text and return sentiment scores and labels for each sentence. This capability is useful for detecting positive and negative sentiment in social media, customer reviews, discussion forums and more.

Azure Language returns sentiment scores in three categories: positive, neutral, and negative. In each of the categories, a score between 0 and 1 is provided. Scores indicate how likely the provided text is a particular sentiment. Azure Language returns both an overall document sentiment, and a sentence-by-sentence breakdown.

We could analyze the sentiment of our restaurant review: 

> "*I had a fantastic meal at the diner in Seattle on Saturday. The mushroom risotto was perfectly prepared, and really tasty. Our waiter, Pete, was friendly and efficient; and gave us a great recommendation for a dessert (strawberry cheesecake). I'd definitely recommend this place for a casual dinner.*"

The sentiment score for the  review might be: 

- Document sentiment: positive
    - Positive score: 0.99
    - Neutral score: 0.01
    - Negative score: 0.00

- Sentence 1 sentiment: positive
    - Positive score: 0.98
    - Neutral score: 0.02
    - Negative score: 0.00

The service would provide sentence analysis for each of the sentences. Each sentence analysis could have a different score breakdown. 

In classic Foundry portal, you can test out Azure Language's sentiment analysis capability in the Language Playground. 

:::image type="content" source="../media/playground-sentiment.png" alt-text="Screenshot of the Language playground's sentiment capability." lightbox="../media/playground-sentiment.png":::

#### Summarization 

With **text summarization**, we can generate both *extractive* summaries that include only the most relevant sentences and *abstractive* summaries that create an overall description of the key points of the document.

Given the example text: 

> "*I had a fantastic meal at the diner in Seattle on Saturday. The mushroom risotto was perfectly prepared, and really tasty. Our waiter, Pete, was friendly and efficient; and gave us a great recommendation for a dessert (strawberry cheesecake). I'd definitely recommend this place for a casual dinner.*" 

We could extract an:

**Extractive summary**
- (Rank score: 100%) I had a fantastic meal at the diner in Seattle on Saturday.
- (Rank score: 52%) The mushroom risotto was perfectly prepared, and really tasty.
- (Rank score: 63%) I'd definitely recommend this place for a casual dinner.

**Abstractive summary**
The individual experienced an exceptional dining experience at the diner in Seattle, highlighting the delectable mushroom risotto as a standout dish. They appreciated the friendly and efficient service provided by the waiter, Pete, who also offered a highly recommended dessert option—strawberry cheesecake. The overall ambiance and food quality were such that the diner was deemed suitable for a casual dinner. The positive review underscores the diner's ability to deliver a satisfying meal, paired with commendable customer service, making it a recommended destination for future dining in the area. The summary encapsulates the main points of enjoyment and recommendation without redundant details from the original document.

In classic Foundry portal, you can test out Azure Language's summarization capability in the Language Playground. 

:::image type="content" source="../media/playground-summarize.png" alt-text="Screenshot of the Language playground's summarization capability." lightbox="../media/playground-summarize.png":::

Next, let's learn how to get started with the Azure Language software development kit (SDK) to build a lightweight application.

::: zone-end