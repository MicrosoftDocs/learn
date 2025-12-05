Sensitivity labels in Microsoft Purview help control what data Microsoft 365 Copilot can access and how Copilot-generated content is classified. Labels don't apply to prompts or responses directly. Instead, they influence Copilot's behavior through how content is labeled before the interaction and the policies applied during output.

## Understand how labeling affects Copilot behavior

Copilot respects sensitivity labels on the content it accesses, and the way output is labeled depends on the app. Label behavior varies slightly across Microsoft 365 apps.

Here's what to expect:

- **Input access**: Copilot can only access content the user already has access to. If a document or email is labeled with encryption, Copilot can only read it if the user meets the access conditions defined in the label.
- **Output labeling**:

  - In **Word and Excel**, Copilot-generated content inherits the label already applied to the file.
  - In **Outlook**, users can manually select a label when sending a message that includes Copilot-generated content. Depending on your organization's configuration, default, mandatory, or auto-labeling policies might apply labels to drafts automatically.
  - In **Teams**, Copilot-generated replies follow the sensitivity label applied to the meeting or chat, not individual prompts.

Copilot doesn't apply or generate its own sensitivity label. If there's no label on the content it interacts with, the output won't include one unless it's applied by the app or an existing policy.

## Apply sensitivity labels to support Copilot

To manage how Copilot interacts with sensitive data:

- **Make sure content is labeled before Copilot accesses it**. Use default labeling or auto-labeling to classify content in advance.
- **Use encryption when needed**, keeping in mind that access to encrypted content depends on label policy conditions.
- **Define label behavior in Word and Excel**, where Copilot output inherits the document's label.
- **Set Outlook labeling requirements** if users need to manually apply labels to drafts that include Copilot-generated content.
- **Review Teams meeting and chat label settings**, since Copilot in Teams follows the session label.

All sensitivity label policies are configured in the **Information Protection** solution area of Microsoft Purview. You don't need to configure anything specific for Copilot. It's a good idea to test label behavior in the apps your users rely on and adjust your policies as needed.

> [!NOTE]
> If your organization doesn't have sensitivity labels and label policies in place, see [Create and configure sensitivity labels and their policies](/purview/create-sensitivity-labels?tabs=classic-label-scheme).

## Use DSPM for AI to recommend labeling

Data Security Posture Management (DSPM) for AI helps identify when sensitive content is accessed during Copilot interactions. DSPM for AI includes a recommendation to set up default sensitivity labels and policies if they haven't been configured yet. This step helps ensure that foundational protections are in place before Copilot is widely used across Microsoft 365 apps.

After labels and policies are created, manage them in **Information Protection**, where you can review label usage and update conditions as needed.
