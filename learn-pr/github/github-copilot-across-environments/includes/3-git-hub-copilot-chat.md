GitHub Copilot Chat is an advanced feature of the GitHub Copilot ecosystem, designed to provide developers with an interactive, conversational AI assistant directly within their development environment.It allows developers to have natural language conversations about their code, ask questions, and receive intelligent responses and suggestions in real-time.
In this unit, we’ll cover:

- How to generate code using GitHub Copilot Chat.
- Debugging using GitHub Copilot Chat.
- How to get code explanations using GitHub Copilot Chat.
- Using slash commands to perform actions with GitHub Copilot.
- Using custom GitHub Copilot agents to improve prompts.

To access Copilot in your IDE, click the chat icon on the left navbar.

:::image type="content" source="../media/chat.png" lightbox="../media/chat.png" alt-text="Screenshot of Chat.":::

GitHub Copilot Chat is particularly beneficial in certain scenarios:

- **Complex code generation**
  When you need to implement complex algorithms, data structures, or generate boilerplate code for specific design patterns, Copilot Chat can help streamline the process. It can assist in creating intricate regular expressions, constructing detailed SQL queries, or developing advanced data structures like a Bubble sort in Python. 

  :::image type="content" source="../media/chat-code-generation.png" alt-text="Screenshot of chat code generation." lightbox="../media/chat-code-generation.png" :::

- **Debugging assistance**
  If you encounter errors in your code, Copilot Chat can be valuable in analyzing error messages and suggesting potential fixes. It can help identify logical errors and provide step-by-step explanations of problematic sections of code. 
  One way to achieve this is by using Copilot inline-chat by highlighting the piece of code containing the error, right clicking and selecting Copilot, then inline-chat. 
  
  :::image type="content" source="../media/selection-code-chat-debugging.png" lightbox="../media/selection-code-chat-debugging.png" alt-text="Screenshot of selection code chat debugging.":::

  For example, you might ask, "I'm getting a `NullReferenceException` in this method. Can you help me debug it?"

  :::image type="content" source="../media/generating-code-chat-debugging.png" alt-text="Screenshot of generating code chat debugging.":::
  
- **Code explanations**
  Copilot Chat can also be used to better understand complex code snippets. It can break down code into simpler terms, explain the purpose and functionality of unfamiliar code, and offer insights into best practices and potential optimizations. For example, you could ask: - "Can you explain how this async/await code works in Python?"

  :::image type="content" source="../media/chat-code-explanations.png" lightbox="../media/chat-code-explanations.png" alt-text="Screenshot of chat code explanations.":::


## How to improve GitHub Copilot Chat responses
You can significantly improve the quality and relevance of GitHub Copilot Chat's responses with certain key features. Let's dive into them.

### Scope referencing

To enhance the accuracy and relevance of the responses provided by GitHub Copilot Chat, it’s important to properly scope your questions using references. Here’s how you can do that:

- **File references:** You can specify a particular file in your question by adding a `#file:` before the file name. 

  :::image type="content" source="../media/chat-scope-file-referencing-pick.png" lightbox="../media/chat-scope-file-referencing-pick.png" alt-text="Screenshot of chat scope file referencing pick.":::

  For example, if you’re working with a file named `controller.js`, you can use the #file command to select it and reference it directly in your question as `#file:controller.js`. This tells Copilot Chat to focus on the contents of that file when generating a response.

  :::image type="content" source="../media/chat-scope-file-referencing.png" lightbox="../media/chat-scope-file-referencing.png" alt-text="Screenshot of chat scope file referencing.":::

- **Environment References:** You can reference the entire solution or workspace by using `@workspace`. This allows Copilot Chat to consider the broader context of the projects and configurations that are currently open in your Visual Studio IDE. For instance, asking "@workspace where is the calculate function?" will prompt Copilot to consider the entire solution to find the most relevant information.

  :::image type="content" source="../media/chat-scope-workspace-referencing.png" lightbox="../media/chat-scope-workspace-referencing.png" alt-text="Screenshot of chat scope workspace referencing.":::

### Slash commands

Slash commands in GitHub Copilot Chat allow you to quickly specify the intent of your query. This can significantly improve the quality of the responses you receive by making your requests more focused. Here are some commonly used slash commands:

- **/doc:** Adds comments to the specified or selected code. For example, you can type `/doc` followed by the code you want to document, and Copilot will generate appropriate comments.

  :::image type="content" source="../media/doc-slash-commands.png" lightbox="../media/doc-slash-commands.png" alt-text="Screenshot of /doc slash commands.":::

