Tailwind Traders' ecommerce website allows customers to browse and purchase items that can be delivered or can be picked-up from a retail store nearest to their location.  

The Marketing department is convinced that they can increase sales dramatically by suggesting add-on products from their catalog that complement the items in the shopper's cart at the moment of checkout. They could hard-code these suggestions, but they feel a more organic approach would be to use years' worth of sales data as well as new shopping trends to decide what products to display to the shopper.  Furthermore, the suggestions could be influenced by factors like product availability, product profitability, and other factors.

The Marketing department's existing data science experts have already done some initial analysis of the problem domain, and have determined that it may take months to prototype, and possibly a year to roll out.

## Which service should we choose?

Let's apply the decision criteria we learned about in the previous unit to find the right option.

First, is Tailwind Traders building a virtual agent that interfaces with humans via natural language?  No, Azure Bot Service is not a good candidate for this scenario.

Second, does Tailwind Traders need a service that can understand the content and meaning of images, video, audio, or translate text into a different language?  No, so those relevant Cognitive Services will not help us.

Third, does Tailwind Traders need to predict user behavior or provide users with personalized recommendations?  Yes!  However, creating recommendations based on user behavior is only part of the requirement.  Tailwind Traders needs to create a complex model that incorporates historical sales data, trending sales data, inventory, and more.  It's possible that Azure Cognitive Service's Personalizer service could play a role, but it couldn't handle the entire breadth of the project alone.

Finally, will the Tailwind Trader app predict future outcomes based on private historical data?  Yes, and that is why in this scenario, Azure Machine Learning is likely the best choice.

The success of this effort would depend primarily on the strength of the model to select just the right up-sale products to suggest to the shopper.  Given that the model would need to be tweaked and tuned over time, an off-the-shelf model would likely not suffice.

Furthermore, it sounds like the Marketing department already employs some data science experts, and they are willing to make at least a year-long commitment to building, testing, and tweaking the models to be used.
