Contoso's employee wants help turning locally stored project materials into a brief, task list, and organized set of source files. Some parts of that work might be suited to resources available on the PC, while other parts might benefit from cloud-hosted models, services, or additional computing capacity.

Contoso therefore needs to consider the location of the source information, the capabilities required for each part of the task, and the resources available locally and in the cloud. This situation illustrates the value of hybrid intelligence.

## What is hybrid intelligence?

| **Approach** | **Where AI work happens** | **Key characteristic** |
| :---: | :---: | :---: |
| **Local intelligence** | On the PC | Uses computing resources available on the device. |
| **Cloud intelligence** | Remote computing infrastructure | Can provide models and computing capacity beyond an individual PC. |
| **Hybrid intelligence** | Across local and cloud environments | Treats local and cloud computing as complementary resources. |

Hybrid intelligence is an approach in which AI experiences can use resources available locally and in the cloud.

A local-only approach limits an AI experience to the models, data, memory, and computing resources available on the device. A cloud-only approach requires AI operations to depend on remote computing resources.

A hybrid approach doesn't treat the PC and cloud as mutually exclusive choices. Instead, local and cloud computing become complementary parts of the AI environment.

For Contoso, this means the company can capitalize on the benefits of both local AI and cloud AI while minimizing the drawbacks of either. Windows can provide a foundation for hybrid intelligence experiences.

## Local intelligence

Local intelligence refers to AI capabilities that use computing resources on the device.

Local processing can be useful when an AI experience needs to work closely with the PC, use a local model, or perform operations suited to the device's available capabilities. The work that can run locally depends on factors such as:

- The model being used.
- The resources required by the workload.
- The available memory and processing capability.
- The capabilities exposed by the AI runtime.
- The requirements of the application or experience.

In the Contoso scenario, local intelligence could contribute to processing information available directly on the employee's PC, such as reviewing project documents or identifying relevant content. Whether a particular operation can run locally depends on the model, runtime, application capabilities, and resources available on the device.

However, implementing local intelligence doesn't mean every AI operation must happen locally.

## Cloud intelligence

Cloud intelligence uses remote computing infrastructure. For instance, cloud resources can provide access to models and computing capacity beyond what is available on an individual PC.

An AI experience might use cloud intelligence when a workload requires a cloud-hosted model, additional computing capacity, or a service available through the cloud. For Contoso, cloud intelligence could contribute when preparing the package requires a cloud-hosted model, an organizational service, or computing capacity beyond what the employee's PC can provide.

Hybrid intelligence preserves access to those resources while making the PC a more active part of the AI computing environment. This helps users do more with the resources they already have access to.

## Intelligent routing

If local and cloud capabilities are both available, the AI experience needs a way to determine how and when to use them.

Intelligent routing coordinates AI work across the computing environments at its disposal. Depending on the design, routing can consider factors such as:

- Which models are available.
- Whether a suitable model is available locally.
- The computing resources required by the request.
- The capabilities needed to complete the work.
- The resources currently available on the PC.

The goal is to enable an AI experience to make effective use of the available resources. Users don't have to make an infrastructure decision before submitting each request, because the experience itself helps direct those decisions.

For the Contoso employee, the interaction remains focused on the desired result: a project brief, task list, and organized set of source files. Behind the scenes, intelligent routing can account for factors such as where the project information is available, which models or services are required, what resources the PC can provide, and which capabilities are permitted. The employee doesn't need to choose an execution environment for each part of the task.

## The role of local models

An AI model contains learned patterns that enable it to process input and generate output. A local model runs inference by using computing resources on the device.

Local models vary in capability and resource requirements. A model suitable for one workload might not be suitable for another. The presence of a local model alone also doesn't guarantee that every part of an AI experience happens on the device.

It's useful to distinguish among:

- **Model location:** Where inference runs.
- **Context location:** Where the information used by the experience is available.
- **Action location:** Where a tool or operation is executed.
- **Experience orchestration:** How models, context, actions, and supporting resources are coordinated.

These elements can have different boundaries. For example, an AI experience might use a local model for initial assessment of a request while using another environment for a different capability, such as in-depth data analysis.

## The role of the AI runtime

A runtime provides the software foundation used to load, manage, and run AI models. It helps applications use available hardware without requiring every application developer to independently build the same low-level infrastructure.

In a hybrid-intelligence architecture, the runtime is one of the layers connecting applications, models, and the PC's computing resources.

## The role of silicon

AI workloads require computing resources. Depending on the workload, processing can involve a central processing unit, graphics processing unit, neural processing unit, or a combination of resources.

Capable silicon increases the range of AI work that can run locally. However, the appropriate hardware depends on the workload. Everyday AI experiences and demanding local-model workloads don't necessarily have the same requirements.

## Key takeaways

Contoso can now answer the first part of its central question.

The company doesn't need to treat the employee's PC and the cloud as separate AI strategies. Hybrid intelligence allows local and cloud computing to contribute to a broader AI experience.

This architecture leads to a new question:

**If the PC becomes part of the AI computing environment, what does that make possible for the employee?**
