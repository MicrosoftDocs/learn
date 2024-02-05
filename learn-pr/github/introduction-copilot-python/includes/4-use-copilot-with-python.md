
In previous units, we showed how to set up Copilot and mentioned how it can make you faster as a developer starting to write code.

In this unit, let's discuss how Copilot can help you with existing projects and help you with more complicated tasks.

## Developing with GitHub Copilot

Often when we build out projects, we need to continuously ensure our code is fresh and updated. Additionally, we might need to fix any bugs that come up or add new features to improve its functionality and usability. Let's explore some ways to make updates with GitHub Copilot.

### Prompt engineering

Although GitHub Copilot can suggest code as you type, you can also build prompts to create useful suggestions. A prompt, which is our input, is a collection of instructions or guidelines that help generate code. A prompt is useful to generate specific responses from Copilot. The prompt might be a comment that steers Copilot to generate code on your behalf or writing code that Copilot autocompletes.

The quality of output from Copilot is dependent on how well you craft your prompt. Designing an effective prompt is, therefore, crucial in ensuring we achieve our desired outcomes. For example, if you have the following prompt:

```python
# Create an API endpoint
```

Since the prompt is ambiguous and vague, the result from GitHub Copilot might not be what you need. For example, it could use a framework that you don't know, or an endpoint that requires data that you don't recognize. However, if you have the following prompt:

```python
# Create an API endpoint using the FastAPI framework that accepts a JSON payload in a POST request
```

This last prompt is specific, clear and allows GitHub Copilot to understand the goal and scope of the task.  You can also provide context and examples to Copilot using both comments and code. Having a good prompt ensures that the model generates a high-quality output.

### Best practices using GitHub Copilot

Copilot supercharges your productivity but requires some good practices to ensure quality. Some best practices when using Copilot are:

1. Keep your prompts simple then add more elaborate components as you keep going for example:
:
```text
create an HTML form with a text field and button
```
Next, elaborate more on the prompt to get more specific suggestions:

```text
Add an event listen to the button to send a POST request to /generate endpoint and display response in a div with id "result"
```

Cycle between suggestions, you can do this using `Ctrl+Enter` (or `Cmd+Enter` on a Mac). You get various suggestions from Copilot, and you can pick the best output.

If you're stuck or not getting the results you want, then you can reword the prompt or start writing code for Copilot to autocomplete.

>[!Note]
> GitHub Copilot uses open files in your text editor as additional context. This is helpful because it provides useful information in addition to the prompt or code you may be writing. If you need GitHub Copilot to provide suggestions based on other files, remember to have those open for more accurate suggestions.
