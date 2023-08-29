
Often, when you write code, you need to consult official documentation, or other web pages, to remember syntax or how to solve a problem. You can also spend hours trying to resolve a problem when the code isn't working. Additionally, you also spend time writing tests and documentation. All these tasks are time consuming and to be more efficient you could use code snippets or rely on tooling in your IDE, integrated development environment, but is there a better way?

## What is GitHub Copilot?

GitHub Copilot is an AI assistant that you use from within your IDE that’s capable of generating code and much more.  

## How does it work?

GitHub Copilot uses prompts, natural language text, that you type, and it provides suggestions based on what you type. A prompt can, for example, look like so:

```python
# Create a web API using FastAPI with a route to products.
```

Copilot then goes on to generate a response that you can choose to accept or reject. A response to the prompt could look similar to the following:

```python
from fastapi import FastAPI
app = FastAPI()

@app.get("/products")
def read_products():
    return []
```

## How it recognizes prompts

Copilot can tell that something is a prompt, an instruction if you: 

Type it as a comment in a code file with a file ending like .py or .js for example. 

Type text in a markdown file and wait for Copilot to return a response within a few second. 

## Accepting suggestions

What’s you’re getting back from Copilot is a suggestion, text that shows itself as grey code, if you use black as your text color. To accept the suggestion, you need to press the “Tab” key.  

Copilot might suggest more than one thing and it’s possible to cycle between suggestion using “ctrl + enter” key and select the most appropriate one.  


## How to set up GitHub Copilot

To use GitHub Copilot, you need the following:

Create a GitHub account, as Copilot is a GitHub service, you need a GitHub account to use the service.

Sign up, you need to sign up for Copilot via its web page.

In GitHub select on your profile then head over to settings where under Copilot you can enable access or sign up for a free trial.

To use GitHub Copilot, you need to install it as an extension into your IDE.

Extensions are available for major IDEs like Visual Studio, Visual Studio Code.