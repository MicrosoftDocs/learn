Along with our foundational principles and guidelines at Microsoft, we have also found a need for tools and resources that make it easier for developers to spot and design against potentially harmful issues.

Watch this video from Dr. Sarah Bird, Principal Program Manager for Azure Machine Learning at Microsoft, as she describes some tools and resources that can help organizations address concerns related to the following principles: security and privacy, fairness, inclusiveness, reliability and safety, transparency, and accountability.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4b8Iv]

In this video, you heard Dr. Sarah Bird explain some of the tools that help combat new AI-specific security and privacy threats and those that help test and monitor for reliability. Dr. Bird says that it’s important to make sure AI works well for everyone using guidelines, assessment tools, mitigation techniques, and continuous monitoring. Finally, tools for transparency and accountability help ensure that AI models are adhering to other ethical principles.

Outlined in this unit are some tools that we have found helpful in implementing our foundational principles and guidelines to use AI at every stage of innovation. These stages range from concept to development, deployment, and beyond. Additionally, you can also reference our [Responsible AI Resource Center](https://www.microsoft.com/ai/responsible-ai-resources) to explore these tools and resources further.

## Security and privacy

Security and privacy are key pillars of trust. There are a number of emerging tools to help protect security and privacy in AI systems. Techniques like homomorphic encryption, multi-party computation (MPC), and differential privacy make it possible to train AI models using private data without sharing it.<sup>9</sup> For example, with MPC we can build a system that analyzes data from three different hospitals without any of them gaining access to each other’s health data. Secure execution environments on public cloud platforms protect data inside a Trusted Execution Environment (TEE), also known as an enclave, so that data scientists can’t view or modify it, but they can still train AI models with it. Once the AI system is built, you can also use technologies like Counterfit to conduct AI security risk assessments.

Implementing security and privacy in your organization:

> [!TIP]
> You can find links to these resources in the summary and resources section of this module.

|Resource type|Details|
|---|---|
|Guidelines|Consider using guidelines like Microsoft’s Securing the Future of Artificial Intelligence and Machine Learning to formulate your own policies.<sup>10</sup> The AI Security Guidelines will provide you with findings that can protect your AI Services with guidance materials.|
|Technology tools|Research Microsoft SEAL—a set of libraries powered by homomorphic encryption that allow computations to be performed directly on encrypted data.<sup>11</sup> Counterfit—an open-source tool to help organizations assess AI security risks, allowing developers to ensure that their algorithms are robust, reliable, and trustworthy.<sup>12</sup> SmartNoise—a differential privacy tool that adds a carefully tuned amount of statistical noise to sensitive data, helping to protect data used in AI systems by preventing reidentification.<sup>13</sup> Presidio— an open-source library for data protection and anonymization for text and images.<sup>14</sup> Azure confidential computing— provides data security using trusted execution environments or encryption, providing protection of sensitive data across the machine learning life cycle.<sup>15</sup> Look into other technologies like multi-party computation (MPC), homomorphic encryption, differential privacy, and secure execution environments to see if they’re right for your use case.|
|Third-party tools|Take advantage of third-party tools like the Private Data Sharing Interface (PSI), which allows researchers to explore private datasets securely using differential privacy.<sup>16</sup>|

## Fairness

AI systems should treat everyone fairly and avoid affecting similarly situated groups of people in different ways. Fairness is a fundamentally sociotechnical challenge, so “fair” classification tools are not be-all-end-all solutions. However, there are two key steps for reducing unfairness—assessment and mitigation.

For fairness assessment there are several open source and proprietary technologies available. One is Aequitas, an open-source toolkit developed at the University of Chicago, for auditing machine learning models for discrimination and bias.<sup>17</sup> Another is Fairness in Machine Learning Systems (FairLearn), an approach created by Microsoft Research co-developed with products teams. FairLearn can be used to assess potential bias in systems that make decisions about allocating resources, opportunities, or information.<sup>18</sup> For example, Fairlearn can turn a classifier that predicts who should be interviewed for a job based on previous hiring decisions into a classifier that predicts who should be interviewed while also respecting demographic parity (or another fairness definition).

For mitigation, there are a variety of common techniques that are suited to different applications. For example, Microsoft Research created a methodology that helps reduce gender biases by modifying word embeddings to remove gender stereotypes, such as the association between receptionist and female.<sup>19</sup>

Implementing fairness in your organization:

|Resource type|Details|
|---|---|
|Guidelines|There are some great papers that can help you in this journey: Utilize the AI Fairness checklist to provide structure for improving ad-hoc processes and empowering advocates. For more information on how to assess the fairness of AI models, watch the NIPS keynote address from Kate Crawford, Principle Researcher at Microsoft and Co-founder of the AI Now Institute at NYU.<sup>20</sup> To understand the unique challenges regarding fairness in machine learning, watch a free Microsoft webinar on Machine Learning and Fairness.<sup>21</sup> 
|Technology tools|Plus look for a Python package for the FairLearn approach on GitHub.<sup>22</sup> Use FairLearn to assess your AI systems and mitigate any negative impacts towards groups of people. Leverage the methodology for reducing bias in word embedding.|
|Third-party tools|Learn how to avoid five key “traps” of fair-ML work in a paper from the ACM Conference entitled Fairness and Abstraction in Sociotechnical Systems;<sup>23</sup> or read the Counterfactual Fairness paper from Cornell University.<sup>24</sup> Check out the Aequitas open-source toolkit.|

## Inclusiveness

Inclusive design practices help ensure that AI models perform well for all users. Microsoft has published inclusive design principles<sup>25</sup> and a related toolkit<sup>26</sup> to help developers and data scientists learn how to address potential barriers in a product environment that could unintentionally exclude people.

There are also technologies that help ensure inclusiveness through automated techniques that take a user query as input and suggest similar criteria that provides more diverse results. A Microsoft Research paper called Algorithmic Greenlining proposes an approach that helps decision-makers develop selection criteria yielding high-quality and diverse results in contexts such as college admissions, hiring, and image search.<sup>27</sup> For example, in a job candidate search, there’s typically limited information about any candidate's “true quality.” An employer's intuition might suggest searching for “computer programmer,” which yields high-quality candidates but might return few female candidates. The algorithmic framework suggests alternative queries which are similar but more gender-diverse, such as “software developer” or “web developer.”

Implementing inclusiveness in your organization:

|Resource type|Details|
|---|---|
|Guidelines|Reference Microsoft’s inclusive design practices,<sup>25</sup> inclusive design toolkit,<sup>26</sup> and Algorithmic Greenlining paper.<sup>27</sup>|

## Reliability and safety

AI systems can become unreliable or inaccurate if their development and testing environment is not the same as the real world or if the system is not maintained properly. This can be especially dangerous in industries where safety may be at risk, like manufacturing or healthcare. To prevent reliability and safety issues, there are a number of technologies and tools that strengthen model performance through long-term monitoring and management. For example, the Data Drift Monitoring feature in Azure Machine Learning detects changes in the distribution of data that may cause degraded prediction performance. Developers can also use Pandora, a debugging framework designed by Microsoft Research, to identify reliability and bias problems within machine learning models.<sup>28</sup> Finally, Microsoft AirSim is a valuable open-source tool for improving simulated training environments.<sup>29</sup>

Implementing reliability and safety in your organization:

|Resource type|Details|
|---|---|
|Technology tools|Explore how to monitor data drift and adapt models to maintain accuracy in Azure Machine Learning. InterpretML — training interpretable glassbox machine learning models. Error Analysis— identify cohorts with higher error rates. Research the Pandora debugging framework and Microsoft AirSim.|

## Transparency

The black-box nature of AI can be problematic and potentially harmful. Transparency is key to supporting the other five principles. Microsoft Research has created an open-source package called InterpretML for training interpretable models and explaining black box systems.<sup>30</sup> InterpretML implements a number of intelligible models including Explainable Boosting Machine (EBM), an improvement over generalized additive models that has both high accuracy and intelligibility.<sup>31</sup> It also supports several methods for generating explanations of black box model behavior or predictions including ‘SHapley Additive exPlanations’ (SHAP) and ‘Local Interpretable Model-agnostics Explanations’ (LIME).<sup>30</sup>

Azure Machine Learning also has a variety of tools that support model transparency. The Model Interpretability feature helps model designers and evaluators explain why a model makes certain predictions, which can be used to debug the model, validate that its behavior matches objectives, or check for bias.

Implementing transparency in your organization:

|Resource type|Details|
|---|---|
|Management tool|Datasheets for Datasets—Consider these questions to help prioritize transparency by creating datasheets for the datasets involved in your AI systems.<sup>32</sup>|
|Technology tools|Access several powerful transparency methods through the InterpretML open-source package. Explore a variety of tools that support model transparency in Azure Machine Learning including the model interpretability feature.|

## Accountability

The people who design and deploy AI systems must be accountable for how their systems operate. A useful first step for developing accountability and transparency in your organization is to create thorough documentation processes for AI systems. One such approach is called “datasheets for datasets,” in which people assembling training datasets generate a datasheet with key information such as the motivation, composition, collection process, and recommended uses.<sup>32</sup> Azure Machine Learning, the DevOps feature (called MLOps) makes it easier to track, reproduce, and share models and their version histories. The Partnership on AI (PAI) is also leading a multistakeholder initiative called ABOUT ML to develop, test, and promulgate best practices for machine learning documentation. These best practices may include documenting how AI systems were designed and for what purposes, where their data came from and why that data was chosen, how they were trained, tested, and corrected, and what purposes they’re not suitable for.<sup>33</sup>

Leverage the HAX Toolkit, which enables you to build effective and responsible human-AI interaction. It includes the Guidelines for Human-AI Interaction, the HAX Workbook, Interaction Guidelines, Design Patterns, and the HAX Playbook. Every resource is grounded in observed needs and validated through rigorous research and pilots with practitioner teams. Outlined in the chart below you’ll find an overview of the resources and tools found within the HAX Toolkit.<sup>34</sup>

Implementing accountability in your organization:

|Resource type|HAX Toolkit|
|---|---|
|Guideline|HAX Workbook–supports early planning and collaboration between UX, AI, PM, and engineering disciplines and helps drive alignment on product requirements across teams. Hax Interaction Guidelines–HAI guidelines synthesize 20 years of research into 18 recommended guidelines for designing AI systems across the user interaction and solution life cycle. HAX Design Patters–provide common ways of implementing the HAX Guidelines. The patterns are UI-independent and can be implemented in various systems and interfaces.|
|Management tools|Read the paper about datasheets for datasets to learn more about the benefits of this approach. HAX Playbook–The HAX Playbook is an interactive tool for generating interaction scenarios to test when designing user-facing AI systems, before building out a fully functional system.|
|Technology tools|Document and manage the entire model development process in one place with MLOps in Azure Machine Learning.|

Next, let’s discuss external engagements and how you can use AI for good.
