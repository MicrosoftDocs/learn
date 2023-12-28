When you're working with a long-running workflow, it's important to consider some additional scenarios. For example, what should happen if a task isn't completed within an acceptable period of time? How can you check the status of a task? You can address these concerns with timeouts and escalation paths.

In the example scenario, you've been asked to amend your new workflow to incorporate an escalation step to take action if a project design proposal isn't approved in a timely fashion.

In this unit, you'll learn how to control long-running tasks using durable timers, and how to add an escalation path based on the timer.

## Timers in Durable Functions

Durable Functions provides timers for use in the orchestrator functions, which you can use to implement delays or set up timeouts for asynchronous actions. You should use durable timers in orchestrator functions instead of the **setTimeout()** and **setInterval()** functions.

You can create a durable timer by calling the **createTimer()** method of the **DurableOrchestrationContext**. This method returns a task that resumes on a specified date and time.

## Using timers for delay

The following example illustrates how to use durable timers for delay, which sends a reminder every day for 10 days.

```javascript
const df = require("durable-functions");
const moment = require("moment");

module.exports = df.orchestrator(function*(context) {
    for (let i = 0; i < 10; i++) {
        const deadline = moment.utc(context.df.currentUtcDateTime).add(i, 'd');
        yield context.df.createTimer(deadline.toDate());
        yield context.df.callActivity("SendReminder");
    }
});
```

You should always use **currentUtcDateTime** to obtain the current date and time, instead of **Date.now** or **Date.UTC**.

## Using timers for timeout

The following example illustrates how to use durable timers for a timeout, which will execute a different path if a timeout occurs. In this example, the function waits until either the **GetQuote** activity function completes or the **deadline** timer expires. If the activity function completes, the code follows the *success case*, otherwise it follows the *timeout case*.

```javascript
const df = require("durable-functions");
const moment = require("moment");

module.exports = df.orchestrator(function*(context) {
    const deadline = moment.utc(context.df.currentUtcDateTime).add(30, "s");

    const activityTask = context.df.callActivity("GetQuote");
    const timeoutTask = context.df.createTimer(deadline.toDate());

    const winner = yield context.df.Task.any([activityTask, timeoutTask]);
    if (winner === activityTask) {
        // success case
        timeoutTask.cancel();
        return true;
    }
    else
    {
        // timeout case
        return false;
    }
});
```

In the next exercise, you'll use this information to add an escalation path to our sample scenario in the orchestrator function.
