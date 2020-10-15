In the previous unit, we introduced the concept of MLOps. MLOps is the practice of collaboration between data scientists, ML engineers, software developers, and other IT teams to manage the end-to-end ML lifecycle. We outlined best practices to efficiently create and deploy AI models.

In this unit, we'll describe the process of managing, monitoring, and retraining those models over time. We discuss the importance of creating dedicated workflows for model monitoring and incident response.

## ML lifecycle: why do ML models need to be monitored and retrained

All models—including those that work perfectly on deployment—require monitoring and retraining over time to maintain high performance.

:::row:::
:::column span="2":::
Reasons for inaccurate predictions might include:  

* **Inadequate training**. For example: app users submit photos taken at night for object recognition, but the model was only trained on well-lit photos.
* **Issues with the "live data" that the model evaluates**. For example: sellers record customer data inconsistently in a company's CRM system.  
* **The model itself "drifts" or declines over time**. This includes "concept drift," where the concept of what you're trying to predict changes. "Data drift," or when the properties of the data change, is also common. And "upstream data changes," or operational changes to how or what data is collected, can impact models as well.
* **The world changes**. For example: a financial trading model based on 2001 data probably isn't effective in 2020.
:::column-end:::
:::column span="2":::
:::image type="complex" source="../media/start-ml-lifecycle-mlops-5.png" alt-text="Illustration of the MLOps practices.":::
There are two large blue circles in the center of the diagram, with an icon and text in each. The left circle is labeled, “Data scientist” and has a nucleus icon in it. The other blue circle reads, “IT” and has an icon of a person next to a computer. There is an infinity symbol that loops around both circles, indicating they work in harmony. Underneath both circles, the four MLOps practices are listed, two on top and two on bottom. They are separated by lines forming a cross between the four. These say, “Model reproducibility,” “Model validation,” “Model deployment,” and “Model retraining.”
:::image-end:::
:::column-end:::
:::row-end:::

Regardless of whether you use a pre-trained model or a custom model, your approach to monitoring and incident response should be the same. However, for pre-trained models, the way you pull teams in, exactly what they have control over, and how teams troubleshoot issues, may vary.

## MLOps practices for model monitoring and retraining

### Monitoring

When a model is deployed, the data scientists and developers who built it should provide maintenance instructions to a dedicated MLOps team responsible for monitoring the model. This information includes performance baselines, key metrics to monitor, and the thresholds for automatic alerts.  

There are a few ways to approach monitoring:

* The first is **automatic monitoring** with established performance thresholds that trigger alerts. For example, the model provides a confidence metric for each prediction it makes. If the team sets a 75% confidence threshold and the application indicates a lower number, it's automatically flagged as a performance concern. Another method of automated monitoring runs on a scheduled basis, as often as every day or every hour. An automated script queries the micro-service that contains the model and logs the analysis. The team can then identify any anomalies that suggest the model is not performing correctly.  
* Another approach to monitoring is a **manual spot check**, where someone tests the model and does their own analysis. In some cases, this is the only way to determine if and why a model is not working correctly.

We recommend a combination of automated analysis and manual spot-check analysis to prevent performance issues from falling through the cracks.

Regardless of how you detect a problem, the issue should be recorded in a central log that orchestrates response team activities.

### Incident response

Let's say your monitoring efforts catch a performance issue. We recommend a three-tiered approach to resolution:

1. Level-one response consists of the MLOps team responsible for ongoing monitoring. These are not data scientists, but operations people who understand the technology that the business uses and how AI models fit into it. They may have scripted approaches for how to respond, such as: if you see issue X, run script Y, and determine if the issue is resolved by executing script Z.

:::row:::
:::column span="2":::
2. If the level-one team can't fix the issue, they then escalate to the level-two team. This team is composed of data scientists who are tasked only with incident response (that is, they are not involved in model or application development). This team will diagnose and attempt to solve the issue at a data science level. For instance, they might examine the models to determine feature distribution and if there are challenges there. Or they will look for anomalies in the datasets and retrain or reevaluate the model.
3. If the level-two team fails to solve the problem, only then do they escalate the problem to the team that built the model. It's important to only pull in the development team when necessary. That way, they can remain focused on developing new models and driving innovation rather than being round-the-clock incident response.
:::column-end:::
:::column span="2":::
:::image type="complex" source="../media/start-ml-lifecycle-mlops-6.png" alt-text="Illustration of an MLOps incident response.":::
The diagram consists of four blue rectangles and grey arrows going between each one, representing the workflow. In the top left of each blue rectangle, there is a shield icon next to the text. The diagram starts with a blue rectangle in the top left corner labeled “Detection of an issue.” A grey arrow goes from the first blue rectangle down to the second blue rectangle, titled, “L1 incident resolution.” An arrow goes from the right side of the second rectangle up to the third rectangle in the top right of the diagram. The blue rectangle is labeled “L2 incident resolution.” A grey arrow points down from the third rectangle to the fourth blue rectangle in the bottom right of the diagram, titled “L3 incident resolution.” Above the L1 and L2 rectangles, there is a label that reads “MLOps team.” Above the L3 rectangle there is a label that reads, “Development team.”
:::image-end:::
:::column-end:::
:::row-end:::

With different tiers responding to problems, it's critical to orchestrate their activities with the central incident log to ensure there's no duplication of efforts.

### Model retraining

There are two main reasons a model may need retraining:

* Your monitoring process uncovered a performance issue. In this scenario, the level two or level three incident response teams might retrain the model to correct the issue.
* There's no "incident" but you want to take advantage of new training data. It's wise to establish processes for retraining models on a scheduled basis, with a frequency that makes sense for your use case.

We recommend retraining models using a CI/CD pipeline, a concept from software development. Short for Continuous Integration/Continuous Delivery, a CI/CD pipeline automates the steps in the application delivery process. Every time a model is changed, or a new model is created, an automated build-and-test sequence is run. The pipeline builds the model, tests the model, and then deploys it first to a small instance, like an Azure container instance.

You'll need to see if the newer version of the model performs better than the previous one on key metrics. We recommend A/B testing, which involves deploying the new model to only a small percentage of traffic and comparing the two versions.

While ML services can help automate aspects of this process, it's important to keep humans "in the loop." This means maintaining human oversight of the retraining and outcomes of the new model. If model retraining is entirely automated, bias may be introduced over time or outcomes may shift. Finally, humans will need to validate the model again by testing it against the desired business outcomes.

## Conclusion: Business outcomes of adopting MLOps

MLOps practices facilitate real business results, enabling a faster time to market for machine learning-based solutions and a more rapid rate of experimentation and innovation. These practices also increase collaboration and alignment across teams and help assure model quality and auditability—ultimately accelerating the ML lifecycle.  

When you're setting up new processes, be aware that these aren't just technical shifts, but also cultural shifts in how your employees work. It's important to manage those changes carefully. To more easily track and manage the processes we've discussed, we recommend using a central MLOps platform that supports the entire lifecycle, such as the Microsoft Azure MLOps offering.

Next, let's wrap up everything you've learned about MLOps with a knowledge check.
