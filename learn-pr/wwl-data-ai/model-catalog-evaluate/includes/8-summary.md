In this module, you explored the complete workflow for selecting, deploying, and evaluating Foundry Models. You learned how to make informed decisions about model selection using benchmarks, how to deploy models to endpoints, and how to assess their performance using various evaluation approaches.

## Key takeaways

The Microsoft Foundry portal's **model catalog** provides access to over 1,900 models from providers including Microsoft, OpenAI, Meta, Mistral, and Hugging Face. Effective filtering by collection, capabilities, deployment options, and other attributes helps you narrow the catalog to models matching your requirements.

**Model benchmarks** offer objective comparisons across quality, safety, cost, and performance dimensions. Quality metrics like accuracy, coherence, and fluency assess how well models generate appropriate responses. Safety metrics identify risks around harmful content. Cost benchmarks help balance quality with budget constraints. Performance metrics like latency and throughput indicate responsiveness for real-time applications.

**Deployment options** include serverless API for pay-per-call flexibility, provisioned deployments for consistent high-volume workloads, managed compute for VM-based hosting, and batch processing for cost-optimized non-interactive jobs. Each option offers different characteristics for scaling, billing, and control.

**Testing in the playground** provides immediate feedback on model behavior without writing code. You can experiment with prompts, adjust parameters, and observe responses to understand model capabilities before integrating into applications.

**Evaluation approaches** range from manual testing to automated metrics. Manual evaluation captures subjective quality aspects like user satisfaction and contextual appropriateness. AI-assisted metrics assess generation quality and safety risks automatically. NLP metrics like F1-score and ROUGE provide mathematical comparison against ground truth data.

**Comprehensive evaluation flows** in the Microsoft Foundry portal let you run systematic assessments using test datasets and multiple metrics. Results identify strengths, weaknesses, and areas requiring improvement, guiding iterative development of your generative AI applications.

## Next steps

With models deployed and evaluated, consider these next steps:

**Integrate models into applications** using the SDKs, REST APIs, and code samples provided in the Microsoft Foundry portal. Your applications can now consume deployed models through authenticated API calls.

**Implement Retrieval Augmented Generation (RAG)** to ground model responses in your organization's data. RAG combines models with search capabilities to provide accurate, contextually relevant responses based on your documents and knowledge bases.

**Apply Azure AI Content Safety** services to add an additional layer of protection against harmful content. Content filters can block inappropriate inputs and outputs, complementing model-level safety features.

**Fine-tune models** (when supported) on your specific domain or use case to improve performance for specialized scenarios. Fine-tuning adapts general-purpose models to your unique requirements.

**Monitor production performance** using Azure Monitor and Application Insights to track usage, latency, costs, and errors. Ongoing monitoring ensures your applications remain healthy and performant.

**Iterate based on user feedback** by collecting real-world usage data and conducting periodic re-evaluations. Continuous improvement keeps your generative AI applications aligned with user needs.

The skills you developed in this module—selecting appropriate models, deploying them effectively, and evaluating their performance—form the foundation for building robust, high-quality generative AI applications using Microsoft Foundry.
