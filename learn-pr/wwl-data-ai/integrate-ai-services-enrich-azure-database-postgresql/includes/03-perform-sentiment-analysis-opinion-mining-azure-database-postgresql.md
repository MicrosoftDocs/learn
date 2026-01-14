Customer reviews, survey responses, and open text feedback often reveal how people truly feel about a product or service. The challenge is that this information is written in free form, making it difficult to track trends or compare experiences at scale. Without the right tools, valuable signals about satisfaction or dissatisfaction remain buried in lengthy comments.  

Consider *Margie’s Travel*, a company that manages vacation rentals. Guests leave detailed reviews in the booking application, sharing their experiences about the property, host, and overall stay. Some highlight positive details like a scenic view or a friendly welcome, while others mention negatives such as noise or outdated furniture. Reading each review individually is time-consuming, and it’s hard to turn those impressions into clear, actionable insights.  

To address this, Margie’s Travel uses Azure AI Services with Azure Database for PostgreSQL to automatically evaluate customer feedback. Two complementary techniques make this evaluation possible: **sentiment analysis** for identifying overall tone, and **opinion mining** for uncovering what customers liked or disliked about specific aspects.  

## Sentiment analysis

Sentiment analysis applies natural language processing to label text as positive, negative, neutral, or mixed. Instead of focusing on every word, it evaluates the overall tone.  

With the `azure_cognitive.analyze_sentiment()` function in Azure Database for PostgreSQL, organizations can run this analysis directly inside their database. It returns a sentiment label along with confidence scores for each category. These scores, ranging from 0 to 1, show how strongly the text leans toward each sentiment.  

For Margie’s Travel, this ranking means every review can be quickly classified. A single property might show mostly positive reviews, while another can have a mix of positive and negative experiences. Staff can use this information to spot patterns across listings and make data-driven improvements.  

## Opinion mining

While sentiment analysis shows overall tone, it doesn’t explain *why* customers feel that way. Opinion mining, also called aspect-based sentiment analysis, provides that deeper view.  

This technique links sentiments to specific aspects of the text. For example, a review might say: *"The location was perfect, but the bed was uncomfortable."* Sentiment analysis would label it as mixed, but opinion mining breaks it down into **"location" = positive** and **"bed" = negative**.  

For Margie’s Travel, opinion mining helps highlight which property features drive satisfaction and which issues matter most to guests. This level of detail is especially useful for property owners who want targeted feedback on what to improve.  

## Why these insights matter

Together, sentiment analysis and opinion mining give businesses the ability to:  
- Track satisfaction trends across large volumes of text.  
- Pinpoint specific strengths and weaknesses mentioned in feedback.  
- React quickly to recurring complaints before they affect reputation.  
- Personalize services by tailoring recommendations or communication.  

For a company like Margie’s Travel, these capabilities turn raw customer comments into structured insights that improve both customer experience and property management decisions.  

## Key takeaways

In this unit, you learn how to evaluate text data with sentiment analysis and opinion mining in Azure Database for PostgreSQL. Sentiment analysis identifies the overall tone of reviews, while opinion mining reveals which aspects are praised or criticized. Using these techniques together transforms free-form feedback into clear insights that organizations can act on.  
