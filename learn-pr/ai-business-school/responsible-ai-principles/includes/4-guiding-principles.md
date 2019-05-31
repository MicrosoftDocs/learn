## Abstract

:::row:::
:::column span="2":::
In the last unit, we discussed the societal implications of AI and the responsibility of enterprises to anticipate and mitigate unintended consequences of AI technology. In light of this responsibility, enterprises are finding the need to create internal policies and practices to guide their AI efforts, whether they are deploying third-party AI solutions or developing their own.

At Microsoft, we’ve recognized six principles that we believe should guide AI development and use: fairness, reliability and safety, privacy and security, inclusiveness, transparency, and accountability. For us, these principles are the cornerstone of a responsible and trustworthy approach to AI, especially as intelligent technology becomes more prevalent in the products and services we use every day.

We recognize that every individual, company, and region will have their own beliefs and standards that should be reflected in their AI journey. We want to share our perspective as you consider developing your own guiding principles.
:::column-end:::
:::column span="2":::
![Six Principles Guiding Microsoft Responsible AI Development and Use - Fairness, Reliability and safety, privacy and security, inclusiveness, transparency, accountability](../media/3.2.1.A.Responsible-AI---Establishing-guiding-principles-unit.jpg)
:::column-end:::
:::row-end:::

## Microsoft’s six guiding principles

### Fairness

AI systems should treat everyone fairly and avoid affecting similarly situated groups of people in different ways. For example, when AI systems provide guidance on medical treatment, loan applications, or employment, they should make the same recommendations to everyone with similar symptoms, financial circumstances, or professional qualifications.

We believe that mitigating bias starts with people understanding the implications and limitations of AI predictions and recommendations. Ultimately, people should supplement AI decisions with sound human judgement and be held accountable for consequential decisions that affect others.

When designing and building AI systems, developers should understand how bias can be introduced and how it can affect AI-based recommendations. To help mitigate bias, they should use training datasets that reflect the diversity of society. They should also design AI models in ways that allow them to learn and adapt over time without developing biases. To help them develop AI systems that treat everyone fairly, developers can leverage tools, methodologies, techniques, and other resources that help detect and mitigate biases.

Examples of useful tools and resources for fostering responsible and trustworthy AI can be found in the next unit, Governance and external engagements.

### Reliability and safety

To build trust, it’s critical that AI systems operate reliably, safely, and consistently under normal circumstances and in unexpected conditions. These systems should be able to operate as they were originally designed, respond safely to unanticipated conditions, and resist harmful manipulation. It’s also important to be able to verify that these systems are behaving as intended under actual operating conditions. How they behave and the variety of conditions they can handle reliably and safely largely reflects the range of situations and circumstances that developers anticipate during design and testing.

We believe that rigorous testing is essential during system development and deployment to ensure AI systems can respond safely in unanticipated situations, don’t have unexpected performance failures, and don’t evolve in ways that are inconsistent with original expectations. After testing and deployment, it’s equally important that organizations properly operate, maintain, and protect their AI systems over the lifespan of their use. If not maintained properly, AI systems can become unreliable or inaccurate, so it’s crucial to account for long-term operations and monitoring in every AI implementation. Ultimately, because AI should augment and amplify human capabilities, people need to play a critical role in making decisions about how and when an AI system is deployed, and whether it’s appropriate to continue to use it over time. Human judgement will be key to identifying potential blind spots and biases in AI systems.

### Privacy and security

As AI becomes more prevalent, protecting privacy and securing important personal and business information is becoming more critical and complex. With AI, privacy and data security issues require especially close attention because access to data is essential for AI systems to make accurate and informed predictions and decisions about people. AI systems must comply with privacy laws that require transparency about the collection, use, and storage of data and mandate that consumers have appropriate controls to choose how their data is used. At Microsoft, we are continuing to research privacy and security breakthroughs (see next unit) and invest in robust compliance processes to ensure that data collected and used by our AI systems is handled responsibly.

### Inclusiveness

