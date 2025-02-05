Privacy assessments (preview) help organizations document and evaluate how personal data is used across business processes. A structured approach ensures consistency in data collection, supports privacy risk evaluation, and helps organizations track compliance.

Organizations can create assessments from templates or customize them to capture specific details about data use. Once published, assessments can be assigned to business assets, reviewed by designated stakeholders, and updated as needed to reflect evolving data practices. Risk settings can also be configured to assess privacy risks based on responses, providing a standardized way to measure potential concerns.

## Assessment management overview

Privacy Assessments are managed from the **Assessment management** page, where organizations can create, assign, and review assessments. This page includes three main sections:

:::image type="content" source="../media/assessment-management-page.png" alt-text="Screenshot showing the Assessment management page in Privacy Assessments." lightbox="../media/assessment-management-page.png":::

- **Assets tab**: Lists business assets (such as projects or business processes) that have been registered in Purview. From here, assessments can be assigned to specific assets.
- **Assessments tab**: Displays registered business assets (such as projects or business processes). Use this tab to assign assessments to specific assets and manage related privacy documentation.
- **Assessment responses tab**: Shows submitted responses with details such as assigned assets, completion status, and risk scores. Reviewers can evaluate responses and take action here.

## Creating assessments

When you create an assessment, you build a questionnaire that respondents complete and submit for review. Assessments can be customized to fit specific business needs, ensuring that privacy teams capture relevant details about data use.

### Before you create an assessment

Consider:

- **Assessment name and purpose**: What data use case does this assessment cover?
- **Reviewers and approvers**: Who will review submitted responses?
- **Risk settings**: Will the assessment measure privacy risks? If so, configure risk factors in the risk register.

### Steps to create an assessment

1. In **Privacy Assessments**, navigate to **Assessment management**.
1. On the **Assessments** tab, select **New assessment**, then choose:
   - **From template**: Use a predefined privacy assessment or data use inventory template.
   - **Custom**: Build a custom questionnaire.
1. Enter a **Name** and **Description**, then select **Next**.
1. At **Assign reviewers**, select users with the **Privacy Curator** role to review and approve responses.
1. Select **Create**.

Once created, the assessment opens in Edit Assessment, where you can add and configure questions.

## Building the assessment questionnaire

The questionnaire is the core of the assessment. You can add different question types, group them into sections, and configure logic to show or hide questions based on responses.

### Question types

- **Text**: Open-ended response.
- **Choice**: Single-select response with radio buttons.
- **Checkbox**: Multi-select response with checkboxes.
- **Date**: Date selection from a calendar.
- **Informational**: Provides guidance or links; doesn't require a response.

**Checkbox** questions default to multi-select but can be switched to single-select **(Choice)**.

## Configuring questions

Each question includes:

- **Prompt**: The question text respondents see.
- **Required answer**: Ensures a response is provided.
- **Attachments**:  Allows respondents to upload supporting files, up to six files, 5 MB each.
- **Risk settings**: Assigns risk levels to responses (if applicable).

The assessment editor provides options to add and configure questions. The example shows a text-based question with toggles for required responses, attachments, and risk settings.

:::image type="content" source="../media/assessment-editor.png" alt-text="Screenshot showing the assessment editor where users can configure question text, required answers, attachments, and risk settings." lightbox="../media/assessment-editor.png":::

## Applying logic to questions

Logic controls whether a question appears based on a previous response. To configure logic:

1. Select **Add logic** on a question.
1. Set conditions that determine when a question appears. For example, "If Question 3 is answered 'Yes,' show Question 4."
1. Choose whether to **Show** or **Hide** the question based on the conditions.

The screenshot shows an example of logic applied to an assessment question, where the "Assessment Concluded" question is only shown if the response to "Personal Data Use" is No.

:::image type="content" source="../media/logic-conditions-example.png" alt-text="Screenshot of an assessment question with logic conditions applied, showing how a question is displayed based on a previous response." lightbox="../media/logic-conditions-example.png":::

Use **Preview** at any time to test how the questionnaire behaves, including logic-based visibility settings.

## Assigning assessments to assets

Assigning assessments to assets links privacy evaluations to specific business operations. To assign an assessment:

1. In **Assessment management**, open the **Assessments** tab.
1. Select the assessment to open its details page.
1. Select **Assign**, then:
   - Select one or more assets.
   - Select one or more reviewers to approve submitted responses.
1. Select **Assign** to complete the process.

## Submitting and reviewing assessments

Asset owners receive an email with a link to complete the assigned assessment. The **Privacy** section of the asset lists all assigned assessments and their status.

### Submitting an assessment

1. Open the assigned assessment.
1. Complete all required questions.
1. Save progress if needed.
1. Select **Submit** when ready.

### Reviewing and approving assessments

Reviewers receive email notifications when an assessment is submitted. To review an assessment:

1. Open the assessment from the **Assessment responses** tab.
1. Review answers and check the **Risk score** panel.
1. Choose **Approve** or **Decline**.

If declined, the respondent can update responses and resubmit.

## Configuring risk settings

Risk settings define the risk factors organizations want to assess. These settings influence the Risk score, which helps privacy teams evaluate potential data risks.

### Defining risk factors

1. In **Privacy Assessments**, navigate to the **Risk register**.
1. Select **Risk settings**, then **Add risk factor**.
1. Enter a **Category name**, **Description**, and assign a **Risk rating** (Low, Medium, or High).

### Assigning risk levels to questions

For **Choice** and **Checkbox** questions, assign a risk level (No risk, Low, Medium, or High) to each response. For **Text** questions, risk is determined during assessment review.

## Understanding risk scores

Risk scores quantify potential privacy risks based on assessment responses.

- Assign a maximum possible risk score to each question with a risk factor.
- Calculate the total risk score based on respondents' selections.
- Determine the final score as a percentage of the maximum possible risk.

Risk levels are categorized as:

| Score Range | Risk Level |
|-----|-----|
| 1 - 3 | Low |
| 4 - 7 | Medium |
| 8 - 10 | High|

Risk scores help organizations quantify potential privacy risks, making it easier to prioritize mitigation efforts.

## Exporting an assessment response

Export assessment results as a **Word** or **PDF** file for auditing and compliance reporting.

1. In **Assessment management**, open the **Assessment responses** tab.
1. Select the response you want to export.
1. Select **Export** response and choose the file format.

The file downloads immediately for external sharing.

## Next steps

Once assessments are in place, organizations can:

- **Monitor assessment responses** to ensure privacy compliance.
- **Adjust risk settings** based on changing business needs.
- **Automate privacy rules** to streamline assessment assignments.

Regularly reviewing assessments ensures organizations stay aligned with evolving privacy requirements.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
