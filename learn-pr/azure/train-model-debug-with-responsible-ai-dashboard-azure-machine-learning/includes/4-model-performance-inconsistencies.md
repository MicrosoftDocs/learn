An effective approach to evaluating the performance of machine learning models is getting a holistic understanding of their behavior across different scenarios. One way to approach this includes calculating and assessing model performance metrics like accuracy, recall, precision, root mean squared error (RSME), mean absolute error (MAE), or R<sup>2</sup> scores. However, just analyzing one metric or alternatively, the aggregated metrics for the overall model is insufficient to debug a model and identify the root cause of errors or inaccuracies. In conjunction with measuring performance metrics, data scientists and AI developers need to conduct comparative analysis to aid their holistic decision making.

Comparative analysis shines a light on how models are performing for one subgroup of the dataset versus another. One of the advantages is that the model overview component of the Responsible AI dashboard isn't just reliant on high-level numeric calculations on datasets, it dives down to the data features as well. This is especially important when one cohort has certain unique characteristics compared to another cohort. For example, discovering that the model is more erroneous with a cohort that has sensitive features (for example, patient race, gender or age) can help expose potential unfairness.

The model overview component provides a comprehensive set of performance and fairness metrics for evaluating your model, along with key performance disparity metrics along specified features and dataset cohorts.  

The Model Overview component within the Responsible AI dashboard helps analyze model performance metric disparities across different data cohorts that the user creates.

# Finding disparities in model performance

Model fairness is quantified through disparity metrics during the analysis process.

The following are the different areas the model overview component highlights issues while also using some of the traditional performance metrics:

- Disparities among performance metric
  - Showing how model is performing for a given cohort using metrics such as Accuracy, Precision, Recall, MAE, RSME etc.
- Probability distribution
  - Showing the probability of a given cohort to fall in a model’s predicted outcome.
- Metric visualization
  - Showing performance scores for a given cohort.