At Microsoft, we firmly believe everyone should benefit from intelligent technology, meaning it must incorporate and address a broad range of human needs and experiences. For the 1 billion people with disabilities around the world, AI technologies can be a game-changer. AI can improve access to education, government services, employment, information, and a wide range of other opportunities. Intelligent solutions such as real-time speech-to-text transcription, visual recognition services, and predictive text functionality are already empowering those with hearing, visual, and other impairments.

Inclusive design practices can help system developers understand and address potential barriers in a product environment that could unintentionally exclude people. By addressing these barriers, we create opportunities to innovate and design better experiences that benefit everyone.

### Transparency

:::row:::
:::column span="2":::
Underlying the preceding values are two foundational principles that are essential for ensuring the effectiveness of the rest: transparency and accountability. When AI systems are used to help inform decisions that have tremendous impacts on people’s lives, it is critical that people understand how those decisions were made. For example, a bank might use an AI system to decide whether a person is creditworthy, or a company might use an AI system to determine the most qualified candidates to hire.

A crucial part of transparency is what we refer to as intelligibility, or the useful explanation of the behavior of AI systems and their components. Improving intelligibility requires that stakeholders comprehend how and why they function so that they can identify potential performance issues, safety and privacy concerns, biases, exclusionary practices, or unintended outcomes. We also believe that those who use AI systems should be honest and forthcoming about when, why, and how they choose to deploy them.
:::column-end:::
:::column span="2":::
![Microsoft Inclusive Design Principles: recognize exclusion, solve for one, extend to many, learn from diversity](../media/3.2.1.B.Responsible-AI---Establishing-guiding-principles-unit1.jpg)
:::column-end:::
:::row-end:::

### Accountability

The people who design and deploy AI systems must be accountable for how their systems operate. Enterprises should draw upon industry standards to develop accountability norms for their own organization. These norms can ensure that AI systems are not the final authority on any decision that impacts people’s lives and that humans maintain meaningful control over otherwise highly autonomous AI systems.

Enterprises should also consider establishing a dedicated internal review body. This body can provide oversight and guidance to the highest levels of the company on which practices should be adopted to help address the concerns discussed above and on particularly important questions regarding the development and deployment of AI systems. They can also help with tasks like defining best practices for documenting and testing AI systems during development or providing guidance when an AI system will be used in sensitive cases (like those that may deny people consequential services like healthcare or employment, create risk of physical or emotional harm, or infringe on human rights). We will further discuss governance models in the next unit.

To learn more about our guiding principles as well as the impact of AI on our future, please read our book, The Future Computed.

## Actions your organization can take

To help you consider how to implement these principles in your own organization, we developed the following recommendations:

### Fairness

* **Understand the scope, spirit, and potential uses of the AI system** by asking questions such as, how is the system intended to work? Who is the system designed to work for? Will it work for everyone equally? How can it harm others?
* **Attract a diverse pool of talent.** Ensure the design team reflects the world in which we live by including team members that have different backgrounds, experiences, education and perspectives.
* **Identify bias in datasets** by evaluating where the data came from, understanding how it was organized, and testing to ensure it is represented. Bias can be introduced at every stage in creation, from collection to modeling to operation.
* **Identify bias in machine learning algorithms** by leveraging tools and techniques that improve the transparency and intelligibility of models. Examples of these tools can be found in the next unit.
* **Leverage human review and domain expertise.** Train employees to understand the meaning and implications of AI results to ensure that they are ultimately accountable for decisions that leverage AI, especially when AI is used to inform consequential decisions about people. Finally, include relevant subject matter experts (such as those with consumer credit expertise for a credit scoring AI system) in the design process and in deployment decisions.
* **Research and employ best practices, analytical techniques, and tools** from other institutions and enterprises to help detect, prevent, and address bias in AI systems.

### Reliability and Safety

