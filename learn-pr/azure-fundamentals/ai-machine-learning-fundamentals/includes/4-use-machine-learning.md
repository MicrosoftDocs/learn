The Tailwind Traders e-commerce website allows its customers to browse and purchase items that can be delivered or picked up from a retail store nearest to their location.

The Marketing team is convinced that it can increase sales dramatically by suggesting add-on products at the point of checkout. The suggested products would complement the items in a shopper's cart. The team could hard-code these suggestions, but it feels that it has a more organic approach. They want to use their years' worth of sales data and new shopping trends to decide what products to display to the shopper. Additionally, the suggestions could be influenced by product availability, product profitability, and other factors.

The Marketing team's existing data science experts have already done some initial analysis of the problem domain. They've determined that their plan might take months to prototype, and possibly a year to roll out.

## Which service should you choose?

Let's apply the decision criteria you learned about in the preceding unit to find the right option.

First, is Tailwind Traders building a virtual agent that interfaces with humans via natural language? No, it isn't, so Azure Bot Service isn't a good candidate for this scenario.

Second, does Tailwind Traders need a service that can understand the content and meaning of images, video, audio, or translate text into a different language? No, it doesn't, so the relevant Cognitive Services isn't what the company needs.

Third, does Tailwind Traders need to predict user behavior or provide users with personalized recommendations? Yes, it does. However, creating recommendations based on user behavior is only part of the requirement. Tailwind Traders needs to create a complex model that incorporates historical sales data, trending sales data, inventory, and more. It's possible that the Azure Cognitive Services Personalizer service could play a role, but it couldn't handle the entire breadth of the project alone.

Fourth, will the Tailwind Traders app predict future outcomes based on private historical data? Yes, and that is why in this scenario, Azure Machine Learning is likely the best choice.

The success of this effort would depend primarily on the ability of the model to select precisely the right up-sale products to suggest to the shopper. Because the model would need to be tweaked and tuned over time, an off-the-shelf model would likely not suffice.

Finally, it sounds like the Marketing team already employs some data science experts. The team is willing to make at least a year-long commitment to building, testing, and tweaking the models to be used.
