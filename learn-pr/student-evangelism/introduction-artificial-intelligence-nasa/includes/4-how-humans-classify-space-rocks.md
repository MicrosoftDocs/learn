Before we build an AI system to detect the rock types, let's consider how humans classify things.

Our thought process usually goes something like this:

### Step 0

We want to collect as many rock images as possible. Having a large number of images helps us see a large number of variation in the items we are trying to classify. Fortunately, in this project, we can choose from a large number of relevant images online.

### Step 1

First, our brain tries to extract patterns from each image. The patterns include the following factors:

- Color combinations  
- Sharp edges  
- Circular patterns  
- Texture in the rock's surface  
- The size of the rock  

Our brains subconsciously do all of these visual searches and categorization without our notice. In AI, we refer to these factors as *features*.

The following image lists some features that we can extract from a photo of a motorcycle:

:::image type="content" alt-text="ADD ALT TEXT HERE." source="../media/features.png" loc-scope="Azure":::

### Step 2

Next, we try to find the relationships between the features and the type of rock.

In this step, our brain tries to separate or collate the characteristics and features of each type of rock. Because of the associations we make, we come up with some rules. For example, we determine that lighter rocks are usually crustals and that the texture of basalt rocks are more dense. These associations, and the links between them, are demonstrated in the following image:

:::image type="content" alt-text="ADD ALT TEXT HERE." source="../media/links.png" loc-scope="Azure":::

### Step 3

Last, we try to use these relationships to determine how to classify a new item. Given a new rock image to consider, our brains extract its characteristics. Then, our brain uses the associations we already made to determine what type of rock it is.

:::image type="content" alt-text="ADD ALT TEXT HERE." source="../media/association-process.png" loc-scope="Azure":::
