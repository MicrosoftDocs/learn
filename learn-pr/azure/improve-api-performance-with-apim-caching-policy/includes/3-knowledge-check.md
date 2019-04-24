
 <!-- Guidance on writing the introductory text in a learning unit: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-learning-unit-introduction-format -->

<!-- Use this syntax for any TODOs or notes to yourself or reviewers -->

<!-- If you have any relevant links to other content (in Learn, Docs or anywhere else), include it only in the Learn More section in the final Summary unit. -->

<!-- Images: all images must be original. Work with the team to submit an image creation request if new art is needed. See here for requirements on screenshots: https://review.docs.microsoft.com/en-us/help/contribute/contribute-how-to-create-screenshot?branch=master -->

<!-- Don't include a summary section in individual units -->

<!-- Don't include a sentence or section to transition to the next unit. The platform will insert the name of the next unit above the navigation button at the bottom -->
You are planning API Management policies for your board games company. You have three APIs:

- **The Board Pricing API**. You manufacture boards of different sizes for partner companies to use with their games. Those partners can use this API to request a price estimate for manufacturing boards of different sizes.
- **The Stock Management API**. Your own staff use a mobile app that calls this API to determine the stock level of your company's games.
- **The Sales API**. The website uses this API to place orders from customers for your company's games.

You have added the Stock Management API and the Sales API to an API Management product named **Sales**.

For the Board Pricing API, you want to make sure that all responses are sent in XML, even though developers have written some operations to generate JSON text. The mobile app expects responses in XML, and the website expects responses in JSON.
