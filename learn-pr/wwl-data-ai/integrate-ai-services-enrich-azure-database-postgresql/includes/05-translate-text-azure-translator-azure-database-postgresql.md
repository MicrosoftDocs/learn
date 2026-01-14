Applications that work across regions often need to support multiple languages. Customers submit reviews, descriptions, or requests in one language, while the business needs to make the content available in another. Without translation, valuable information stays locked away from some audiences, creating communication barriers and limiting reach.  

Let’s consider **Margie’s Travel**, a vacation rental company that serves an international customer base. Guests leave reviews in their native languages, and property owners upload descriptions in English, Spanish, Japanese, and other languages. To make the platform accessible, Margie’s Travel needs a way to automatically translate text so guests and hosts can understand each other without requiring manual translation.  

Azure Translator, available through the `azure_ai` extension in Azure Database for PostgreSQL, provides this capability. It supports translation between more than 100 languages:contentReference[oaicite:0]{index=0} and makes it possible to perform translations directly in SQL queries.  

## Translate with Azure Database for PostgreSQL

The `azure_cognitive.translate()` function handles translation in Azure Database for PostgreSQL. It accepts the input text and one or more target languages. The source language can be provided, or the function can detect it automatically:contentReference[oaicite:1]{index=1}.  

The function returns a table that includes:  
- **translations** – the translated text for each target language.  
- **detected_language** – the automatically detected source language if one isn’t specified.  
- **source_text** – the input text, available if it uses a nonstandard script for that language.  

For Margie’s Travel, this feature means a review in Japanese can be instantly translated into English for a host, while a property description originally written in Spanish can be shown in French for a guest. The translation happens inside the database, without moving the data to another system.  

## Why translation matters

By integrating Azure Translator with Azure Database for PostgreSQL, organizations can:  
- Support a global audience by breaking down language barriers.  
- Provide consistent experiences across multiple regions.  
- Reduce manual effort by managing translation within the database.  
- Improve accessibility by making content available in users’ preferred languages.  

For Margie’s Travel, translation ensures the platform feels welcoming and useful to both renters and hosts worldwide.  

## Key takeaways

In this unit, you learn how to use Azure Translator with Azure Database for PostgreSQL to translate text into multiple languages. This feature enables applications to provide multilingual support, improve accessibility, and deliver consistent experiences across global markets.  
