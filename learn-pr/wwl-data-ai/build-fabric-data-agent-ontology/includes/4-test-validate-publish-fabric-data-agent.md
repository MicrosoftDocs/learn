An answer that sounds plausible isn't sufficient evidence that a data agent retrieves the right data. For the Lamna Healthcare scenario, you validate source selection, query logic, and expected results before you publish the agent.

## Establish expected answers

Start with a small benchmark of representative questions. For each question, record an expected query and answer that you verify directly against the relevant source. Microsoft's [iterative improvement guidance](/fabric/data-science/develop-iterative-process-data-agent) recommends this question, expected-query, and expected-answer structure.

Choose questions that test different parts of the scenario:

- "Which rooms belong to the Surgical Services department?" tests entity mappings and department filtering.
- "How many rooms in that department have a current patient assignment?" tests relationships and counting logic.
- "Which equipment readings fall within this specified time interval?" tests source selection and time filters.

These are question patterns, not assertions that a particular dataset contains a particular answer. Define the department and time interval explicitly in your benchmark. Derive the expected result from the sample data rather than accepting the agent's first response as the reference.

For a count, specify what one counted item represents. If a join returns several assignment records for one room, counting rows can differ from counting distinct rooms. A correct-looking number doesn't replace checking that logic.

Retain previously successful questions when you change the configuration. Retesting them helps you detect whether a correction for one question creates a problem for another.

## Inspect queries and ontology context

Use the [documented response-debugging workflow](/fabric/data-science/data-agent-ontology-sources#debug-a-response):

1. Run a benchmark question in the agent's test experience.
1. Open the run steps and identify the selected underlying source.
1. Inspect the generated SQL, KQL, or DAX query and any source errors.
1. Run or inspect that query against the underlying source.
1. Compare the returned data with the expected result.

:::image type="content" source="../media/fabric-data-agent-inspect-query.png" alt-text="Screenshot of Data agent test pane with an answer  and the expanded run step showing the generated SQL query and its output.":::

Check the objects, join paths, filters, and aggregations, not just the displayed answer. For a department count, verify the department filter and the definition of occupancy. For readings, verify the time range. Run steps help you inspect the source interaction, but they don't establish that the business interpretation is correct.

If the query refers to an unexpected object or omits a recent definition, inspect the context available to the agent:

1. Open the ontology's more-options menu in the data agent.
1. Select **Download ontology context**.
1. Review its entities, properties, relationships, definitions, synonyms, mappings, and bindings.
1. Select **Refresh** if the context doesn't reflect the intended ontology changes.
1. Test the question again.

:::image type="content" source="../media/fabric-data-agent-download-ontology-context.png" alt-text="Screenshot of the Data agent Explorer pane with the ontology more-options menu open and Download ontology context highlighted.":::

The downloaded context is read-only. Editing the downloaded file doesn't change agent behavior. Make shared semantic corrections in the ontology, refresh its context in the agent, and retest. Without a manual refresh, the agent retrieves the latest context every 10 minutes.

## Correct the source of the problem

Choose a correction based on what your checks reveal. More agent instructions aren't the answer to every failure.

| Observation | Appropriate investigation |
| --- | --- |
| Wrong underlying source | Check ontology mappings and bindings, plus source descriptions and instructions |
| Wrong business interpretation | Check definitions, synonyms, relationships, and relevant instructions |
| Wrong join, filter, or aggregation | Compare the query with source schema and verified query examples |
| Correct query but missing results | Check source data and the requesting user's permissions |
| Recent ontology changes are absent | Refresh the ontology context and retest |

For eligible mounted sources, source instructions explain query details, and example queries demonstrate verified patterns. Keep these additions specific to the source. Correct an organization-wide definition or binding in the ontology rather than masking it with an agent-only workaround.

After a change, rerun the affected question and the rest of your benchmark. Compare both the generated query and the answer. If a question remains ambiguous, clarify it instead of assuming that a longer instruction produces the intended interpretation.

## Publish and share the agent

When your benchmark results meet the scenario's requirements, select **Publish**. Include a description of the agent's purpose and supported questions. The description helps people understand the agent and helps automated systems decide when to invoke it. It doesn't itself configure an external integration.

Publishing produces a published version while leaving the draft available for continued refinement. Changes to the draft don't affect the published version until you publish updates. Switch between draft and published versions to compare the same benchmark questions.

This version separation doesn't freeze the underlying data. Continue to validate the business definitions, source data, and access relevant to the questions.

When you share the agent, choose the appropriate additional permissions:

- **No additional permission selected** allows recipients to query only the published version, without viewing its configuration.
- **View details** allows recipients to inspect the configurations and query the draft and published versions, without editing them.
- **Edit and view details** allows recipients to view and edit the configurations and query both versions.

For ontology-backed queries, recipients also need access to the ontology item and the underlying sources required by their questions. A shared agent link doesn't supply those permissions. A recipient who lacks source access can encounter an authorization error or empty results.

Check access using the intended recipient's permissions, rather than treating a successful author test as proof that every colleague has access. Grant only the source permissions required for the task. For example, queries through a data agent require Read permission on a Power BI semantic model, not Build permission.

For versioning and source-specific access requirements, see [Fabric data agent sharing and permission management](/fabric/data-science/data-agent-sharing).
