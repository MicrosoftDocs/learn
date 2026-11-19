GitHub Copilot uses language models to [suggest code as you type](https://docs.github.com/en/copilot/responsible-use/inline-suggestions). A function name, nearby code or comments, and related open files give Copilot context for an inline suggestion. It might suggest the next line or a whole function. You decide what to accept, change, or dismiss.

## Scenario: Personalize a portfolio

The sample React portfolio still shows the original developer's name, title, and GitHub profile link. You'll use Copilot to update those details and make the footer icons pulse on hover. You'll check both changes in the live preview.

GitHub Codespaces provides a cloud-hosted development environment that you can open in Visual Studio Code (VS Code) in your browser. The sample repository configures the tools and dependencies for you.

## What will I learn?

By the end of this module, you'll be able to:

- Open the portfolio in a codespace and verify that Copilot is enabled for JavaScript in the browser editor.
- Prompt Copilot to change the portfolio's name, title, and GitHub profile link, then review and apply the suggested values.
- Guide an inline suggestion with a CSS comment and check the footer's hover animation in the live preview, including with reduced motion enabled.

## Prerequisites

Before you start, check your skills and account access:

- **Skills:** You should be comfortable editing JavaScript in a text editor and using Git to commit and push changes.
- **Codespaces access:** Use a GitHub account that can create a codespace on the MicrosoftDocs sample repository. If you have read-only access, you need [permission to fork the repository](https://docs.github.com/en/codespaces/developing-in-a-codespace/using-source-control-in-your-codespace#about-automatic-forking). If MicrosoftDocs is outside your organization, an Enterprise Managed User account can't create a codespace on this sample, even with a Copilot seat.
- **Copilot access:** Use a GitHub account that can receive inline completions and use Copilot Chat in VS Code. If your organization or enterprise assigns your seat, it must also [allow Chat in the IDE](https://docs.github.com/en/copilot/how-tos/copilot-in-your-ide/chat-with-copilot/chat-in-ide?tool=vscode#prerequisites). If you don't have an individual plan or an assigned seat, [check your eligibility for Copilot Free](https://docs.github.com/en/copilot/how-tos/manage-your-account/get-started-with-a-copilot-plan#accessing-copilot-free). Activating Free doesn't require a Pro trial or payment card.
