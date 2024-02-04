Let's explore how you can modify a Python repository using code suggestions from GitHub Copilot to create an interactive HTML form and an Application Programming Interface (API) endpoint. By working with this repository, you'll quickly get hands-on with a Python web app that serves an HTTP API that generates a pseudo-random token, commonly used in for identification.

## What is an API?

An API acts as the intermediary that allows different applications to communicate to each other. For example, a weather website can either share historical data or provide forecast functionality through its API. Using the API, you can embed the data into your website or create an application sharing weather data with other features.

## Extend the Web API

The API already has a single endpoint to generate a token. Let's update the API by adding a new endpoint that accepts text and returns a list of tokens.

>[!Note]
> For this exercise, use the [Codespace with the preconfigured environment](https://codespaces.new/MicrosoftDocs/mslearn-copilot-codespaces-python?azure-portal=true) in your browser.


### Step 1: Add a Pydantic model

Go to the `main.py` file, and add a comment so that GitHub Copilot can generate a `Pydantic` model for you. The generated model should look like this:

```python
class Text(BaseModel):

text: str
```

### Step 2: Generate a new endpoint

Next, generate a new endpoint with GitHub Copilot by adding the comment:

```python
# Create a FastAPI endpoint that accepts a POST request with a JSON body containing a single field called "text" and returns a checksum of the text
```

### Step 3: Add necessary imports

The generated code causes the application to crash. The crash happens because the `base64` and `os` modules aren't imported. Add the following lines to the top of the file:

```python
import base64
import os
```

Finally, verify the new endpoint is working by trying it out by going to the `/docs` endpoint and confirming that the endpoint shows up.


Congratulations, through the exercise, you haven't only used Copilot to generate code but also done it in an interactive and fun way! You can use GitHub Copilot to not only generate code, but write documentation, test your applications and more.

When you've finished the exercise in GitHub, return here for:
> [!div class="checklist"]
> * A quick knowledge check
> * A summary of what you've learned
> * A badge for completing this module
