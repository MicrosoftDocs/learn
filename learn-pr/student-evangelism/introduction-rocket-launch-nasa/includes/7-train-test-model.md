After you choose a machine learning algorithm, you have to provide it with data grounded in truth. When you input complex data, you'll want the model to output the correct choice. For this step you use an existing set of data to train the model.

## How would you train a human?

A machine learning algorithm is trained in a similar way to how a human is trained. If you'd never seen berries before, and were to walk into an area with five different types of berries: raspberries, blueberries, blackberries, strawberries, and huckleberries. Imagine you were told to grab 100 berries and that someone would tell you which berry each was. So you grab 100 berries and ask about five of them. You choose five that look different, one of each of the five types. For the next five, you'd be pretty sure you could determine what they are. Maybe there are some blackberries that aren't as ripe and kind of look like raspberries and there are some blueberries that aren't as ripe and kind of look like huckleberries. Over the 100 berries, you'd have a pretty good idea which berry is which.

Then, you are asked to go into a new field of berries, which have the same five types, and only collect the raspberries. You're pretty such you know what raspberries look like:

:::image type="complex" source="../media/raspberry.png" alt-text="Photo of a raspberry." loc-scope="azure":::

*Picture is shared by [Pro2 on Wikipedia](https://commons.wikimedia.org/wiki/File:Raspberry.jpg?azure-portal=true)*

:::image-end:::

So you are successful at this. You collect ten raspberries successfully!

To recap: The initial 100 berries was your initial data set. You were given the input (the 100 berries) and the output (the correct type of berry) and you *trained* yourself to be able to identify them.

Then, you were given a test: given any input, identify the type of berry, and only select one desired output - the raspberry. You still looked at other berries/input (as you were walking through the bushes) and you still tested your mental model of berries, and you only chose raspberries. At this point, you think your mental model of berries is 100% accurate.

*But then*, a new berry bush is added without you knowing. You go out to find more raspeberries, but you also collect some of these:

:::image type="complex" source="../media/thimbleberry.png" alt-text="Photo of a man's hand holding a thimbleberry." loc-scope="azure":::

*Picture is shared by [Jesse Taylor on Wikipedia](https://commons.wikimedia.org/wiki/File:Thimbleberry_(Rubus_parviflorus)_--_fruits.JPG?azure-portal=true)*

:::image-end:::

These look similar to raspberries, and they both look different from the other four types of berries. But they are *not* the same berry. The one you just brought back was a thimbleberry. (Dun dun duuuuuuuuuuun *cue dramatic music*)

This is a case where your data set isn't extensive enough. You think you're more accurate at identifying berries than you actually are.

Identifying berries might seem trivial, unless they are poisonous. But the implications apply to machine learning solutions. When these solutions risk people's lives, as is the case with rocket launches, these kinds of mistakes are unacceptable.

## Train and test machine learning models

Machine learning models act in the same way as described in the previous section. You give the model data with both input and output to train it. However, you don't give it *all* the data because otherwise the model will overfit. It would only know how to identify *those* berries and not be able generalize to a new berry farm where all the berries are larger. So you keep some of the data for testing the model. To test the model, you only provide it with the input data. You "grade" or "score" the model by checking what it thought the output should be with the true output.

Luckily, the machine learning algorithms you need are already written. The tools required to split your data, train your model, and test your model are also available. You can access and use these tools as a service.

## Step 4: Deploy your model

Finally, once your model has been trained and tested, you can deploy your model. That way it's available to be used with any other piece of software. For example, you could create a website where someone would put in a picture of a berry and the site would output the type of berry.
