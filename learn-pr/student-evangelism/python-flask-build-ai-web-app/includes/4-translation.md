While solutions using machine learning or artificial intelligence have become increasingly common they can still be difficult to create from scratch. Fortunately, there are numerous solutions already built which we can access like we would any application programming interface (API). This allows us to focus on our code rather than complex modeling.

Azure provides a set of offerings called [Cognitive Services](https://docs.microsoft.com/azure/cognitive-services?WT.mc_id=python-11210-chrhar), which include services for computer vision, speech to text and text to speech, and text translation. You can access any of these via software developer kits (SDKs) or by calling them the same way we'd call any other HTTP endpoint.

To use Cognitive Services you will need an Azure account. If you're new to Azure, you can [sign-up for free](https://azure.microsoft.com/account/free?WT.mc_id=python-11210-chrhar), which will include $200 free credit for the first 30 days. If you're a student, you can [enroll for Azure for Students](https://azure.microsoft.com/free/students?WT.mc_id=python-11210-chrhar) which includes $100 to use across 12 months and a host of other free services.

## Translator service

Translator service, part of Cognitive Services, will translate to and from dozens of languages. It can automatically detect the source language, and can translate to multiple target languages in one call. You call Translator service the same way you would call any other HTTP endpoints. In Python, this is typically done with the **requests** library, which is what we will use when we return to our code.

## Key management

In order to call Translator service (or any other Cognitive Service) we will need a key. This key will be used whenever we access the service. The key is similar to a password; anyone who has access will be able to call the service, and if we are using a paid version could run up a large bill!

One great solution for protecting the key when doing development work is to use a library called [python-dotenv](https://github.com/theskumar/python-dotenv), commonly called dotenv. When using dotenv we create a file named **.env** which contains any key/value pairs we don't want as part of our source code. We will ensure the file is listed in our [gitignore](https://git-scm.com/docs/gitignore) file when push our code to [GitHub](https://github.com) so we don't accidentally publish it for the world to see.
