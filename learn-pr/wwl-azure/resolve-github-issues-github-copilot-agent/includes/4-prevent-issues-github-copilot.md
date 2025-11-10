Unit 4: Prevent issues using GitHub Copilot

(Coding with Copilot and Expert Techniques)

Purpose: Shift the mindset from reactive (fixing issues) to proactive (avoiding issues). This unit highlights how to incorporate Copilot and secure coding practices into daily development so that fewer issues get created in the first place.

## Proactive Mindset – “Build security in”

Start with an expert mantra: “The cheapest bug to fix is the one you never introduce.” Emphasize that while it’s great to know how to fix issues quickly, it’s even better if they don’t occur. This is where planning, good habits, and tools like Copilot can help during coding and code review.

## Copilot as a Coding Partner

Encourage using Copilot from the start of writing new code:

- Writing Secure Code from Scratch: When you start a new function or feature, communicate intent in comments. E.g., // Query database for user by name using parameterized query. Copilot will likely complete with a safe pattern. Another: // Hash the password using a secure method might prompt it to produce a bcrypt example. Essentially, you’re leveraging AI to get best-practice templates. The expert insight: “AI has been trained on millions of code examples. By nudging it in the right direction, you can often get it to write the secure version of code by default. This saves time and also teaches you by example.”

- Continuous Validation: You can also ask Copilot while coding: “Is there a potential flaw in this approach?” or “What input validation should I add here?” It’s like having a mentor doing a real-time code review.

- Custom Instructions: Mention that Copilot has a feature where you can set your preferences (Copilot settings allow you to say things like “always use braces in if statements” or even “prefer secure coding practices”). A lead dev might ensure team-wide instructions like “avoid using obsolete crypto or risky functions” – Copilot will then bias away from those. Not all learners may use this feature, but it’s good to know for advanced usage.

## Coding Standards and Linters

Point out that aside from Copilot, teams use linters and code analysis tools to enforce standards. For security, tools like ESLint (.NET analyzers, etc.) can catch some issues. Copilot is complementary: it helps you write code that likely already passes those checks. It reduces the back-and-forth.

A practical scenario: “Our team’s style guide forbids using String.Concat with untrusted input for SQL. If I start doing that, CodeQL or Roslyn analyzer would flag it in a PR. But Copilot, by following my comment to use parameters, helps me avoid that violation in the first place.”

## Preventive Measures Highlight Reel

Recap a few key secure coding practices as general advice:

- Validate inputs (length, format, whitelist where possible) – e.g., if expecting an email, ensure it matches an email regex before proceeding. Copilot can help write validation code if you prompt it.

- Principle of least privilege – only give your code the access it needs (e.g., if your app only needs read access to a directory, don’t run it as an admin). Not directly Copilot’s domain, but an expert tip.

- Use safe libraries – rather than writing your own crypto or SQL drivers, use well-tested ones (Entity Framework parameterizes by default, for instance). You can ask Copilot to implement using those libraries for you.

- Write unit tests for critical paths – if you have a regex or input filter, have tests for malicious inputs. Copilot can even generate some test cases if asked (for example, “write xUnit tests for ValidatePath function” and it might produce a few).

## Copilot in Code Reviews (Prevention Angle)

Encourage using Copilot’s code review features. GitHub now has an experimental “Copilot for Pull Requests” that can auto-review code changes and point out potential issues. An expert would certainly run static analysis, but having an AI highlight “Hey, this new code creates a SQL string, did you mean to parameterize it?” is like a safety net. If the learner’s company enables that, it’s a fantastic proactive tool.

Even without that, the learner can copy a diff into Copilot Chat and ask, “Any security concerns with this change?” and see what it says. It’s like consulting a second pair of eyes instantly.

## Performance and Other Issues

Acknowledge that Copilot can help prevent non-security issues too (like performance pitfalls). For instance, if you start writing an inefficient algorithm, Copilot might suggest a more optimal approach it’s seen. So generally, it can raise code quality. But caution that one should still understand and test the code – don’t accept a suggestion blindly because it might trade one problem for another if you’re not careful.

## Keeping Up-to-Date

An expert knows that best practices evolve. Copilot’s training is periodically updated (though not instantaneous). So verify against official docs when in doubt. E.g., if tomorrow a new hashing algorithm supersedes bcrypt, Copilot might not know it immediately – staying informed through communities or MS Learn content is still important. Essentially, Copilot is a helper, not a substitute for continuous learning.
