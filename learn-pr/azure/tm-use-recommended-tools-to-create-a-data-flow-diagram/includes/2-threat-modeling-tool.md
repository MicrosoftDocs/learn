## Quick overview

The Microsoft Threat Modeling Tool, recognized by the threat-modeling community, helps engineers create data-flow diagrams and apply STRIDE for their threat-modeling work.

The Threat Modeling Tool offers:

- Customizable templates
- Threat-generation engine with threats and risk-reduction strategies

The default template is called "SDL TM Knowledge Base" and gives you a basic set of elements and threat-generation capabilities. All you need is a basic understanding of data-flow diagrams and STRIDE.

### STRIDE recap

STRIDE is the acronym for the six major threat categories:

- **Spoofing**: pretending to be someone or something else
- **Tampering**: changing data without authorization
- **Repudiation**: not claiming responsibility for an action taken
- **Information disclosure**: seeing data without permission
- **Denial of service**: overwhelming the system
- **Elevation of privilege**: having permissions I shouldn't have

## Advanced user section

For more advanced users, you can customize the template across three main sections.

### Stencils

Process, external interactor, data store, data-flow, and trust boundaries make up the parent elements.

:::image type="content" source="../media/parentstencils.jpg" alt-text="Screenshot of Parent Stencils." loc-scope="other":::

You can also create child elements to help provide granularity for more context, actionable threat generation, and risk-reduction strategies.

:::image type="content" source="../media/expandedflowstencils.jpg" alt-text="Screenshot of Expanded Flow Stencils." loc-scope="other":::

#### Example of how child elements work

The **data-flow** parent element gives you the option to choose between the **HTTP** and **HTTPS** child elements.

HTTP should generate more threats because tampering, information disclosure, and spoofing threats are common with unencrypted channels.

##### Using HTTP

:::image type="content" source="../media/HTTP.JPG" alt-text="Screenshot illustrating the HTTP child element." loc-scope="other":::

##### Using HTTPS

:::image type="content" source="../media/HTTPS.JPG" alt-text="Screenshot illustrating the HTTPS child element." loc-scope="other":::

#### How to add element properties

If you have other properties that must be included in the default template, you can add them to each element in the administrator view.

:::image type="content" source="../media/StencilPropertiesAdmin.JPG" alt-text="Screenshot of the Stencil Properties Admin View." loc-scope="other":::

You can see the changes whenever you drag and drop that element onto the canvas.

:::image type="content" source="../media/StencilProperties.JPG" alt-text="Screenshot of the Stencil Properties User View." loc-scope="other":::

### Threat properties

Properties allow you to create fields that are filled out for each generated threat, just like stencil properties allow you to create fields for each element.

Remember: the goal is to have as much context as possible in the simplest manner.

#### Example of threat properties

##### Administrator view

Add fields that give you more context and actionable steps. Examples include:

- **Issue priority**: understand which issues need to be worked on first.
- **Hyperlinks**: link issues to online documentation.
- **External risk mapping**: speak the same risk language of other organizations by using reliable third-party sources, such as OWASP Top 10 and CWE Details.

:::image type="content" source="../media/ThreatAdminView.JPG" alt-text="Screenshot of the Threat Properties Admin View." loc-scope="other":::

##### User view

Threat Modeling Tool users see these changes whenever they analyze their data-flow diagrams.

:::image type="content" source="../media/ThreatUserView.JPG" alt-text="Screenshot of the Threat Properties User View." loc-scope="other":::

### Threats and risk reduction strategies

This section is the heart of the threat modeling tool. The threat-generation engine looks at individual and connected elements to decide which threats to generate.

#### How threat generation works

##### Step 1 - Specify sources and targets

The threat-generation engine uses simple sentences to generate a threat. Examples include:

- target is [element name]
- source is [element name]

You can also use the element name on titles and descriptions. The format is: '{target.Name}' or '{source.Name}'.

##### Step 2 - Combine sources and targets

You can be precise with the way a threat is generated. Combine targets, sources, and their individual properties with AND OR operators. Examples include:

- target.[property name] is 'Yes' **AND** source.[property name] is 'No'
- flow crosses [trust boundary name]

##### Step 3 - Generate or ignore threats

The threat-generation engine uses two fields to generate or ignore a threat:

- **Include**: A threat is generated if sentences added in this field are true.
- **Exclude**: A threat isn't generated if sentences added in this field are true.

Here's an actual example from the default template to bring these steps together:

- **Threat:** Cross Site Scripting
- **Include:** (target is [Web Server]) **OR** (target is [Web Application])
- **Exclude:** (target.[Sanitizes Output] is 'Yes') **AND** (target.[Sanitizes Input] is 'Yes')

The Cross Site Scripting threat in this example is **only** generated when:

- The process is either a Web Server or a Web Application
- Input and output aren't sanitized

:::image type="content" source="../media/IncludeExclude.JPG" alt-text="Screenshot of Include/Exclude view." loc-scope="other":::

> [!NOTE]
> Microsoft Threat Modeling Tool template creation is a complex topic and will not be fully discussed in this learning path.
