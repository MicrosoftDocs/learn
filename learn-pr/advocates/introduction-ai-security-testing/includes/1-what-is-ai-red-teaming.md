Red teaming is a term in the information security industry that is used to describe the process of testing security vulnerabilities using systematic adversarial attacks. Red teaming is performed to harden the security of an organization's systems. Red teaming is separate from unauthorized attacks by malicious third parties.

The introduction of Large Language Models (LLMs) into application ecosystems requires red teams to include adversarial techniques on probing, testing, and attacking AI systems. Adversarial and even benign usage of AI enabled applications can produce potentially harmful outputs. For example, having a company's social media chatbot corrupted to generate hate speech or to glorify violence. Adversarial usage can also lead to AI applications emitting private data, crafting attacks, and can lead to other downstream negative security effects.

The following diagram provides an overview of the expansion of scope that occurred with red teaming since the introduction of LLM into application ecosystems.

![Graphic showing the expansion of red teaming to include AI enabled applications.](../media/ai-red-teaming-description.png)

AI red teaming takes place at two levels: at the base LLM level, such as red team attacks against a popular LLM, or at the application level where an AI enabled application uses an LLM as a part of its back end infrastructure. Taking this two layer approach leads to the following outcomes:

:::image type="content" source="../media/model-vs-application-red-teaming.png" alt-text="Diagram showing two levels of AI red teaming: base LLM probing and application-level probing." lightbox="../media/model-vs-application-red-teaming.png":::

- Red teaming the model helps to identify early in the process how models can be misused, to scope capabilities of the model, and to understand the model's limitations. These insights can be fed into the model development process and can improve future model versions.
- Red teaming at the application-level takes a system wide approach, of which the base LLM is one part. For example, when performing AI red teaming against an AI-powered search assistant, the underlying LLM must be probed alongside the broader search experience. Taking a system wide approach helps to identify failures beyond just the model-level safety mechanisms, by including the overall application specific safety triggers.  

Organizations with mature AI practices run dedicated AI Red Teams who perform these adversarial tests against LLMs, AI enabled applications and services. These teams have learned the following:

- AI red teaming is more expansive than traditional red teaming
- AI red teaming focuses on failures from both malicious and benign personas
- Red teaming generative AI systems requires multiple attempts of the same test
- AI systems constantly evolve
- Mitigating AI failures requires defense in depth

## AI red teaming is more expansive than traditional red teaming

AI red teaming is now an umbrella term for probing both security and responsible AI (safety) outcomes. AI red teaming intersects with traditional red teaming goals but includes LLMs as an attack vector. AI red teaming checks defenses against new classes of security vulnerabilities including prompt injection and model poisoning. AI red teaming also includes probing for outcomes that may harm organizational reputations, such as fairness issues and harmful content. Performing AI red teaming before an LLM or AI enabled workload is released to the public helps organizations identify issues and prioritize defense investments.

## AI red teaming focuses on failures from both malicious and benign personas

Unlike traditional security red teaming, which mostly focuses on only malicious adversaries, AI red teaming considers broader set of personas and failures. AI red teams have learned important lessons from adversarial testing against AI-powered search and assistant products. When testing an AI-enabled search engine, AI red teaming focuses on how a malicious adversary can subvert the AI system through security-focused techniques. It also examines how the system can generate problematic and harmful content when regular users interact with it. This is important because a flagship AI product generating problematic content can trigger significant reputational harm for the organization. 

## Red teaming generative AI systems require multiple attempts of the same test

In a traditional red teaming engagement, using a tool or technique at two different time points on the same input, would always produce the same output. This is known as a deterministic output. Generative AI systems are probabilistic, which means that running the same input twice may provide different outputs.

:::image type="content" source="../media/deterministic-vs-probabilistic-outputs.png" alt-text="Diagram comparing deterministic traditional systems that always produce the same output with probabilistic generative AI systems that produce varied outputs." lightbox="../media/deterministic-vs-probabilistic-outputs.png"::: The probabilistic nature of generative AI allows for a wider range in creative output. This makes red teaming challenging as using the same test prompt may lead to success in one attempt and failure in another. One method to address this is to perform multiple iterations of red teaming in the same operation. To accomplish this, organizations invest in automation that helps to scale operations. They also develop systematic measurement strategies that quantify the extent of the risk.

## AI systems constantly evolve

As new models are released, the AI applications that use them are regularly updated. For example, developers may update an LLM or an AI enabled application's metaprompt (also known as the system message). Metaprompts provide the underlying instructions to the underlying language model. Changing the metaprompt leads to changes in how the model responds, result in red team exercises having to be performed again. As the responses from LLMs are probabilistic rather than deterministic, the outcomes of changes can't be predicted and can only really be understood through testing. AI red teams need to perform systematic, automated measurement and testing and monitor AI enabled systems over time.

## Mitigating AI failures requires defense in depth

AI red teaming requires a defense-in-depth approach. Defense in depth requires applying multiple security controls, each of which mitigates a different adversarial strategy. With AI enabled applications that can involve the use of classifiers to flag potentially harmful content to using metaprompt. By implementing classifiers, it's possible to guide the behavior or AI enabled applications and limit conversational drift in interactive scenarios.

:::image type="content" source="../media/defense-in-depth-ai-systems.png" alt-text="Diagram showing four layered security controls for AI systems: input classifiers, metaprompt instructions, application controls, and model alignment." lightbox="../media/defense-in-depth-ai-systems.png":::
