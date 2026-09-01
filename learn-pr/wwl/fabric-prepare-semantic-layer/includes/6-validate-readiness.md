You designed the gold layer and configured Prep for AI controls. But a completed setup doesn't mean the semantic model is ready. Copilot might still use the wrong field, ignore a business rule, or return an unrelated visual. You need to test priority questions and confirm that each answer uses the right reasoning path before you mark the semantic model Approved for Copilot.

## Why testing matters

A correct number from the wrong measure can look right today and fail tomorrow when data changes. Approval means you trust the reasoning path, not just the output. If you approve without testing, every Copilot experience that uses your semantic model inherits untested behavior.

## How to test

Pick a small set of questions that business leaders use for decisions. For each question, write down the expected measure, dimensions, and filters before you ask Copilot.

| Test question | What a correct answer uses |
| --- | --- |
| Which category has the highest total sales? | `Total Sales`, product category, correct ranking |
| Which product is most profitable? | `Profit Margin` unless total profit is asked |
| How do sales compare by customer city? | Customer city, not a technical location field |

Ask each question several ways. Copilot can return different answers to the same question, so one correct response doesn't prove the semantic model works.

When an answer is wrong, expand **How Copilot arrived at this** in the Copilot pane to see which fields and filters Copilot selected. You can also select **Add to page** to add the visual to your report and inspect its fields directly. Find the earliest point where the answer went wrong, then choose the fix:

| What went wrong | What to fix |
| --- | --- |
| Wrong measure or entity | Improve the name, description, or relationship |
| Technical field in the answer | Remove it from the AI data schema |
| Unknown business phrase | Add a synonym |
| Missing business rule | Add a focused AI instruction |
| Stable question needs a set answer | Create a verified answer |

After each fix, close and reopen the Copilot pane, then ask the same question again. This confirms the fix works without breaking other answers.

## When to approve

Approve the semantic model only after priority questions consistently use the trusted definitions. Record what the semantic model doesn't cover so users don't treat it as an unlimited source of truth.

New measures, changed terms, and new user questions can change that boundary over time. Save failed prompts and their fixes as a regression set for future updates. **AI readiness is a release practice, not a one-time checklist.**

> [!TIP]
> If a test returns the right number from the wrong measure, does your review catch that problem before approval?
