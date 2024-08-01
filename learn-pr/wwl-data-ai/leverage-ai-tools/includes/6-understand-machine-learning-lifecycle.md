The availability of sophisticated AI models can help organizations reduce significantly the intimidating amount of resources a data science project can require. As more organizations experiment with AI, they find they need to to understand the machine learning lifecycle.

## Machine learning challenges and need of machine learning operations

Maintaining AI solutions typically requires machine learning lifecycle management to document and manage data, code, model environments, and the machine learning models themselves. You need to establish processes for developing, packaging, and deploying models, as well as monitoring their performance and occasionally retraining them. And most organizations are managing multiple models in production at the same time, adding to the complexity.

To cope effectively with this complexity, some best practices are required. They focus on cross-team collaboration, automating and standardizing processes, and ensuring models can be easily audited, explained, and reused. To get this done, data science teams rely on the **machine learning operations** approach. This methodology is inspired by DevOps (development and operations), the industry standard for managing operations for an application development cycle, since the struggles of developers and data scientists are similar.

![A screenshot of a graph showing MLOps practices: data scientists and IT work together on model reproducibility, validation, deployment, and retraining.](../media/7-discover-business-value-applying-devops-1.png)

## Azure Machine Learning

Data scientists can manage and execute machine learning DevOps from **Azure Machine Learning**, a platform by Microsoft to make machine learning *lifecycle management* and *operations* practices easier. Such tools help teams collaborate in a shared, auditable, and safe environment where many processes can be optimized via automation.

#### Machine learning lifecycle management

Azure Machine Learning supports end-to-end machine learning lifecycle management of pretrained and custom models. The typical lifecycle includes the following steps: data preparation, model training, model packaging, model validation, model deployment, model monitoring and retraining. 

![A screenshot of a graph showing the ML lifecycle: prepare data, train model, package model, validate model, deploy mode, monitor model, and retrain model.](../media/6-understand-machine-learning-lifecycle-1.png)

The classic approach covers all the usual steps of a data science project. 

1. **Prepare dataset**. AI starts at data. First, data scientists need to prepare data with which to train the model. This is often the biggest time commitment in the lifecycle. This task involves finding or building your own dataset, cleaning it so it's easily readable by machines, ensuring it's a representative sample, discovering which variables are pertinent for your goal, and so on.
2. **Train and test**.  Next, data scientists apply algorithms to the data to train a machine learning model. Then they test it with new data to see how accurate its predictions are.
3. **Package**. A model can't be directly put into an app. It needs to be containerized, so it can run with all the tools and frameworks that have been used in its building.
4. **Validate**. At this point, the team evaluates how model performance compares to their business goals. Testing may have returned good enough metrics, but still the model may not work as expected when used in a real business scenario.
   * **Repeat steps 1-4**. It can take hundreds of training hours to find a satisfactory model. The development team may train many versions of the model by adjusting training data, tuning algorithm hyperparameters, or trying totally different algorithms. Ideally the model improves with each round of adjustment. Ultimately, it's the development team's role to determine which version of the model best fits the business use case.
5. **Deploy**. Finally, they deploy the model in the cloud (often through an API), on an on-premises server, or at the edge on devices like cameras, IoT gateways, or machinery.
6. **Monitor and retrain**. Even if a model works well at first, it needs to be continually monitored and retrained to stay relevant and accurate.

>[!NOTE]
>Integrating pretrained models and adapting them to your business needs requires a different workflow that integrating custom models. Using Azure Machine Learning, you can use pretrained models or build your own models. Choosing one approach over another depends on the scenario. Working with pretrained models has the advantage of requiring less resources and delivering results faster. However, prebuilt models are trained to solve a wide range of use cases, so they may struggle to meet very specific needs. In these cases, a full custom model may be a better idea. A flexible mix of both approaches is often preferable and helps scale. AI teams can save resources using pretrained models for the easiest use cases, while investing these resources in building custom AI models for the hardest scenarios. Further iterations can improve the prebuilt models by retraining them.

#### Machine learning operations

Machine learning operations (MLOps) applies the methodology of DevOps (development and operations) to manage the machine learning lifecycle more efficiently. It enables a more agile, productive collaboration in AI teams among all stakeholders. These collaborations involve data scientists, AI engineers, app developers, and other IT teams.

MLOps processes and tools help those teams collaborate and provide visibility through shared, auditable documentation. MLOps technologies provide the ability to save and track changes to all resources, like data, code, models, and other tools. These technologies can also create efficiencies and accelerate the lifecycle with automation, repeatable workflows, and reusable assets. All these practices make AI projects more agile and efficient.

Azure Machine learning supports the following MLOps practices: 

* **Model reproducibility**: means models can easily be run on the same dataset by any team member with same or similar results. Reproducibility is critical for making results of models in production reliable. Azure Machine Learning supports model reproducibility with centrally manage assets like environments, code, datasets, models and machine learning pipelines. 

* **Model validation**: before a model is deployed, it's critical to validate its performance metrics. You may have several metrics that are used to indicate the "best" model. Validating performance metrics in ways relevant to the business use case is critical. Azure Machine Learning supports model validation with many tools to evaluate model metrics, such as loss functions and confusion matrixes.

* **Model deployment**: when a model is deployed, it is important to have data scientists and AI engineers work together to determine the best deployment option. These options include, cloud, on-premise, and edge devices (cameras, drones, machinery). 

* **Model retraining**: models need to be monitored and periodically retrained to correct performance issues and take advantage of newer training data. Azure Machine Learning supports a systematic and iterative process to continually refine and ensure the accuracy of the model.

>[!TIP]
>**Customer story**: A healthcare organization uses Azure Machine Learning to train custom machine learning models that predict the likelihood of complications during surgical procedures.
>The models are trained on huge volumes of data, including factors such as age, ethnicity, smoking history, body mass index, and blood platelet count. Using these models enables medical professionals to better assess risk and determine options for surgery or lifestyle change recommendations for individual patients.
>The responsible AI dashboard in Azure Machine Learning helps explain predictive factors and mitigate bias from demographic factors.
>Ultimately, the predictive modeling solution helps reduce risk and uncertainty, and improve surgical outcomes.
>Read the full case study here: [https://aka.ms/azure-ml-customer-story](https://aka.ms/azure-ml-customer-story)
