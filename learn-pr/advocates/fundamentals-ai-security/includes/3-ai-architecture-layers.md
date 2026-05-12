To understand how attacks against AI can occur, it helps to separate AI architecture into three layers. Each layer has distinct components, distinct security challenges, and distinct types of controls.

- AI Usage layer
- AI Application layer
- AI Platform layer

:::image type="content" source="../media/ai-architecture-layers.png" alt-text="A diagram showing the three AI architecture layers: AI Usage, AI Application, and AI Platform.":::

## AI usage layer

The AI usage layer describes how AI capabilities are ultimately used and consumed. Generative AI offers a new type of user/computer interface that is fundamentally different from other computer interfaces such as APIs, command prompts, and graphical user interfaces (GUIs). The generative AI interface is both interactive and dynamic, allowing the computer capabilities to adjust to the user and their intent. This approach contrasts with previous interfaces that primarily force users to learn the system design and functionality to accomplish their goals. This interactivity allows user input to have a high level of influence on the output of the system (as opposed to application designers alone), making safety guardrails critical to protect people, data, and business assets.

Protecting AI at the AI usage layer is similar to protecting any computer system because it relies on security assurances for identity and access controls, device protections and monitoring, data protection and governance, administrative controls, and other controls.

Additional emphasis is required on user behavior and accountability because of the increased influence users have on the output of the systems. Organizations must update acceptable use policies and educate users on those policies. Policies should include AI-specific considerations related to security, privacy, and ethics. Additionally, users should be educated on AI-based attacks that can be used to trick them with convincing fake text, voices, videos, and more (sometimes called deep fakes or AI-generated social engineering).

### Key security concerns at this layer

- Users can intentionally or accidentally cause the system to produce harmful output
- AI-generated content (deep fakes, phishing emails) can deceive users
- Overreliance on AI output without human verification

## AI application layer

At the AI application layer, the application accesses the AI capabilities and provides the service or interface that the user consumes. The components in this layer can vary from relatively simple to highly complex, depending on the application.

The simplest standalone AI applications act as an interface to a set of APIs, taking a text-based user prompt and passing that data to the model for a response. More complex AI applications include the ability to ground the user prompt with additional context, including a persistence layer, semantic index, or via plugins to allow access to additional data sources. Advanced AI applications may also interface with existing applications and systems—these applications might work across text, audio, and images to generate various types of content.

Increasingly, AI applications also function as AI agents—autonomous or semi-autonomous systems that can plan tasks, call external tools, browse the web, or execute code. Agents introduce new security considerations because they act on behalf of users and can interact with other systems.

To protect the AI application from malicious activities at this layer, an application safety system must be built to provide deep inspection of the content being used in the request sent to the AI model, and the interactions with any plugins, data connectors, and other AI applications (a process known as AI orchestration).

### Key security concerns at this layer

- Prompt injection attacks that manipulate the application logic
- Insecure plugin or tool integrations that expand the attack surface
- Insufficient input validation and output filtering
- Agent actions that bypass intended access controls

## AI platform layer

The AI platform layer provides the AI capabilities to the applications. At the platform layer, there's a need to build and safeguard the infrastructure that runs the AI model, the training data, and specific configurations that change the behavior of the model, such as weights and biases. This layer provides access to functionality via APIs, which pass text known as a metaprompt (or system prompt) to the AI model for processing, then return the generated outcome, known as a prompt response.

To protect the AI platform from malicious inputs, a safety system must be built to filter out potentially harmful instructions sent to the AI model (inputs). Because AI models are generative, there's also a potential that harmful content might be generated and returned to the user (outputs). Any safety system must protect against potentially harmful inputs and outputs of many classifications including hate speech, jailbreaks, and others. Classifications evolve over time based on model knowledge, locale, and industry.

### Key security concerns at this layer

- Model poisoning during training or fine-tuning
- Unauthorized access to model weights, training data, or configuration
- Model theft through API abuse or extraction attacks
- Insufficient content filtering on inputs and outputs

## Shared responsibility for AI security

Just as cloud computing uses a shared responsibility model between the provider and the customer, AI systems require a similar division of security responsibilities across these three layers. Who is responsible for securing each layer depends on how the AI capability is deployed.

The deployment model determines the division:

- **Software as a Service (SaaS)**: The AI provider manages nearly all security responsibilities across all three layers. The customer is primarily responsible for their own data governance, user access policies, and acceptable use. For example, when using a provider's copilot product built into a productivity application, the provider secures the platform and application, while you manage user policies.
- **Platform as a Service (PaaS)**: The provider secures the AI platform layer (model hosting, safety systems, infrastructure), while the customer takes responsibility for the AI application layer—including input validation, plugin security, orchestration, and content filtering. Both share some responsibilities, such as content filtering configuration.
- **Infrastructure as a Service (IaaS)**: The customer takes on the most responsibility, managing security across all three layers—from the infrastructure running the model to the application logic and user-facing controls. The provider secures only the underlying compute, storage, and networking infrastructure.

The following diagram illustrates how responsibility shifts between the provider and the customer depending on the deployment model. As you move from SaaS to IaaS, your organization assumes greater security responsibility.

:::image type="content" source="../media/ai-shared-responsibility.png" alt-text="Diagram showing the AI shared responsibility model. In SaaS, the provider manages most security. In PaaS, responsibility is shared. In IaaS, the customer manages most security across all three AI layers." lightbox="../media/ai-shared-responsibility.png":::

> [!NOTE]
> For example, Microsoft formalizes this model in their [AI shared responsibility documentation](/azure/security/fundamentals/shared-responsibility-ai), which maps specific security tasks to the provider and customer at each layer and deployment type.

Understanding where your responsibilities begin and end is essential for building a comprehensive AI security strategy. Organizations that assume the AI provider handles all security—regardless of deployment model—leave critical gaps that attackers can exploit.

### Key considerations

- Start with a SaaS approach when possible to minimize the security responsibilities your organization must manage
- As you move toward PaaS or IaaS, ensure you have the expertise and processes to secure the additional layers
- Regardless of deployment model, your organization is always responsible for user access policies, data governance, and acceptable use education
