Data-driven applications often share a similar structure. You have a page where you list items, a page to display the details of an item, and then the appropriate pages to allow creation, updates, and deletes. Having to create each of these pages by hand can become tedious, especially since much of the code and HTML is repetitive.

To help streamline the creation of data-driven applications, Django provides generic views. Generic views are class-based views designed to perform all of these common operations. We can use generic views to quickly create pages to display and edit data. These views can even generate the HTML forms for us!

In this module we will explore generic views and forms, and how we can use a common library to enhance the display of our forms.

## In this module you will learn how to

- use generic views
- create Django forms
- use the django-crispy-forms library

## Prerequisites

- Software
  - [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
  - [Git](https://git-scm.com/?azure-portal=true)
- Coding skills
  - Understanding of HTML and CSS
  - Basic understanding of Django
  - Basic understanding of relational databases
  - Intermediate level knowledge of Python, including
    - [Package Management](https://docs.python.org/3/installing/index.html?azure-portal=true)
    - [Virtual Environments](https://packaging.python.org/tutorials/installing-packages/?azure-portal=true&#creating-virtual-environments)
    - [Inheritance](https://docs.python.org/3/tutorial/classes.html?azure-portal=true&#inheritance)
