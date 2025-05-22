## Quick overview

The Microsoft Threat Modeling Tool, recognized by the threat-modeling community, helps engineers create data-flow diagrams. It offers customizable templates and a threat-generation engine with threats and risk-reduction strategies.

The default template is called *SDL TM Knowledge Base* and gives you a basic set of elements and threat-generation capabilities. All you need is a basic understanding of data-flow diagrams and STRIDE.

### STRIDE

STRIDE is a model that categorizes security threats to help identify them. The Microsoft Threat Modeling Tool helps apply STRIDE for threat-modeling work. STRIDE is the acronym for the six major threat categories:

- **Spoofing**: Pretending to be someone or something else.
- **Tampering**: Changing data without authorization.
- **Repudiation**: Not claiming responsibility for an action taken.
- **Information disclosure**: Seeing data without permission.
- **Denial of service**: Overwhelming the system.
- **Elevation of privilege**: Having permissions I shouldn't have.

With this in mind, you can customize your template across the areas we'll discuss next in stencils, threat properties, and risk reduction strategies.

### Stencils

Stencils are made up of parent stencils that include process, external interactor, data store, data-flow, and trust boundaries. They can be drag-and-dropped onto your canvas to build your data-flow diagram.

:::image type="content" source="../media/parentstencils.jpg" alt-text="Screenshot of Parent Stencils." loc-scope="other":::

You can also create child stencils to help provide granularity for more context, actionable threat generation, and risk-reduction strategies.

:::image type="content" source="../media/expandedflowstencils.jpg" alt-text="Screenshot of Expanded Flow Stencils." loc-scope="other":::

#### Example of how child elements work

The **data-flow** parent element gives you the option to choose between the **HTTP** and **HTTPS** child elements. HTTP should generate more threats because tampering, information disclosure, and spoofing threats are common with unencrypted channels. Following are images of using HTTP vs. HTTPS.

:::image type="content" source="../media/HTTP.JPG" alt-text="Screenshot illustrating the HTTP child element." loc-scope="other":::

:::image type="content" source="../media/HTTPS.JPG" alt-text="Screenshot illustrating the HTTPS child element." loc-scope="other":::

#### Add element properties

If you have other properties that must be included in the default template, you can add them to each element in the administrator view.

:::image type="content" source="../media/StencilPropertiesAdmin.JPG" alt-text="Screenshot of the Stencil Properties Admin View." loc-scope="other":::

You can see the changes whenever you drag and drop that element onto the canvas.

:::image type="content" source="../media/StencilProperties.JPG" alt-text="Screenshot of the Stencil Properties User View." loc-scope="other":::

### Threat properties

These properties allow you to create fields that are filled out for each generated threat, just like stencil properties allow you to create fields for each element. Remember, the goal is to have as much context as possible in the simplest manner.

### Administrator and User Views

Administrators can add fields that give you more context and actionable steps. Examples include:

- **Issue priority**: Understand which issues need to be worked on first.
- **Hyperlinks**: Link issues to online documentation.
- **External risk mapping**: Speak the same risk language of other organizations by using reliable third-party sources, such as OWASP (Open Worldwide Application Security Project) Top 10 and CWE (Common Weakness Enumeration) Details.

:::image type="content" source="../media/ThreatAdminView.JPG" alt-text="Screenshot of the Threat Properties Admin View." loc-scope="other":::

Then in the User view, the Threat Modeling Tool users see changes whenever they analyze their data-flow diagrams.

:::image type="content" source="../media/ThreatUserView.JPG" alt-text="Screenshot of the Threat Properties User View." loc-scope="other":::

### Threats and risk reduction strategies

This section is the heart of the threat modeling tool. The threat-generation engine looks at individual and connected elements to decide which threats to generate.

**Step 1 specifies sources and targets**. The threat-generation engine uses simple sentences to generate a threat. Examples include *target is [element name]* and *source is [element name]*. You can also use the element name on titles and descriptions. The format is *{target.Name}* or *{source.Name}*.

**Step 2 combines sources and targets**. You can be precise with the way a threat is generated. Combine targets, sources, and their individual properties with AND/OR operators. Examples include:

- target.[property name] is 'Yes' **AND** source.[property name] is 'No'
- flow crosses [trust boundary name]

**Step 3 generates or ignores threats**. The threat-generation engine uses two fields to generate or ignore a threat:

- **Include**: A threat is generated if sentences added in this field are true.
- **Exclude**: A threat isn't generated if sentences added in this field are true.

Here's an actual example from the default template to bring these steps together:

- **Threat**: Cross Site Scripting
- **Include**: (target is [Web Server]) **OR** (target is [Web Application])
- **Exclude**: (target.[Sanitizes Output] is 'Yes') **AND** (target.[Sanitizes Input] is 'Yes')

The Cross Site Scripting threat in this example is only generated when the process is either a Web Server or a Web Application and Input and output aren't sanitized.

:::image type="content" source="../media/IncludeExclude.JPG" alt-text="Screenshot of Include/Exclude view." loc-scope="other":::

> [!NOTE]
> Microsoft Threat Modeling Tool template creation is a complex topic and won't be fully discussed in this learning path.
