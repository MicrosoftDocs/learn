When defining an AI system's fairness, one aspect to consider is how well the system performs for different groups of people. You can look at the performance of the complete system, and it is sometimes useful to examine the performance of one or more components of the system on their own. Research has shown that without conscious effort focused on parity, the performance of an AI system can often vary based on differences between groups, such as race, ethnicity, language, gender, and age, as well as intersectional groups.

:::image type="icon" source="../media/consider-the-fairness-principle.png":::

Each service and feature of the AI system is different, and the system may not perfectly match your context or cover all scenarios required for your use-case. So, you must evaluate error rates for the AI system with real-world data that reflects your use-case, including testing with users from different demographic groups. Through evaluation, you can ensure the AI system is fair and not causing any harm. Three common types of AI-caused harms are:

**Harms of allocation**: When an AI system is used to extend or withhold opportunities or resources to people, and it makes different recommendations to some people based on which demographic group(s) they belong to, it causes harms of allocation. For example, educational institutions are increasingly using AI systems to screen applications, resumes, and other data. When educational institutions train an AI system using biased historical data, they can inadvertently perpetuate existing discriminatory selection practices. If an institution with predominantly male learners trains its system based on historical data, it may end up favoring male applicants over female applicants, thereby perpetuating gender disparities.

**Harms of quality of service**: When an AI system's effectiveness fluctuates, it causes harm to quality of service. For example, facial recognition systems can misidentify or fail to recognize individuals from certain demographic groups. This can happen when the data set used to train the system was not diverse, causing it to behave differently based on race or gender. This can result in serious consequences, such as misidentification in law enforcement or security applications.

**Harm of representation:** When an AI system's output contains stereotyping or demeaning content against some groups of people, or the outputs fail to depict a group of people sufficiently, it causes harms of representation. This can happen when AI harmfully associates certain genders, races, or ethnicities with certain traits, roles, or behaviors. For example, an automated ad recommendation system was found to have provided more criminal background check ad recommendations to people of color. This can result in higher levels of discrimination against certain groups of people.

## Ensure fairness in education

AI systems should be fair and equitable to everyone, regardless of background, identity, or situation. When AI systems advise on how to teach, learn, or complete assignments, they should not favor or disadvantage any group of people. Ensuring fairness in AI is very important because as AI is incorporated by more trainers and institutions, it can have a significant impact on the quality and outcomes of education, as well as the well-being of those impacted by decisions driven by AI.

To ensure fairness in the AI system you are implementing, you should:

**Understand the purpose, scope, and intended uses of the AI system**. Ask yourself questions such as: What problem is the system trying to solve? Who will benefit from the system? Who might be harmed by the system? How can the system be used in ways that are not intended or responsible?

**Work with a diverse pool of people to implement the system**. Make sure that your implementation team reflects the diversity of your learner community and includes people with different backgrounds, experiences, education, and perspectives. This will help you avoid blind spots and performance issues that could affect the system's performance and impact.

**Detect and eliminate bias in datasets by examining the sources, structure, and representativeness of your data**. As data is the foundation of AI systems, it can reflect existing social and systemic inequalities at every stage in creation, from data collection to data modeling to operation. You should ensure that your data is relevant, accurate, complete, and representative of your learner community.

**Identify societal bias in machine learning algorithms** by applying tools and techniques that improve the transparency and intelligibility of the AI systems you are implementing. Using prebuilt models, such as those delivered by Azure OpenAI Service can help avoid biases. You should also be cautious with the results provided by the Al system and continue to meticulously monitor AI systems for performance issues.

**Leverage human review and domain expertise**. Train your team to understand the meaning and implications of AI results, especially when AI is used to make consequential decisions about people. Decisions that use AI should always be paired with review by subject matter experts. You should use AI as a copilot; it is a technology that can help you to do your job better and faster but still requires a degree of supervision.

**Research and employ best practices**. Consider learning from the best practices used by other educational organizations and enterprises to help detect, prevent, and address societal and systemic biases in AI systems.

:::image type="icon" source="../media/research-and-employ-best-practices.png":::

Understanding the fairness of an AI system is just the beginning. As we transition from the concept of fairness, it's crucial to recognize that fairness goes together with reliability and safety. These aspects are not isolated; they are interdependent components that form the backbone of trustworthy AI. In Unit 2, we will move to the principle of reliability & safety, exploring how this principle ensures that AI systems not only perform equitably but also operate with integrity and resilience in all circumstances.
