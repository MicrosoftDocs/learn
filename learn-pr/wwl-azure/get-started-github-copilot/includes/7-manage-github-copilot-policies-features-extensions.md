GitHub provides several options for customizing and extending GitHub Copilot. For individual users, you can manage your GitHub Copilot plan, configure settings for GitHub Copilot, and install GitHub Copilot Extensions.

> [!NOTE]
> If you're a member of an organization and you've been assigned a GitHub Copilot subscription through your organization, work with your account manager to ensure that you have the correct plan and settings. You may not be able to change your individual plan or settings if your organization has a Copilot Business or Copilot Enterprise plan.

## Manage GitHub Copilot policies and features as an individual subscriber

In addition to the configuration for the GitHub Copilot plugin in your supported IDE, you can configure settings for GitHub Copilot on GitHub. The settings apply wherever you use GitHub Copilot.

### Enable or disable features

There are several features of GitHub Copilot that you can enable or disable using your account settings. These features are enabled by default, but you can choose to disable them if you prefer.

#### Copilot in GitHub

You can choose whether to use Copilot Chat in GitHub, however, preview features aren't available. This setting is enabled by default.

#### Copilot in GitHub Desktop

You can choose whether to use Copilot Chat for assistance in GitHub Desktop. This setting is enabled by default.

#### Copilot can search the web

You can choose whether to use the web search capability in GitHub Copilot Chat. If you enable this setting, Copilot Chat will use Bing to search the internet for information related to a question. Bing search is particularly helpful when discussing new technologies or highly specific subjects.

#### Alternative AI models

You can choose whether to allow the following AI models to be used as an alternative to Copilot's default model.

- Anthropic Claude Sonnet
- Google Gemini

### Enable or disable privacy policies

There are several privacy policies for GitHub Copilot that you can enable or disable using your account settings

#### Enable or disable suggestions matching public code

> [!NOTE]
> If you're a member of an organization on GitHub Enterprise Cloud who has been assigned a GitHub Copilot subscription through your organization, you won't be able to configure suggestions matching public code in your personal account settings. Your setting for suggestions matching public code is inherited from your organization or enterprise.

Your personal settings for GitHub Copilot include an option to either allow or block code suggestions that match publicly available code. If you choose to block suggestions matching public code, GitHub Copilot checks code suggestions with their surrounding code of about 150 characters against public code on GitHub. If there's a match, or a near match, the suggestion isn't shown to you.

If you choose to allow suggestions matching public code, when Copilot suggests matching code you can display details of the matches and click through to the relevant repositories on GitHub.

#### Enable or disable prompt and suggestion collection for product improvements

You can choose whether your prompts and Copilot's suggestions are collected and retained by GitHub, and further processed and shared with Microsoft.

- In the upper-right corner of any page on GitHub, click your profile photo, then click **Your Copilot**.
- To allow or prevent GitHub using your data, select or deselect **Allow GitHub to use my code snippets from the code editor for product improvements**.

#### Model training and improvements

By default, GitHub, its affiliates, and third parties won't use your data, including prompts, suggestions, and code snippets, for AI model training. This is reflected in your personal settings for GitHub Copilot and can't be enabled.

## Manage GitHub Copilot extensions for your personal account

You can add additional functionality to GitHub Copilot in your personal account, by installing GitHub Apps from the GitHub Marketplace.

### About GitHub Copilot Extensions for your personal account

Copilot Extensions are a type of GitHub App that you can install on your GitHub account, to add additional capabilities to Copilot.

Anyone can install Copilot Extensions for their personal account, but you must set up Copilot Free, or have an active Copilot Pro or Copilot Pro+ plan, to use a Copilot Extension you install.

> [!NOTE]
> If you have access to Copilot through a Copilot Business or Copilot Enterprise plan, Copilot Extensions are installed by organization owners at the organization level, and you don't need to install the extension on your personal account.

You can also create your own custom Copilot Extensions for your personal account.

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

Copilot Chat isn't designed to answer noncoding questions, and therefore its responses may not always be accurate or helpful in these contexts. If a user asks Copilot Chat a noncoding question, it may generate an answer that is irrelevant or nonsensical, or it may indicate that it's unable to provide a useful response.

## Summary

GitHub provides several options for customizing and extending GitHub Copilot. For individual users, you can manage your GitHub Copilot plan, configure settings for GitHub Copilot, and install GitHub Copilot Extensions. You can also enable or disable features and privacy policies to customize your experience with GitHub Copilot.
