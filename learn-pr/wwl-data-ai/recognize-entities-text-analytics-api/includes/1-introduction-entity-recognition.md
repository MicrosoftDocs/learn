Entity recognition is a part of the Text Analytics service under Azure Cognitive Services. You can provide the service with unstructured text and it will return a list of entities, or items in the text that it recognizes.  The service can also provide links to more information about that entity on the web.  An entity is essentially a type or a category that certain text elements can fall under.  The service supports two types of recognition.

## Named entity recognition    

Named entity recognition provides the ability to recognize and identify items in text that are categorized according to some pre-defined classes.  Version 3, which is in preview, will add the ability to identify more items such as personal and/or sensitive information like phone numbers, social security numbers, email addresses, and bank account numbers.

## Entity linking    

The entity linking feature helps to remove ambiguity that may exist around an identified entity. A document may contain an entity such as **ARES**, which could mean the Greek god of war or it could be an acronym for Amateur Radio Emergency Services.  Text Analytics is not able to make this linking on its own.  It requires a knowledge base, in the required language, to provide the necessary recognition.  This is a way to customize linked entities to your own organizations list of entity elements.

## Learning objectives

In this module, you will learn more about:     

- entity types
- how to create the necessary JSON document for creating entities in code
- how to properly structure a request     