Excel provides robust functionality for analyzing business data. However, interpreting large datasets—often containing thousands of rows—can be complex. In a sales role, users frequently download quarterly reports that include columns such as region, revenue, product, and sales representative.

Before you start prompting Copilot in Excel, it helps to understand how it interprets the information inside your workbook. Copilot doesn't "see" the whole sheet the way you do—it analyzes the structure of tables, headers, and data types to generate summaries, insights, and visuals.

In this unit, you'll learn how Copilot in Excel recognizes data patterns, responds to different prompt types, and provides contextual explanations so that your requests produce the best possible results.

## How Copilot "reads" your data

Copilot works best when your worksheet contains a clearly defined table with headers. It automatically infers the data type of each column—such as text, number, date—to guide the kind of summaries it can produce. It uses column headers as context clues: words like *Region*, *Revenue*, or *Product* help Copilot recognize how to group and summarize information.

If the dataset isn't formatted as a table, Copilot might prompt you to create one before generating insights.

## Prompt patterns Copilot understands

Copilot responds best to natural-language prompts that refer to specific columns or metrics. The table below shows common prompt types, what they do, and an example of each.

| **Prompt type** | **Description** | **Example** |
|:----------------|:----------------|:-------------|
| **Descriptive** | Summarizes or lists key values, totals, or categories in the data. | "Summarize total revenue by region." |
| **Comparative** | Compares one value or group against another to highlight differences or rankings. | "Which regions performed above average?" |
| **Diagnostic** | Looks for possible reasons or contributing factors behind a trend or result. | "Why did revenue drop in Q2?" |
| **Visual** | Creates or suggests a chart or graph to display summarized data. | "Create a bar chart of sales by region." |

>[!NOTE]
>Being explicit helps Copilot focus on the right part of the dataset. Vague requests like "Give me insights" might produce broad or irrelevant summaries.

## How Copilot explains results

When Copilot generates a response, it often includes short text explanations that describe what it found in your data. These summaries can highlight trends, averages, or exceptions, and sometimes include reasoning such as "The Central region generated the highest revenue."

Treat these statements as starting points: review them against the data and adjust any conclusions as needed.

You can copy summaries into new cells, reuse them in presentations, or refresh them as your data changes.

## Refining and iterating

After an initial response, you can ask follow-ups like: "Group the results by quarter," or "Show only the top five products."

Each prompt you give Copilot builds upon the ones before it. Copilot remembers the context of your earlier request, so you can refine your insights without starting over.

Suppose you ask Copilot, "Summarize revenue by region." It returns a short table showing total sales for each region and notes that the Central region performed best overall.

You can then refine the result by asking, "Add a column for quarter-over-quarter change," or "Sort this from highest to lowest." Copilot updates the output while keeping the context of your previous prompt.

If you need a more visual view, you could follow up with, "Create a chart that compares revenue by region." Copilot uses the same summarized data to build a bar chart directly in your worksheet.

Each follow-up helps you explore the data from a new angle—without starting from scratch—so you can move from a broad overview to specific insights in just a few steps.

## Limitations and good practices

For best results, keep these facts and practices in mind:

- Copilot summarizes *visible* data only—hidden rows or filtered-out items aren't included.
- It doesn't permanently change formulas or underlying structure unless explicitly told to.
- Avoid ambiguous prompts such as "Give me insights" without specifying columns or metrics.
- Clean headers and consistent units (for example, keeping all currency in USD) improve accuracy.
