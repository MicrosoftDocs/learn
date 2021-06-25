In our exercises, we found that our model could predict avalanches so some degree, but it was still wrong around 40% of the time. This is because our feature – the number of weak layers of snow – is not the only thing that is responsible for avalanches.

There are two primary ways to improve classification model performance that we will dive into now: providing additional features and being selective about what enters the model.

## Provide additional features

Like linear regression, logistic regression does not have to be limited to a single input (feature). It can combine features to make predictions. For example, we might try to predict avalanches based on snow fall and number of hikers disturbing a trail. We can enter both these into the same model to calculate a probability of an avalanche.

Internally, logistic regression combines features similarly to linear regression. That is, it treats all features as **independent**, meaning that it assumes that features do not influence one another. For example, our model will assume that the amount of snowfall does not change how many people will visit the trail. By default, it also assumes that snowfall increases risk of avalanche by a set amount – regardless as to how many hikers are walking the trail.

### The good and bad sides of independent features

Logistic regression can be explicitly told to combine features so that how they work together can be modelled, but by default it will not do so. This makes logistic regression different from most other well-known categorisation algorithms such as **decision trees and neural networks.**

The fact that logistic regression treats features as independent by default is both a strength and a limitation that should be kept in mind. For example, this means it can make clear predictions simply, such as “increasing the number of people increases risk”, which cannot usually be done with other models. It also reduces the chance of overfitting the training data. By contrast, the model can fail to work well if features **actually interact in the real world** – for example, five hikers crossing a mountain is risky if there is snow, but five people is completely safe if there is no snow-fall to cause an avalanche. A logistic regression model would need to be told explicitly to look for an **interaction** between snow-fall and number of hikers in this example to pick up this nuance.

## Think about your features

The other way to improve models is to give real thought to which features are supplied, and why. Generally, the more features we add to a model, the better the model will work. This is only true, however, if the features we provide are actually relevant and explain something that existing features do not.

### Avoiding overtraining
If we supply additional features that are not particularly useful, the model can **overtrain** – giving the appearance of working better, but actually working worse in the real world.

For example, imagine if we had daily records of the amount_of_snow, number_of_hikers, temperature, and number_of_birds_spotted. The number of birds spotted is probably not relevant information, but if supplied the model will end up modelling a relationship between avalanches and the number of birds spotted on given days. If birds tended to be spotted more on avalanche days (for example, because more people were looking at the mountain after the avalanche and incidentally saw birds), the model will suggest that birds could be responsible for causing avalanches. We might then set up a systematic bird watching program to predict avalanches, only to find it does not work at all.

### Avoiding undertraining

Using features naively can also lead to **undertraining** – not making predictions as well as is possible. For example, the temperature and the number_of_hikers might both be strongly linked to avalanches, but if people only walk on sunny days, the model might find it difficult to differentiate how important hikers are, who disturb the snow, versus temperature, which melts the snow. Similarly, we probably will find that our model works better if we supply our number_of_hikers as an exact count of visitors, rather than simply “high” or “low”, so that the model training can find a more exact relationship.