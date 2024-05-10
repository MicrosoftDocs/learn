The GitHub Copilot extensions help developers write code faster and with fewer errors. But GitHub Copilot is an AI pair programmer, it's not a programmer. To get the most out of the GitHub Copilot tools, you need to understand what the GitHub Copilot tools need from you.

### Get the most out of Copilot inline suggestions

The GitHub Copilot extension presents suggestions automatically to help you code more efficiently. GitHub Copilot provides better suggestions when you follow certain actions and behaviors. You may already be following some of these actions and behavior, since they help you and your colleagues understand your code.

#### Provide context to Copilot

Copilot works best when it has sufficient context to know what you're doing and what you want help with. Just as you would provide a colleague with the context when asking for help with a specific programming task, you can do the same with Copilot.

#### Open files

For code completions, Copilot looks at the current and open files in your editor to analyze the context and create appropriate suggestions. Having related files open in VS Code while using Copilot helps set this context and lets the Copilot see a bigger picture of your project.

#### Top level comment

Just as you would give a brief, high-level introduction to a coworker, a top level comment in a code file can help Copilot understand the overall context of the code you're creating.

#### Appropriate includes and references

It's best to manually set the includes or module references you need for your work. Copilot can make suggestions, but you likely know best what dependencies you need to include. This can also help let Copilot know what frameworks, libraries, and their versions you'd like it to use when crafting suggestions.

#### Meaningful function names

Just as a method called fetchData() won't mean much to a coworker (or you after several months), fetchData() won't help Copilot either. Using meaningful function names helps Copilot provide a body that does what you want.

#### Specific and well-scoped function comments

A function name can only be so descriptive without being overly long. Function comments can help fill in details that Copilot might need to know.

#### Prime Copilot with sample code

One trick to get Copilot on the right page, is to copy and paste desirable code samples into an open editor tab. The sample should represent the code that you want Copilot to emulate. Providing an example can help Copilot generate suggestions that match the language and tasks you want it to emulate. Once Copilot has helped you create some code that matches your goal, you can delete the sample code. This approach is especially helpful when you need to "train" Copilot. For example, suppose Copilot defaults to suggesting code snippets that implement an older version of a library. You can insert code into your project that uses the latest version of the library. This helps Copilot to begin suggesting code snippets that use the latest version of the library. Once Copilot has learned to use the new library version, you can delete the sample code.

#### Be consistent and keep the quality bar high

Copilot is going to latch on to your code to generate suggestions that follow the existing pattern, so the adage "garbage in, garbage out" applies.

Always keeping a high quality bar can take discipline. Especially when you're coding fast and loose to get something working, you might want to disable Copilot completions while in "hacking" mode. You can temporarily disable completions from the Copilot status menu. Bring up the Copilot status menu dropdown by selecting the Copilot Status bar item.

### Get the most out of Copilot Chat

When you're using chat to interact with GitHub Copilot, there are several things you can do to optimize your experience.

#### Use chat participants, slash commands, and chat variables

Chat participants are designed to collect extra context either about a code base or a specific domain or technology. When you specify the appropriate participant, Copilot Chat can find and provide better information to send to the Copilot backend. For example, use `@workspace` when you ask questions about your open project, or `@vscode` when you ask questions about Visual Studio Code features and APIs.

Slash commands help Copilot Chat understand your intent when you ask a question. Are you learning about a code base (`/explain`), do you want help with fixing an issue (`/fix`), or are you creating test cases (`/tests`)? By letting Copilot Chat know what you're trying to do, it can tune its reply to your task and provide helpful commands, settings, and code snippets.

Chat participants, such as `@workspace` or `@vscode`, can contribute chat variables that provide domain-specific context. You can reference a chat variable in your chat prompt by using the `#` symbol. You can use chat variables to be more specific about the context of your prompt.

For example, the `#file` variable lets you reference specific files from your workspace in your chat prompt. This helps make the answers from Copilot Chat more relevant to your code by providing context about the file you're working with. You can ask questions like "`Can you suggest improvements to #file:package.json?`" or "`How do I add an extension in #file:devcontainer.json?`". Using the `#file` variable can help you get more targeted and accurate responses from Copilot.

#### Be specific and keep it simple

When you ask Copilot to do something, be specific. Break large tasks into a series of smaller tasks. For example, don't ask Copilot to `create an Express app, that uses TypeScript and Pug, and that has a products page that retrieves data from a MongoDB database.` Instead, first ask Copilot to `create the Express app with TypeScript and Pug`. Next, ask Copilot to `add a products page`, and finally ask Copilot to `retrieve the customer data from a database`.

When you ask Copilot to perform a task, be specific about the inputs, outputs, APIs, or frameworks that you want to use. When you specify specific details in your prompt, you have a better chance of getting the result you want. For example, instead of "`read product data from the database`", use "`read all products by category, return the data in JSON format, and use the Mongoose library`".

#### Iterate on your solution

When asking Copilot Chat for help, you aren't stuck with the first response. You can iterate and prompt Copilot to improve the solution. Copilot has both the context of the generated code and also your current conversation.
