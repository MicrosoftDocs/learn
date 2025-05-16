Artificial Intelligence (AI) imitates human behavior by using machine learning to interact with the environment and execute tasks without explicit directions on what to output.

## What is generative AI?

*Generative* AI describes a category of capabilities within AI that create original content. These capabilities include taking in natural language input, and returning appropriate responses in a variety of formats such as natural language, images, code, and more. Let's take a look at a couple of examples: 

#### Natural language generation

To generate a natural language response, you might submit a request such as *"Write a cover letter for a person with a bachelor's degree in history."*

A generative AI application might respond to such a request like this:

*Dear Hiring Manager,
I am writing to express my interest in the position of...*

![Screenshot of an AI-generated cover letter for a person with a bachelor's degree in history.](../media/microsoft-copilot-example-write-letter.png)

#### Image generation

Some generative AI applications can interpret a natural language request and generate an appropriate image. For example, you might submit a request like *"Create a logo for a florist business."*

A generative AI application could then return a new image based on the description you provided, like this:

![Screenshot of an AI-generated image of a florist business logo.](../media/florist-example.png)

#### Code generation

Some generative AI applications are designed to help software developers write code. For example, you could submit a request like *"Write Python code to add two numbers."* and generate the following response:

```python
def add_numbers(a, b):
    return a + b

```

## Generative AI applications  

Generative AI often appears as chat-based assistants that are integrated into applications to help users find information and perform tasks efficiently. One example of such an application is [Microsoft Copilot](https://copilot.microsoft.com), an AI-powered productivity tool designed to enhance your work experience by providing real-time intelligence and assistance. All generative AI assistants utilize language models. A subset of these assistants also execute programmable tasks.  

Assistants that not only produce new content, but execute tasks such as filing taxes or coordinating shipping arrangements, just as a few examples, are known as *agents*. **Agents** are applications that can respond to user input or assess situations *autonomously*, and take appropriate actions. These actions could help with a series of tasks. For example, an "executive assistant" agent could provide details about the location of a meeting on your calendar, then attach a map or automate the booking of a taxi or rideshare service to help you get there.  

One way to think of different generative AI applications is by grouping them in buckets. In general, you can categorize industry and personal generative AI assistants into three buckets, each requiring more customization: ready-to-use applications, extendable applications, and applications you build from the foundation.

- **Ready-to-use**: these applications are ready-to-use generative AI assistants. They do not require any programming work on the user's end to utilize the tool. You can start simply by asking the assistant a question.
- **Extendable**: some ready-to-use applications can also be extended using your own data. These customizations enable the assistant to better support specific business processes or tasks. Microsoft Copilot is an example of technology that is ready-to-use and extendable. 
- **Applications you build from the foundation**: you can build your own assistants and assistants with agentic capabilities starting from a language model. Many language models exist, which we will cover later on in this module. 

Often, you will use services to extend or build Generative AI applications. These services provide the infrastructure, tools, and frameworks necessary to develop, train, and deploy generative AI models. For example, Microsoft provides services such as Copilot Studio to extend Microsoft 365 Copilot and Microsoft Azure AI Foundry to build AI from different models.  

Next, let's build a solid understanding of how the language models in these generative AI applications work. 
