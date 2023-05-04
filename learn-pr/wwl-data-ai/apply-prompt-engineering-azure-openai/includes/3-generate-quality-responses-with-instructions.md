Azure OpenAI models are capable of generating responses to natural language queries with remarkable accuracy. However, the quality of the responses depends largely on how well the prompt is written. Developers can optimize the performance of Azure OpenAI models by using different instructions in their prompts, resulting in more accurate and relevant responses.

## Provide clear instructions

Asking the Azure OpenAI model clearly for what you want is one way to get desired results. By being as descriptive as possible, the model can generate a response that most closely matches what you're looking for.

For example, say you want to create a product description for a new water bottle. Consider the answer associated with each prompt:

**Write a product description for a new water bottle**

**Introducing the latest addition to our product line - the innovative and eco-friendly water bottle. Made from high-quality, BPA-free materials, this bottle is designed to keep your beverages at the perfect temperature for hours. Its sleek and stylish design makes it the perfect accessory for any outdoor activity or workout session. With its convenient carrying handle and leak-proof lid, you can take it with you wherever you go, without worrying about spills or leaks. Plus, its easy-to-clean design ensures that you can use it again and again, making it the perfect choice for anyone looking for a reliable and sustainable water bottle.*

**Write a product description for a new water bottle that is 100% recycled. Be sure to include that it comes in natural colors with no dyes, and each purchase removes 10 pounds of plastic from our oceans**

*Introducing our newest water bottle, the eco-friendly choice for the conscious consumer. Made from 100% recycled materials and available in natural colors with no dyes, this bottle is not only stylish but also sustainable. Each purchase of this bottle removes 10 pounds of plastic from our oceans, making it a responsible choice for those who care about the environment. Its durable and leak-proof design makes it perfect for outdoor activities, while its easy-to-carry handle makes it convenient to take on the go. Join us in our mission to reduce plastic waste and choose this eco-friendly water bottle for your daily hydration needs.*

Including specifics that need to be included lets the model know what information to add to the description, making it more accurate to the new product.

This method can be extrapolated to include complex instructions, such as a bulleted list of details to include, length of response, or desired formats to be included in the output. Try asking for exactly what you want to see in the result, and you may be surprised at how well the model satisfies your request.

## Request output composition

Specifying the structure of your output can have a large impact on your results. This could include something like asking the model to cite their sources, write the response as an email, format the response as a SQL query, classify sentiment into a specific structure, and so on. For example:

**Write a table with 6 animals in it, with their genus and species**

| Animal        | Genus          | Species       |
| ------------- |:-------------:|:-------------:|
| *Red Panda*     | *Ailurus*        | *fulgens*       |
| *African Elephant* | *Loxodonta*   | *africana*      |
| *Snow Leopard*  | *Panthera*       | *uncia*         |
| *Arctic Fox*    | *Vulpes*         | *lagopus*       |
| *Chimpanzee*    | *Pan*            | *troglodytes*   |
| *Siberian Tiger* | *Panthera*      | *tigris altaica*|

This can even be used with custom formats, such as a JSON structure:

**Put two fictional characters into JSON of the following format**
**{**  
  **firstNameFictional:**  
  **jobFictional:**
**}**

*Here's an example of how you can put two fictional characters into JSON format:*

```json
{
  "firstNameFictional": "Henry",
  "jobFictional": "Wizard"
},
{
  "firstNameFictional": "Frank",
  "jobFictional": "Hero"
}
```

## Format of instructions

How instructions are formatted can impact how the model interprets the prompt. 

### System message

### Divide complex prompts into multiple queries

System message
Break prompts down into multiple queries

Duplicate most important part
Recency bias
