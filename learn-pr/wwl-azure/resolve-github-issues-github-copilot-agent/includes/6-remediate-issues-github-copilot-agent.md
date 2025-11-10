Unit 6: Remediate issues using GitHub Copilot's Agent mode

Purpose: Guide learners on using GitHub Copilot Agent to automatically remediate identified issues. This unit focuses on leveraging the Agent mode to implement fixes efficiently, building on the analysis skills from the previous unit.

## Using Agent Mode for Implementing Fixes

Now outline how to effectively instruct Copilot to make changes.

o	Emphasize the need to set the stage. The code should be open and you might highlight a portion or at least ensure Copilot “knows” where you want changes. Copilot’s suggestions are scoped to what it sees.

o	Provide tactics for prompting:

	Goal-oriented prompts: e.g., “Optimize this function” or “Fix the vulnerability here by doing X.” In the lab, we did “Refactor to use parameterized queries” etc. Being direct is usually best.

	Incremental changes: For complex fixes, do it in pieces. “Don’t ask Copilot to overhaul the entire file in one go if you can help it. Tackle one issue at a time. That way, if something goes wrong, it’s easier to pinpoint.” Just like you wouldn’t ask a junior dev to fix ten bugs at once, give Copilot one task at a time.

	Review diffs carefully: The unit should teach that even though Copilot writes code, you are the code reviewer. “Always inspect the diff line-by-line. Ensure it did what you intended. I’ve seen Copilot occasionally change something unrelated – rarely, but it can happen if it misunderstood. Don’t blindly accept changes.” This instills that professional caution.

	Editing Copilot’s suggestions: It’s okay to tweak the code after Copilot writes it. Maybe it used a different variable name or slightly off logic. A senior dev would then either edit manually or even ask Copilot to refine: “Actually, use this approach instead…”. Copilot remembers the conversation context, so you can correct or guide it further.

	Dealing with Copilot uncertainty: Sometimes Copilot might say “I’m not sure” or not produce a perfect fix. Encourage trying rephrasing the request or breaking it down. If Copilot suggests something odd, the expert advice is: “Trust but verify – if it looks wrong, ask Copilot why it chose that. You can literally ask: ‘Explain this change.’ If it can justify, great; if it reveals a misunderstanding, then adjust your prompt.”

o	Possibly mention alternative flows: You can also just start coding and use Copilot’s autocomplete. E.g., type SqlCommand cmd = new SqlCommand( and Copilot might finish the line with a parameter query. This is Copilot’s original completion ability (which many have used). Chat aside, sometimes just writing a comment and waiting is enough for Copilot to inline-suggest the code. This unit could briefly acknowledge that: “Copilot can also suggest code as you type. In fact, the lab fix for password hashing could have been done by writing a comment // hash password securely and Copilot might complete it with a secure implementation.” However, Copilot Chat is our focus, which is more interactive.

## Integrating with Git Workflow: It might be worth noting that Copilot can even help in writing commit messages or PR descriptions by summarizing changes (like the GitHub blog example of formatting data into a table, or summing up a diff). That’s a bit beyond fixing code, but for completeness: “After fixing, consider asking Copilot to draft a succinct commit message: it often does a decent job summarizing the change.” This adds a nice polish to the workflow where AI helps not only in coding but in documentation.

Expert Reassurance: Some learners might worry “Am I cheating by using Copilot? Will I actually learn?” Address this. The expert voice can say: “Using Copilot is not cheating; it’s leveraging a tool to be more efficient. You still have to understand the problem and verify the solution. In fact, as you use it, you’re reinforcing your knowledge. When Copilot suggests a parameterized query, you’re seeing an example of best practice code. Over time, you internalize these patterns.” Also, mention that most professional developers now use things like Copilot or at least look up solutions – knowing how to use these resources is a skill in itself. We’re effectively training that skill in this module.

## When Not to Rely on Copilot

Briefly, an expert would caution that if something is truly critical or sensitive (say, crypto code for production), you’d want to double-check with documentation or a security review. Copilot gets you 90% there fast, but that last 10% – making sure it’s perfect for your scenario – is your job. In the lab, our stakes are low, but in real life, treat Copilot’s output as if it were written by a colleague – likely good, but not infallible.
