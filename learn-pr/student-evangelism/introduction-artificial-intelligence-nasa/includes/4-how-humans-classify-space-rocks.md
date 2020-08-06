Before we build an AI system to detect the rock types, lets see how we 'humans' classify things.

This is the likely process that our brain goes through to do this:

### Step 0

We have to collect as many rock images as possible. This will let us see lots of different variations of the items we are trying to classify. Fortunately, this project, there are lots of space rock pictures openly available online that you can use.

### Step 1

Our brain first tries to extract patterns from each image, patterns such as:

Color combinations  
Sharp edges  
Circular patterns  
Texture of the rock  
Size of the rock  

Our brains subconsciously do all of these without us noticing. We call these 'Features' in AI.

Below are some features that we can extract from a motorcycle. You can see there are wheels, handle-bars, throttle, etc.

:::image type="content" alt-text="ADD ALT TEXT HERE." source="../media/features.png" loc-scope="Azure":::

### Step 2

Next, we try to find the relationships between the features and rock types.

In this step our brain tries to figure out what are the characteristics/features of each rock type.

As a result of this, we will come up with some rules, for example : "Lighter rocks are usually Crustals". "Basalt rocks have more dense textures", ...
We show these associations with links such as shown below:

:::image type="content" alt-text="ADD ALT TEXT HERE." source="../media/links.png" loc-scope="Azure":::

### Step 3

Last, we try to use these relationships to figure out how to classify a new item.

Given a new rock image, our brain extracts all of its characteristics we discussed above, and then uses the associations we made in the second step to decides what type of rock it is.

:::image type="content" alt-text="ADD ALT TEXT HERE." source="../media/association-process.png" loc-scope="Azure":::
