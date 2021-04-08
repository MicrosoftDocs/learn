A machine learning model is trained similar to how humans are trained. So, how does a human learn?

What if you walk into an area in which five different types of berries that you've never seen before are growing? Imagine that you're asked to pick 100 random berries, including one berry from each of the five distinct types of berry plants. You are told the names of the five berries you picked, one from each type of berry plant. You have a raspberry, a blueberry, a blackberry, a strawberry, and a huckleberry. The other 95 berries that you picked are one of those types of berries.

Being able to name the five different berry types, you feel sure that you can identify the types of the remaining randomly picked 95 berries. Maybe some blackberries aren't as ripe, so they are smaller and look a bit like raspberries, and some blueberries aren't as ripe and might look more like huckleberries. But even so, for the 100 berries, you'd have a decent idea which berry is which type, and you'd be able to sort all 100 berries by type.

Next, you're asked to collect only raspberries in a new, adjacent field. You're confident that you know what raspberries look like:

:::image type="content" source="../media/raspberry.png" alt-text="Photo of a raspberry." border="false" loc-scope="Azure":::

You complete this task and collect 10 raspberries successfully!

To recap, the initial 100 berries were in your initial dataset. You were given the input (the 100 berries) and the output (the types of berries that were included), and you *trained* yourself to be able to identify the berries you picked.

Then, you were given a test. In a new field of berries, given any input, identify the type of berry, and select only one output—raspberries. You looked at other berries (input) as you walked among the berry plants. You tested your mental model of berries and picked only raspberries. At this point, you believe that your mental model of berries is 100% accurate.

But then, you spot a berry plant that looks similar to a raspberry, but slightly different. What you didn't know is that there were actually six berry types in the new berry-picking field. You do find more raspberries, but you also collect some of the other berries, thinking that they might actually be raspberries, although they do look a little different:

:::image type="content" source="../media/thimbleberry.png" alt-text="Photo of a hand holding a thimbleberry." loc-scope="Azure":::

Both the new berry and a raspberry look different from the other four types of berries, but they look similar to each other. But they are *not* the same type of berry. The new type of berry you picked was a *thimbleberry*.

In this case, your dataset isn't extensive enough. It would be inaccurate to put a thimbleberry with raspberries just because you think they should fit in one of the berry types, and you don't know that there are more than five types of berries. You think you're more accurate at identifying berries than you actually are because you don't know everything you need to know to be accurate.

Identifying berries might seem trivial, but the implications apply to machine learning solutions. When these types of solutions affect people's lives, like in a rocket launch, these kinds of data analysis mistakes must be avoided.

