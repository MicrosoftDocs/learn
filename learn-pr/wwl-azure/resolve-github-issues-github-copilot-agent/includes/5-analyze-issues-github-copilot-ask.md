Unit 5: Analyze issues using GitHub Copilot's Ask mode

Purpose: Teach learners how to effectively use GitHub Copilot Chat to diagnose and fix issues. This unit bridges the gap between knowing there’s a problem and actually writing the solution. We break it into using Ask Mode (understanding & planning) and Agent Mode (coding the fix) – essentially problem-solving with Copilot.

## Overview of GitHub Copilot Chat in VS Code: Give a quick intro to the Copilot Chat interface. (If possible, include a screenshot or diagram of the VS Code sidebar with Copilot Chat, but since we are text-only, a description must do.)

- Ask Mode (Chat Q\&A): You ask questions about the code or for guidance. It’s like searching the web or Stack Overflow, but context-aware about your code. The answer appears in the chat panel. Emphasize that Copilot’s answers are based on patterns it learned; it doesn’t guarantee correctness, but often it’s very accurate and can cite examples.

- Agent Mode (Task/Command mode): You instruct Copilot to make changes (“fix this”, “refactor that”). It will modify your code directly (showing a diff first). This is relatively new and powerful – essentially an AI doing the edit for you under your supervision. It uses the context of your open workspace.

## Using Ask Mode for Issue Diagnosis

Reinforce what was practiced: reading an issue and then asking Copilot targeted questions.

o	Give examples of good questions to ask:

	“What does this function do?” (for quick understanding of unfamiliar code).

	“Is there a security issue with how variable X is used here?” (Copilot might catch something).

	“How can I do Y in C#?” (for when you know what you need to do conceptually, e.g., parameterize a query, but not the exact syntax).

	“Why is approach X not secure?” (like we did with MD5).

o	Tip from experience: “Be specific in your questions. If you ask a vague question, you might get a vague answer. Mention the context – Copilot has the file open so it knows the code around, leverage that.”

o	Copilot can also summarize issues: If an issue description is long or code is complex, you can ask Copilot to summarize it to ensure you understood correctly. This can be a time-saver.

o	Mention limitations: Sometimes Copilot might miss context or be uncertain. For critical decisions, double-check its advice. (In our lab, it gave correct advice for all our queries. In real life, if you ask “Is this code secure?”, it might say "looks okay" even if subtle issues exist – use it as a helper, not an oracle.)

o	Encourage an iterative approach: “Often I’ll have a conversation with Copilot: first I ask what’s wrong with the code, then maybe how to fix it, perhaps even ask for a code example. Treat it like a knowledgeable peer.”
