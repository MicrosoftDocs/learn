You've learned so far how what-if can be used to preview changes that you are about to apply to your deployments. There's another aspect that it's important to test for as well, namely best practices. So what are these best practices and why are they important for your templates?

> [!NOTE]
> Lets get one thing clear, these are recommendations, not requirements. You are highly encouraged to follow these recommendations however.

There are recommendations on different levels, everything from parameters and variables to things applying to your resources. Let's try to look at these from a high level and see what can be gained from adhering to these recommendations:

- **Maintainability**, as you develop your template, from authoring it the first time to updating it over time it's important to *keep a clean house*. As your template grows so does constructs like parameters and variables and it's important to ensure that you understand what each of them are used for and that they are used properly. Imagine you have scenario where the parameter name is badly named and you are struggling to understand what it does by just looking at it. Or let's imagine you are using a hardcoded value where you shouldn't and something changes in your operations and IT services goes down. There are some real time consuming scenarios here where it makes sense to be very disciplined in how you name, author and even clean things up.
- **Correctness**, say you have taken all precautions to name things good but there's just too many rules to keep track of. This is where you want a tool that enforces all these rules and regulations.
- **Flexibility**, you want to ensure that your template are flexible enough to be used in any environment.
- **Domain specific rules**. You need a way to apply domain specific rules that only make sense in the domain you work in. This is not something a tool or script can know of but it can support running customized scenarios.

## The test toolkit

brief overview of the test toolkit, what it is, how to run it.

test scenarios, what do they test for.

> Apply recommended practices to your templates with the ARM Template Test Toolkit 
