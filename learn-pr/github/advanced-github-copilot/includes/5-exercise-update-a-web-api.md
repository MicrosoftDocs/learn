Let's explore how you can modify a Python repository using advanced GitHub Copilot techniques for an Application Programming Interface (API) endpoint. Gain more practical experience by using this repository that contains a Python Web Application that hosts a Travel Weather API.

## What is an API?

An API acts as the intermediary that allows different applications to communicate to each other. For example, a weather website can either share historical data or provide forecast functionality through its API. Using the API, you can embed the data into your website or create an application sharing weather data with other features.

## Extend the Web API

The current API isn't exposing country/{country} which needs to be implemented to list cities. The route should allow only GET HTTP requests with a JSON response providing information from the historical high and low for that country, city, and given month.


>[!Note]
> For this exercise, use the [Codespace with the preconfigured environment](https://codespaces.new/MicrosoftDocs/mslearn-advanced-copilot?azure-portal=true) in your browser.


### Step 1: Add a new route

Open the main.py file, and by using the inline chat with the following command ctrl + i (on Windows) or cmd + i(on Mac) ask GitHub Copilot to help you create a new API that shows you the cities of a country. Use the following prompt:

```text
Create a new route that exposes the cities of a country.
```

This prompt should give you something similar like this:


```python
# Create a new route that exposes the cities of a country:
@app.get('/countries/{country}')
def cities(country: str):
    return list(data[country].keys())

```

>[!Note]
> Try your new route and refine your prompt until the result is as desired.

### Step 2: Create a test

Now that you created a new route, create a test with Copilot Chat for this route that uses Spain as the country. Remember to select your code and ask Copilot Chat to help you with this specific API that we just created. You can use the inline-chat or the dedicated chat pane with the following prompt:

```text
/tests help me to create a new test for this route that uses Spain as the country.
```

Once Copilot helped you to create your test, try it. If this isn't functioning as expected, feel free to share those details with Copilot in the chat. For example:

```text
This test is not quite right, it is not including cities that doesn't exist. Only Seville is part of the API.
```

### Step 3: Use an agent to write the documentation

Finally, use the `@workspace` agent to write the project documentation and how to run the project itself. Open the `README.md` file and use the following prompt in GitHub Copilot Chat:

```text
@workspace I want to document how to run this project so that other developers can get started quickly by reading the README.md file.
```

You should get a response that helps you update the README.md file with the necessary information to run the project.

Congratulations on completing this exercise. You used GitHub Copilot to generate a new API route, then wrote a test to verify its correctness, and finally, you added documentation using an agent that will help developers understand how to run this project.

When you've finished the exercise in GitHub, return here for:
> [!div class="checklist"]
> * A quick knowledge check
> * A summary of what you've learned
> * A badge for completing this module
