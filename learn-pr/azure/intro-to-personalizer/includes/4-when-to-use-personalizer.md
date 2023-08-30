How do you know when, or where, to use Personalizer? Microsoft offers some recommendations on scenarios such as:

- You want to select and display content to users for enhancing their experience with your services. If you're selling mobile phones, you might want to help the user discover how to make selections for size, color, storage, etc.
- Achieving better business results through targeted advertisements on your site.
- Improving productivity by guiding employees through complex processes. 

The list represents a small sample of opportunities for implementing Personalizer in your environment. You could consider Personalizer as a good choice for any service or application that can benefit from offering recommendations and suggestions that the user might perceive as having been tailored to their needs.


## Setting expectations

The focus here is more on guidelines that will make the use of Personalizer effective for your scenarios. It's not a comprehensive list but does list some of the more important considerations:

- Clearly defined business goals are critical to ensuring Personalizer is a valid choice for the intended purpose.
- Use Personalizer for content that lends itself to contextual decision making for the user.
- Use aggregate data to collect the user behaviors and to evaluate the reward scores for model improvement.
- Follow proper ethics to ensure any learning from the model follows the [guidance for integration and responsible use of Personalizer](/azure/ai-services/personalizer/responsible-guidance-integration?azure-portal=true).

## Use Personalizer with a recommendation solution

Many companies use recommendation engines, marketing and campaigning tools, audience segmentation and clustering, collaborative filtering, and other means to recommend products from a large catalog to customers.

The [Microsoft Recommenders GitHub repository](https://github.com/Microsoft/Recommenders?azure-portal=true) provides examples and best practices for building recommendation systems, provided as Jupyter notebooks. It provides working examples for preparing data, building models, evaluating, tuning, and operationalizing the recommendation engines, for many common approaches including xDeepFM, SAR, ALS, RBM, DKN.

Personalizer can work with a recommendation engine when it's present.

Recommendation engines take large amounts of items (for example, 500,000) and recommend a subset (such as the top 20) from hundreds or thousands of options.
Personalizer takes a few actions with lots of information about them and ranks them in real time for a given rich context, while most recommendation engines only use a few attributes about users, products and their interactions.
Personalizer is designed to autonomously explore user preferences all the time, which yields better results where content is changing rapidly, such as news, live events, live community content, content with daily updates, or seasonal content.
A common use is to take the output of a recommendation engine (for example, the top 20 products for a certain customer) and use that as the input actions for Personalizer.