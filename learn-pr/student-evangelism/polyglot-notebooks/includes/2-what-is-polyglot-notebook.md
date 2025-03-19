To create documentation for a system, you often consider several different things like a textual description, flowcharts for the architecture, and even code for important parts. To properly describe a system, you therefore conclude you need more than one file, stored in different formats. Because you're looking to maintain many different files that can be a bit cumbersome, you're looking for a way to reduce this complexity.

## What is a notebook?

Notebooks are interactive files that allow you to mix executable code, visualizations, equations, and narrative text. Notebooks are composed of code cells that make it easy to quickly iterate code. This capability makes it ideal to use when performing data science, machine learning, documentation, or any sort of prototyping. A notebook uses the concept of *cells* to represent different types of content. Here's what a Notebook can look like:  

![Screenshot of a Jupyter Notebook with markdown in one cell and Hello World code in another.](../media/code-cell-1.png)

The preceding image shows a rendered Notebook with a markdown cell on top displaying *Some text*, then a code cell for Python underneath and under it a code cell for Python. Additionally, the code cell was executed and displays the text *Hello World*.

## What is Polyglot programming?

Polyglot programming is the practice of using multiple programming languages, using the strength of each language for different tasks. When polyglot programming meets notebooks, you get Polyglot Notebooks.

As opposed to traditional notebooks that are typically used with Python, the Polyglot Notebooks extension allows you to use multiple programming languages natively, all in the same notebook in Visual Studio Code. No more needing wrapper libraries or magic commands to work with your favorite languages in the same notebook!

![Screenshot of the Polyglot Notebooks extension in Visual Studio Code.](../media/polyglot-extension-2.png)

## Why use Polyglot Notebooks

There are many reasons why Polyglot Notebooks are a great tool to use for your everyday workflows.

- **Supports many languages**: Polyglot Notebooks support various different languages. Current supported languages are C#, F#, PowerShell, JavaScript, HTML, Mermaid, SQL, KQL (Kusto Query Language).
- **Powerful features**: Polyglot Notebook has a set of features that makes it a compelling choice. Notably, for example, you can share variables between cells, regardless of chosen language. You can also fetch data using C# and, in another cell, read and work with the same data in JavaScript. There are also magic commands that can extend the Polyglot Notebook capabilities.
- **Prototyping is easy**. With all Notebook solutions, prototyping an app is made easy because you don't need a full-fledged IDE to get started with writing and running code.

## Polyglot Notebook vs Jupyter Notebook

If you're used to working with Notebooks already, the first thing that comes to mind might be Jupyter Notebooks. While they're a great solution, we believe that Polyglot Notebooks offer extra value. The significant differences are in the number of languages Polyglot Notebooks support. Polyglot Notebooks also offer features like variable sharing, magic commands, and the ability to render flowcharts via Mermaid, just to mention a few.

These differences allow you to, for example, build full-stack solutions. With Polyglot Notebooks, the following example is possible: Imagine querying a data source, exposing that as a Web API, and then calling said API from another cell and rendering it as HTML. All of this is possible thanks to Polyglot Notebooks. Additionally, you can document the preceding example with state and flow diagrams.
