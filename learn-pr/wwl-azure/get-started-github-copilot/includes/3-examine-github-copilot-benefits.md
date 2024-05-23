GitHub Copilot provides developers with an AI pair programmer that works with all popular programming languages. Using GitHub Copilot dramatically accelerates the overall productivity of developers. In recent research, GitHub and Microsoft found that developers experience a significant productivity boost when working on real-world projects and tasks using GitHub Copilot. In fact, in less than two years since its launch, developers have experienced the following results while using GitHub Copilot:

- 46% of new code is now written by AI.
- 55% faster overall developer productivity.
- 74% of developers feel more focused on satisfying work.

GitHub Copilot was developed by GitHub and OpenAI. It's powered by OpenAI Codex, an AI system created by OpenAI. The OpenAI Codex has broad knowledge of how people use code and is more capable than GPT-3 in code generation. In addition, the data set used to train OpenAI Codex includes a larger concentration of public source code. These factors make GitHub Copilot more effective than GPT-3 in generating code completions and suggestions.

GitHub Copilot is available as an extension for Visual Studio Code, Visual Studio, Vim/Neovim, and the JetBrains suite of integrated development environments (IDEs).

## GitHub Copilot account types

GitHub Copilot has multiple offerings for organizations and an offering for individual developers. All the offerings include code completions and chat assistance. The primary differences between the organization offerings and the individual offering are license management, policy management, and IP indemnity.

Organizations can choose between GitHub Copilot Business and GitHub Copilot Enterprise. The Enterprise offering is available through GitHub Enterprise Cloud and includes additional features suited for larger organizations.

GitHub Copilot Individual is designed for individual developers, freelancers, students, educators, and open source maintainers. The plan includes all the features of GitHub Copilot Business except organizational license management, policy management, and IP indemnity.

### GitHub Copilot Individual

GitHub Copilot Individual is available for free to all GitHub users. It includes features like code completions, chat in IDE and mobile, and security vulnerabilities filter. GitHub Copilot Individual is focused on making developers more productive and fulfilled. These features allow developers to code faster and enables them to focus on more satisfying work.

### GitHub Copilot Business

GitHub Copilot Business allows you to control who can use GitHub Copilot in your company. Once you give access to an organization, its admins can then give access to individuals and teams. With Copilot Business, GitHub Copilot is open to every developer, team and organization, and enterprise.

With features like code completions, chat in IDE and mobile, security vulnerabilities filter, code referencing, public code filter, IP indemnity, and enterprise-grade security, safety, and privacy, GitHub Copilot Business is focused on making organizations more productive, secure, and fulfilled. These features allow developers to code faster and enables them to focus on more satisfying work.

### GitHub Copilot Enterprise

GitHub Copilot Enterprise is available for organizations through GitHub Enterprise Cloud. GitHub Copilot Enterprise helps developer teams get up to speed quickly. Teams can search through and build documentation, get suggestions based on internal and private code, and quickly review pull requests.

The primary difference between Business and Enterprise is that GitHub Copilot Enterprise includes an extra layer of customization for organizations. GitHub Copilot Enterprise also includes GitHub Copilot integrated into GitHub.com as a chat interface. This feature allows developers to converse about their codebase from within GitHub.com. GitHub Copilot Enterprise can index an organization’s codebase for a deeper understanding of the customer’s knowledge. This provides for more tailored suggestions and offers customers access to fine-tuned custom, private models for code completion.

## GitHub Copilot tools and features

The GitHub Copilot tools provide a range of features, such as:

- **Code completion**: Copilot suggests code as you type.
- **Chat interactions**: Ask Copilot for help with your code.
- **Pull request summaries (Copilot Enterprise only)**: Get Copilot to describe the changes in a pull request.
- **Knowledge bases (Copilot Enterprise only)**: Create and manage collections of documentation to use as a context for chatting with Copilot.
- **Copilot in the CLI**: Use Copilot from the command line to generate code snippets and more.

### GitHub Copilot

GitHub Copilot natively integrates with Visual Studio Code, Visual Studio, and other developer environments.

