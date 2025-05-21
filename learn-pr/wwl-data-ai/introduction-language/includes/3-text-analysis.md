Text analysis includes:

- **Named entity recognition** identifies people, places, events, and more. This feature can also be customized to extract custom categories. 
- **Entity linking** identifies known entities together with a link to Wikipedia.
- **Personal identifying information (PII) detection** identifies personally sensitive information, including personal health information (PHI). 
- **Language detection** identifies the language of the text and returns a language code such as "en" for English.
- **Sentiment analysis and opinion mining** identifies whether text is positive or negative.
- **Summarization** summarizes text by identifying the most important information.
- **Key phrase extraction** lists the main concepts from unstructured text.

## Entity recognition and linking

An entity is an item of a particular type or a category; and in some cases, subtype, such as those as shown in the following table.

|Type|SubType|Example|
|---|---|---|
|Person||"Bill Gates", "John"|
|Location||"Paris", "New York"|
|Organization||"Microsoft"|
|Quantity|Number|"6" or "six"|
|Quantity|Percentage|"25%" or "fifty percent"|

*Entity linking* helps disambiguate entities by linking to a specific reference.

For example, suppose you want to detect entities in the following restaurant review:

> "*I ate at the restaurant in Seattle last week.*"

|Entity|Type|SubType|
|---|---|---|
|Seattle|Location||
|last week|DateTime|DateRange|


## Sentiment analysis and opinion mining

Sentiment analysis is 

Scores indicate how likely the provided text is a particular sentiment. 

For example, the following two restaurant reviews could be analyzed for sentiment:

> *Review 1*: "*We had dinner at this restaurant last night and the first thing I noticed was how courteous the staff was. We were greeted in a friendly manner and taken to our table right away. The table was clean, the chairs were comfortable, and the food was amazing.*"

and

> *Review 2*: "*Our dining experience at this restaurant was one of the worst I've ever had. The service was slow, and the food was awful. I'll never eat at this establishment again.*"

The sentiment score for the first review might be: 
Document sentiment: positive
Positive score: .90 
Neutral score: .10
Negative score: .00
 
The second review might return a response: 
Document sentiment: negative
Positive score: .00 
Neutral score: .00
Negative score: .99

## Key phrase extraction

Key phrase extraction identifies the main points from text. Consider the restaurant scenario discussed previously. If you have a large number of surveys, it can take a long time to read through the reviews. Instead, you can use the key phrase extraction capabilities of the Language service to summarize the main points.

You might receive a review such as:

> "*We had dinner here for a birthday celebration and had a fantastic experience. We were greeted by a friendly hostess and taken to our table right away. The ambiance was relaxed, the food was amazing, and service was terrific. If you like great food and attentive service, you should try this place.*"

Key phrase extraction can provide some context to this review by extracting the following phrases:
- birthday celebration
- fantastic experience
- friendly hostess
- great food
- attentive service
- dinner
- table
- ambiance
- place

As well as using sentiment analysis to determine that this is a positive review, you can also use the key phrase service to identify important elements of the review.