- **/explain:** Provides explanations for selected code. This is particularly useful when you need to understand what a particular piece of code does. For example, `/explain the #file:controller.js` will give you a detailed explanation of that file.

  :::image type="content" source="../media/explain-slash-commands.png" lightbox="../media/explain-slash-commands.png" alt-text="Screenshot of /explain slash commands.":::

- **/fix:** Proposes fixes for problems in the selected code. If you're facing issues, you can highlight the problematic section and use `/fix` to receive suggestions for resolving the issue.

  :::image type="content" source="../media/fix-slash-commands.png" lightbox="../media/fix-slash-commands.png" alt-text="Screenshot of /fix slash commands.":::

- **/generate:** Helps in generating new code based on your requirements. For example, `/generate code to find the root of a number in client.js` will create a function to perform the task.

  :::image type="content" source="../media/generate-slash-commands.png" lightbox="../media/generate-slash-commands.png" alt-text="Screenshot of /generate slash commands.":::

- **/optimize:** Analyzes and suggests improvements to the running time or efficiency of the selected code. For instance, `/optimize the `calculate` method in controller.js` will focus on enhancing the performance of that specific method.

  :::image type="content" source="../media/optimize-slash-commands.png" lightbox="../media/optimize-slash-commands.png" alt-text="Screenshot of /optimize slash commands.":::

- **/tests:** Automatically creates unit tests for the selected code. You can simply highlight the code and use `/tests using Mocha` to generate tests.

  :::image type="content" source="../media/tests-slash-commands.png" lightbox="../media/tests-slash-commands.png" alt-text="Screenshot of /tests slash commands.":::

### Copilot agents

GitHub Copilot agents are custom tools that you can build and integrate with GitHub Copilot Chat to provide additional functionalities tailored to your specific needs. In addition to slash commands, you can use specific agents within Copilot Chat in your IDE to handle different tasks:

- **@workspace:** This agent allows you to extend the context of whatever questions you ask Copilot to the whole project. It is very useful for getting code generated that would fit in your project right away, using information from your whole project. It can also be utilized for getting answers about your whole codebase. 

  :::image type="content" source="../media/workspace-agent-command.png" lightbox="../media/workspace-agent-command.png" alt-text="Screenshot of `@workspace` agent command.":::

  You can also use the “@workspace /new” smart action which allows you  to generate a completely new project from scratch based on your requirements. For example, “@workspace /new generate new html file pages and javascript for advanced calculations“

  :::image type="content" source="../media/workspace-new-agent-command.png" lightbox="../media/workspace-new-agent-command.png" alt-text="Screenshot of  `@workspace \new` agent command.":::

  Click on “Create Workspace” to proceed with code generation and just like that you have your new project with the code you requested.

  :::image type="content" source="../media/new-generated-workspace-project.png" lightbox="../media/new-generated-workspace-project.png" alt-text="Screenshot of new generated workspace project.":::

- **@terminal:** This agent is useful for command-line related questions. For example, you could ask it to find the largest file in a directory or explain the last command you ran.

  :::image type="content" source="../media/terminal-agent-command.png" lightbox="../media/terminal-agent-command.png" alt-text="Screenshot of `@terminal` agent command.":::

- **@vscode:** Use this agent to ask questions related to Visual Studio Code, such as how to debug or change settings within the IDE.

  :::image type="content" source="../media/vscode-agent-command.png" lightbox="../media/vscode-agent-command.png" alt-text="Screenshot of `@vscode` agent command.":::

  By effectively utilizing these tools and techniques, you can significantly improve the quality of responses you receive from GitHub Copilot Chat, making your coding experience more efficient and productive.

### Sharing feedback on GitHub Copilot Chat
Most IDEs with Copilot Chat integration have built-in feedback mechanisms. For example, in VS Code, you can find feedback options at the beginning of GitHub Copilot Chat's suggestions. Hover over a suggestion, and you should see thumbs up and thumbs down buttons. 

:::image type="content" source="../media/thumbs-up-helpful-buttons.png" alt-text="Screenshot of thumbs up helpful buttons.":::

Click on the thumbs up to rate a suggestion as helpful. 

:::image type="content" source="../media/thumbs-down-unhelpful.png" alt-text="Screenshot of thumbs down unhelpful.":::

Click on thumbs down to rate an unhelpful one.
