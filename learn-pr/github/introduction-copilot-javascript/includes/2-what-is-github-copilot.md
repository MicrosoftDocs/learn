When writing code, you often consult documentation or web pages to remember syntax or solve problems. You might spend hours fixing issues, writing tests, and creating documentation. These tasks are time-consuming. Using code snippets or IDE tools can help, but is there a better way?

## How does it work?

GitHub Copilot is an AI assistant that you use from within your IDE that’s capable of generating code and much more. GitHub Copilot uses prompts, natural language, and it provides suggestions based on what you type. A prompt can, for example, can be a comment within your code file:

```javascript
// Create a web API using express and JavaScript with routes for products and customers
```

Copilot then goes on to generate a response that you can choose to accept or reject. A response to the prompt could look similar to the following code:

```javascript
const express = require("express");

app = express();
app.path("/products", () => "products");
app.listen(3000, () => "app runs");
```

## How it recognizes prompts

Copilot can recognize a prompt or instruction if you:

- Type it as a comment in a code file (for example, `.py`, `.js`).
- Type text in a markdown file and wait a few seconds for Copilot to respond.

## Accepting suggestions

What you get from Copilot is a suggestion, which appears as grey text if you use black as your text color. To accept the suggestion, press the <kbd>Tab</kbd> key.

Copilot might suggest multiple options. To cycle through suggestions, use <kbd>Ctrl</kbd> + <kbd>Enter</kbd> and select the most appropriate one.

## How to set up GitHub Copilot

To use GitHub Copilot, you need to complete the following steps:

1. **GitHub Account**: 
   - Create a GitHub account. Since Copilot is a GitHub service, you need a GitHub account to use it.

2. **Sign Up for Copilot**: 
   - Sign up for Copilot via its [web page](https://copilot.github.com/).

3. **Enable Copilot**:
   - In GitHub, go to your profile, then head over to **Settings**.
   - Under **Copilot**, enable access or sign up for GitHub Copilot Free or try a trial for one of the tiered plans.

4. **Install the Extension**:
   - Install the GitHub Copilot extension into your IDE.
   - Extensions are available for major IDEs like Visual Studio and Visual Studio Code.
