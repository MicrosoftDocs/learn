**Sentiment analysis** is a crucial natural language processing (NLP) technique that allows us to discern the emotional tone or sentiment expressed in textual data. Using machine learning and natural NLP, sentiment analysis aims to determine whether the opinions, sentiments, appraisals, attitudes, and emotions expressed within text convey a positive, negative, or neutral sentiment. These capabilities empower applications to understand user sentiment, monitor brand perception, and make informed decisions based on textual content.

The web and mobile apps for Margie's Travel allow renters to submit reviews detailing their experiences staying at properties listed in the apps. The text of these reviews contains valuable information about how the customer felt about the property, its host, and their stay. Understanding these sentiments can help Margie's Travel better serve its customers and provide valuable feedback to property owners and managers.

## Analyze sentiment with the azure_ai extension

The `azure_ai` extension for Azure Database for PostgreSQL - Flexible Server relies on integration with the Azure AI Language service to perform sentiment analysis. The sentiment analysis capabilities of the extension are accessible using the `analyze_sentiment()` function within the `azure_cognitive` schema.

This method has three overloads, allowing you to analyze the sentiment of one record at a time or multiple records by passing in an array of values to evaluate. Using the `language` parameter, you can also indicate in which of the [94 supported languages](/azure/ai-services/language-service/sentiment-opinion-mining/language-support#sentiment-analysis-language-support) the input text is written.

The output of the `analyze_sentiment()` function is the `sentiment_analysis_result` composite type. The type's structure is:

```sql
   Column       |   Type   
----------------+------------------
 sentiment      | text      
 positive_score | double precision
 neutral_score  | double precision
 negative_score | double precision
```

The composite type contains the sentiment predictions of the input text. It includes the sentiment, which can be positive, negative, neutral, or mixed, and the scores for positive, neutral, and negative aspects found in the text. The scores are represented as real numbers between 0 and 1. For example, in (neutral, 0.26, 0.64, 0.09), the sentiment is neutral, with a positive score of 0.26, neutral of 0.64, and negative at 0.09.

The function assigns sentiment labels (positive, negative, or neutral) to individual sentences or entire documents. These labels indicate the emotional tone expressed in the text. It returns confidence scores along with the sentiment labels, representing the model's confidence in its predictions.

## Benefits of sentiment analysis

- Understand customer feedback: Analyze reviews, social media posts, surveys, etc.
- Monitor brand reputation: Track sentiment trends over time.
- Personalize user experiences: Adapt content based on user sentiment.
