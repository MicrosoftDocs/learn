Once you have chosen a machine learning algorithm, say a two-class classification algorithm, you have to provide it with data grounded in truth to train the model to output the correct choice given a complex input of data. This requires having existing data to train the model. 

## How Would You Train a Human?

This isn't far off from what humans do. If you had never seen berries before, and were to walk into an area with 5 different types of berries: raspberries, blueberries, blackberries, strawberries, and huckleberries. Imagine you were told to grab 100 berries and that someone would tell you which berry each was. So you grab 100 berries and the first 5 you ask about, you choose 5 that all look different (so one of each of the 5 types). The next 5, you're probably pretty sure what they are, but there are some blackberries that aren't as ripe and kind of look like raspberries and there are some blueberries that aren't as ripe and kind of look like huckleberries. Over the 100 berries, you think you have a pretty good idea which berry is which. 

Then, you are asked to go into a new field of berries, which have the same 5 types, and only collect the raspberries. You're pretty such you know what raspberries look like:

:::image type="content" source="../media/raspberry.png" alt-text="Photo of a raspberry." loc-scope="azure":::

*Picture is shared by [Pro2 on Wikipedia](https://commons.wikimedia.org/wiki/File:Raspberry.jpg?azure-portal=true)*

So you are successful at this. You collect 10 raspberries successfully!

To recap: The initial 100 berries was your initial data set. You were given the input (the 100 berries) and the output (the correct type of berry) and you *trained* yourself to be able to identify them. 

Then, you were given a test: given any input, identify the type of berry, and only select one desired output (the raspberry). You still looked at other berries/input (as you were walking through the bushes) and you still tested your mental model of berries, and you only chose raspberries. At this point, you think your mental model of berries is 100% accurate.

*But then*, la new berry bush was added without you knowing, and when you went out to find more raspeberries you also collected some of these:

:::image type="content" source="../media/thimbleberry.png" alt-text="Photo of a man's hand holding a thimbleberry." loc-scope="azure":::

*Picture is shared by [Jesse Taylor on Wikipedia](https://commons.wikimedia.org/wiki/File:Thimbleberry_(Rubus_parviflorus)_--_fruits.JPG?azure-portal=true)*

While they look similar, and they both look different from the other four types of berries (blueberries, blackberries, strawberries, and huckleberries), they are *not* the same berry. The one you just brought back was a thimbleberry. (Dun dun duuuuuuuuuuun *cue dramatic music*)

This is a case where your data set was not extensive enough and you actually thought you were more accurate at identifying berries than you actually were. 

While identifying berries is pretty trivial (unless they are poisonous) the implications of this in machine learning solutions that involve people's lives (like rocket launches) can't make these mistakes. 

## Train and Test Machine Learning Models

Machine learning models act the same way as we described above. You give the model data with both input and output to train it. You don't give it ALL of the data, otherwise the model will overfit (only know how to identify THOSE berries and not be able generalize to a new berry farm that just has bigger berries all around). So you keep some of the data to test the model with. To test the model, you only give the input to the model and then you "grade" or "score" the model by checking what it thought the output should be with what the output really is. 

Luckily, the machine learning algorithms and the tools needed to split your data, train your model, and test your model have been written and we can now use them as a service. 

## Step 4: Deploy Your Model

Finally, once your model has been trained and tested, you can deploy your model to be used with any other piece of software. For example, you could create a website where someone would put in a picture of a berry and it would return the type of berry it is. 