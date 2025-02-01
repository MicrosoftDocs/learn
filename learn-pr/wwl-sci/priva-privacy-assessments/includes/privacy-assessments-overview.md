Organizations need a structured way to track and document how personal data is used across their data estates. Many organizations rely on manual, time-consuming processes like updating questionnaires or monitoring data use manually. These processes make it harder for privacy teams to keep up as data practices evolve. As a result, privacy impact assessments might become outdated or fail to reflect current data practices.

**Microsoft Priva Privacy Assessments (preview)** helps address these challenges by automating the discovery, documentation, and evaluation of personal data use. This solution allows organizations to automate privacy assessments and build a complete compliance record for responsible data use. With custom privacy risk frameworks and rules, organizations can identify potential risks and trigger assessments automatically when data processing changes are detected in the Data Map.

## Prerequisites

Before using Privacy Assessments, ensure that your organization has access to the [Microsoft Purview Data Map](/purview/concept-elastic-data-map). Privacy Assessments rely on data relationships defined in Data Map to trigger assessments when processing activities change.

## Key terms and concepts

Understanding key terms helps you navigate Privacy Assessments effectively.

| Term | Description |
|-----|-----|
| Assessment | A structured questionnaire used to document a specific data use case. Users can build custom assessments or use built-in templates. |
| Privacy Rule | A logic-based rule that evaluates data in the Data Map and triggers an assessment if a specific condition is met. |
| Logical Business Asset | A concept representing data usage (for example, projects, business processes) rather than physical data like tables or databases. |
| Assessment Response | The documentation and approval process for an assigned assessment. Business stakeholders complete and submit responses for review. |
| Related Physical Data | Technical and physical data assets (such as servers, databases, schemas, and tables) that are associated with a privacy assessment. |

## Privacy assessment scenarios

Privacy assessments help organizations monitor data use, evaluate risk, and document compliance.

As a privacy professional, you can:

- **Automate privacy assessments**: Create custom assessments to capture critical information about data usage.
- **Monitor personal data usage**: Set up privacy rules that track changes in the Data Map and trigger assessments when needed.
- **Evaluate privacy risks**: Use a custom privacy risk framework to assess risks based on structured assessments.

Other compliance stakeholders, like business owners and engineers, can:

- Register and model personal data use in the Microsoft Purview Unified Catalog, using projects to track business assets like applications and processes.
- Define relationships between business assets (representing data use) and physical data assets (like databases or tables).
- Complete and submit assessment responses that document personal data usage and compliance.

## What you see in Privacy Assessments

The **Overview page** provides quick access to setup tasks and key actions.

:::image type="content" source="../media/privacy-assessments-overview.png" alt-text="Screenshot showing the overview page for Privacy Assessments." lightbox="../media/privacy-assessments-overview.png":::

**Setup tasks**:

A list of recommended setup tasks appears when you first access Privacy Assessments. Tasks remain visible for two weeks after completion.

**Create new**:

From this section, you can quickly create new privacy assessments and privacy rules to automate compliance tracking.

Once you're familiar with how Privacy Assessments work, the next step is to configure and deploy assessments in your organization.
