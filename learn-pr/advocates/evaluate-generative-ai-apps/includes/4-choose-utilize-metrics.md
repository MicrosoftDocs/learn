To effectively carry out evaluations, a thorough understanding of various metrics is essential. Metrics serve as the foundation for quantifying the performance and reliability of generative AI applications. They offer a standardized way to measure different aspects of the AI models, ensuring that each evaluation is objective and comprehensive.

When you analyze these metrics, you can gain valuable insights into the strengths and weaknesses of the AI system, facilitating targeted improvements and refinements. As such, it’s important to choose the right metrics for your evaluation by selecting metrics that align with the specific goals and requirements of your application. The interpretation of what constitutes a "good" score can vary significantly depending on the specific task and context of the evaluation.

You should regularly update and refine metrics to reflect evolving standards and user needs. Understanding metrics is crucial for developers and stakeholders, as metrics provide actionable insights to refine and enhance AI applications, leading to more reliable and user-centric solutions.

## Performance and quality metrics
Performance and quality metrics are essential for assessing the efficiency and effectiveness of generative AI applications. These metrics provide a systematic way to measure various aspects of an AI model's output, ensuring it meets desired standards and user expectations. They encompass both qualitative and quantitative dimensions, offering a comprehensive evaluation of the AI's capabilities.

Provided is a table of our built-in performance and quality metrics:

### Qualitative metrics

Qualitative metrics measure the subjective qualities of AI-generated responses. Qualitative metrics focus on the human experience, assessing aspects like readability, creativity, and appropriateness.

|Metric  |Definition  |Example of Use  |Interpretation  |
|---------|---------|---------|---------|
|Coherence     | The degree to which the output is logically consistent and makes sense.         | Assess whether the generated output for an AI creative writing assistant follows a logical sequence and maintains consistent character development throughout the story        |Assessed on a scale of 1.0 - 5.0. <br><br> High coherence means the content is easy to follow and understand as a whole.|
|Fluency     | The smoothness and readability of the output, with correct grammar and syntax.        |Assessing a chatbot's responses to ensure they're grammatically correct and easy to read.         |Assessed on a scale of 1.0 - 5.0. <br><br> High fluency means the text flows well and sounds natural to a native speaker.|
|Groundedness     | The extent to which the output is based on factual information or given context.        | Verifying that a generated news article accurately reflects the facts and sources provided.        | Assessed on a scale of 1.0 - 5.0. <br><br> High groundedness means the model's output is factually accurate and consistent with the given context or known information.|
|Relevance     | How well the output aligns with the given context or user query.        | Assess how well generated article summaries match users' interests for an AI-powered personalized news aggregator.        |Assessed on a scale of 1.0 - 5.0. <br><br> High relevance means the content is closely aligned with the user's intent or the subject matter being discussed.|
|Similarity     |The degree of resemblance between the generated output and the reference text.        | Assess that the AI-generated content aligns with established legal practices and terminology by comparing AI generated contract clauses with a database of standard legal language.        |Assessed on a scale of 1.0 - 5.0 <br><br> A high similarity score indicates that the compared texts or concepts have similar meanings or convey essentially the same information, even if using different words.|
|F1 Score     |A measure of a model's accuracy that combines precision (relevance of retrieved items) and recall (completeness of retrieval).         |Assess how well a model correctly identifies and classifies various skin conditions for an AI app that assists doctors in diagnosing skin conditions from images.         | Assessed on a scale of 0 - 1. <br><br> A high F1 score indicates that the model has low false positives and low false negatives.|

### Quantitative metrics

Quantitative metrics involve objective, numerical measurements of the AI's performance. Quantitative metrics are often data-driven and based on specific algorithms or statistical analysis.

|Metric  |Definition  |Example  |Interpretation  |
|---------|---------|---------|---------|
|ROUGE     | Recall-Oriented Understudy for Gisting Evaluation, measures the overlap of n-grams (word sequences) between the generated and reference texts. It's useful for assessing if key information is retained in summaries.        | Assess how AI-generated summaries of scientific papers capture key findings from the original research papers, comparing them against human-written reviews.        |Assessed on a scale of 0 - 1. <br><br> Higher ROUGE scores indicate better coverage of the reference content.|
|BLEU     |Bilingual Evaluation Understudy measures how many words overlap between the machine translation and reference translations, considering exact matches and near matches. It focuses on precision and aims to capture translation adequacy and fluency.         |Assess the quality of AI-generated posts in various languages for a multilingual content generation tool for a social media platform. Compare the AI generated posts against human-translated versions.         |Assessed on a scale of 0 - 1. <br><br> Higher BLEU scores suggest better translation quality.|
|METEOR     |Metric for Evaluation of Translation with Explicit ORdering, designed to improve some of the weaknesses of BLEU. METEOR is an automatic metric for machine translation evaluation. It considers synonyms and paraphrases and aligns words between the machine translation and reference.         | An e-learning platform developing an AI tutor that explains complex concepts in simpler terms uses METEOR to evaluate the quality of its explanations. This metric helps assess whether the AI-generated explanations effectively convey the same meaning as expert-written materials, even if using different words.        |Assessed on a scale of 0 - 1. <br><br> A high METEOR score suggests that the generated text closely matches the reference text in terms of content and meaning.|
|GLEU     |A variant of BLEU developed by Google for evaluating machine translation. GLEU is similar to BLEU but calculates the minimum of precision and recall for n-grams, making it more sensitive to changes in translation quality that affect both precision and recall.         | A company creating an AI system for generating product descriptions uses GLEU to fine-tune their model. They compare the AI-generated descriptions against professionally written ones, using GLEU's sensitivity to both precision and recall to incrementally improve the system's ability to create compelling and accurate product narratives.        |Assessed on a scale of 0 - 1. <br><br> A high GLEU score indicates a high degree of overlap in n-grams between the generated text and reference translations. A high GLEU score generally suggests fluency and adequacy in translation, and good precision in word choice and word order.|

