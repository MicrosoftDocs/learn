Evaluations are systematic processes of assessing the performance, reliability, and efficacy of generative AI applications. These assessments involve a series of tests and metrics designed to quantify how well an AI model performs its intended task. The goal is to ensure that the AI application behaves as expected, providing accurate and relevant outputs in various scenarios.

Evaluations are crucial for several reasons:

- **Quality Assurance**: They help in ensuring that the AI systems meet the desired standards of accuracy and reliability.
- **Performance Metrics**: Evaluations provide essential data on the effectiveness of the AI app’s outputs, highlighting areas for improvement.
- **Bias Detection**: They help in identifying and measuring the prevalence of   biases present in the AI model, highlighting areas for improvement.
- **User Trust**:  AI applications that perform well consistently help build trust with users, earning higher satisfaction and usage.

## AI-assisted evaluations with Azure

Evaluating generative AI models presents unique challenges due to their dynamic and often creative outputs. Traditional evaluation methods may not fully capture the intricacies of generative models, necessitating more specialized approaches. As such, we provide AI-assisted evaluations which leverage machine learning techniques to augment the evaluation process. The choice of models for AI-assisted evaluation can significantly impact the results. Therefore, we recommend testing and comparing your evaluations with the supported GPT 3.5, GPT 4, or Davinci model for your calculations.

You have the flexibility to run evaluations with Azure either through the UI in Azure AI Studio or programmatically with the Azure AI Evaluation SDK. Both tools provide access to a series of Performance & Quality and Risk & Safety metrics.  However, programmatically, you also have the option to create your own code-based and prompt-based custom evaluators, and also log your custom evaluators to your Azure AI project.

## Evaluate with Azure AI Studio

Azure AI Studio supports running both manual and automated evaluations. Manual evaluation enables human graders to manually score generated outputs for both manual input entry and an uploaded dataset. After you run the evaluation, you can provide a thumbs up or down rating to each response to grade the prompt output. When mitigating specific risks, it’s helpful to keep manually checking progress against a small dataset until evidence of the risk is no longer observed before moving on to automated evaluation.

Automated evaluation enables you to generate outputs for each data row in your test dataset. You can choose one or more built-in evaluation metrics to assess the output for different qualities.

## Evaluate with the Azure AI Evaluation SDK

Given either a test dataset or a target, your generative AI application generations are quantitatively measured with both mathematical based metrics and AI-assisted quality and safety evaluators. Built-in or custom evaluators can provide you with comprehensive insights into the application's capabilities and limitations. Performing evaluations programmatically provides the flexibility to integrate with existing workflows and pipelines. Although programmatic evaluations are not run in Azure AI Studio, you can track and compare your evaluation results in your Azure AI Studio project.

In general, it’s recommended to balance automated and human evaluation. Use a combination of AI-assisted evaluations and human assessment to capture both quantitative and qualitative insights.
