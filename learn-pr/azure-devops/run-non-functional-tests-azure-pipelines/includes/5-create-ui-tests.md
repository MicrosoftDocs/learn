SCRAPS

Take a moment to familiarize yourself with its contents. If you've written NUnit tests or have gone through the [Run quality tests in your build pipeline using Azure Pipelines](/learn/modules/run-quality-tests-build-pipeline?azure-portal=true) module, the format of this test code will look familiar to you.

NOTE: We run IE because support for it is already built-in 
Point to doc with all the browsers?

Define NUnit (knowledge unit?)

CALL OUT WHAT DRIVERS ARE ON THE BUILD AGENT

CALL OUT IE INSTEAD OF EDGE

Verify CSS class - show screenshot?

SHOW XPATH FORMAT like https://www.guru99.com/xpath-selenium.html

**Amita:** Until we had the pipeline, I used to download the build and install it on my server but now I can use the CD pipeline test environment.

TODO: Does Andy say they'll help maintain the tests, for when they change the UI?

TODO: Also, talk about how we'll skip the process of creating the Nunit tests. In practice, you would choose a UI testing framework that fits with the type of app you're building and the language you use to build it.
"Remember, the focus is how to run UI tests in the pipeline, not how to use any specific framework or language". Therefore, for learning purposes, we'll skip. ..."

TODO: Change XPath modal window to CSS class name!

---
In this section, you run Selenium tests that verify the UI behaviors that Amita described.

Here's how you'll run the tests:

> [!div class="checklist"]
> * Check out a Git branch that implements the tests and examine the test code.
> * Run the tests locally on Chrome, Firefox, and Internet Explorer.
> * Incorporate the tests in your release pipeline and watch the tests run in Azure Pipelines.

> [!NOTE]
> For this part, you don't need to have Chrome, Firefox, and Internet Explorer installed locally. The tests will run only on the browsers you have installed. In practice, you can install the web browsers you want to test on to help ensure that the tests you write will succeed in the pipeline.


## Fetch the branch from GitHub

In this section, you fetch the `selenium-tests` branch from GitHub and check out, or switch to, that branch.

This branch contains the _Space Game_ project that you worked with in previous modules and an Azure Pipelines configuration to start with.

1. In Visual Studio Code, open the integrated terminal.
1. To download a branch named `selenium-tests` from the Microsoft repository and switch to that branch, run the following `git fetch` and `git checkout` commands:

    ```bash
    git fetch upstream selenium-tests
    git checkout selenium-tests
    ```

    Recall that *upstream* refers to the Microsoft GitHub repository. Your project's Git configuration understands the upstream remote, because you set up that relationship when you forked the project from the Microsoft repository and cloned it locally.

    Shortly, you'll push this branch up to your GitHub repository, known as `origin`.

1. Optionally, in Visual Studio Code, open the *azure-pipelines.yml* file, and familiarize yourself with the initial configuration.

    The configuration resembles the basic one that you created in the [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline?azure-portal=true) module. It builds only the application's **Release** configuration.

## Write the unit test code

Amita is impressed and feels a bit excited about writing code to control her web browser. Andy does some research on Selenium ahead of meeting with Amita to write their tests.

