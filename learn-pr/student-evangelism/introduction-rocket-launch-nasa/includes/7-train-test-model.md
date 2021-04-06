After you choose a machine learning algorithm to use, you must provide it with data that's grounded in truth. When you input complex data, you'll want the model to output the correct choice. For this step, you use an existing set of data to train the model.

### How would you train a human?

A machine learning algorithm is trained similar to how a human is trained. 

What if you walk into an area in which 5 different types of berries that you've never seen before are growing? Imagine that you're asked to pick 100 random berries, including 1 berry from each of the five distinct types of berry plants. You are told the names of the 5 berries you picked from each type of berry plant. You have a raspberry, a blueberry, a blackberry, a strawberry, and a huckleberry. The other 95 berries that you picked are one of those types.

Being able to name the five different berry types, you feel sure that you can identify the types of the remaining randomly picked 95 berries. Maybe some blackberries aren't as ripe, so they are smaller and look a bit like raspberries, and some blueberries aren't as ripe and might look more like huckleberries. But even so, for the 100 berries, you'd have a decent idea which berry is which, and you'd be able to sort all 100 berries by type.

Next, you're asked to collect only raspberries in a new field that contains the same five types of berries. You're confident that you know what raspberries look like:

:::image type="content" source="../media/raspberry.png" alt-text="Photo of a raspberry." loc-scope="Azure":::

You complete this task and collect 10 raspberries successfully!

To recap: the initial 100 berries were in your initial dataset. You were given the input (the 100 berries) and the output (the correct types of the berries), and you *trained* yourself to be able to identify the berries you picked.

Then, you had a test: given any input, identify the type of berry, and select only one output—raspberries. You looked at other berries (input) as you were walking through the berry bushes. You tested your mental model of berries and chose only raspberries. At this point, you believe that your mental model of berries is 100% accurate.

But then, you spot a berry plant that looks similar to a raspberry. What you didn't know is that there were actually six berry types in your berry-picking field. You do find more raspberries, but you also collect some of these berries, thinking they might actually be raspberries, although they look a little different:

:::image type="content" source="../media/thimbleberry.png" alt-text="Photo of a hand holding a thimbleberry." loc-scope="Azure":::

Both the new berry and a raspberry look different from the other four types of berries, but they look similar to each other. But they are *not* the same type of berry. The type of berry you just picked was a *thimbleberry*.

In this case, your dataset isn't extensive enough. You think you're more accurate at identifying berries than you actually are.

Identifying berries might seem trivial, unless they're poisonous. But the implications apply to machine learning solutions. When these solutions risk people's lives, like in a rocket launch, these kinds of mistakes must be avoided.

### Train and test machine learning models

Machine learning models are similar to the berry identification experiment. You give the model data that has both input and output to train it. However, you don't give it *all* the data because otherwise the model will overfit. It would know only how to identify *those* berries. It wouldn't be able to generalize to a new berry farm on which all the berries are larger, for example. So, you keep some of the data for testing the model. To test the model, you provide it only with the input data. You use the true output to "grade" or "score" the model.

Luckily, the machine learning algorithms you need are already written. The tools required to split your data, train your model, and test your model also are available. You can access and use these tools as a service, so you don't have to install them on your computer.

## Deploy your model

Finally, when your model is trained and tested, you can deploy your model. When your model is deployed, it's available to be used with any other piece of software. For example, you can create a website where someone enters a picture of a berry and the site identifies the type of berry.