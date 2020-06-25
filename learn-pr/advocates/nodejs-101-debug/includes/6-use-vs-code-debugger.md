It's time to put in practice your newly acquired debugging knowledge! Turns out we have the perfect opportunity for that. In our Tailwind Traders application we are developing a new feature to allow displaying a product's price in multiple currencies. A coworker wrote some code for it, but is having a hard time trying to figure out what's going wrong. Let's try helping.

Open VS Code on your machine, and create a new file named `currency.js` with this code:

```js
const rates = {};

function setEchangeRate(rate, sourceCurrency, targetCurrency) {
  if (rates[sourceCurrency] === undefined) {
    rates[sourceCurrency] = {};
  }

  if (rates[targetCurrency] === undefined) {
    rates[targetCurrency] = {};
  }

  rates[sourceCurrency][targetCurrency] = rate;
  rates[targetCurrency][sourceCurrency] = 1 / rate;
}

function getExchangerate(sourceCurrency, targetCurrency) {
  return rates[sourceCurrency][targetCurrency];
}

function convertToCurrency(value, sourceCurrency, targetCurrency) {
  const exchangeRate = getExchangerate(sourceCurrency, targetCurrency);
  return value * exchangeRate;
}

function formatValueForDisplay(value) {
  return value.toFixed(2);
}

function printForeignValues(value, sourceCurrency) {
  console.info(`The value of ${value} ${sourceCurrency} is:`);

  for (const targetCurrency in rates[sourceCurrency]) {
    const convertedValue = convertToCurrency(value, sourceCurrency, targetCurrency);
    const displayValue = formatValueForDisplay(convertedValue);
    console.info(`- ${convertedValue} ${targetCurrency}`);
  }
}

setEchangeRate(0.88, 'USD', 'EUR');
setEchangeRate(107.4, 'USD', 'JPY');
printForeignValues(10, 'EUR');
```

## Create a launch configuration

We are going to use the debugger a lot, so let's create a launch configuration for your app. Go to the **Run** tab in VS Code, click on **create a launch.json file** then select **Node.js**.

This will create the file `.vscode/launch.json` in your project. You can then edit this file to further customize how your program should be started for debugging. By default, it creates a launch configuration to execute an `index.js` file in your project's root.

:::image source="../media/launch-configuration.png" alt-text="VS Code debugger execution controls":::

Edit the path and name of the program entry point to match your setup. In our case replace `${workspaceFolder}/index.js` by `${workspaceFolder}/currency.js`.

> [!NOTE]
> You can click on **Add Configuration** if you want to create different launch configurations for your project.

Once you have finished preparing your configuration, select it using the dropdown at the top of the side bar then click on the run button to start debugging.

## Analyze the issues

Now start the program using the **Start debugging** button. You should see the program finishing quickly, that's normal as you did not add any breakpoints yet.

If you don't have the debug console displayed, bring it on with `Ctrl+Shift+Y` (Windows, Linux) or `Cmd+Shift+Y` (Mac). You should see this in the debug console, followed by an exception.

```text
The value of 10 EUR is:
- 11.363636363636365 USD
```

What our program aims to do is set the exchange rate between three currencies (USD, EUR, JPY) and display the how much value is `10 EUR` in all the other currencies, with 2 digits after decimal point.

We can see two bugs here:

- There is more than 2 digits after decimal point.
- The program crash with an exception, failing to display the `JPY` value.

## Fix the digits display

We will start by fixing the first issue. As you did not write this code and there are different functions called, let's first understand the execution flow using step by step.

Add a breakpoint at line **41**, before `printForeignValues(10, 'EUR');`.

:::image source="../media/exercise-add-breakpoint.png" alt-text="Screenshot of breakpoint location in the code":::

Then start debugging again, and step into the `printForeignValues()` function.
Now take some time to inspect the different variables values, using the **Variables** panel.

- What's the value of `value` and `sourceCurrency`?
- Do you see the three expected keys `USD`, `EUR` and `JPY` in the `rates` variable?

Now advance step by step until the variable `convertedValue` is set. You should see that the value seems correct at this point.

Step a bit further to see the value of `displayValue`. Is it the string we expect to display?

We can then conclude that up to this point, the methods `convertToCurrency()` and `formatValueForDisplay()` seem correct and return the expected result.

Continue stepping until the `console.info()` call, and examine this line carefully. Do you see the mistake here?

You can then fix the first bug by using `displayValue` instead of `convertedValue` when printing the value. Restart the program and check that the `USD` value is displayed correctly. First problem, solved.

## Fix the currency display

Let's now find out why the program is crashing. Remove the current breakpoint and check the `Uncaught exception` box in the breakpoint panel, to force the program to pause after the exception is raised.

## 

rewind call stack!