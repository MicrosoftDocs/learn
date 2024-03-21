Before understanding how to work with prompt flow, let's explore the development lifecycle of a Large Language Model (LLM) application.

The lifecycle consists of the following stages:

:::image type="content" source="../media/development-lifecycle.png" alt-text="Diagram of the four stages of the development lifecycle.":::

1. **Initialization**: Define the use case and design the solution.
1. **Experimentation**: Develop a flow and test with a small dataset.
1. **Evaluation and refinement**: Assess the flow with a larger dataset.
1. **Production**: Deploy and monitor the flow and application.

During both evaluation and refinement, and production, you might find that your solution needs to be improved. You can revert back to experimentation during which you develop your flow continuously, until you're satisfied with the results.

Let's explore each of these phases in more detail.

## Initialization

Imagine you want to design and develop an LLM application to classify news articles. Before you start creating anything, you need to define what categories you want as output. You need to understand what a typical news article looks like, how you present the article as input to your application, and how the application generates the desired output.

In other words, during *initialization* you:

:::image type="content" source="../media/initialization.png" alt-text="Diagram of the four steps during initialization.":::

1. Define the **objective**
1. Collect a **sample dataset**
1. Build a **basic prompt**
1. Design the **flow**

To design, develop, and test an LLM application, you need a sample dataset that serves as the input. A sample dataset is a small representative subset of the data you eventually expect to parse as input to your LLM application.

When collecting or creating the sample dataset, you should ensure diversity in the data to cover various scenarios and edge cases. You should also remove any privacy sensitive information from the dataset to avoid any vulnerabilities.

## Experimentation

You collected a sample dataset of news articles, and decided on which categories you want the articles to be classified into. You designed a flow that takes a news article as input, and uses an LLM to classify the article. To test whether your flow generates the expected output, you run it against your sample dataset.

:::image type="content" source="../media/experimentation.png" alt-text="Diagram of the four steps during experimentation.":::

The *experimentation* phase is an iterative process during which you (1) **run** the flow against a sample dataset. You then (2) **evaluate** the prompt's performance. If you're (3) satisfied with the result, you can **move on** to evaluation and refinement. If you think there's room for improvement, you can (4) **modify** the flow by changing the prompt or flow itself.

## Evaluation and refinement

When you're satisfied with the output of the flow that classifies news articles, based on the sample dataset, you can assess the flow's performance against a larger dataset.

By testing the flow on a larger dataset, you can evaluate how well the LLM application generalizes to new data. During evaluation, you can identify potential bottlenecks or areas for optimization or refinement.

When you edit your flow, you should first run it against a smaller dataset before running it again against a larger dataset. Testing your flow with a smaller dataset allows you to more quickly respond to any issues.

Once your LLM application appears to be robust and reliable in handling various scenarios, you can decide to move the LLM application to production.

## Production

Finally, your news article classification application is ready for *production*.

:::image type="content" source="../media/production.png" alt-text="Diagram of the three steps during production.":::

During production, you:

1. **Optimize** the flow that classifies incoming articles for efficiency and effectiveness.
1. **Deploy** your flow to an endpoint. When you call the endpoint, the flow is triggered to run and the desired output is generated.
1. **Monitor** the performance of your solution by collecting usage data and end-user feedback. By understanding how the application performs, you can improve the flow whenever necessary.

## Explore the complete development lifecycle

Now that you understand each stage of the development lifecycle of an LLM application, you can explore the complete overview:

:::image type="content" source="../media/detailed-lifecycle.png" alt-text="Diagram of all stages including their steps of the development lifecycle.":::
