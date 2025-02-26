Evaluations are systematic processes of assessing the performance, reliability, and efficacy of generative AI applications. These assessments involve a series of tests and metrics designed to quantify how well an AI model performs its intended task. The goal is to ensure that the AI application behaves as expected, providing accurate and relevant outputs in various scenarios.

Evaluations are crucial for several reasons:

- **Quality Assurance**: They help in ensuring that the AI systems meet the desired standards of accuracy and reliability.
- **Performance Metrics**: Evaluations provide essential data on the effectiveness of the AI app’s outputs, highlighting areas for improvement.
- **Bias Detection**: They help in identifying and measuring the prevalence of   biases present in the AI model, highlighting areas for improvement.
- **User Trust**:  AI applications that perform consistently well help build trust with users, earning higher satisfaction and usage.

## AI-assisted evaluations with Azure

Evaluating generative AI models presents unique challenges due to their dynamic and often creative outputs. Traditional evaluation methods might not fully capture the intricacies of generative models, necessitating more specialized approaches. As such, we provide AI-assisted evaluations which use machine learning techniques to augment the evaluation process. The choice of models for AI-assisted evaluation can significantly affect the results. Therefore, we recommend testing and comparing your evaluations with the supported GPT 3.5, GPT 4, or Davinci model for your calculations.

You have the flexibility to run evaluations with Azure either through the UI in Azure AI Foundry or programmatically with the Azure AI Evaluation SDK. Both tools provide access to a series of Performance & Quality and Risk & Safety metrics. However, programmatically, you also can create your own code-based and prompt-based custom evaluators, and also log your custom evaluators to your Azure AI project.

## Evaluate with Azure AI Foundry

Azure AI Foundry supports running both manual and automated evaluations. Manual evaluation enables human graders to manually score generated outputs for both manual input entry and an uploaded dataset. After you run the evaluation, you can provide a thumb up or down rating to each response to grade the prompt output. When mitigating specific risks, it’s helpful to keep manually checking progress against a small dataset until evidence of the risk is no longer observed before moving on to automated evaluation.

:::image type="complex" source="../media/manual-evaluation.png" alt-text="A screenshot of the manual evaluation interface in Azure AI Foundry. The assistant setup displays and a set of manual evaluation results. There's a set of percentages for the data rated, the responses that received a thumb-up, and the responses that received a thumb-down. There's also a table of the user input, expected result, and the output.":::
   This image shows a screenshot of the Azure AI Foundry interface, focusing on the setup and evaluation of an AI assistant for a camping store chatbot. The interface has a light color scheme with blue accents. The screen is divided into several sections: Assistant setup, manual evaluation result, and evaluation table. The interface includes various icons and tools for navigation and interaction, such as edit, play, thumbs up/down buttons for each response. This screenshot provides insight into the process of setting up, training, and evaluating an AI assistant for a specific use case in e-commerce.
:::image-end:::

Automated evaluation enables you to generate outputs for each data row in your test dataset. You can choose one or more built-in evaluation metrics to assess the output for different qualities.

:::image type="complex" source="../media/automated-evaluation-results.png" alt-text="A screenshot of the automated evaluation results in Azure AI Foundry. There are four charts which display the average score and counts for coherence, fluency, groundedness, and relevance. There is a tab which provides the risk and safety counts for the risk and safety evaluators. There is also a drop-down that can be used to apply filters.":::
   The image shows a screenshot of the Azure AI Foundry interface, displaying an evaluation dashboard for a project named 'evaluation_test_qa'. The interface has a clean, modern design with a light color scheme. At the top of the screen, there's a header with the Azure AI Foundry logo, project name, and various icons for notifications, settings, and project selection. The main content area is divided into two sections: evaluation details, metric dashboard. Each metric has an information icon next to it, suggesting additional details are available. At the top right of the metric dashboard, there's an 'Applied filters' dropdown set to 'All metrics'. The left side of the screen contains a navigation menu with various icons, for different sections or tools within Azure AI Foundry. This dashboard provides a comprehensive view of the AI model's performance across multiple evaluation criteria, allowing developers to assess and improve their model's output quality.
:::image-end:::

## Evaluate with the Azure AI Evaluation SDK

Given either a test dataset or a target, your generative AI application generations are quantitatively measured with both mathematical based metrics and AI-assisted quality and safety evaluators. Built-in or custom evaluators can provide you with comprehensive insights into the application's capabilities and limitations. Performing evaluations programmatically provides the flexibility to integrate with existing workflows and pipelines. Although programmatic evaluations aren't run in Azure AI Foundry, you can track and compare your evaluation results in your Azure AI Foundry project.

In general, balance automated and human evaluation. To capture both quantitative and qualitative insights, use a combination of AI-assisted evaluations and human assessment.
