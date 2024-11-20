While solutions using machine learning or artificial intelligence have become increasingly common, they can still be difficult to create from scratch. Fortunately, there are many solutions already built, which we can access like we would any application programming interface (API). This approach allows us to focus on our code, rather than complex modeling.

Azure provides a set of offerings called [Azure AI services](/azure/ai-services?azure-portal=true&WT.mc_id=python-11210-chrhar), which include services for computer vision, speech to text and text to speech, and text translation. You can access any of these services via software developer kits (SDKs), or by calling them in the same way you'd call any other HTTP endpoint.

To use Azure AI services, you'll need an Azure account. If you're new to Azure, you can [sign-up for free](https://azure.microsoft.com/free/?WT.mc_id=python-11210-chrhar), which will include $200 free credit for the first 30 days. If you're a student, you can [enroll for Azure for Students](https://azure.microsoft.com/free/students?WT.mc_id=python-11210-chrhar&azure-portal=true), which includes $100 to use across 12 months, and a host of other free services.

## Translator service

Translator service, part of Azure AI services, will translate to and from dozens of languages. It can automatically detect the source language, and can translate to multiple target languages in one call. You call Translator service in the same way you would call any other HTTP endpoint. In Python, you typically do this by using the **requests** library, which is what we'll use when we return to our code.

## Key management

To call Translator service (or any other Cognitive Service), we'll need a key. This key will be used whenever we access the service. The key is similar to a password. Anyone who has access to the key can call the service, and if we were using a paid version they could run up a large bill!

One great solution for protecting the key when doing development work is to use a library called [python-dotenv](https://github.com/theskumar/python-dotenv?azure-portal=true), commonly called dotenv. When using dotenv, we create a file named **.env**, which contains any *key/value* pairs we don't want as part of our source code. We'll ensure that the file is listed in our [gitignore](https://git-scm.com/docs/gitignore?azure-portal=true) file when we push our code to [GitHub](https://github.com?azure-portal=true), so that we don't accidentally publish it for the world to see.
