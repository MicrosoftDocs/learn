It's time to put into practice your newly acquired debugging knowledge. It turns out we have the perfect opportunity for that. In our Tailwind Traders app, we're developing a new feature to allow a product's price to display in multiple currencies. A coworker wrote some code for it but is having a hard time trying to figure out what's going wrong. Let's help.

Open Visual Studio Code on your machine, and create a new file named `currency.js` with this code:

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

To save the file, select **Ctrl+S** (Windows, Linux) or **Cmd+S** (Mac).

The goal of this program is to set the exchange rate between three currencies, USD, EUR, and JPY. Then we want to display how much value `10 EUR` is in all the other currencies, with two digits after the decimal point. For every currency added, the exchange rate for all other currencies should be calculated.

## Create a launch configuration

We're going to use the debugger a lot, so let's create a launch configuration for your app. Go to the **Run** tab in Visual Studio Code, select **create a launch.json file**, and then select **Node.js**.

The file `.vscode/launch.json` is created in your project. You can edit this file to further customize how your program should be started for debugging. By default, a launch configuration is created to execute the currently opened file. In this example, the file is `currency.js`.

:::image source="../media/launch-configuration.png" alt-text="Screenshot of generated launch configuration.":::

Check that the path and name of the program entry point match your setup.

> [!NOTE]
> Select **Add Configuration** if you want to create different launch configurations for your project.

After you've finished preparing your configuration, to select it, at the top of the sidebar, use the dropdown. Next, to start debugging, select **Run**.

## Analyze the issues

Now, to start the program, select **Start debugging**.

:::image source="../media/start-debugging.png" alt-text="Screenshot of the Start debugging button in Visual Studio Code.":::

You should see the program finish quickly. That's normal because you haven't added any breakpoints yet.

If you don't have the debug console displayed, to turn it on, select **Ctrl+Shift+Y** (Windows, Linux) or **Cmd+Shift+Y** (Mac). You should see this text in the debug console, followed by an exception.

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

What this program aims to do is set the exchange rate between three currencies (USD, EUR, JPY), and display the value for `10 EUR` in all the other currencies, with two digits after the decimal point.

We can see two bugs here:

- There are more than two digits after the decimal point.
- The program crashed with an exception and failed to display the `JPY` value.

## Fix the digits display

We'll start by fixing the first issue. Because you didn't write this code and there are different functions called, let's first understand the execution flow by using step-by-step execution.

### Use breakpoints and step-by-step execution

To add a breakpoint, click in the left margin at line **39**, on `printForeignValues(10, 'EUR');`.

:::image source="../media/add-breakpoint.png" alt-text="Screenshot of the breakpoint location in the code.":::

Then, start debugging again, and step into the `printForeignValues()` function.

:::image source="../media/step-into.png" alt-text="Screenshot of the Step into button.":::

### Check the variables state

Now, take some time to inspect the different variables' values by using the **Variables** panel.

:::image source="../media/variables-panel.png" alt-text="Screenshot of the Variables panel.":::

- What's the value of `value` and `sourceCurrency`?
- Do you see the three expected keys, `USD`, `EUR`, and `JPY`, in the `rates` variable?

To advance step by step until the variable `convertedValue` is set, use **Step over**.

:::image source="../media/step-over.png" alt-text="Screenshot of the Step over button.":::

You should see that the value seems correct at this point.

Step a bit further to see the value of `displayValue`. It should contain the formatted string for display, with two digits as we expected.

We can then conclude that up to this point, the functions `convertToCurrency()` and `formatValueForDisplay()` seem correct, and return the expected result.

### Correct the mistake

Continue stepping until the `console.info()` call, and examine this line carefully. Do you see the mistake here?

You can then fix the first bug by using `displayValue` instead of `convertedValue` when you print the value. Restart the program, and check that the `USD` value correctly displays `11.36`. First problem - solved.

## Find the cause of the crash

Let's now find out why the program is crashing. Remove the current breakpoint, and to force the program to pause after the exception is raised, in the **Breakpoints** panel, check the `Uncaught exception` box.

Run the program in the debugger again. It should pause on the exception with a large error log in the middle of the editor window.

:::image source="../media/exception.png" alt-text="Screenshot of the exception message shown in Visual Studio Code.":::

Look at the line where the execution stopped and the exception message `TypeError: Cannot read property 'toFixed' of undefined` appears. From that message, you can deduce that the `value` parameter function has the value `undefined` instead of being a number, which caused the exception.

