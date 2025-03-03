Now that you understand how to select a model and build a prototype, it’s time to think about scaling for real-world workloads. To prepare for scale, you need to shift your focus from prototype to production, which involves adopting the **Generative AI Operations** (**GenAIOps**) lifecycle.

Generative AI (GenAI) applies pretrained models that can be fine-tuned or augmented with your own data to create content based on user input. Compared to traditional AI application development, this shift moves the focus away from model creation and toward generating dynamic content, which brings its own set of challenges and opportunities for scaling.

Let's explore this paradigm shift, before delving into the end-to-end lifecycle of GenAI applications.

## Understand the shift from MLOps to GenAIOps

The application of DevOps principles and practices to the development of machine learning solutions isn't new. Applying DevOps to traditional machine learning is known as **Machine Learning Operations**, or **MLOps**. MLOps is a merger of machine learning with DevOps practices to cover the major components of a machine learning workflow: data pipeline, model training, and model deployment.

**Generative AI Operations**, or **GenAIOps**, is a specialized domain within MLOps that focuses on developing and deploying applications that are integrated with language models.

|   | Traditional DevOps | Traditional MLOps| GenAIOps|
|---|---|---|---|
|**Audiences**| App developers|ML engineers and data scientists| ML engineers and app developers|
|**Assets to share**|Libraries and code components, APIs, environments, features|Model, data, environments, features| Language models, agents, plugins, prompts, chains, APIs|
|**Metrics/evaluations**| Code safety, unit tests validation, latency, cost| Quality (accuracy) and harm (bias)|Quality (coherence, relevance), harm (fabrications, toxicity), honest (groundedness), cost (token per request), latency (response time)|
|**ML models**| -- | Build from scratch|Prebuilt, fine-tuned serves as API|

There are several differences between MLOps and GenAIOps:​

- **Audiences:** MLOps is mainly for data scientists, while GenAIOps has a broader audience, including developers.​​
- **Generated assets:** in MLOps the key assets are related to data and models, while in GenAIOps there’s a focus on integrations of pretrained models with data connectors, functions, plugins, or other language models.
- **Evaluation metrics:**

    - **Model performance metrics**: In traditional machine learning scenarios we could compute the distance between the predicted and actual outcomes, expressed in terms of *accuracy* or *loss*. With language models, we don't always have a ground truth, so we need different quality measures, such as *coherence* and *relevance* of responses.
    - **Application performance metrics**:​ GenAIOps also includes a set of metrics to evaluate the performance of the application, similarly to what happens in traditional DevOps and MLOps, like *cost*, *throughput*, and *latency*.
    - **Risk and safety metrics**: In addition to known harms, such as data bias, language models' new capabilities also bring new risks related to the generation of fabrications, incorrect information, or offensive messages, which require new safety metrics.

- **The underlying models:** in MLOps, the models are commonly trained from scratch, while in GenAIOps we use models pretrained​ on huge volumes of data (for example, the whole internet) and eventually fine-tuned or augmented on specific data.​

## Explore the GenAIOps lifecycle

The GenAIOps lifecycle is complex, and anything but linear. It’s an iterative process, reflecting the multifaceted nature of real-world applications. It includes three primary loops, all unified by a fourth overarching loop.

:::image type="content" source="../media/lifecycle.png" alt-text="Diagram showing the language model lifecycle in loops.":::

- **Explore:** Where you *define* the business need, or use case, and *design* the architecture, including necessary prompts and models.
- **Build:** Where you *develop* the initial application and *evaluate* it iteratively to reach quality and safety targets.
- **Operationalize:** Where you *deploy* the application for real-world use, and *deliver* reliable and responsible service.

Overarching all these phases is the **management loop**, which focuses on governance, security, and compliance. It's a framework that balances speed in deliverables with strict adherence to standards.

Next, we're going to delve into each and every step described to be part of the GenAIOps lifecycle, by covering the main tools that help you during each specific phase.
