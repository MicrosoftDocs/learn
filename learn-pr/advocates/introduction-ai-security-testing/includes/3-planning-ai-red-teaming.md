The red teaming process is a best practice in the responsible development of applications and systems that use Large Language Models (LLMs). Red teaming complements the systematic measurement and mitigation work done by developers and helps to uncover and identify harms. Red teams also help enable measurement strategies to validate the effectiveness of mitigations.

When planning your own approach to red teaming LLMs and AI enabled applications used by your organization, you should consider the following goals:

- Ensure that proper software security protocols are being followed for the application. Just because an application uses AI doesn't mean that you should ignore traditional security practices.
- Test the LLM base model and determine whether there are gaps in the existing safety systems, given the context of your application.
- Provide feedback on failures that testing uncovers in order to make improvements.

You should include the following elements when red teaming LLMs and AI enabled applications in development by your organization.

- Recruit the AI red team
- Design adversarial tests
- Perform tests
- Report results

## Recruit the red team

The success of your AI red teaming is dependent on the people you recruit to perform the AI red teaming process. When selecting red team members, keep in mind the following principles:

- Select for diverse experience, demographics, and expertise
- Ensure a mix of benign and adversarial mindsets
- Spread red team members across harms and product features
- Provide clear objectives to red team members

### Select for diverse experience, demographics, and expertise

When red teaming, you need to probe the LLM or AI enabled application in ways that are obvious. You also need to probe the LLM and AI enabled application using approaches that are developed from different perspectives on the world. Seek red team members with different levels of experience, demographic background, different areas of expertise, and different use cases for the target LLM or AI enabled application. For example, if probing a chatbot to help health care providers, a nurse will have a different approach to a systems administrator who manages the chatbot's host infrastructure.

### Ensure a mix of benign and adversarial mindsets

The traditional approach with red teams is to staff them with IT professionals and developers who have an adversarial mindset and security-testing experience. When it comes to AI enabled applications and LLMs, it also is important to include people in your red team who are ordinary users of your application system. These users can bring valuable perspectives on harms that regular users might encounter. For example, a nurse might be able to figure out how to convince a chatbot to release confidential patient data in a way that wouldn't occur to an information security professional. Just as an indirect approach to negotiation can be successful with some people, an indirect approach to manipulation to AI enabled applications and LLMs can tease out results blocked by conventional attacks.

### Assign red teamers to harms and product features

Assign responsible AI (RAI) red team members with specific expertise to probe for specific types of harms. For example, security subject matter experts can probe for jailbreaks, meta prompt extraction, and content related to cyberattacks.

For multiple rounds of testing, decide whether to switch red teamer assignments in each round to get diverse perspectives on each harm. Switching tasks may also maintain creativity in the way the red teamers approach the assignments. When switching assignments, allow time for red teamers to adjust to the process for their newly assigned harm.

In later stages of the red teaming process, when the application and its UI are developed, you might want to assign red teamers to specific features of the application to ensure coverage of the entire application.

Consider how much time and effort each red teamer should dedicate (for example, testing for benign scenarios might need less time than testing for adversarial scenarios).

### Provide clear objectives to red team members

Red team members should be provided with clear instructions that can include:

- An introduction describing the goal of the given round of red teaming
- The product and features that to test and how to access them
- The types of issues to test for
- How much time and effort each red team member should spend on testing
- How to record results
- Who to contact with questions.

The red team should be provided with a consistent way of recording their result including:

- The date an example was surfaced
- A unique identifier for the input/output pair if available, for reproducibility purposes
- The input prompt; a description or screenshot of the output.

## Design adversarial tests

Because an application is developed using a base model, you may need to test at both the LLM and the application layer. Red teamers should test the following before and after mitigations are in place:

- The LLM base model with its safety system in place to identify any gaps that may need to be addressed in the context of your application system. This testing is often done through an API endpoint.
- The AI enabled application. This testing is often done through a UI.

## Perform tests

You can begin by testing the base model to understand the risk surface, identify harms, and guide the development of RAI mitigations for your product. You should test versions of your product iteratively with and without RAI mitigations in place to assess the effectiveness of RAI mitigations. You should use both manual red teaming and systematic measurements. Tests should be performed on the production UI as much as possible as this replicates real-world usage. When reporting results, make clear which endpoints were used for testing. When testing was done in an endpoint other than product, consider testing again on the production endpoint or UI in future rounds.

Tests should include the following elements:

- Determine scope of harm
- Extend the list of harms based on open-ended testing
- Retest after applying mitigations

### Determine scope of harm

Start with organizational policies on trust and safety or responsible AI. You may need to address compliance regulations and executive orders. It's necessary to work with your organization's legal and policy teams to identify the most important harms for your organization and this particular application. The outcome of this consultation will be a list of harms with examples of the harm.

These aren't the only harms that might be discovered by the red teaming process. A benefit of RAI red teamers exploring and documenting any problematic content is that they'll often find harms that hadn't been predicted by organizational policies or regulation. There have been multiple examples of large organizations releasing AI enabled applications and services where the public have found outcomes that have led to reputational harm for that organization because the organization didn't consider testing for that type of outcome. If you have a creative red team, they're more likely to discover these problematic outcomes before the public does.

### Extend the list of harms based on open-ended testing

Focus on the scoped prioritized list from the policy and compliance angle as these items are the ones that are more likely to result in regulatory scrutiny and sanction. Supplement this list with harms found by creative red teamers.

Plan which harms to prioritize for iterative testing. Several factors can inform your prioritization, including, but not limited to, the severity of the harms and the context in which they're more likely to surface. Each newly discovered harm should also be added to the overall list of harms so that it can be checked for in future.

### Retest after applying mitigations

Test on the full list of known harms with mitigations in place. In the process, you may identify new harms or where mitigations haven't addressed existing known harms. Integrate newly discovered harms these into the harms list and be open to shifting measurement and mitigation priorities to address the newly identified harms.

## Report results

A critical part of the red team process is recording what tests were performed and what results were obtained. Be strategic with what data you're collecting to avoid overwhelming red teamers, while not missing critical information.

Ensure that there's a consistent location for recording results information. It's common to use a shared Excel spreadsheet as a way of collecting red teaming data, though some organizations use more sophisticated methods. If possible allow everyone in the red team access to each other's examples as a way to spark creative ideas for their own testing and avoid duplication of data.

It's important to share a short report on a regular interval with key stakeholders that:

- Lists the top identified issues
- Provides a link to the raw data
- Previews the testing plan for the upcoming rounds
- Acknowledges red teamers
- Provides any other relevant information

In the report, be sure to clarify that the role of RAI red teaming is to expose and raise understanding of risk surface and isn't a replacement for systematic measurement and rigorous mitigation work. It's important that people don't interpret specific examples as a metric for the pervasiveness of that harm. Additionally consider a content warning on the report if the report contains problematic content.
