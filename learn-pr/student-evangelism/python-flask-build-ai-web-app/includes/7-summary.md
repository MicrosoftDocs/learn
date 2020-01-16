# Summary

In this module, you learned the basics of building Web sites in Python using the Flask framework. You learned that Python code goes in a file named **app.py** and that code in that file calls Flask functions such as `render_template()` and `flash()`. You also learned how to programmatically inject content into HTML templates using Flask expressions, and how to use `@app.route()` to connect functions in your code to routes supported by the application. Finally, you learned how easy it is to use the Azure CLI's `az webapp up` command to upload a Web site that you have written and tested locally to an Azure App Service.

In addition, you discovered that you can use Azure Cognitive Services to build intelligent applications infused with AI. The Computer Vision API extracts text from images, identifies objects in those images, and more. It can even generate captions for the images you upload. And the Translator Text API translates text between dozens of languages. Combined with other Cognitive Services, these APIs make it possible to write apps that you could only have dreamed about just a few short years ago.

## Check your knowledge

1. Flask is a framework for building Web apps in which of the following languages?
	- Python, Node.js, and Java
	- Python and Node.js
	- Python and Java
	- Python only

1. What is the name of the HTTP header that carries API keys in calls to Azure Cognitive Services?
	- Ocp-Apim-Cognitive-Key
	- Ocp-Apim-Subscription-Key
	- Ocp-Apim-Auth-Key
	- None of the above

1. What is the default port number that Flask uses to service HTTP requests?
	- 80
	- 5000
	- 8080
	- 127
	
1. Which of the following Azure CLI commands adds an application setting named API_KEY to an App Service named "contoso?"
	- `az webapp config appsettings set -g contoso-rg -n contoso-travel --settings API_KEY=a1b2c3d4`
	- `az webapp config appsettings add -g contoso-rg -n contoso-travel --settings API_KEY=a1b2c3d4`
	- `az appsvc config appsettings set -g contoso-rg -n contoso-travel --settings API_KEY=a1b2c3d4`
	- None of the above; application settings must be added through the Azure Portal

1. Which of the following are valid expression delimiters in Flask?
	- `{{` and `}}`
	- `{%` and `%}`
	- Both A and B
	- None of the above

1. How are messages "flashed" with Flask's `flash()` method shown by default?
	- In alert boxes
	- In modal popup windows that are browser-specific
	- In `<div>` elements decorated with `class="flash"` attributes
	- Flashed messages are not shown by default

1. By default, HTML files served up by Flask must be located in a directory named:
	- static
	- html
	- templates
	- main