> [!NOTE]
> It's important to note that while these are the theoretical maximum scores, in practice, achieving a perfect score is often unrealistic, especially for metrics like BLEU, METEOR, and GLEU.

## Risk and safety metrics

The development and deployment of generative AI applications brings a plethora of opportunities, ranging from personalized content generation to advanced problem-solving capabilities. However, alongside these benefits come significant risks and safety concerns. When you evaluate AI systems through robust risk and safety metrics, you can support the creation of reliable and responsible AI solutions.

Risk and safety metrics are essential, as they measure the tendency of AI systems to generate harmful, unsafe, or otherwise undesirable outputs. These metrics help in identifying potential risks and formulating mitigation strategies to address them. The key reasons these metrics matter include:

- **Measuring harm**: Identifying and quantifying harmful content generated by AI systems to help ensure they don't spread misinformation, hate speech, or other malicious content.
- **Influencing mitigation strategy**: Providing actionable insights that can help in developing plans to mitigate identified risks and improve the overall safety of AI applications.
- **Building trust**: Enhancing user trust by demonstrating a commitment to safety and responsibility in AI deployments.

Provided is a table of our built-in risk and safety metrics:

|Metric  |What it Measures  |Assessment Output  |
|---------|---------|---------|
|Hateful and Unfair Content Defect Rate     | Measures the frequency of AI-generated content that contains hate speech or unfair biases.        |Severity level: 0 – 7, <brSeverity label: Very low, Low, Medium, and High|
|Sexual Content Defect Rate     |Measures the occurrence of AI-generated content containing inappropriate sexual references.         |Severity level: 0 – 7, <br> Severity label: Very low, Low, Medium, and High|
|Violent Content Defect Rate    |Evaluates the frequency of content that depicts or incites violence.         |Severity level: 0 – 7, <br> Severity label: Very low, Low, Medium, and High|
|Self-Harm Related Content Defect Rate     |Measures the generation of content that encourages or glamorizes self-harm.         | Severity level: 0 – 7, <br> Severity label: Very low, Low, Medium, and High|
|Jailbreak Defect Rate    |Measures how often AI systems can be manipulated to bypass safety protocols and restrictions. A jailbreak occurs when a user finds a way to get the AI to produce content it's designed to prevent.         | True or False        |
|Indirect Attack Rate     |Measures the susceptibility of AI to indirect prompt injections, where seemingly harmless prompts elicit inappropriate responses. An indirect prompt injection occurs when the AI is tricked into generating harmful content through a series of seemingly innocuous prompts.        | True or False        |
|Protected Material Defect Rate     |Evaluates how often AI systems generate content that infringes upon protected material, such as copyrighted text.         |True or False         |

Based on the results of a risk and safety evaluation, several mitigations can be implemented to enhance the robustness and reliability of AI systems. One approach is to modify the [system message](/azure/ai-services/openai/concepts/system-message?context=%2Fazure%2Fai-studio%2Fcontext%2Fcontext&tabs=top-techniques) by incorporating a tailored safety message that guides user interaction and sets clear boundaries for acceptable use. Azure AI Foundry also provides [safety system message templates](/azure/ai-services/openai/concepts/safety-system-message-templates) within the chat playground. 

:::image type="content" source="../media/system-message.png" alt-text="A screenshot of the Azure AI Foundry chat playground. There's a pop-up to select safety system messages." lightbox="../media/system-message.png":::

Additionally, implementing modified content filters or blocklists with [Azure AI Content Safety](/azure/ai-studio/concepts/content-filtering) can dynamically detect and intercept potentially harmful outputs before they reach the end user.

:::image type="content" source="../media/content-filter.png" alt-text="A screenshot of the content filters configuration in Azure AI Foundry."  lightbox="../media/content-filter.png":::