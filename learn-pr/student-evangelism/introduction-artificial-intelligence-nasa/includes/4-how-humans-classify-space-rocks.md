To build an AI model to detect rock types, we need to consider how humans classify things.

In this section, we'll outline a common thought process that humans follow for examining and classifying data. Later, we'll use these steps to form a model for our computer to do the same tasks.

### Step 0: Get data

We want to collect as many rock images as possible. Having a large number of images helps us see a large number of variations in the items we're trying to classify. Fortunately, in this project, we can choose from a large number of relevant images online.

### Step 1: Extract features

First, our brain tries to extract patterns from each image. The patterns include the following factors:

- Color combinations  
- Sharp edges  
- Circular patterns  
- Texture in the rock's surface  
- The size of the rock
- The size and shape of minerals in the rock

Our brains subconsciously do all of these visual searches and categorization without our notice. In AI, we refer to these factors as *features*.

The following image lists some features we can extract from a photo of a motorcycle:

:::image type="complex" source="../media/features.png" alt-text="Diagram that shows how humans extract and identify features from what they see.":::
   First, a picture of motorcycle. Arrows move from the motorcycle to an extraction algorithm that happens in the human brain. Next, arrows from the extraction algorithm produce a geometric table labeled as features. The table of features has nine boxes that show parts of the motorcycle.
:::image-end:::

### Step 2: Find relationships

Next, we try to find the relationships between the features and the type of rock that's shown in a photo of a rock.

In this step, our brain tries to separate or collate the characteristics and features of each type of rock. Because of the associations we make, we come up with some rules. We determine that lighter rocks usually are highland rocks and that the texture of basalt rocks is more jagged. These associations and the links between them are demonstrated in the following image:

:::image type="content" source="../media/links.png" alt-text="A diagram that shows four sets of nine black dots. Different patterns of colored lines connect the dots in each set to demonstrate the dynamic associations." loc-scope="Azure":::

### Step 3: Classify types

Last, we try to use these relationships between known items to determine how to classify a new item. Given a new rock image to consider, our brains extract its characteristics. Then, our brain uses the associations we already made to determine what type of rock it is.

:::image type="content" source="../media/association-process.png" alt-text="A diagram that shows the progression from pixel numbers, to feature extraction, and finally to associations." loc-scope="Azure":::
