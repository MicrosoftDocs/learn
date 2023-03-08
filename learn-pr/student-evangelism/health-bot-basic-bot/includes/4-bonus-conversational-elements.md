This unit describes more elements for flow control and advanced functionality to help you build a bot efficiently.

## Conversational elements

From sending prompt messages to getting answers from the user to specific questions, interaction with users is a mandatory functionality in any chat bot conversation. Azure Health Bot provides a simple interface to allow communication with the user in scenarios and data flows.

:::image type="content" source="../media/4-health-bot-conversational-elements.png" alt-text="Screenshot that shows the three conversational elements: Prompt, Yes or No, and Statement.":::

### Prompt

Use prompts to create two-way interactions with the user. Configure the displayed message in a way that it guides the user and provides the expected value. The fields for creating prompts are:

- **Display Text** (optional): The text that's presented to the user and prompts a value entry. Provide plain text, a string literal, or a valid JavaScript expression that evaluates to a string.
- **Variable name** (required): The name of the conversation variable that will store the user's response.
- **Data Type** (required): The variable type for storing the user response. Options are number, string, Boolean, date, time, object, or choice.
- **Is Active** (optional): A valid Boolean expression that determines whether or not the step is executed during runtime.
- **Maximum number of retries:** (optional) The number of times that the bot will repeat the prompt if the user response is not valid (that is, not compatible with the data type). You can limit the number of attempts or leave this field empty for unlimited retries. You then need to decide how to handle failures when the user reaches the maximum number of attempts.

Allowing the user to select an option from a predefined list is often preferable to forcing the user to enter plain text.

### Yes/no

The yes/no prompt is essentially a Boolean prompt combined with a decision step. It asks a Boolean question and branches to a yes or a no according to the answer.

### Statement

A statement triggers an output from the health bot instance with no expectation of a response. The configuration pane is quite simple. Both the **Display Text** and **Is Active** fields can contain static values, or they can refer to valid JavaScript expressions that include variable data.

## Flow control

The data flow components are responsible for constructing, executing, and controlling scenario logic and data flow.

:::image type="content" source="../media/4-health-bot-flow-control-elements.png" alt-text="Screenshot that shows the five elements of flow control: Branch, Switch, Begin, Replace, and End.":::

### Branch

The flow of the script will branch according to the yes/no nodes of the *branch* object. These nodes refer to a true and false evaluation, respectively. It's a two-way decision split, based on code. It's not based on the user's input.

### Switch

The switch element defines a multi-way split in the flow of the scenario according to the evaluated expression. Instead of using a simple branch element that's set to two exit points, the switch statement allows multiple exit points to simplify the scenario flow.

Sharing the same functionality between different scenarios is common. It's possible to create a scenario that can be called throughout the project. It can receive input parameters and return output to the calling scenario, making it reusable. The variables defined in such a scenario are local to the scope of the instance. So they won't affect other variables, even variables with the same name.

### Begin Scenario

The begin element invokes a sub-scenario. Sub-scenario is another smaller scenario which is connected to the main scenario through a keyword or action. Execution of the current scenario is resumed after the sub-scenario ends.

Select the relevant scenario trigger value from the dropdown menu. Define the arguments with either a literal or a variable object. Define the output variable name with the return value from the called scenario.

### Replace Scenario

When you want to completely replace a scenario and end the current scenario, you can use the **Replace Scenario** option.

### End Scenario

When you're ready to return from the called scenario, place an end object from the end scenario with the result element in the sub-scenario.

The scope of the end object is as follows:

- **Scenario**: Ends the current scenario and returns the value.
- **Conversation**: Ends the current conversation and returns the value.

## Advanced functionality

The Health Bot service is a highly configurable and extensible bot-building platform. It allows integration with other services and resources into your scenarios and flows. This capability has the potential to enhance conversations and provide an engaging experience to the user.

:::image type="content" source="../media/4-health-bot-advanced-control-elements.png" alt-text="Screenshot that shows the four advanced functionalities: Data Connections, Global, Action, and L U.":::

### Data Connection

To integrate external data resources, you can use a data connections object. This object allows you to make HTTPS calls to API providers or to your own API endpoints.

You can define data connections at two levels:

- **Connection-level configuration**: These configuration details set the baseline for the data connection. They're included in all the calls to the connection endpoints.
- **Step-level configuration**: This configuration can extend or override the connection-level details. They're used at specific scenario steps and don't apply to every call made to the connection.

### Skill

Extend your bot by using [Bot Framework Skills](/azure/bot-service/skills-conceptual?view=azure-bot-service-4.0). Bot Framework Skills are reusable conversational skill building-blocks that cover conversational use-cases. They enable you to add extensive functionality to a Bot within minutes.

### Global

By using the global variables element, you can set and get variables to use throughout your scenarios. Variables set in this way (unlike variables that use the $, @, & notations) maintain their context. They're persistent and available in all scenarios and for all users.

### Assign

Instead of writing JavaScript code to assign variables, you can use Assign, which allows the same functionality without any code.

### Action

Use actions to take control of the Bot Framework APIs, so that you can modify and extend your bot's functionality.

### Wait

You can use the wait element to temporarily pause and suspend the scenario execution. The user sets the time period.

### Language Understanding

You can set HTTPS calls to the Language Understanding (LUIS) service. Interactions with LUIS automatically enforce a no-storage policy.
