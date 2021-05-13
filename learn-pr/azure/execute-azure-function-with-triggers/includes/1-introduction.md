Imagine a scenario where a busy hair salon has a recurring problem: their customers commonly miss their appointments. The appointments are reserved time slots. If a customer misses an appointment, the salon loses money. To fix this problem, the salon reaches out to you, a software developer. To improve the situation, you decide to send reminder text messages. These could be sent as soon as the appointment is scheduled or changed, and each morning, you'll send a text message to every customer with an appointment that day.

You need to create a service that can be easily scheduled, updated and scaled. You decide to solve this problem using an Azure Functions app. You already know how to implement the logic to send a text message. Now you need to learn how to send the message at a specific time or when a specific event occurs. Luckily, Azure Functions app supports a feature called _triggers_. Triggers are used to determine how an Azure Function is executed.

## Learning objectives

In this module, you will:
- Determine which trigger works best for your business needs.
- Create a timer trigger to invoke a function on a consistent schedule.
- Create an HTTP trigger to invoke a function when an HTTP request is received.
- Create a blob trigger to invoke a function when a blob is created or updated in Azure Storage.