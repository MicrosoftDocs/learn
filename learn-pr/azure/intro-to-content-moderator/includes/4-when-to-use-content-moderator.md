How do you know when, or where, to use Personalizer? Microsoft offers some recommendations on scenarios such as:

- You want to select and display content to users for enhancing their experience with your services. Perhaps you want to help guide users through a web site experience to ensure they can successfully navigate your offerings. If you are selling mobile phones, you may want to help the user discover how to make selections for size, color, storage, etc.
- Achieve better business results through upsell opportunities or driving revenues through targeted advertisements on your site.
- Improving productivity by guiding employees through complex processes. Perhaps you want to ensure that all expense reports are completed accurately the first time, which reduces delays in payment of expenses.

The list represents a small sample of opportunities for implementing Personalizer in your environment. You may consider Personalizer as a good choice for any service or application that can benefit from offering recommendations and suggestions that make the user feel as through the service or application has been tailored to their needs.

## Setting expectations

The focus here is more on guidelines that will make the user of Personalizer effective for your scenarios.  It is not a comprehensive list but does list some of the more important considerations.

- Clearly defined business goals are critical to ensuring Personalizer is a valid choice for the intended purpose
- Content that lends itself to contextual decision making for the user and what to show the user of the service
- Aggregate data should be used to collect the user behaviors and to evaluate the reward scores for model improvement
- Follow proper ethics to ensure any learning from the model follows [responsible user guidelines](https://docs.microsoft.com/azure/cognitive-services/personalizer/ethics-responsible-use).

## Use Personalizer with a recommendation solution

Many companies use recommendation engines, marketing and campaigning tools, audience segmentation and clustering, collaborative filtering, and other means to recommend products from a large catalog to customers.

The [Microsoft Recommenders GitHub repository](https://github.com/Microsoft/Recommenders) provides examples and best practices for building recommendation systems, provided as Jupyter notebooks. It provides working examples for preparing data, building models, evaluating, tuning, and operationalizing the recommendation engines, for many common approaches including xDeepFM, SAR, ALS, RBM, DKN.

Personalizer can work with a recommendation engine when it's present.

Recommendation engines take large amounts of items (for example, 500,000) and recommend a subset (such as the top 20) from hundreds or thousands of options.
Personalizer takes a few actions with lots of information about them and ranks them in real time for a given rich context, while most recommendation engines only use a few attributes about users, products and their interactions.
Personalizer is designed to autonomously explore user preferences all the time, which will yield better results where content is changing rapidly, such as news, live events, live community content, content with daily updates, or seasonal content.
A common use is to take the output of a recommendation engine (for example, the top 20 products for a certain customer) and use that as the input actions for Personalizer.
