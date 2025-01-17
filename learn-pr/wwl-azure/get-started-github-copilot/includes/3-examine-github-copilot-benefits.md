GitHub Copilot provides developers with an AI pair programmer that works with all popular programming languages. Using GitHub Copilot dramatically accelerates the overall productivity of developers. In recent research, GitHub and Microsoft found that developers experience a significant productivity boost when working on real-world projects and tasks using GitHub Copilot. In fact, in less than two years since its launch, developers have experienced the following results while using GitHub Copilot:

- 46% of new code is now written by AI.
- 55% faster overall developer productivity.
- 74% of developers feel more focused on satisfying work.

GitHub Copilot was developed by GitHub and OpenAI. It's powered by OpenAI Codex, an AI system created by OpenAI. The OpenAI Codex has broad knowledge of how people use code and is more capable than GPT-3 in code generation. In addition, the data set used to train OpenAI Codex includes a larger concentration of public source code. These factors make GitHub Copilot more effective than GPT-3 in generating code completions and suggestions.

GitHub Copilot is available as an extension for Visual Studio Code, Visual Studio, Vim/Neovim, and the JetBrains suite of integrated development environments (IDEs).

## GitHub Copilot subscription plans

GitHub Copilot has two subscription offerings for developer organizations, one for professional developers that don't have access to GitHub Copilot through an organization, and one free offering for individuals. All the offerings include code completions and chat assistance in the developer IDE. Paid subscriptions currently range between 10 and 39 dollars (USD) per month and can be billed monthly or annually.

### GitHub Copilot Free

GitHub Copilot Free is available to individual GitHub customers who don't have access to GitHub Copilot through an organization or enterprise. This free tier provides limited access to select features of GitHub Copilot, allowing an individual to experience AI-powered coding assistance without a paid subscription. The free tier currently includes 2000 code completions and 50 chat messages per month.

### GitHub Copilot Pro

GitHub Copilot Pro is available to individual GitHub customers who don't have access to GitHub Copilot through an organization or enterprise. This paid tier offers full access to all GitHub Copilot features, including advanced capabilities and unlimited usage, for a comprehensive AI coding experience. GitHub Copilot Pro is free for verified students, teachers, and maintainers of popular open source projects on GitHub. If you don't meet the criteria for a free Copilot Pro subscription, you'll be offered a 30-day free trial, after which a paid subscription is required for continued use.

### GitHub Copilot Business

GitHub Copilot Business is available for organizations with a GitHub Free or GitHub Team plan, or enterprises on GitHub Enterprise Cloud. GitHub Copilot Business gives organizations and enterprises control over Copilot policies, including which members can use Copilot.

### GitHub Copilot Enterprise

GitHub Copilot Enterprise is available for enterprises on GitHub Enterprise Cloud. In addition to all of the Copilot Business features, Copilot Enterprise provides additional AI features on GitHub. With this subscription plan you can choose to assign either Copilot Enterprise or Copilot Business to each individual organization in the enterprise.

## GitHub Copilot tools and features for professionals

The GitHub Copilot tools provide a range of features, each tier building on the features included in the previous tiers.

GitHub Copilot Pro includes the following features:

- Code completion in IDEs.
- Copilot Chat in IDEs.
- Copilot Chat in GitHub Mobile.
- Copilot Chat in GitHub (GitHub.com).
- Copilot Chat in Windows Terminal.
- Copilot in the CLI.
- Block suggestions matching public code.
- Copilot pull request summaries.
- Copilot Chat skills in IDEs.

GitHub Copilot Business includes the features provided with GitHub Copilot Pro and adds the following features:

- Exclude specified files from Copilot.
- Organization-wide policy management.
- Audit logs.
- Increased GitHub Models rate limits.

GitHub Copilot Enterprise includes the features provided with GitHub Copilot Business and adds the following features:

- Copilot knowledge bases.
- Fine tuning a custom large language model.

### GitHub Copilot integration with the developer environment

GitHub Copilot natively integrates with Visual Studio Code, Visual Studio, and other developer environments.

GitHub Copilot is implemented using two extensions for Visual Studio Code: GitHub Copilot and GitHub Copilot Chat.

- The GitHub Copilot extension provides code completions and code generation from comments. Powerful tools that help developers write code faster and smarter.
- The GitHub Copilot Chat extension provides the editor with an AI-enabled chat interface that’s focused on developer scenarios. It recognizes the entire project workspace, the code revisions being entered, error messages, and other aspects of the compiler/runtime environment. Developers can use Copilot Chat to get an in-depth analysis of their code, investigate new features, enhance or refactor existing features, generate unit tests, and even receive proposed fixes for bugs.

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
