It's time to put in practice your newly acquired debugging knowledge! It turns out we have the perfect opportunity for that. In our Tailwind Traders application, we are developing a new feature to allow displaying a product's price in multiple currencies. A coworker wrote some code for it, but is having a hard time trying to figure out what's going wrong. Let's try helping.

Open VS Code on your machine, and create a new file named `currency.js` with this code:

```js
const rates = {};

function setExchangeRate(rate, sourceCurrency, targetCurrency) {
  if (rates[sourceCurrency] === undefined) {
    rates[sourceCurrency] = {};
  }

  if (rates[targetCurrency] === undefined) {
    rates[targetCurrency] = {};
  }

  rates[sourceCurrency][targetCurrency] = rate;
  rates[targetCurrency][sourceCurrency] = 1 / rate;
}

function convertToCurrency(value, sourceCurrency, targetCurrency) {
  const exchangeRate = rates[sourceCurrency][targetCurrency];
  return exchangeRate && value * exchangeRate;
}

function formatValueForDisplay(value) {
  return value.toFixed(2);
}

function printForeignValues(value, sourceCurrency) {
  console.info(`The value of ${value} ${sourceCurrency} is:`);

  for (const targetCurrency in rates) {
    if (targetCurrency !== sourceCurrency) {
      const convertedValue = convertToCurrency(value, sourceCurrency, targetCurrency);
      const displayValue = formatValueForDisplay(convertedValue);
      console.info(`- ${convertedValue} ${targetCurrency}`);
    }
  }
}

setExchangeRate(0.88, 'USD', 'EUR');
setExchangeRate(107.4, 'USD', 'JPY');
printForeignValues(10, 'EUR');
```

Save the file with `Ctrl+S` (Windows, Linux) or `Cmd+S` (Mac).

This program's goal is to set the exchange rate between three currencies (USD, EUR, JPY) and display how much value is `10 EUR` in all the other currencies, with two digits after decimal point. For every currency added, the exchange rate to all other currencies should be calculated.

## Create a launch configuration

We are going to use the debugger a lot, so let's create a launch configuration for your app. Go to the **Run** tab in VS Code, click on **create a launch.json file** then select **Node.js**.

This will create the file `.vscode/launch.json` in your project. You can then edit this file to further customize how your program should be started for debugging. By default, it creates a launch configuration to execute the currently opened file, `currency.js` in our case.

:::image source="../media/launch-configuration.png" alt-text="Screenshot of generated launch configuration":::

Check that the path and name of the program entry point matches your setup.

> [!NOTE]
> You can click on **Add Configuration** if you want to create different launch configurations for your project.

Once you have finished preparing your configuration, select it using the dropdown at the top of the side bar then click on the run button to start debugging.

## Analyze the issues

Now start the program using the **Start debugging** button.

:::image source="../media/start-debugging.png" alt-text="Screenshot of start debugging button in VS Code":::

You should see the program finishing quickly, that's normal as you did not add any breakpoints yet.

If you don't have the debug console displayed, bring it on with `Ctrl+Shift+Y` (Windows, Linux) or `Cmd+Shift+Y` (Mac). You should see this text in the debug console, followed by an exception.

```text
The value of 10 EUR is:
11.363636363636365
- 11.363636363636365 USD
/app/node-101/currency.js:23
  return value.toFixed(2);
               ^
TypeError: Cannot read property 'toFixed' of undefined
    at formatValueForDisplay (/app/node-101/currency.js:23:16)
    at printForeignValues (/app/node-101/currency.js:32:28)
    at Object.<anonymous> (/app/node-101/currency.js:40:1)
    at Module._compile (internal/modules/cjs/loader.js:959:30)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:995:10)
    at Module.load (internal/modules/cjs/loader.js:815:32)
    at Function.Module._load (internal/modules/cjs/loader.js:727:14)
    at Function.Module.runMain (internal/modules/cjs/loader.js:1047:10)
    at internal/main/run_main_module.js:17:11
```

What our program aims to do is set the exchange rate between three currencies (USD, EUR, JPY) and display how much value is `10 EUR` in all the other currencies, with two digits after decimal point.

We can see two bugs here:

- There are more than two digits after decimal point.
- The program crash with an exception, failing to display the `JPY` value.

## Fix the digits display

We will start by fixing the first issue. As you did not write this code and there are different functions called, let's first understand the execution flow using step by step.

### Use breakpoints and step by step execution

Add a breakpoint by clicking in the left margin at line **39**, on `printForeignValues(10, 'EUR');`.

:::image source="../media/add-breakpoint.png" alt-text="Screenshot of breakpoint location in the code":::

Then start debugging again, and step into the `printForeignValues()` function.

:::image source="../media/step-into.png" alt-text="Screenshot of step into button":::

### Check variables state

Now take some time to inspect the different variables values, using the **Variables** panel.

:::image source="../media/variables-panel.png" alt-text="Screenshot of variables panel":::

- What's the value of `value` and `sourceCurrency`?
- Do you see the three expected keys `USD`, `EUR` and `JPY` in the `rates` variable?

Advance step by step until the variable `convertedValue` is set using **Step over**.

:::image source="../media/step-over.png" alt-text="Screenshot of step over button":::

You should see that the value seems correct at this point.

Step a bit further to see the value of `displayValue`. It should contain the formatted string for display, with two digits as we expected.

We can then conclude that up to this point, the functions `convertToCurrency()` and `formatValueForDisplay()` seem correct and return the expected result.

### Correct the mistake

Continue stepping until the `console.info()` call, and examine this line carefully. Do you see the mistake here?

You can then fix the first bug by using `displayValue` instead of `convertedValue` when printing the value. Restart the program and check that the `USD` value correctly displays `11.36`. First problem, solved.

