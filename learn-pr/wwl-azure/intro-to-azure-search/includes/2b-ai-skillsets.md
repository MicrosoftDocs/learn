AI enrichment refers to embedded image and natural language processing in a pipeline that extracts text and information from content that can't otherwise be indexed for full text search. 

AI processing is achieved by adding and combining skills in a skillset. A skillset defines the operations that extract and enrich data to make it searchable. These AI skills can be either built-in skills, such as text translation or Optical Character Recognition (OCR), or custom skills that you provide.

### Built in skills

Built-in skills are based on pretrained models from Microsoft, which means you can't train the model using your own training data. Skills that call the Azure AI services APIs have a dependency on those services and are billed at the Azure AI services pay-as-you-go price when you attach a resource. Other skills are metered by Azure Cognitive Search, or are utility skills that are available at no charge.

Built-in skills fall into these categories:

**Natural language processing skills**: with these skills, unstructured text is mapped as searchable and filterable fields in an index.

Some examples include: 

- Key Phrase Extraction: uses a pre-trained model to detect important phrases based on term placement, linguistic rules, proximity to other terms, and how unusual the term is within the source data.

- Text Translation Skill: uses a pre-trained model to translate the input text into various languages for normalization or localization use cases.

**Image processing skills**: creates text representations of image content, making it searchable using the query capabilities of Azure Cognitive Search.

Some examples include: 

- Image Analysis Skill: uses an image detection algorithm to identify the content of an image and generate a text description.

- Optical Character Recognition Skill: allows you to extract printed or handwritten text from images, such as photos of street signs and products, as well as from documents—invoices, bills, financial reports, articles, and more. 

