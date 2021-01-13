Before we build an AI system to detect the rock types, let's consider how humans classify things.

Our thought process usually goes something like this:

### Step 0

We want to collect as many rock images as possible. Having a large number of images helps us see a large number of variations in the items we're trying to classify. Fortunately, in this project, we can choose from a large number of relevant images online.

### Step 1

First, our brain tries to extract patterns from each image. The patterns include the following factors:

- Color combinations  
- Sharp edges  
- Circular patterns  
- Texture in the rock's surface  
- The size of the rock 
- The size and shape of minerals in the rock 

Our brains subconsciously do all of these visual searches and categorization without our notice. In AI, we refer to these factors as *features*.

The following image lists some features we can extract from a photo of a motorcycle:

:::image type="content" source="../media/features.png" alt-text="Left to right, a figure of a motorcycle; the words Feature, extraction, algorithm; and nine boxes that show parts of a motorcycle under the heading Features." loc-scope="Azure":::

### Step 2

Next, we try to find the relationships between the features and the type of rock is shown in a photo of a rock.

In this step, our brain tries to separate or collate the characteristics and features of each type of rock. Because of the associations we make, we come up with some rules. For example, we determine that lighter rocks usually are highland rocks and that the texture of basalt rocks is more jagged. These associations and the links between them are demonstrated in the following image:

:::image type="content" source="../media/links.png" alt-text="Diagram that shows four sets of nine black dots, with colored lines being drawn between the dots in each set to demonstrate dynamic associations." loc-scope="Azure":::

### Step 3

Last, we try to use these relationships between known items to determine how to classify a new item. Given a new rock image to consider, our brains extract its characteristics. Then, our brain uses the associations we already made to determine what type of rock it is.

:::image type="content" source="../media/association-process.png" alt-text="Diagram that demonstrates the progression from pixel numbers to feature extraction to associations." loc-scope="Azure":::