GitHub Copilot is implemented using two extensions for Visual Studio Code: GitHub Copilot and GitHub Copilot Chat.

- The GitHub Copilot extension provides code completions and code generation from comments. Powerful tools that help developers write code faster and smarter.
- The GitHub Copilot Chat extension provides the editor with an AI-enabled chat interface that’s focused on developer scenarios. It recognizes the entire project workspace, the code revisions being entered, error messages, and other aspects of the compiler/runtime environment. Developers can use Copilot Chat to get an in-depth analysis of their code, investigate new features, enhance or refactor existing features, generate unit tests, and even receive proposed fixes for bugs.

### Copilot for Pull Requests

This new functionality is powered by OpenAI’s new GPT-4 model. It adds support for AI-powered tags in pull-request descriptions through a GitHub app that organization admins and individual repository owners can install. These tags are automatically filled out by GitHub Copilot based on the changed code. Developers can then review or modify the suggested description.

### AI-generated answers about documentation

GitHub is launching GitHub Copilot for Docs. This product is an experimental tool that uses a chat interface to provide users with AI-generated responses to questions about documentation. It can answer a developer's questions about the languages, frameworks, and technologies they're using.

### Copilot for the command line interface (CLI)

Next to the editor and pull request, the terminal is the place where developers spend the most time. However, even the most proficient developers need to scroll through many pages to remember the precise syntax of many commands. GitHub Copilot CLI can compose commands and loops, and throw around obscure find flags to satisfy your query.

## Limitations of GitHub Copilot Chat

Depending on your codebase, the prompts that you enter, and other factors, you may experience different levels of performance when using GitHub Copilot Chat. The following information is designed to help you understand system limitations and key concepts about performance as they apply to GitHub Copilot Chat.

### Limited scope

GitHub Copilot Chat is trained on a large body of code but it still has a limited scope. It may not be able to handle some complex code structures or obscure programming languages. For each programming language, the quality of suggestions you receive may depend on the volume and diversity of training data for that language. For example, JavaScript is well-represented in public repositories and is one of GitHub Copilot's best supported languages. Languages with less representation in public repositories may be more challenging for Copilot Chat. Additionally, Copilot Chat can only suggest code based on the context of the code being written, so it may not be able to identify larger design or architectural issues.

### Potential biases

GitHub Copilot's training data is drawn from existing code repositories that could contain biases and errors. GitHub Copilot could perpetuate the biases if they exist in the training data. GitHub Copilot Chat may be biased towards certain programming languages or coding styles, which can lead to suboptimal or incomplete code suggestions.

### Security risks

Copilot Chat generates code based on the context of the code being written, which can potentially expose sensitive information or vulnerabilities if not used carefully. You should be careful when using Copilot Chat to generate code for security-sensitive applications and always review and test the generated code thoroughly.

### Matches with public code

Copilot Chat is capable of generating new code, which it does in a probabilistic way. The probability that Copilot Chat produces code that matches code in the training set is low, but not zero. A Copilot Chat suggestion may contain some code snippets that match code in the training set. Copilot Chat uses filters that block matches with public code on GitHub repositories, but you should still take precautions. You should treat GitHub Copilot suggestions the same way you would treat any code that uses material you didn't originate yourself. This includes precautions to ensure its suitability. These include rigorous testing, IP scanning, and checking for security vulnerabilities. You should make sure your IDE or editor doesn't automatically compile or run generated code before you review it.

### Inaccurate code

GitHub Copilot Chat may generate code that appears to be valid but isn't. The code may not actually be semantically or syntactically correct, or may not accurately reflect the intent of the developer. To mitigate the risk of inaccurate code, you should carefully review and test generated code. This is particularly important when dealing with critical or sensitive applications. You should also ensure that the generated code adheres to best practices and design patterns and fits within the overall architecture and style of the codebase.

### Inaccurate responses to noncoding topics

Copilot Chat isn't designed to answer noncoding questions, and therefore its responses may not always be accurate or helpful in these contexts. If a user asks Copilot Chat a noncoding question, it may generate an answer that is irrelevant or nonsensical, or it may simply indicate that it's unable to provide a useful response.
