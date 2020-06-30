It's time to put in practice your newly acquired debugging knowledge! Turns out we have the perfect opportunity for that. In our Tailwind Traders application we are developing a new feature to allow displaying a product's price in multiple currencies. A coworker wrote some code for it, but is having a hard time trying to figure out what's going wrong. Let's try helping.

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
  return value * exchangeRate;
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

Save this file with `Ctrl+S` (Windows, Linux) or `Cmd+S` (Mac).

## Create a launch configuration

We are going to use the debugger a lot, so let's create a launch configuration for your app. Go to the **Run** tab in VS Code, click on **create a launch.json file** then select **Node.js**.

This will create the file `.vscode/launch.json` in your project. You can then edit this file to further customize how your program should be started for debugging. By default, it creates a launch configuration to execute the currently opened file, `currency.js` in our case.

:::image source="../media/launch-configuration.png" alt-text="VS Code debugger execution controls":::

Check that the path and name of the program entry point matches your setup.

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

Add a breakpoint at line **39**, before `printForeignValues(10, 'EUR');`.

:::image source="../media/exercise-add-breakpoint.png" alt-text="Screenshot of breakpoint location in the code":::

Then start debugging again, and step into the `printForeignValues()` function.
Now take some time to inspect the different variables values, using the **Variables** panel.

- What's the value of `value` and `sourceCurrency`?
- Do you see the three expected keys `USD`, `EUR` and `JPY` in the `rates` variable?

Now advance step by step until the variable `convertedValue` is set. You should see that the value seems correct at this point.

Step a bit further to see the value of `displayValue`. Is it the string we expect to display?

We can then conclude that up to this point, the functions `convertToCurrency()` and `formatValueForDisplay()` seem correct and return the expected result.

Continue stepping until the `console.info()` call, and examine this line carefully. Do you see the mistake here?

You can then fix the first bug by using `displayValue` instead of `convertedValue` when printing the value. Restart the program and check that the `USD` value is displayed correctly. First problem, solved.

## Find the cause of the crash

Let's now find out why the program is crashing. Remove the current breakpoint and check the `Uncaught exception` box in the breakpoint panel, to force the program to pause after the exception is raised.

Run the program again, and it should pause on the exception with a big error log in the middle of the editor window:

:::image source="../media/exception.png" alt-text="Screenshot of the exception message shown in VS Code":::

Look at the line where the execution stopped and the exception message `TypeError: Cannot read property 'toFixed' of undefined`. From that, you can deduce that the `value` parameter function has the value `undefined` instead of being a number, causing the exception.

What you see below the error message is called a *stack trace* and can be a bit difficult to decipher. The good news is that VS Code process the function call stack for you, showing by default only the meaningful information in the **Call stack** panel. Let's use it to find out which code led to this exception.

We know that the exception was thrown in `formatValueForDisplay()`. Double-click on the function below it in the **Call stack** panel to see where is what called. You should end up at this line in `printForeignValues` function:

```js
const displayValue = formatValueForDisplay(convertedValue);
```

Looking closely, you can see that parameter causing the exception comes from the `convertedValue` variable. Now we need to find out at what point this value becomes `undefined`.

One option would be to add a breakpoint at this line, and inspect the variable every time the breakpoint is it. Though, we don't know when it might occur, and in very complex programs this approach might take too much time.

What would be nice here would be to tell the debugger to only stop at this breakpoint when `convertedValue` is `undefined`. Turns out, VS Code can do that! Instead of using left-click to add a regular breakpoint at line `31`, right-click and select **Add conditional breakpoint**.

:::image source="../media/conditional-breakpoint.png" alt-text="Set a conditional breakpoint in VS Code":::

You can now input the condition that will trigger the breakpoint. Type `convertedValue === undefined` and press `Enter`. Restart the program, and it should stop right where you wanted.

Now take some time to analyze the current state.

- The variable `convertedValue` is the result of `convertToCurrency(value, sourceCurrency, targetCurrency)`, so what is the parameters' value?
- In particular, what's the value of `value`?

Maybe we should take a look at the code of the `convertToCurrency()` function.

```js
function convertToCurrency(value, sourceCurrency, targetCurrency) {
  const exchangeRate = rates[sourceCurrency][targetCurrency];
  return value * exchangeRate;
}
```

We now that the result of this code is `undefined`, and we also know that `value` is `10`. It means that the issue must be with the value of `exchangeRate`. Hover the `rates` variable to take a peek.

:::image source="../media/peek-at-variable.png" alt-text="Peek at the rates variable value":::

We try to get the exchange rate from `EUR` to `JPY`, but if you unfold the `EUR` value you can see that there's only a conversion rate for `USD`, `JPY` is missing!

## Fix missing conversion rates

Now we know that some conversion rates are missing, let's understand why. Remove all existing breakpoints by clicking the **Remove all breakpoints** button in the **Breakpoints** panel.

:::image source="../media/remove-all-breakpoints.png" alt-text="Button to remove all breakpoints":::

Now add a breakpoint at the beginning of the program, line `37`, before `setExchangeRate(0.88, 'USD', 'EUR');`. Restart the program, and watch the value of the `rates` variable by clicking the **Plus** button in the **Watch** panel and typing `rates`. We can now at all times see how its value changes.

Step over the first `setExchangeRate()` call, and look at the result on `rates`.
Does its value seems correct to you?

You can see at this point that the `USD` and `EUR` have matching opposite conversion rates, as we expect. Now step over one more time, to look at the result of the second `setExchangeRate()` call. What do you see? What did you expect?

Looking at the result, we see that `USD` and `JPY` have matching opposite conversion rates, but there's nothing between `EUR` and `JPY`. Time to look at the `setExchangeRate()` code:

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

The most important lines are the last two. It seems you've found the bug! The rates are only set between the `sourceCurrency` and `targetCurrency`, but we also need to calculate it for the other currencies that were previously added.

Replace these two lines:

```js
rates[sourceCurrency][targetCurrency] = rate;
rates[targetCurrency][sourceCurrency] = 1 / rate;
```

With this code:

```js
  for (const currency in rates) {
    if (currency !== targetCurrency) {
      const pivotRate = currency === sourceCurrency ? 1 : rates[currency][sourceCurrency];
      rates[currency][targetCurrency] = rate * pivotRate;
      rates[targetCurrency][currency] = 1 / (rate * pivotRate);
    }
  }
```

Using this code, for every currency other that `sourceCurrency` and `targetCurrency`, we will use the conversion rate to `sourceCurrency` to deduce the rate between the other currency and `targetCurrency` and set it accordingly.

> [!NOTE]
> This will only work if rates between `sourceCurrency` and other currency already exists, which is an acceptable limitation in this case.

Let's test our change. Remove all breakpoints, then restart the program. You should now see the expected result in the console, without any crash.

```text
The value of 10 EUR is:
- 11.36 USD
- 1220.45 JPY
```

That's it, you fixed the code. You are now capable of efficiently debugging code you don't even know beforehand using VS Code, well done!