### Rewind the call stack

The *stack trace* you see under the error message can be a bit difficult to decipher. The good news is that Visual Studio Code processes the function call stack for you. By default, it shows only the meaningful information in the **Call stack** panel. Let's use it to find out which code led to this exception.

We know that the exception was thrown in `formatValueForDisplay()`. To see where it was called, in the **Call stack** panel, double-click on the function under it. You should end up at this line in `printForeignValues` function.

```js
const displayValue = formatValueForDisplay(convertedValue);
```

Looking closely, you can see that the parameter that causes the exception comes from the `convertedValue` variable. Now, you need to find out at what point this value becomes `undefined`.

One option is to add a breakpoint at this line and inspect the variable every time the breakpoint hits it. We don't know when it might occur, and in complex programs, this approach might be cumbersome.

### Add a conditional breakpoint

What would be nice here is to tell the debugger to stop at this breakpoint only when `convertedValue` is `undefined`. It turns out, Visual Studio Code can do that. Instead of left-clicking to add a regular breakpoint at line `31`, right-click, and select **Add conditional breakpoint**.

:::image source="../media/conditional-breakpoint.png" alt-text="Screenshot of setting a conditional breakpoint in Visual Studio Code.":::

You can now input the condition that will trigger the breakpoint. Enter `convertedValue === undefined`, and select **Enter**. Restart the program, and it should stop right where you want.

### Observe the current state

Now, take some time to analyze the current state.

- The variable `convertedValue` is the result of `convertToCurrency(value, sourceCurrency, targetCurrency)`, so also check the parameters' values and confirm they're correct.
- In particular, look at `value`, and see that it has the expected value `10`.

Take a look at the code of the `convertToCurrency()` function.

```js
function convertToCurrency(value, sourceCurrency, targetCurrency) {
  const exchangeRate = rates[sourceCurrency][targetCurrency];
  return exchangeRate && value * exchangeRate;
}
```

You know that the result of this code is `undefined`. You also know that `value` is `10`. It means that the issue must be with the value of `exchangeRate`. Hover over the `rates` variable to take a peek.

:::image source="../media/peek-at-variable.png" alt-text="Screenshot of peeking at the rates variable value.":::

You try to get the exchange rate from `EUR` to `JPY`, but if you unfold the `EUR` value, you can see that there's only a conversion rate for `USD`. The conversion rate for `JPY` is missing.

## Fix missing conversion rates

Now that you know some conversion rates are missing, let's understand why. To remove all existing breakpoints, in the **Breakpoints** panel, select **Remove all breakpoints**.

:::image source="../media/remove-all-breakpoints.png" alt-text="Screenshot of the button to remove all breakpoints.":::

### Watch the rates variable

Add a breakpoint at the beginning of the program, line `37`, on `setExchangeRate(0.88, 'USD', 'EUR');`. Restart the program, and to watch the value of the `rates` variable, in the **Watch** panel, select **Plus**, and enter `rates`. Every time the value of `rates` is updated, and its value will be reflected in the **Watch** panel.

Step over the first `setExchangeRate()` call, and look at the result on `rates`.

You can see, at this point, that `USD` and `EUR` have matching opposite conversion rates, as you expect. Now, step over one more time to look at the result of the second `setExchangeRate()` call.

You see that `USD` and `JPY` have matching opposite conversion rates, but there's nothing between `EUR` and `JPY`. It's time to look at the `setExchangeRate()` code.

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

The most important lines are the last two. It seems you've found the bug! The rates are only set between `sourceCurrency` and `targetCurrency`, but you also need to calculate the rate for the other currencies that were previously added.

### Fix the code

Replace these two lines:

```js
rates[sourceCurrency][targetCurrency] = rate;
rates[targetCurrency][sourceCurrency] = 1 / rate;
```

with this code.

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

Using this code, for every currency other than `sourceCurrency` and `targetCurrency`, you'll use the conversion rate of `sourceCurrency` to deduce the rate between the other currency and `targetCurrency`, and set it accordingly.

> [!NOTE]
> This fix will only work if rates between `sourceCurrency` and other currencies already exist, which is an acceptable limitation in this case.

### Test the correction

Let's test our change. Remove all breakpoints, and then restart the program. You should now see the expected result in the console without any crash.

```text
The value of 10 EUR is:
- 11.36 USD
- 1220.45 JPY
```

That's it. You fixed the code. You can now efficiently debug code you didn't even know beforehand by using Visual Studio Code. Well done!
