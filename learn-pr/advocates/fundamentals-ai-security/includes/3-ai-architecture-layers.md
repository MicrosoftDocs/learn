To understand how attacks against AI can occur, you can separate AI architecture into three layers as shown in the exhibit:

- AI Usage layer
- AI Application layer
- AI Platform

![A diagram of a security system  Description automatically generated](../media/image2.png)

## AI Usage Layer

The AI Usage layer describes how AI capabilities are ultimately used and consumed. Generative AI offers a new type of user/computer interface that is fundamentally different from other computer interfaces (API, command-prompt, and graphical user interfaces (GUIs)). The generative AI interface is both interactive and dynamic, allowing the computer capabilities to adjust to the user and their intent, which contrasts with previous interfaces that primarily force users to learn the system design and functionality and adjust to it. This interactivity allows user input to have a high level of influence of the output of the system (vs. application designers), making safety guardrails critical to protect people, data, and business assets.   

Protecting AI at the AI usage layer is similar to protecting any computer system as it relies on security assurances for identity and access controls, device protections and monitoring, data protection and governance, administrative controls, and other controls. 

Additional emphasis is required on user behavior and accountability because of the increased influence users have on the output of the systems. It's critical to update acceptable use policies and educate users on them. These should include AI specific considerations related to security, privacy, and ethics. Additionally, users should be educated on AI based attacks that can be used to trick them with convincing fake text, voices, videos, and more. 

## AI Application Layer

At the AI Application layer, the application accesses the AI capabilities and provides the service or interface that will be consumed by the user. The components in this layer can vary from relatively simple to highly complex, depending on the application.  The simplest standalone AI applications act as an interface to a set of APIs taking a text-based _user-prompt_¸ and passing that data to the model for a response.  More complex AI applications include the ability to _ground_ the user-prompt with additional context, including a _persistence layer,_ _semantic index¸_ or via_ plugins_ to allow access to additional data sources. Advanced AI applications may also interface with existing applications and systems; these may work across text, audio, and images to generate various types of content. 

To protect the AI application from malicious activities at this layer, an application safety system must be built to provide deep inspection of the content being used in the request sent to the AI model, and the interactions with any plugins, data connectors, and other AI applications (known as AI Orchestration).

## AI Platform

The AI platform layer provides the AI capabilities to the applications. At the platform layer there is a need to build and safeguard the infrastructure that runs the AI model, training data, and specific configurations that change the behavior of the model, such as weights and biases. This layer provides access to functionality via APIs, which will pass text known as a _Metaprompt_ to the AI model for processing, then return the generated outcome, known as a _Prompt-Response_. 

To protect the AI platform from malicious inputs, a safety system must be built to filter out the potentially harmful instructions sent to the AI model (inputs). As AI models are generative, there is also a potential that some harmful content may be generated and returned to the user (outputs). Any safety system must first protect against potentially harmful inputs and outputs of many classifications including hate, jailbreaks, and others (these classifications will likely evolve over time based on model knowledge, locale, and industry).  