* **Understand your organization’s AI Maturity** by taking Microsoft’s AI Ready Assessment accessible from the link in the resources section. Use the results to determine which AI technologies will fit your organization’s current maturity level and how your organization can best take advantage of AI.
* **Develop processes for auditing AI systems** in order to evaluate the quality and suitability of data and models, monitor ongoing performance, and verify that systems are behaving as intended based on established performance measures.
* **Provide detailed explanation of system operation** including design specifications, information about training data, training failures that occurred and potential inadequacies with trainings data, and the inferences and significant predictions generated.
* **Design for unintended circumstances** such as accidental system interactions, the introduction of malicious data, or cyberattacks.
* **Involve domain experts in the design and implementation processes**, especially when AI is being used to help make consequential decisions about people.
* **Conduct rigorous testing during AI system development and deployment** to ensure that systems can respond safely to unanticipated circumstances, don’t have unexpected performance failures, and don’t evolve in unexpected ways. AI systems involved in high-stakes scenarios that affect human safety or large populations should be tested both in lab and real-world scenarios.
* **Evaluate when and how an AI system should seek human input for impactful decisions or during critical situations.** Consider how an AI system should transfer control to a human in a manner that is meaningful and intelligible. Design AI systems to ensure humans have the necessary level of input on highly impactful decisions.
* **Develop a robust feedback mechanism for users to report performance issues** so that they can be resolved quickly.

### Privacy and Security

* **Comply with relevant data protection, privacy, and transparency laws** like GDPR or the California Privacy Act by investing resources in developing compliance technologies and processes or working with a technology leader during the development of AI systems. Develop processes to continually check that the AI systems are satisfying all aspects of these laws.
* **Design AI systems to maintain the integrity of personal data** so that they can only use personal data during the time it’s required and for the defined purposes that have been shared with customers. Delete inadvertently collected personal data or data that is no longer relevant to the defined purpose.
* **Protect AI systems from bad actors** by designing AI systems in accordance with secure development and operations foundations, using role-based access, and protecting personal and confidential data that is transferred to third parties. Design AI systems to identify abnormal behaviors and to prevent manipulation and malicious attacks. Learn more about how to protect against new AI-specific security threats by reading our paper, Securing the Future of Artificial Intelligence and Machine Learning at Microsoft accessible in the resources section of this module.
* **Design AI systems with appropriate controls** for customers to make choices about how and why their data is collected and used.
* **Ensure your AI system maintains anonymity** by de-identifying personal data.
* **Conduct privacy and security reviews** for all AI systems.
* **Research and implement industry best practices** for tracking relevant information about customer data, accessing and using that data, and auditing access and use.

### Inclusiveness

* **Comply with laws regarding accessibility and inclusiveness** such as the Americans with Disabilities Act, the Communications and Video Accessibility Act, and the European Union laws and U.S. regulations that mandate the procurement of accessible technology.
* **Use the** Inclusive Design toolkit, available in the resources section of this module, to help system developers understand and address potential barriers in a product environment that could unintentionally exclude people.
* **Have people with disabilities test your systems** to help you determine whether the system can be used as intended by the broadest possible audience.
* **Consider commonly used accessibility standards** to help ensure your system is accessible for people of all abilities.

### Transparency

* **Share key characteristics of datasets** to help developers understand if a specific dataset is appropriate for their use case. For more information on tools and techniques for increasing transparency, please see the next unit, Governance and external engagements.
* **Improve model intelligibility** by leveraging simpler models and generating intelligible explanations of the model’s behavior. Techniques to simplify models without sacrificing accuracy and tools to generate explanations of model’s behaviors can be found in the next unit.
* **Train employees on how to interpret AI outputs** and ensure that they remain accountable for making consequential decisions based on the results.

### Accountability

* **Set up internal review boards** to provide oversight and guidance on the responsible development and deployment of AI systems.
* **Ensure your employees are trained** to use and maintain the solution in a responsible and ethical manner and understand when the solution may require additional technical support.
* **Keep humans with requisite expertise in the loop** by reporting to them and involving them in decisions about model execution. When automation of decisions is required, ensure they are able to inspect, identify, and resolve challenges with model output and execution.
* **Put in place a clear system of accountability and governance** to conduct remediation or correction activities if models are seen as behaving in an unfair or potentially harmful manner.

At Microsoft, we developed these six principles to guide our use of AI with the aim of respecting collective values while helping society realize the full potential of AI. We encourage organizations to do the same, by either creating or adapting existing principles or guidelines to fit with their culture and priorities.

Next, let’s look at how companies can foster responsible and trustworthy AI, both internally and with other organizations.