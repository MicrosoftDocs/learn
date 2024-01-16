
The Responsible AI dashboard is built on the latest open-source tools developed by the leading academic institutions and organizations including Microsoft. These tools are instrumental for data scientists and AI developers to better understand model behavior, discover and mitigate undesirable issues from AI model using ErrorAnalysis, InterpretML, Fairlearn, DiCE, and EconML.

## Responsible AI dashboard components

The Responsible AI dashboard brings together various new and pre-existing tools. The dashboard integrates these tools with Azure Machine Learning CLI v2, Azure Machine Learning Python SDK v2, and Azure Machine Learning studio. The tools include:  

| Tool | Description |
|---| ---|
| Data analysis | To understand and explore your dataset distributions and statistics. |
| Model overview and fairness assessment | To evaluate the performance of your model and evaluate your model's group fairness issues (how your model's predictions affect diverse groups of people) |
| Error analysis | To view and understand how errors are distributed in your dataset. |
| Model interpretability (importance values for aggregate and individual features) | To understand your model's predictions and how those overall and individual predictions are made. |
| Counterfactual what-if | To observe how feature perturbations would affect your model predictions while providing the closest data points with opposing or different model predictions. For example: Taylor would have obtained a loan approval from the AI system if they earned $10,000 more in annual income and had two fewer credit cards open. |
| Causal analysis | To estimate how a real-world outcome changes in the presence of an intervention. It also helps construct promising interventions by simulating feature responses to various interventions and creating rules to determine which population cohorts would benefit from a particular intervention. Collectively, these functionalities allow you to apply new policies and effect real-world change.  For example, how would providing promotional values to certain customers affect revenue? <br> <br> The capabilities of this component come from the EconML package, which estimates heterogeneous treatment effects from observational data via machine learning.|

Together, these tools will help you debug machine learning models, while informing your data-driven and model-driven business decisions. The following diagram shows how you can incorporate them into your AI lifecycle to improve your models and get solid data insights.

:::image type="content" source="../media/dashboard.png" alt-text="Diagram of Responsible AI dashboard components for model debugging and responsible decision-making." lightbox="../media/dashboard.png" :::

### Model debugging

Assessing and debugging machine learning models is critical for model reliability, interpretability, fairness, and compliance. It helps determine how and why AI systems behave the way they do. You can then use this knowledge to improve model performance. Conceptually, model debugging consists of three stages:

1. **Identify**, to understand and recognize model errors and/or fairness issues by addressing the following questions:
  
   "What kinds of errors does my model have?"
  
   "In what areas are errors most prevalent?"
1. **Diagnose**, to explore the reasons behind the identified errors by addressing:
  
   "What are the causes of these errors?"

   "Where should I focus my resources to improve my model?"
1. **Mitigate**, to use the identification and diagnosis insights from previous stages to take targeted mitigation steps and address questions such as:

   "How can I improve my model?"

   "What social or technical solutions exist for these issues?"

:::image type="content" source="../media/model-debugging.png" alt-text="Diagram of model debugging via Responsible AI dashboard." lightbox= "../media/model-debugging.png":::

## Reasons for using the Responsible AI dashboard

Although progress has been made on individual tools for specific areas of Responsible AI, data scientists often need to use various tools to holistically evaluate their models and data. For example: they might have to use model interpretability and fairness assessment together. 

If data scientists discover a fairness issue with one tool, they then need to jump to a different tool to understand what data or model factors lie at the root of the issue before taking any steps on mitigation. The following factors further complicate this challenging process:

- There's no central location to discover and learn about the tools, extending the time it takes to research and learn new techniques. 
- The different tools don't communicate with each other. Data scientists must wrangle the datasets, models, and other metadata as they pass them between the tools. 
- The metrics and visualizations aren't easily comparable, and the results are hard to share.

The Responsible AI dashboard challenges this status quo. It's a comprehensive yet customizable tool that brings together fragmented experiences in one place. It enables you to seamlessly onboard to a single customizable framework for model debugging and data-driven decision-making. 

By using the Responsible AI dashboard, you can create dataset cohorts, pass those cohorts to all of the supported components, and observe your model health for your identified cohorts. You can further compare insights from all supported components across various prebuilt cohorts to perform disaggregated analysis and find the blind spots of your model.
