Often, when you write code, you need to consult official documentation or other web pages to remember syntax or how to solve a problem. You can also spend hours trying to resolve a problem when the code isn't working. Additionally, you also spend time writing tests and documentation. All these tasks are time consuming. To be more efficient, you could use code snippets or rely on tooling in your integrated development environment (IDE). But is there a better way?

## How does it work?

GitHub Copilot is an AI assistant that you use from within your IDE that’s capable of generating code and much more. GitHub Copilot uses *prompts*. A prompt is natural language text that you type. Copilot uses the text to provide suggestions based on what you type.

A prompt can look like the following example:

```python
# Create a web API using FastAPI with a route to products.
```

Copilot then uses the prompt to generate a response that you can choose to accept or reject. A response to the prompt might look like the following code:

```python
from fastapi import FastAPI
app = FastAPI()

@app.get("/products")
def read_products():
    return []
```

## How it recognizes prompts

Copilot can tell that something is a prompt or an instruction if you:

- Type it as a comment in a code file with a file ending like .py or .js.
- Type text in a markdown file and wait a few seconds for Copilot to return a response.

## Accepting suggestions

What you get back from Copilot is a *suggestion*. Text that shows itself as grey code, if you use black as your text color. To accept the suggestion, you need to press the <kbd>Tab</kbd> key.

Copilot might suggest more than one thing. In which case, you can cycle between suggestions by using <kbd>Ctrl + Enter</kbd>, and select the most appropriate one.

## How to set up GitHub Copilot

To set up GitHub Copilot, you need to:

- Create a GitHub account. Copilot is a GitHub service, so you need a GitHub account to use the service.
- Sign up. You need to sign up for Copilot via its web page.
- Enable Copilot. In GitHub, select your profile, then select **Settings**. Under **Copilot**, you can enable access or sign up for a free trial.

To use GitHub Copilot, you need to install it as an extension into your IDE. Extensions are available for major Integrated Development Environments (IDEs) like Visual Studio, and Visual Studio Code.
