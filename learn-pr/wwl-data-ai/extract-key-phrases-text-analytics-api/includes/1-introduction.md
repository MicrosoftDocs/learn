Key phrase extraction is the concept of evaluating the text of a document, or documents, and then identifying the main points around the context of the document(s). Consider a scenario where you own and operate a restaurant, even a chain of restaurants.  Customers can complete surveys and provide feedback on the restaurant, the service, staff, etc.  Depending on the volume of surveys that you have collected, it can take a long time to read through the reviews.   Instead, you can use the key phrase extraction features of the Azure Cognitive Services Text Analytics service and let the AI algorithms do the work for you.

You might find reviews such as:

"We had dinner at the restaurant last night and the first thing I noted was how courteous the staff was.  We were greeted in a friendly manner and taken to our table right away.  The table was clean, the chairs were comfortable, and the food was amazing."

Key phrase extraction would be able to detect some aspects of this review by extracting key phrases:

- table
- chairs
- restaurant
- night
- food
- dinner
- friendly manner
- staff

Looking at this list you might wonder if it is worth much but you can take away some key aspects without ever having read the review.  You can see that customers visited a restaurant at night and had dinner.  Obviously were seated at a table that had chairs, this is a good thing, and they found the staff friendly.

The above was a simple example of a survey scenario but we can think of a few other scenarios where key phrase extraction can apply:

- integrate speech to text and analyze customer support calls to determine their most common issues with your products
- monitor social media feeds.  Perhaps you are running a political campaign and want to see how the candidates are being perceived on social media.  You can mine the posts on feeds, such as Twitter, and then extract key phrases from the tweets
- evaluate a set of documents for classified or sensitive information and decide whether to release them or not

## Learning objectives

In this module, you will learn:

- How to create the proper JSON document for the request
- How to submit the request
- How to evaluate the results