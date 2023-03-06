As AI becomes more prevalent, it's imperative that organizations have processes in place to ensure it's used responsibly. While we recognize we don't have all of the answers, we hope our experience and perspective will prove valuable to others as they embark on their own AI journey.

Now that you have reviewed this module, you should be able to:

* Explain how Microsoft provides accountability for responsible AI through a governance structure.
* Describe how Microsoft risk management processes are used to identify, assess, and mitigate risks.
* Establish responsible design principles within your own organization.

## Use these resources to discover more

[!include[](../../../includes/open-link-in-new-tab-note.md)]

To learn more about our perspective on responsible AI and the impact of AI on our future, read our book [The Future Computed](https://blogs.microsoft.com/uploads/2018/02/The-Future-Computed_2.8.18.pdf).

* [Download PDF](https://aka.ms/AA7a8si) of Understanding AI governance at Microsoft.
* [Download PDF](https://aka.ms/AA7a3jb) of Governance in action at Microsoft.
* [Download PDF](https://aka.ms/AA629xl) of Establishing responsible design principles in AI engineering to share with others.
* [Download PDF](https://aka.ms/AA629xn) of Engaging externally: AI for Good to share with others.
* [Download PDF](https://aka.ms/AA7anff) of Putting principles into practice: how we approach responsible AI at Microsoft.

Below are some extra resources your organization can leverage when developing your own governance model for responsible AI.

### Skill up resources

* [2018 WEF Future of Jobs Report](https://www.weforum.org/reports/the-future-of-jobs-report-2018) states many companies have been focusing their upskilling and retraining efforts on those people who already have higher skills and value to the company.
* Developer-focused [AI School](https://aischool.microsoft.com), which provides online videos and other assets that help build professional AI skills.
* The [Skillful Initiative](https://www.markle.org/rework-america/skillful), a partnership with the Markle Foundation in the US, helps match people with employers and fill high-demand jobs.

### Microsoft programs

AI for Good includes four programs: [AI for Accessibility](https://www.microsoft.com/ai-for-accessibility), [AI for Earth](https://www.microsoft.com/ai-for-earth/), [AI for Humanitarian Action](https://www.microsoft.com/ai/ai-for-humanitarian-action), and [AI for Cultural Heritage](https://www.microsoft.com/ai/ai-for-cultural-heritage), which are already supporting nearly 250 projects across the globe. Learn more about how to protect against new AI-specific security threats by reading our paper, [Securing the Future of Artificial Intelligence and Machine Learning at Microsoft](https://www.microsoft.com/download/details.aspx?id=57597) and follow along with the news. For example, last year we publicly [called for regulation](https://blogs.microsoft.com/on-the-issues/2018/07/13/facial-recognition-technology-the-need-for-public-regulation-and-corporate-responsibility/) of facial recognition technology and outlined our recommendations for the public and private sector alike.

### Principles and guidelines

Microsoft's responsible AI journey began when we established six key principles to guide our development and use of AI, which are outlined in [The Future Computed](https://blogs.microsoft.com/blog/2018/01/17/future-computed-artificial-intelligence-role-society/): fairness, reliability and safety, privacy and security,  inclusiveness, transparency, and accountability.

With these foundational principles in place, we began developing more scenario-specific guidelines. For example, in May of 2019, we published a paper called [Guidelines for Human-AI Interaction](https://www.microsoft.com/research/publication/guidelines-for-human-ai-interaction/), which includes 18 generally applicable design guidelines to help developers design responsible and human-centered AI systems. In addition to this key resource, we've published many other guidelines and principles including the ones below:

* Design bots based on ethical principles by reviewing these [10 guidelines](https://www.microsoft.com/research/uploads/prod/2018/11/Bot_Guidelines_Nov_2018.pdf).
* Join [Partnership on AI](https://www.partnershiponai.org/) (PAI), a group of researchers, non-profits, non-governmental organizations (NGOs), and companies dedicated to ensuring that AI is developed and used in a responsible manner.
* When working with Facial Recognition, [understand current and future regulation](https://blogs.microsoft.com/on-the-issues/2018/07/13/facial-recognition-technology-the-need-for-public-regulation-and-corporate-responsibility/), [follow a principled approach](https://blogs.microsoft.com/on-the-issues/2018/12/17/six-principles-to-guide-microsofts-facial-recognition-work/), and [understand the design scenarios and limitations](https://azure.microsoft.com/resources/transparency-note-azure-cognitive-services-face-api/).

## Engineering tools for responsible AI

### Security and privacy

|Resource type|Details|
|---|---|
|<br>Guidance|<ul><li>[Securing the Future of Artificial Intelligence and Machine Learning at Microsoft](https://www.microsoft.com/security/blog/2019/02/07/securing-the-future-of-ai-and-machine-learning-at-microsoft/) provides guidance on how to protect algorithms, data, and services from new AI-specific security threats. While security is a constantly changing field, this paper outlines emerging engineering challenges and shares initial thoughts on potential remediation.</li></ul>|
|<br>Open-source code|<ul><li>Homomorphic encryption is a special type of encryption technique that allows users to compute on encrypted data without decrypting it. The results of the computations are encrypted and can be revealed only by the owner of the decryption key. To further the use of this important encryption technique, we developed [Microsoft SEAL](https://www.microsoft.com/research/project/microsoft-seal/) and made it open-source.</li></ul>|
|<br>Technologies|<ul><li>Secure execution environments such as [Azure confidential computing](https://azure.microsoft.com/solutions/confidential-compute/) help users secure data while it's "in use" on public cloud platforms (a state required for efficient processing). The data is protected inside a Trusted Execution Environment (TEE), also known as an enclave, such that code and data are protected against viewing and modification from outside of the TEE. This has many benefits, including the ability to train AI models using data sources from different organizations without sacrificing data confidentiality.</li><ul><li>The Azure team has worked with Microsoft Research, Intel, Windows, and our Developer Tools group to develop our confidential computing solution, which enables developers to take advantage of different TEEs without having to change their code.</li><li>The Open Enclave SDK project provides a consistent API surface for developing apps using enclave-based computing.</li></ul><li>Multi-party computation (MPC) allows a set of parties to share encrypted data and algorithms with each other while preserving input privacy and ensuring that no party sees information about other members. For example, with MPC we can build a system that analyzes data from three different hospitals without any of them gaining access to each other's health data.</li><li> [Differential privacy](https://www.microsoft.com/research/project/project-laplace/) is a key technology for training machine learning models using private data. A differentially private algorithm uses random noise to ensure that the model output doesn't noticeably change when one individual in the dataset changes. This prevents attackers from inferring an individual's private information from the model's output.</li></ul>|
|<br>Tools|<ul><li>[The PSI (Private data Sharing Interface) tool](https://privacytools.seas.harvard.edu/publications/psipaper), developed by Harvard researchers, leverages differential privacy to enable researchers from many fields to explore and share datasets that contain private information.</li></ul>|

### Fairness

|Resource type|Details|
|---|---|
|<br>Guidance|<ul><li>Read this paper from the ACM Conference on Fairness, Accountability, and Transparency: [Fairness and Abstraction in Sociotechnical Systems](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3265913) that explains five key "traps" of fair-ML work and how to avoid them.</li><li>Read this paper from Cornell University: [Counterfactual Fairness](https://arxiv.org/abs/1703.06856) for an example of a framework for modeling fairness using tools from causal interference, and how it applies to the fair prediction of student success in law school.</li></ul>|
|<br>Open-source code|<ul><li>Fairness in Machine Learning (ML) Systems ([Fairlearn](https://www.microsoft.com/research/publication/a-reductions-approach-to-fair-classification/)) is an approach created by Microsoft Research and codeveloped with products teams. FairLearn can be used to assess the potential unfairness of ML systems that make decisions about allocating resources, opportunities, or information. Fairness is a fundamentally sociotechnical challenge, so "fair" classification tools aren't be-all-and-end-all solutions, and they're only appropriate in particular, limited, circumstances. A Python package that implements this approach is available on [GitHub](https://github.com/Microsoft/fairlearn).</li><ul><li>For example, consider an ML system tasked with choosing applicants to interview for a job. FairLearn can turn a classifier that predicts who should be interviewed based on previous hiring decisions into a classifier that predicts who should be interviewed while also respecting demographic parity (or another fairness definition).</li></ul>|
|<br>Tools|<ul><li>A [Methodology for reducing bias in word embedding](https://arxiv.org/pdf/1607.06520.pdf) created by Microsoft Research helps reduce gender biases by modifying embeddings to remove gender stereotypes, such as the association between receptionist and female.|
|<br>Further training|<ul><li>To understand the unique challenges regarding fairness in ML, watch our free  [webinar on Machine Learning and Fairness](https://www.microsoft.com/research/video/machine-learning-and-fairness/). In this webinar, you'll learn how to make detecting and mitigating biases a first-order priority in your development and deployment of ML systems.</li><li>For more on how organizations should approach assessing the fairness of their AI models, watch this [NIPS keynote](https://www.youtube.com/watch?v=fMym_BKWQzk) address from Kate Crawford, Principal Researcher at Microsoft and Cofounder of the AI Now Institute at NYU.</li></ul>|

### Inclusiveness

|Resource type|Details|
|---|---|
|<br>Guidance|<ul><li>Reference the [Inclusive Design toolkit](https://download.microsoft.com/download/b/0/d/b0d4bf87-09ce-4417-8f28-d60703d672ed/inclusive_toolkit_manual_final.pdf) and [inclusive design practices](https://www.microsoft.com/design/inclusive/) to learn how to understand and address potential barriers in a product environment that could unintentionally exclude people.</li><li> The Microsoft Research paper [Algorithmic greenlining](https://www.microsoft.com/research/publication/algorithmic-greenlining-an-approach-to-increase-diversity/) is an approach that app developers or decision-makers can use to develop selection criteria yielding high-quality and diverse results in contexts such as college admissions, hiring, and image search.<br>Take, for example, choosing job candidate search criteria. There's typically limited information about any candidate's "true quality." An employer's intuition might suggest searching for "computer programmer," which yields high-quality candidates but might return few female candidates. The greenlining algorithm suggests alternative queries that are similar but more gender-diverse, such as "software developer" or "web developer."</li></ul>|

### Reliability and safety

|Resource type|Details|
|---|---|
|<br>Technologies|<ul><li>The [Data Drift Monitoring](/azure/machine-learning/how-to-enable-data-collection) feature in [Azure Machine Learning](https://azure.microsoft.com/services/machine-learning-service/) detects changes in the distribution of data that may cause degraded prediction performance, enabling developers to maintain accuracy by adapting the model to reflect changing data.</li></ul>|
|<br>Tools|<ul><li>[Pandora](https://docs.wixstatic.com/ugd/1acfaf_4b2b106eaf6a40a89185eccacf822ea1.pdf) is a debugging framework designed by Microsoft Research to identify reliability and bias problems within machine learning models. It uses interpretable machine learning techniques, such as decision trees, to discover patterns and identify potential issues.</li><li> Microsoft [AirSim](https://github.com/microsoft/AirSim) is a valuable open-source tool for improving simulated training environments.</li></ul>|

### Transparency

|Resource type|Details|
|---|---|
|<br>Open-source code|<ul><li>[InterpretML](https://www.microsoft.com/research/blog/creating-ai-glass-boxes-open-sourcing-a-library-to-enable-intelligibility-in-machine-learning/) is an open-source package created by Microsoft Research for training interpretable models and explaining black box systems. It implements many intelligible models including Explainable Boosting Machine (EBM), an improvement over generalized additive models that has both high accuracy and intelligibility.  It also supports several methods for generating explanations of black box model behavior or predictions including 'SHapley Additive exPlanations' (SHAP) and 'Local Interpretable Model-agnostics Explanations' (LIME).</li></ul>|
|<br>Technologies|<ul><li>[Azure Machine Learning](https://azure.microsoft.com/services/machine-learning-service/) has various tools that support model transparency. The [Model Interpretability](/azure/machine-learning/how-to-machine-learning-interpretability) feature enables model designers and evaluators to explain why a model makes the predictions it does, which can be used to debug the model, validate that its behavior matches objectives, and check for bias.</li></ul>|

### Accountability

|Resource type|Details|
|---|---|
|<br>Guidance|<ul><li>[Datasheets for datasets](https://arxiv.org/abs/1803.09010) is a paper that encourages people assembling training datasets to generate a datasheet with key information such as the motivation, composition, collection process, and recommended uses. Datasheets for datasets have the potential to increase transparency and accountability within the machine learning community, mitigate unwanted biases in machine learning systems, facilitate greater reproducibility of machine learning results, and help researchers and practitioners select more appropriate datasets for their chosen tasks.</li><li>The Partnership on AI (PAI) is leading a multi-stakeholder initiative called [ABOUT ML](https://www.partnershiponai.org/about-ml/) to develop, test, and promulgate best practices for machine learning documentation. These best practices may include documenting how AI systems were designed and for what purposes, where their data came from and why that data was chosen, how they were trained, tested, and corrected, and what purposes they're not suitable for.</li></ul>|
|<br>Technologies|<ul><li>The DevOps feature in [Azure Machine Learning](https://azure.microsoft.com/services/machine-learning-service/) (called MLOps) makes it easier to track, reproduce, and share models and their version histories. It offers centralized management throughout the entire model development process, and helps teams monitor model performance by collecting application and model telemetry.</li></ul>|

## References

1. [Microsoft, "Software Engineering for Machine Learning: A Case Study." Saleema Amershi, Andrew Begel, Christian Bird, Robert DeLine, Harald Gall, Ece Kamar, Nachiappan Nagappan, Besmira Nushi, Thomas Zimmermann, 2019.](https://www.microsoft.com/en-us/research/uploads/prod/2019/03/amershi-icse-2019_Software_Engineering_for_Machine_Learning.pdf)
2. [Reuters, "Microsoft turned down facial-recognition sales on human rights concerns." Joseph Menn, 17 April 2019.](https://www.reuters.com/article/us-microsoft-ai-idUSKCN1RS2FV)   
3. [Microsoft, "The Future Computed: Artificial Intelligence and its role in society." Brad Smith and Harry Shum, 17 January 2018.](https://blogs.microsoft.com/blog/2018/01/17/future-computed-artificial-intelligence-role-society/)
4. [Microsoft, "Guidelines for Human-AI Interaction." Saleema Amershi, Dan Weld, Mihaela Vorvoreanu, Adam Fourney, Besmira Nushi, Penny Collisson, Jina Suh, Shamsi Iqbal, Paul Bennett, Kori Inkpen, Jaime Teevan, Ruth Kikin-Gil, Eric Horvitz, May 2019.](https://www.microsoft.com/research/publication/guidelines-for-human-ai-interaction/)
5. [Microsoft, "Responsible bots: 10 guidelines for developers of conversational AI." November 2018.](https://www.microsoft.com/research/uploads/prod/2018/11/Bot_Guidelines_Nov_2018.pdf)
6. [Microsoft Azure, "Transparency Note: Azure Cognitive Services Face API." 6 May 2019.](https://azure.microsoft.com/resources/transparency-note-azure-cognitive-services-face-api/)  
7. [Microsoft, "Six principles to guide Microsoft's facial recognition work." Rich Sauer, 17 December 2018.](https://blogs.microsoft.com/on-the-issues/2018/12/17/six-principles-to-guide-microsofts-facial-recognition-work/)  
8. [Microsoft, "Facial recognition technology: The need for public regulation and corporate responsibility." Brad Smith, 13 July 2018.](https://blogs.microsoft.com/on-the-issues/2018/07/13/facial-recognition-technology-the-need-for-public-regulation-and-corporate-responsibility/) 
9. [Microsoft, "Project Laplace."](https://www.microsoft.com/research/project/project-laplace/)  
10. [Microsoft, "Securing the future of AI and machine learning at Microsoft." Andrew Marshall, 7 February 2019.](https://www.microsoft.com/security/blog/2019/02/07/securing-the-future-of-ai-and-machine-learning-at-microsoft/)  
11. [Microsoft, "Microsoft SEAL."](https://www.microsoft.com/research/project/microsoft-seal/)
12. [Microsoft, "AI security risk assessment using Counterfit." Will Pearce, Ram Shankar Siva Kumar, 3 May 2021.](https://www.microsoft.com/security/blog/2021/05/03/ai-security-risk-assessment-using-counterfit)
13. [Microsoft, "Use differential privacy in Azure Machine Learning."](/azure/machine-learning/how-to-differential-privacy)
14. [Microsoft, Presidio.](https://presidio-demo.azurewebsites.net/) 
15. [Microsoft, "Azure confidential computing."](https://azure.microsoft.com/solutions/confidential-compute/)
16. [National Science Foundation, "A Private Data Sharing Interface."](https://privacytools.seas.harvard.edu/publications/psipaper)
17. [University of Chicago, "Aequitas."](http://www.datasciencepublicpolicy.org/projects/aequitas/)
18. [Microsoft, "A Reductions Approach to Fair Classification." Association for Computing Machinery, March 2018.](https://www.microsoft.com/research/publication/a-reductions-approach-to-fair-classification/)
19. [NIPS, "Man is to Computer Programmer as Woman is to Homemaker? Debiasing Word Embeddings." Tolga Bolukbasi, Kai-Wei Chang, James Zou, Venkatesh Saligrama, Adam Kalai, 21 July 2016.](https://arxiv.org/pdf/1607.06520.pdf)
20. [NIPS, "The Trouble with Bias – NIPS 2017 Keynote." Kate Crawford, 5 December 2017.](https://www.youtube.com/watch?v=fMym_BKWQzk)  
21. [Microsoft Research Webinar Series, "Machine Learning and Fairness." Jenn Wortman Vaughan, Hanna Wallach. 2018.](https://www.microsoft.com/research/video/machine-learning-and-fairness/)  
22. [GitHub, FairLearn](https://github.com/Microsoft/fairlearn)  
23. [SSRN, "Fairness and Abstraction in Sociotechnical Systems." Andrew Selbst, Danah Boyd, Sorelle Friedler, Suresh Venkatasubramanian, Janet Vertesi, 23 August 2018.](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3265913)
24. [Cornell University, "Counterfactual Fairness." Matt J. Kusner, Joshua R. Loftus, Chris Russell, Ricardo Silva, 8 March 2018.](https://arxiv.org/abs/1703.06856)
25. [Microsoft, "Inclusive Design."](https://www.microsoft.com/design/inclusive/)  
26. [Microsoft, "Inclusive Microsoft Design Toolkit." 2016.](https://download.microsoft.com/download/b/0/d/b0d4bf87-09ce-4417-8f28-d60703d672ed/inclusive_toolkit_manual_final.pdf)  
27. [Microsoft, "Algorithmic Greenlining: An Approach to Increase Diversity." Christian Borgs, Jennifer Chayes, Nika Haghtalab, Adam Tauman Kalai, Ellen Vitercik, January 2019.](https://www.microsoft.com/research/publication/algorithmic-greenlining-an-approach-to-increase-diversity/)  
28. [Microsoft Research, "Towards Accountable AI: Hybrid Human-Machine Analyses for Characterizing System Failure." Besmira Nushi, Ece Kamar, Eric Horvitz.](https://docs.wixstatic.com/ugd/1acfaf_4b2b106eaf6a40a89185eccacf822ea1.pdf)  
29. [GitHub, AirSim](https://github.com/microsoft/AirSim)  
30. [GitHub, InterpretML](https://github.com/Microsoft/interpret)  
31. [Microsoft, "Creating AI glass boxes – Open sourcing a library to enable intelligibility in machine learning." 10 May 2019.](https://www.microsoft.com/research/blog/creating-ai-glass-boxes-open-sourcing-a-library-to-enable-intelligibility-in-machine-learning/)
32. [Cornell University, "Datasheets for Datasets." Timnit Gebru, Jamie Morgenstern, Briana Vecchione, Jennifer Wortman Vaughan, Hanna Wallach, Hal Daumeé III, Kate Crawford, 14 April 2019.](https://arxiv.org/abs/1803.09010)  
33. [Partnership on AI, ABOUT ML (Annotation and Benchmarking on Understanding and Transparency of Machine Learning Lifecycles).](https://www.partnershiponai.org/about-ml/)
34. [Microsoft, HAX Toolkit.](https://www.microsoft.com/en-us/haxtoolkit/)
