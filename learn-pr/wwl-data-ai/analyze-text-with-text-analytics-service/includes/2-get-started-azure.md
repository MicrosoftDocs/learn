
The Language service is a part of the Azure Cognitive Services offerings that can perform advanced natural language processing over raw text.

## Azure resources for the Language service

To use the Language service in an application, you must provision an appropriate resource in your Azure subscription. You can choose to provision either of the following types of resource:

- A **Language** resource - choose this resource type if you only plan to use natural language processing services, or if you want to manage access and billing for the resource separately from other services.
- A **Cognitive Services** resource - choose this resource type if you plan to use the Language service in combination with other cognitive services, and you want to manage access and billing for these services together.

## Language detection

Use the language detection capability of the Language service to identify the language in which text is written. You can submit multiple documents at a time for analysis. For each document submitted to it, the service will detect:

- The language name (for example "English").
- The ISO 639-1 language code (for example, "en").
- A score indicating a level of confidence in the language detection.

For example, consider a scenario where you own and operate a restaurant where customers can complete surveys and provide feedback on the food, the service, staff, and so on. Suppose you have received the following reviews from customers:

> **Review 1**: "*A fantastic place for lunch. The soup was delicious.*"
>
> **Review 2**: "*Comida maravillosa y gran servicio.*"
>
> **Review 3**: "*The croque monsieur avec frites was terrific. Bon appetit!*"

You can use the text analytics capabilities in the Language service to detect the language for each of these reviews; and it might respond with the following results:

|Document|Language Name| ISO 6391 Code|Score|
|---|---|---|---|
|Review 1|English|en|1.0|
|Review 2|Spanish|es|1.0|
|Review 3|English|en|0.9|

Notice that the language detected for review 3 is English, despite the text containing a mix of English and French. The language detection service will focus on the ***predominant*** language in the text. The service uses an algorithm to determine the predominant language, such as length of phrases or total amount of text for the language compared to other languages in the text. The predominant language will be the value returned, along with the language code. The confidence score may be less than 1 as a result of the mixed language text.

### Ambiguous or mixed language content

There may be text that is ambiguous in nature, or that has mixed language content.  These situations can present a challenge to the service.  An ambiguous content example would be a case where the document contains limited text, or only punctuation.  For example, using the service to analyze the text ":-)", results in a value of **unknown** for the language name and the language identifier, and a score of **NaN** (which is used to indicate *not a number*).

## Sentiment analysis

The text analytics capabilities in the Language service can evaluate text and return sentiment scores and labels for each sentence. This capability is useful for detecting positive and negative sentiment in social media, customer reviews, discussion forums and more.

Using the pre-built machine learning classification model, the service evaluates the text and returns a sentiment score in the range of 0 to 1, with values closer to 1 being a positive sentiment. Scores that are close to the middle of the range (0.5) are considered neutral or indeterminate.

For example, the following two restaurant reviews could be analyzed for sentiment:

> "*We had dinner at this restaurant last night and the first thing I noticed was how courteous the staff was.  We were greeted in a friendly manner and taken to our table right away.  The table was clean, the chairs were comfortable, and the food was amazing.*"

and

> "*Our dining experience at this restaurant was one of the worst I've ever had. The service was slow, and the food was awful. I'll never eat at this establishment again.*"

The sentiment score for the first review might be around 0.9, indicating a positive sentiment; while the score for the second review might be closer to 0.1, indicating a negative sentiment.

### Indeterminate sentiment

A score of 0.5 might indicate that the sentiment of the text is indeterminate, and could result from text that does not have sufficient context to discern a sentiment or insufficient phrasing. For example, a list of words in a sentence that has no structure, could result in an indeterminate score. Another example where a score may be 0.5 is in the case where the wrong language code was used.  A language code (such as "en" for English, or "fr" for French) is used to inform the service which language the text is in.  If you pass text in French but tell the service the language code is **en** for English, the service will return a score of precisely 0.5.

## Key phrase extraction

Key phrase extraction is the concept of evaluating the text of a document, or documents, and then identifying the main talking points of the document(s). Consider the restaurant scenario discussed previously. Depending on the volume of surveys that you have collected, it can take a long time to read through the reviews. Instead, you can use the key phrase extraction capabilities of the Language service to summarize the main points.

You might receive a review such as:

> "*We had dinner here for a birthday celebration and had a fantastic experience. We were greeted by a friendly hostess and taken to our table right away. The ambiance was relaxed, the food was amazing, and service was terrific. If you like great food and attentive service, you should try this place.*"

Key phrase extraction can provide some context to this review by extracting the following phrases:

- attentive service
- great food
- birthday celebration
- fantastic experience
- table
- friendly hostess
- dinner
- ambiance
- place

Not only can you use sentiment analysis to determine that this review is positive, you can use the key phrases to identify important elements of the review.

## Entity recognition

You can provide the Language service with unstructured text and it will return a list of *entities* in the text that it recognizes.  The service can also provide links to more information about that entity on the web.  An entity is essentially an item of a particular type or a category; and in some cases, subtype, such as those as shown in the following table.

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
|URL||"`https://www.bing.com`"|
|Email||"`support@microsoft.com`"|
|US-based Phone Number||"(312) 555-0176"|
|IP Address||"10.0.1.125"|

The service also supports *entity linking* to help disambiguate entities by linking to a specific reference. For recognized entities, the service returns a URL for a relevant *Wikipedia* article.

For example, suppose you use the Language service to detect entities in the following restaurant review extract:

> "*I ate at the restaurant in Seattle last week.*"

|Entity|Type|SubType|Wikipedia URL|
|---|---|---|---|
|Seattle|Location||https://en.wikipedia.org/wiki/Seattle|
|last week|DateTime|DateRange||
