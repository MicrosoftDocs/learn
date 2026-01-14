Businesses often store text that's rich with details but hard to work with directly. A single property description might mention furniture, neighborhood landmarks, and amenities, while a guest review could mix praise with criticism. Buried in these words are clues that could improve search, highlight unique features, or surface trends. The challenge is finding a way to pull out those details without reading through every line of text.  

Let’s consider **Margie’s Travel**, a vacation rental company that manages thousands of listings. Their database holds long descriptions and customer reviews. The application team wants to quickly identify the main topics, capture mentions of specific places or items, and ensure that sensitive details like phone numbers aren't exposed. Performing these tasks by hand isn’t practical at scale, so they use Azure Language services with the `azure_ai` extension in Azure Database for PostgreSQL.  

With this approach, they can apply three capabilities directly inside the database: **key phrase extraction**, **named entity recognition**, and **personally identifiable information (PII) detection**.  

## Key phrase extraction

Key phrase extraction identifies the main ideas or topics in text. It pulls out the concepts that best represent what the passage is about.  

In Azure Database for PostgreSQL, this extraction is done with the `azure_cognitive.extract_key_phrases` function. It requires the input text and language, and it returns a list of the most relevant phrases. For example, analyzing a property description might yield phrases such as *"queen bed,"* *"light rail station,"* or *"garden produce."*  

For Margie’s Travel, these insights make it easier to tag listings with consistent topics or cluster reviews based on recurring themes.  

## Named entity recognition

Named entity recognition (NER) identifies and categorizes specific items such as people, locations, products, or dates.  

In Azure Database for PostgreSQL, the `azure_cognitive.recognize_entities` function performs this analysis. It labels recognized entities and provides a confidence score for each. For example, a listing description might surface entities like *"Queen Anne neighborhood"* (location), *"basement"* (structural location), or *"sofa"* (product).  

For Margie’s Travel, these insights enrich their data by turning free text into structured information. Staff can filter or search listings by recognized entities, making the platform more useful for both guests and property owners.  

## Personally identifiable information (PII) detection

Text often contains sensitive details that shouldn't be shared, such as phone numbers, addresses, or payment information. Personally identifiable information (PII) detection identifies and redacts this type of content automatically.  

In Azure Database for PostgreSQL, the `azure_cognitive.recognize_pii_entities` function detects and masks PII, returning both the original text with sensitive details redacted and metadata about what was found.  

For Margie’s Travel, this function ensures that private customer data is safeguarded when reviews are analyzed, displayed, or exported. It reduces risk and supports compliance requirements.  

## Why these insights matter

Key phrase extraction, named entity recognition, and PII detection help transform unstructured text into structured, secure insights. Together, they enable organizations to:  
- Improve search and categorization by surfacing important phrases.  
- Highlight entities such as locations and products to enrich applications.  
- Protect privacy by automatically redacting sensitive information.  

For Margie’s Travel, these capabilities mean they can handle large volumes of text more efficiently while improving customer trust and the overall experience.  

## Key takeaways

In this unit, you learn how to extract insights from text data with Azure Language services in Azure Database for PostgreSQL. Key phrase extraction identifies important topics, named entity recognition categorizes entities, and PII detection safeguards sensitive information. These techniques turn free-form text into structured data that's easier to analyze, search, and protect.  
