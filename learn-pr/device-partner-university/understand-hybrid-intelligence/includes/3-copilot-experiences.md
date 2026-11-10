The Contoso employee doesn't need to understand models, runtimes, or routing to prepare the project package. The employee needs an AI experience that can help with the work.

Hybrid intelligence matters to the employee because it can expand the resources and capabilities that will be available to that experience.

Three concepts help explain the relationship between hybrid intelligence and Copilot on Windows:

- PC context
- Local actions
- Local models

## PC context

AI responses become more useful when they're grounded in relevant context.

In the Contoso scenario, relevant PC context might include the project documents, meeting notes, and supporting files selected for the package. An AI experience that can work with this appropriate context could provide assistance grounded in the employee's current project instead of responding only with general information.

The experience should still operate within the access and security boundaries established for the user, application, and organization. This distinction becomes especially important when an experience moves from understanding information to acting.

## Local actions

An AI experience can do more than generate a response. Depending on the capabilities made available to it, the experience might also perform actions through tools or applications.

Local actions are operations performed through resources available on the PC.

In the Contoso scenario, supported actions could help organize selected source files, create a draft project brief, or prepare a task list. The exact actions available depend on the AI experience, its tools and update status, and the permissions and policies that apply. Contoso therefore needs to determine not only which actions would be useful, but also which files and applications each action should be permitted to affect.

>[!NOTE]
> Local actions create value because they connect intelligence to work on the PC. They also increase the importance of security. An AI response can provide information, but an AI action can affect files, applications, or other resources.

## Local models

Local models make it possible for supported AI inference to run on the PC. They can contribute to AI experiences without replacing every cloud model or cloud service.

For the Contoso employee, local models could become one of several resources available to the Copilot experience. The employee can remain focused on the desired result while the experience coordinates the underlying resources.

The important concept is complementarity:

- Local models can contribute device-based inference.
- Cloud models can provide cloud-based intelligence.
- Routing coordinates the resources used by the experience.
- The user interacts with one experience while routing coordinates local and cloud resources.

## Where Copilot+ PCs fit

Copilot+ PCs are designed to support AI experiences that make use of capable local hardware. Their hardware provides a strong foundation for experiences that use local AI models.

Not every part of a hybrid-intelligence experience has identical hardware requirements. An experience that works with PC context or invokes a supported action might have different requirements from an experience that runs an AI model locally.

This distinction helps Contoso understand the Copilot+ PC value proposition. The value isn't simply that the PC can connect to cloud AI. The PC itself can provide meaningful AI computing capability.

## One experience, multiple resources

The employee describes the desired outcome to Copilot: create a project brief, task list, and organized set of source files from selected project materials. Depending on the capabilities available in the experience, completing that work can involve:

- Using relevant project context available through the PC.
- Selecting local or cloud AI models based on the capabilities and resources required.
- Coordinating work across the available computing environments.
- Invoking supported tools or actions within the applicable permissions and policies.
- Using PC hardware capable of running the selected local workloads.

The employee doesn't need to manually coordinate these layers. The architecture exists to support the experience.

## Key takeaway

So far, the focus has been on what hybrid intelligence can enable for the employee. But Contoso must also consider what changes when an AI experience can act.

It's one thing for AI to summarize information. It's another for AI to access a resource, invoke a tool, or modify something on an employee's behalf.

That progression leads to the next question:

**How can Contoso support useful agentic work without giving an agent unrestricted access to the employee's environment?**
