<!-- Guidance on writing the introductory text in a learning unit: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-learning-unit-introduction-format -->

<!-- Use this syntax for any TODOs or notes to yourself or reviewers -->

<!-- If you have any relevant links to other content (in Learn, Docs or anywhere else), include it only in the Learn More section in the final Summary unit. -->

<!-- Images: all images must be original. Work with the team to submit an image creation request if new art is needed. See here for requirements on screenshots: https://review.docs.microsoft.com/en-us/help/contribute/contribute-how-to-create-screenshot?branch=master -->

<!-- Don't include a summary section in individual units -->

<!-- Don't include a sentence or section to transition to the next unit. The platform will insert the name of the next unit above the navigation button at the bottom -->
 Many organizations use APIs to publish data and services. Customers and partners can call these APIs from any kind of client: desktop applications, mobile apps, web apps, and other systems. If your API is popular, you may need to optimize its performance to guarantee a good service to users.

    Suppose you are a developer for a board game company. A product line produced by your company has recently become very popular, and the volume of requests from your retail partners to your inventory API is growing quickly: much faster than the rate that your inventory actually changes. You'd like to be able to respond to requests successfully without incurring load on your API.

    You use Azure API Management to host your API. You've read that you can configure an API Management policy to cache compiled responses to requests and you think that this will be a good way to optimize performance. You want to learn how to write API Management policies and how to use them to set up and control a cache. Then you want to write a policy that accelerates responses to users.

## Choosing the right policy

Policies in Azure API Management - APIM can be used to control many aspects of an already deployed API changing its behaviour via configuration. 
The statements which form a policy are executed sequentially on either outbound responses  or inbound requests.