In this unit, we revisit Tailwind Traders to find a solution to a challenge their marketing department faces.

## What's the opportunity?

Tailwind Traders' ecommerce website allows customers to browse and purchase items that can be delivered or can be picked-up from a retail store nearest to their location.  

The Marketing department is convinced that they can increase sales dramatically by suggesting add-on products from their catalog that compliment the items in the shopper's cart at the moment of checkout.  They could hardcode this, however they feel a more organic approach would be to use years' worth of sales data as well as new shopping trends to decide what products to display to the shopper.  Furthermore, this could be influenced by factors like product availability, product profitability, and other factors.

Fortunately, the Marketing department's existing data science experts have already done some initial analysis of the problem domain, and have determine that it may take months to prototype, and possibly a year to roll out.

### Which service should we choose?

Given that Tailwind Traders needs to create a complex model that incorporates historical sales data, trending sales data, inventory, and more, Azure Machine Learning is likely the best choice.  This success of this effort would depend primarily on the strength of the model to select just the right upsale products to suggest to the shopper.  Given that the model would need to be tweaked and tuned over time, an off-the-shelf model would likely not suffice.

Furthermore, it sounds like the Marketing department already employs some data science experts, and they are willing to make at least a year-long commitment to building, testing, and tweaking the models to be used.

### Why not use Azure Cognitive Services?

Again, since Tailwind Traders is looking for a very customized model that utilizes large amounts of historical data and real-time data to make the right recommendations for each shopper, an off-the-shelf model from Azure Cognitive Services would not be the right choice.

Given that the Marketing department employs data scientists and they have a generous timeline for the project, these are not constraints that would disqualify the use of Azure Machine Learning.

### Why not use Azure Bot Service?

In this scenario, the Azure Bot Service would not be a candidate for consideration.  The upsell and add-on features that the Marketing department wants to implment would not be displayed to the user as a chat window on the web page.