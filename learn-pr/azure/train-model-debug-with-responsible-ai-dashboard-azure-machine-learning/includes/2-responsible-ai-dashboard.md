
The Responsible AI dashboard provides a single interface to help you implement Responsible AI in practice effectively and efficiently.

## Responsible AI dashboard components

The Responsible AI dashboard brings together various new and pre-existing tools. The dashboard integrates these tools with Azure Machine Learning CLI v2, Azure Machine Learning Python SDK v2, and Azure Machine Learning studio. The tools include:  

- Data analysis, to understand and explore your dataset distributions and statistics.
- Model overview and fairness assessment, to evaluate the performance of your model and evaluate your model's group fairness issues (how your model's predictions affect diverse groups of people).
- Error analysis, to view and understand how errors are distributed in your dataset.  
- Model interpretability (importance values for aggregate and individual features), to understand your model's predictions and how those overall and individual predictions are made.
- Counterfactual what-if, to observe how feature perturbations would affect your model predictions while providing the closest data points with opposing or different model predictions.
- Causal analysis, to use historical data to view the causal effects of treatment features on real-world outcomes.

Together, these tools will help you debug machine learning models, while informing your data-driven and model-driven business decisions. The following diagram shows how you can incorporate them into your AI lifecycle to improve your models and get solid data insights.

:::image type="content" source="./media/dashboard.png" alt-text="Diagram of Responsible AI dashboard components for model debugging and responsible decision-making.":::

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

:::image type="content" source="./media/model-debugging.png" alt-text="Diagram of model debugging via Responsible AI dashboard." lightbox= "./media/model-debugging.png":::

### Responsible decision-making

Decision-making is one of the biggest promises of machine learning. The Responsible AI dashboard can help you make informed business decisions through:

- Data-driven insights, to further understand causal treatment effects on an outcome by using historical data only. For example:

  "How would a medicine affect a patient's blood pressure?"
  
  "How would providing promotional values to certain customers affect revenue?"
  
  These insights are provided through the causal inference component of the dashboard.
- Model-driven insights, to answer users' questions (such as "What can I do to get a different outcome from your AI next time?") so they can take action. These insights are provided to data scientists through the counterfactual what-if component.

:::image type="content" source="./media/decision-making.png" alt-text="Diagram that shows responsible AI dashboard capabilities for responsible business decision-making.":::

Exploratory data analysis, causal inference, and counterfactual analysis capabilities can help you make informed model-driven and data-driven decisions responsibly.

These components of the Responsible AI dashboard support responsible decision-making:

- **Data analysis**: You can reuse the data analysis component here to understand data distributions and to identify overrepresentation and underrepresentation. Data exploration is a critical part of decision making, because it isn't feasible to make informed decisions about a cohort that's underrepresented in the data.
- **Causal inference**: The causal inference component estimates how a real-world outcome changes in the presence of an intervention. It also helps construct promising interventions by simulating feature responses to various interventions and creating rules to determine which population cohorts would benefit from a particular intervention. Collectively, these functionalities allow you to apply new policies and effect real-world change.
  
  The capabilities of this component come from the [EconML](https://github.com/Microsoft/EconML) package, which estimates heterogeneous treatment effects from observational data via machine learning.
- **Counterfactual analysis**: You can reuse the counterfactual analysis component here to generate minimum changes applied to a data point's features that lead to opposite model predictions. For example: Taylor would have obtained the loan approval from the AI if they earned $10,000 more in annual income and had two fewer credit cards open. 

  Providing this information to users informs their perspective. It educates them on how they can take action to get the desired outcome from the AI in the future.
  
  The capabilities of this component come from the [DiCE](https://github.com/interpretml/DiCE) package.

## Reasons for using the Responsible AI dashboard

Although progress has been made on individual tools for specific areas of Responsible AI, data scientists often need to use various tools to holistically evaluate their models and data. For example: they might have to use model interpretability and fairness assessment together. 

If data scientists discover a fairness issue with one tool, they then need to jump to a different tool to understand what data or model factors lie at the root of the issue before taking any steps on mitigation. The following factors further complicate this challenging process:

- There's no central location to discover and learn about the tools, extending the time it takes to research and learn new techniques. 
- The different tools don't communicate with each other. Data scientists must wrangle the datasets, models, and other metadata as they pass them between the tools. 
- The metrics and visualizations aren't easily comparable, and the results are hard to share.

The Responsible AI dashboard challenges this status quo. It's a comprehensive yet customizable tool that brings together fragmented experiences in one place. It enables you to seamlessly onboard to a single customizable framework for model debugging and data-driven decision-making. 

By using the Responsible AI dashboard, you can create dataset cohorts, pass those cohorts to all of the supported components, and observe your model health for your identified cohorts. You can further compare insights from all supported components across a variety of prebuilt cohorts to perform disaggregated analysis and find the blind spots of your model.