Amita and Andy sit down to write their Selenium tests. Andy has an empty NUnit project already set up. Throughout the process, they refer to the Selenium documentation, a few online tutorials, and the notes they took when Amita performed the tests manually. (We'll point you to more resources at the end of this module.)

Let's review the process Andy and Amita use to write their tests. You can follow along by opening *HomePage_ClickingLinksShould.cs* under the *Tailspin.SpaceGame.Web.UITests* directory in Visual Studio Code.

### Define the test class

**Andy:** The first thing we need to do is define our test class. There are a few naming conventions we can use, but let's call our class `HomePage_ClickingLinksShould`. Naming classes this way helps make the output human-readable when the tests run.

Andy adds this code to *HomePage_ClickingLinksShould.cs*:

```cs
public class HomePage_ClickingLinksShould
{
}
```

**Andy:** We need to mark this class as `public` so that it's available to the NUnit framework.

### Add the IWebDriver member variable

**Andy:** The next thing we need is an `IWebDriver` member variable. `IWebDriver` is the programming interface you use to launch a web browser and interact with web page content.

**Amita:** I've heard of interfaces in programming, but can you tell me more?

**Andy:** Think of an interface as a specification or blueprint for how a component should behave. An interface provides the methods, or behaviors, of that component, but does not provide any of the underlying details. You or someone else would then create one or more _concrete classes_ that implement that interface. Selenium provides the concrete classes that we need.

Here's a diagram that shows the `IWebDriver` interface:

![](../media/5-webdriver-interface.png)

This diagram shows three of the methods `IWebDriver` provides: `Navigate`, `FindElement`, and `Close`.

The three classes shown here, `ChromeDriver`, `FirefoxDriver`, and `InternetExplorerDriver`, each implement `IWebDriver` and its methods. There are other classes that implement `IWebDriver`, such as `SafariDriver`. Each driver class can control the web browser it represents.

Andy adds a member variable named `driver` to the `HomePage_ClickingLinksShould` class, like this:

```cs
public class HomePage_ClickingLinksShould
{
    private IWebDriver driver;
}
```

### Define the test fixtures

**Andy:** We want to run the entire set of tests on Chrome, Firefox, and Internet Explorer. In NUnit, we can use _test fixtures_ to run the entire set of tests multiple times, one time for each browser we want to test on.

In NUnit, you use the `TestFixture` attribute to define your test fixtures. Andy adds these three test fixtures to the `HomePage_ClickingLinksShould` class:

```cs
[TestFixture("Chrome")]
[TestFixture("Firefox")]
[TestFixture("IE")]
public class HomePage_ClickingLinksShould
{
    private IWebDriver driver;
}
```

**Andy:** Next, we need to define a constructor for our test class. The constructor is called when NUnit creates an instance of this class. The constructor takes as its argument the string that we attached to our test fixtures. Here's what that looks like:

```cs
[TestFixture("Chrome")]
[TestFixture("Firefox")]
[TestFixture("IE")]
public class HomePage_ClickingLinksShould
{
    private string browser;
    private IWebDriver driver;

    public HomePage_ClickingLinksShould(string browser)
    {
        this.browser = browser;
    }
}
```

**Andy:** We add the `browser` member variable so that we can use the current browser name in our setup code. Let's write the setup code next.

### Define the Setup method

When you build the app, .NET installs any dependent NuGet packages that you need. Dependent packages are specified in the project file, which has the *.csproj* extension.

As part of that process, the 

The driver is created in the `Setup` method, which is called before any tests are run.

This example shows where the `Setup` method matches the web browser name(provided to the test fixture) with the `IWebBrowser` implementation to use.

```cs
var cwd = Environment.CurrentDirectory;
switch(browser)
{
  case "Chrome":
    driver = new ChromeDriver(cwd);
    break;
  case "Firefox":
    driver = new FirefoxDriver(cwd);
    break;
  case "IE":
    driver = new InternetExplorerDriver(cwd);
    break;
  default:
    throw new ArgumentException($"'{browser}': Unknown browser");
}
```

### Define the test method

**Andy:** We're now ready to define the test method. Amita, based on the manual tests you showed me earlier, let's call this method `DisplayModal`, since it 

The `DisplayModal` method runs the tests. Here's how this method is defined:

```cs
[Test, TestCaseSource(typeof(TestCaseFactory), "XPathData")]
public void DisplayModal(string linkXPath, string modalXPath)
```

The `Test` attribute marks this method as a test that you want NUnit to run. The `TestCaseSource` attribute specifies data to use in the tests. We'll examine that part shortly.

The `DisplayModal` method takes two XPath expressions (as strings) as its arguments: the XPath to the link to click and the XPath to the expected modal window that appears when you click the link.

Here's a brief description of how the `DisplayModal` method works:

1. If the driver equals `null`, skip the test.

    The driver is `null` when the underlying web browser is not installed or the driver code cannot be loaded.
1. Click the link that opens the modal window.

    Selenium provides a few ways to click links. Here, we use `IJavaScriptExecutor` to click links by using JavaScript. This technique works well across web browsers because it can click links without first needed to scroll the link into view.
1. Click the close button that appears on the modal.
1. Verify that the CSS class of the modal window equals "modal-content".

    This step is performed at the end of the `DisplayModal` method by using an assertion. An _assertion_ is a condition or statement that you declare to be true. If the condition turns out to be false, that could indicate a bug in your code or a behavior that has changed. NUnit runs each test method and records the result as a passing or failing test.

    ```cs
    // Verify that the modal uses the "modal-content" CSS class.
    Assert.That(modal.GetAttribute("class").Equals("modal-content"));
    ```

The test uses `WebDriverWait` to ensure that the required page elements are available before continuing.

### Defining test case data

Recall that the `TestCaseSource` attribute specifies data to use in the tests.

```cs
[Test, TestCaseSource(typeof(TestCaseFactory), "XPathData")]
public void DisplayModal(string linkXPath, string modalXPath)
```

In this example, the `TestCaseFactory` class's `XPathData` property provides the test data. Here's the `TestCaseFactory` class, which appears at the bottom of *HomePage_ClickingLinksShould.cs*.

```cs
// Provides a data source for test methods.
public class TestCaseFactory
{
    public static IEnumerable XPathData
    {
        get
        {
            // Download game
            yield return new TestCaseData(
                "/html/body/div/div/section[2]/div[2]/a",
                "//*[@id=\"pretend-modal\"]/div/div"
            );

            // Screenshots
            yield return new TestCaseData(
                "/html/body/div/div/section[3]/div/ul/li[1]/a",
                "/html/body/div[1]/div/div[2]/div/div"
            );
            yield return new TestCaseData(
                "/html/body/div/div/section[3]/div/ul/li[2]/a",
                "/html/body/div[1]/div/div[2]/div/div"
            );
            yield return new TestCaseData(
                "/html/body/div/div/section[3]/div/ul/li[3]/a",
                "/html/body/div[1]/div/div[2]/div/div"
            );
            yield return new TestCaseData(
                "/html/body/div/div/section[3]/div/ul/li[4]/a",
                "/html/body/div[1]/div/div[2]/div/div"
            );

            // Top player on the leaderboard
            yield return new TestCaseData(
                "/html/body/div/div/section[4]/div/div/div[1]/div[2]/div[2]/div/a/div",
                "//*[@id=\"profile-modal-1\"]/div/div"
            );
        }
    }
}
```

In C#, `IEnumerable` provides a collection of objects that you can iterate over, such as in a `foreach` or `while` loop. The `yield return` statements return the next set of test case data each time the `XPathData` property is accessed.

Each set of test case data contains two XPath expressions: the XPath to the link to click and the XPath to the expected modal window that appears when you click the link. NUnit passes these XPath expressions to the `DisplayModal` test method.

## Examine the unit test code

Amita is impressed and feels a bit excited about writing code to control her web browser. Amita and Andy sat down and write their Selenium tests, referring to the notes they took when Amita perform the tests manually.

Let's review the important parts of the test code so you understand how it works.

In Visual Studio Code, open *HomePage_ClickingLinksShould.cs* under the *Tailspin.SpaceGame.Web.UITests* directory.

Take a moment to familiarize yourself with its contents. If you've written NUnit tests or have gone through the [Run quality tests in your build pipeline using Azure Pipelines](/learn/modules/run-quality-tests-build-pipeline?azure-portal=true) module, the format of this test code will look familiar to you.

### Defining the test fixtures

Near the top of the file, locate this code:

```cs
[TestFixture("Chrome")]
[TestFixture("Firefox")]
[TestFixture("IE")]
public class HomePage_ClickingLinksShould
{
    private string browser;
    private IWebDriver driver;

    public HomePage_ClickingLinksShould(string browser)
    {
        this.browser = browser;
    }
```

We want to run the entire set of tests on Chrome, Firefox, and Internet Explorer. `TestFixture` enables you to run tests multiple times. This example shows three test fixtures; each test fixture specifies a web browser to test on.

For each test fixture, NUnit calls the `HomePage_ClickingLinksShould` constructor, passing one of the web browser names as its argument.

The `driver` data member is an `IWebDriver` object. `IWebDriver` is the programming interface you use to launch a web browser and interact with web page content.

If you're unfamiliar with the concept of interfaces in languages such as C#, think of it as a specification or blueprint for how a component should behave. An interface provides the methods, or behaviors, of that component, but do not provide any of the underlying details. You then create one or more _concrete classes_ that implement that interface.

Here's a diagram that shows the `IWebDriver` interface:

![](../media/5-webdriver-interface.png)

This diagram shows three of the methods `IWebDriver` provides: `Navigate`, `FindElement`, and `Close`.

The three classes shown here, `ChromeDriver`, `FirefoxDriver`, and `InternetExplorerDriver`, each implement `IWebDriver` and its methods. There are other classes that implement `IWebDriver`, such as `SafariDriver`. Each driver class can control the web browser it represents.

### Defining the Setup method

The driver is created in the `Setup` method, which is called before any tests are run.

This example shows where the `Setup` method matches the web browser name(provided to the test fixture) with the `IWebBrowser` implementation to use.

```cs
var cwd = Environment.CurrentDirectory;
switch(browser)
{
  case "Chrome":
    driver = new ChromeDriver(cwd);
    break;
  case "Firefox":
    driver = new FirefoxDriver(cwd);
    break;
  case "IE":
    driver = new InternetExplorerDriver(cwd);
    break;
  default:
    throw new ArgumentException($"'{browser}': Unknown browser");
}
```

### Defining the DisplayModal method

The `DisplayModal` method runs the tests. Here's how this method is defined:

```cs
[Test, TestCaseSource(typeof(TestCaseFactory), "XPathData")]
public void DisplayModal(string linkXPath, string modalXPath)
```

The `Test` attribute marks this method as a test that you want NUnit to run. The `TestCaseSource` attribute specifies data to use in the tests. We'll examine that part shortly.

The `DisplayModal` method takes two XPath expressions (as strings) as its arguments: the XPath to the link to click and the XPath to the expected modal window that appears when you click the link.

Here's a brief description of how the `DisplayModal` method works:

1. If the driver equals `null`, skip the test.

    The driver is `null` when the underlying web browser is not installed or the driver code cannot be loaded.
1. Click the link that opens the modal window.

    Selenium provides a few ways to click links. Here, we use `IJavaScriptExecutor` to click links by using JavaScript. This technique works well across web browsers because it can click links without first needed to scroll the link into view.
1. Click the close button that appears on the modal.
1. Verify that the CSS class of the modal window equals "modal-content".

    This step is performed at the end of the `DisplayModal` method by using an assertion. An _assertion_ is a condition or statement that you declare to be true. If the condition turns out to be false, that could indicate a bug in your code or a behavior that has changed. NUnit runs each test method and records the result as a passing or failing test.

    ```cs
    // Verify that the modal uses the "modal-content" CSS class.
    Assert.That(modal.GetAttribute("class").Equals("modal-content"));
    ```

The test uses `WebDriverWait` to ensure that the required page elements are available before continuing.

### Defining test case data

Recall that the `TestCaseSource` attribute specifies data to use in the tests.

```cs
[Test, TestCaseSource(typeof(TestCaseFactory), "XPathData")]
public void DisplayModal(string linkXPath, string modalXPath)
```

In this example, the `TestCaseFactory` class's `XPathData` property provides the test data. Here's the `TestCaseFactory` class, which appears at the bottom of *HomePage_ClickingLinksShould.cs*.

```cs
// Provides a data source for test methods.
public class TestCaseFactory
{
    public static IEnumerable XPathData
    {
        get
        {
            // Download game
            yield return new TestCaseData(
                "/html/body/div/div/section[2]/div[2]/a",
                "//*[@id=\"pretend-modal\"]/div/div"
            );

            // Screenshots
            yield return new TestCaseData(
                "/html/body/div/div/section[3]/div/ul/li[1]/a",
                "/html/body/div[1]/div/div[2]/div/div"
            );
            yield return new TestCaseData(
                "/html/body/div/div/section[3]/div/ul/li[2]/a",
                "/html/body/div[1]/div/div[2]/div/div"
            );
            yield return new TestCaseData(
                "/html/body/div/div/section[3]/div/ul/li[3]/a",
                "/html/body/div[1]/div/div[2]/div/div"
            );
            yield return new TestCaseData(
                "/html/body/div/div/section[3]/div/ul/li[4]/a",
                "/html/body/div[1]/div/div[2]/div/div"
            );

            // Top player on the leaderboard
            yield return new TestCaseData(
                "/html/body/div/div/section[4]/div/div/div[1]/div[2]/div[2]/div/a/div",
                "//*[@id=\"profile-modal-1\"]/div/div"
            );
        }
    }
}
```

In C#, `IEnumerable` provides a collection of objects that you can iterate over, such as in a `foreach` or `while` loop. The `yield return` statements return the next set of test case data each time the `XPathData` property is accessed.

Each set of test case data contains two XPath expressions: the XPath to the link to click and the XPath to the expected modal window that appears when you click the link. NUnit passes these XPath expressions to the `DisplayModal` test method.

## Run the unit tests locally

Before submitting to the pipeline ...

## Modify the build configuration

In this section, you modify the build configuration to switch from using a Microsoft-hosted agent to using the agent from your build pool.

1. In Visual Studio Code, open the *azure-pipelines.yml* file, and then look for the `pool` section.

    ```yml
    pool:
      vmImage: 'Ubuntu-16.04'
      demands:
        - npm
    ```

1. Modify the `pool` section, as shown here:

    ```yml
    pool:
      name: 'MyAgentPool'
      demands:
        - npm
    ```

    This version uses `name` to specify your agent pool, *MyAgentPool*. It maintains the `demands` section to specify that the build agent must have npm, the Node.js package manager, installed.

1. In the integrated terminal, add **azure-pipelines.yml** to the index, commit the changes, and push the branch up to GitHub.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Use private agent pool"
    git push origin selenium-tests
    ```

## Watch Azure Pipelines use your build agent

Watch the build run in the pipeline by using your build agent.

1. In Azure DevOps, go to the **Space Game - web - Agent** project.
1. On the project page or in the left pane, select **Pipelines**.
1. Select **Builds**, and then select the running build.
1. Trace the build through each of the steps.

    You can see that the build has succeeded by using your build agent from your agent pool.

    ![Azure Pipelines showing the private agent running the build](../media/5-build-results-private-pool.png)

---

Roberta: I did all the prep work, I just need to come back and set the procedures. I'll follow along with the narrative from the previous module.

* Pull down branch
* Run Selenium tests locally (head vs headless)
* Modify pipeline to run tests on Windows agent
* Push and run through pipeline
* See results

* Fetch branch with starter build config
  * This branch will include an additional .csproj that contains Selenium tests
  * [Reference](https://docs.microsoft.com/azure/devops/pipelines/test/continuous-test-selenium?view=azure-devops)
* Change (or add) deployment stage to **Hosted VS2017**.
* `git commit && git push` - watch it build, deploy, & **run tests** in the pipeline.
* Verify the results in the pipeline.
* Manually promote the build to Preprod.

Amita is impressed and feels a bit excited about writing code to control her web browser. Perhaps Mara shows her some resources (tutorials, reference documentation) so Amita can continue writing tests. Amita can then write and verify additional tests and submit them to GitHub and have them run through the pipeline just like the developers.