## Find the cause of the crash

Let's now find out why the program is crashing. Remove the current breakpoint and check the `Uncaught exception` box in the breakpoint panel, to force the program to pause after the exception is raised.

Run the program in the debugger again, and it should pause on the exception with a big error log in the middle of the editor window:

:::image source="../media/exception.png" alt-text="Screenshot of the exception message shown in VS Code":::

Look at the line where the execution stopped and the exception message `TypeError: Cannot read property 'toFixed' of undefined`. From that, you can deduce that the `value` parameter function has the value `undefined` instead of being a number, causing the exception.

### Rewind the call stack

The *stack trace* you see below the error message can be a bit difficult to decipher. The good news is that VS Code processes the function call stack for you, showing by default only the meaningful information in the **Call stack** panel. Let's use it to find out which code led to this exception.

We know that the exception was thrown in `formatValueForDisplay()`. Double-click on the function below it in the **Call stack** panel to see where it was called. You should end up at this line in `printForeignValues` function:

```js
const displayValue = formatValueForDisplay(convertedValue);
```

Looking closely, you can see that parameter causing the exception comes from the `convertedValue` variable. Now we need to find out at what point this value becomes `undefined`.

One option would be to add a breakpoint at this line, and inspect the variable every time the breakpoint hits it. Though, we don't know when it might occur, and in complex programs this approach might be cumbersome.

### Add conditional breakpoint

What would be nice here is to tell the debugger to only stop at this breakpoint only when `convertedValue` is `undefined`. It turns out, VS Code can do that! Instead of using left-click to add a regular breakpoint at line `31`, right-click and select **Add conditional breakpoint**.

:::image source="../media/conditional-breakpoint.png" alt-text="Screenshot of setting a conditional breakpoint in VS Code":::

You can now input the condition that will trigger the breakpoint. Type `convertedValue === undefined` and press `Enter`. Restart the program, and it should stop right where you wanted.

### Observe current state

Now take some time to analyze the current state.

- The variable `convertedValue` is the result of `convertToCurrency(value, sourceCurrency, targetCurrency)`, so check also the parameters' values and confirm they are correct.
- In particular, look at `value` and see that it has the expected value `10`.

Maybe we should take a look at the code of the `convertToCurrency()` function.

```js
function convertToCurrency(value, sourceCurrency, targetCurrency) {
  const exchangeRate = rates[sourceCurrency][targetCurrency];
  return exchangeRate && value * exchangeRate;
}
```

We know that the result of this code is `undefined`, and we also know that `value` is `10`. It means that the issue must be with the value of `exchangeRate`. Hover over the `rates` variable to take a peek.

:::image source="../media/peek-at-variable.png" alt-text="Screenshot of peeking at the rates variable value":::

We try to get the exchange rate from `EUR` to `JPY`, but if you unfold the `EUR` value you can see that there's only a conversion rate for `USD`, `JPY` is missing!

## Fix missing conversion rates

Now we know that some conversion rates are missing, let's understand why. Remove all existing breakpoints by clicking the **Remove all breakpoints** button in the **Breakpoints** panel.

:::image source="../media/remove-all-breakpoints.png" alt-text="Screenshot of button to remove all breakpoints":::

### Watch `rates` variable

Add a breakpoint at the beginning of the program, line `37`, on `setExchangeRate(0.88, 'USD', 'EUR');`. Restart the program, and watch the value of the `rates` variable by clicking the **Plus** button in the **Watch** panel and typing `rates`. Every time the value of `rates` is updated, its value will be reflected in the **Watch** panel.

Step over the first `setExchangeRate()` call, and look at the result on `rates`.

You can see at this point that the `USD` and `EUR` have matching opposite conversion rates, as we expect. Now step over one more time, to look at the result of the second `setExchangeRate()` call.

We see that `USD` and `JPY` have matching opposite conversion rates, but there's nothing between `EUR` and `JPY`. Time to look at the `setExchangeRate()` code:

```js
function setExchangeRate(rate, sourceCurrency, targetCurrency) {
  if (rates[sourceCurrency] === undefined) {
    rates[sourceCurrency] = {};
  }

  if (rates[targetCurrency] === undefined) {
    rates[targetCurrency] = {};
  }

  rates[sourceCurrency][targetCurrency] = rate;
  rates[targetCurrency][sourceCurrency] = 1 / rate;
}
```

The most important lines are the last two. It seems you've found the bug! The rates are only set between the `sourceCurrency` and `targetCurrency`, but we also need to calculate the rate for the other currencies that were previously added.

### Fix the code

Replace these two lines:

```js
rates[sourceCurrency][targetCurrency] = rate;
rates[targetCurrency][sourceCurrency] = 1 / rate;
```

With this code:

```js
  for (const currency in rates) {
    if (currency !== targetCurrency) {
      // Use a pivot rate for currencies that don't have the direct conversion rate
      const pivotRate = currency === sourceCurrency ? 1 : rates[currency][sourceCurrency];
      rates[currency][targetCurrency] = rate * pivotRate;
      rates[targetCurrency][currency] = 1 / (rate * pivotRate);
    }
  }
```

Using this code, for every currency other than `sourceCurrency` and `targetCurrency`, we'll use the conversion rate of `sourceCurrency` to deduce the rate between the other currency and `targetCurrency` and set it accordingly.

> [!NOTE]
> This will only work if rates between `sourceCurrency` and other currencies already exist, which is an acceptable limitation in this case.

### Test the correction

Let's test our change. Remove all breakpoints, then restart the program. You should now see the expected result in the console, without any crash.

```text
The value of 10 EUR is:
- 11.36 USD
- 1220.45 JPY
```

That's it, you fixed the code. You are now capable of efficiently debugging code you don't even know beforehand using VS Code, well done!
