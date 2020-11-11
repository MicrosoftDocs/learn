After you choose a machine learning algorithm, you have to provide it with data grounded in truth. When you input complex data, you'll want the model to output the correct choice. For this step, you use an existing set of data to train the model.

## How would you train a human?

A machine learning algorithm is trained in a similar way to how a human is trained. What if you walk into an area with five different types of berries that you've never seen before? There are raspberries, blueberries, blackberries, strawberries, and huckleberries. Imagine you're told to grab 100 berries, and choose 5 that look different - one of each of the five types. You're told the names of the five types of berries.

For the next 5, you'd be sure you could determine what they are. Maybe some blackberries aren't as ripe and look a bit like raspberries and some blueberries aren't as ripe and look a bit like huckleberries. But even so, over the 100 berries, you'd have a decent idea which berry is which.

Next, you're asked to collect only raspberries in a new field that contains the same five types of berries. You're pretty sure you know what raspberries look like:

:::image type="content" source="../media/raspberry.png" alt-text="Photo of a raspberry." loc-scope="azure":::

*Picture is shared by [Pro2 on Wikipedia](https://commons.wikimedia.org/wiki/File:Raspberry.jpg?azure-portal=true)*

You complete this task and collect 10 raspberries successfully!

To recap: The initial 100 berries were your initial data set. You were given the input (the 100 berries) and the output (the correct type of berry) and you *trained* yourself to be able to identify them.

Then you had a test: given any input, identify the type of berry and only select one desired output - the raspberry. You looked at other berries/input as you were walking through the bushes. You tested your mental model of berries and only chose raspberries. At this point, you think your mental model of berries is 100% accurate.

*But then*, a new berry bush is added without you knowing. You go out to find more raspberries, but you also collect some of these berries:

:::image type="content" source="../media/thimbleberry.png" alt-text="Photo of a man's hand holding a thimbleberry." loc-scope="azure":::

*Picture is shared by [Jesse Taylor on Wikipedia](https://commons.wikimedia.org/wiki/File:Thimbleberry_(Rubus_parviflorus)_--_fruits.JPG?azure-portal=true)*

These berries look similar to raspberries. They also both look different from the other four types of berries. But they are *not* the same type of berry. The one you just brought back was a thimbleberry. (Dun dun duuuuuuuuuuun *cue dramatic music*)

In this case, your data set isn't extensive enough. You think you're more accurate at identifying berries than you actually are.

Identifying berries might seem trivial, unless they're poisonous. But the implications apply to machine learning solutions. When these solutions risk people's lives, as is the case with rocket launches, these kinds of mistakes are unacceptable.

## Train and test machine learning models

Machine learning models act in the same way as described in the previous section. You give the model data with both input and output to train it. However, you don't give it *all* the data because otherwise the model will overfit. It would only know how to identify *those* berries. It wouldn't be able to generalize to a new berry farm where all the berries are larger. So you keep some of the data for testing the model. To test the model, you only provide it with the input data. You "grade" or "score" the model by checking what it thought the output should be with the true output.

Luckily, the machine learning algorithms you need are already written. The tools required to split your data, train your model, and test your model are also available. You can access and use these tools as a service.

## Step 4: Deploy your model

Finally, once your model has been trained and tested, you can deploy your model. That way it's available to be used with any other piece of software. For example, you could create a website where someone enters a picture of a berry and the site identifies the type of berry.
