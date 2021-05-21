Apart from the scenario steps that were demonstrated while building the bot, it is preferred to have knowledge on a few more Flow control and Advanced functionality elements to build the bot efficiently.

## Conversational Elements

From sending prompt messages to getting answers from the user to specific questions, interaction with end users is a mandatory functionality in any chat bot conversation. The Health bot provides a simple interface to allow communication with the user in scenarios and data flows.

:::image type="content" source="../media/4-conversational-elements.png" alt-text="Conversation Elements":::

### Prompt

Prompts are used to create two-way interactions with user. An author should configure the displayed message such that it guides the user and helps to provide the expected value.

- **Display Text:** (Optional) The text presented to the user, prompting value entry. Provide plain text, a string literal or a valid JavaScript expression that evaluates to a string.
- **Variable name:** (Required) The name of the conversation variable that will store the user's response.
- **Data Type:** (Required) The variable type for storing the user response (e.g. Number, String, Boolean, Date, Time, Object or a Choice.
- **Is Active:** (Optional) A valid Boolean expression that determines whether the step is executed during runtime or not.
- **Maximum number of retries:** (Optional) In cases the user response is not compatible with the data type, the bot will repeat the prompt until the user input is valid. You can limit the number of attempts or leave this field empty for unlimited retries. Author is responsible of failure handling, in case maximum number of attempts has reached.

#### Prompt choice data type

Selecting an option from a predefined list in many cases is preferable to forcing the user to enter plain text.

### Yes/No Prompt

The Yes/No prompt is essentially a Boolean *prompt* combined with a decision step. It allows the author to ask Boolean questions and branches to a Yes or a no according to the answer.

### Statement

Notice that the configuration pane is quite simple. Both the *Display Text* and the *Is Active* field can contain static values as well as refer to valid JavaScript expressions that include variable data.

## Flow Control

The Data flow components are responsible for constructing, executing and controlling scenario logic and data flow.

:::image type="content" source="../media/4-flow-control.png" alt-text="Flow Control":::

### Branch

The flow of the script will branch according to the yes/no nodes of the *Branch* object which refer to a true and false evaluation respectively. It is a two-way decision split, based on code. It is not based on the user's input.

### Switch

The Switch element defines a multi-way split in the flow of the scenario according to the evaluated expression. Instead of using a simple "branch element" that is set to two exit points, the Switch statement allows multiple exit points, simplifying the scenario flow.

## Sub scenario

Sharing the same functionality between different scenarios is highly common. It is possible to create a scenario that can be called throughout the project. It can receive input parameters and return output to the calling scenario, making it reusable. The variables defined in such a scenario are local to the instance of the sub-scenario, so they will not affect other variables, even variables with the same name.

### Begin

It invokes a sub-scenario. Execution of the current scenario is resumed once the sub-scenario terminates.
Select the relevant Scenario trigger value from the dropdown menu. Define the Arguments with either a literal or a variable object. Define the output Variable name with the return value from the called scenario.

### Replace

We can use the Replace Scenario option, in cases you wish to completely replace a scenario and end the current scenario.

### End

When you are ready to return from the called scenario, place an "End object" from the End Scenario with Result element in the sub-scenario.

#### End Scope

**Scenario:** Ends current scenario and returns the value.

**Conversation:** Ends current conversation and returns the value.

## Advanced Functionality

The health bot service is a highly configurable and extensible bot building platform, specifically it allows integration with third party services and resources into your scenarios and flows. Such capability has the potential to enhance conversations and provide engaging experience to the end user.

:::image type="content" source="../media/4-advanced-funtionalities.png" alt-text="Advanced Functionalities":::

### Data Connections

To integrate external data resources, you can use a data connection object which allows you to make HTTPS calls to third-party API providers or your own API endpoints.
Data connections can be defined at two levels:

1. **Connection level configuration:** These configuration details set the baseline for the data connection and are included in all the calls to the connection endpoints

2. **Step level configuration:** This configuration can extend or override the connection level details. They are used at specific scenario steps and don't apply to every call made to the connection.

### Global Variables

Using the Global variables element, you can set and get variables to use throughout your scenarios. Variables set in this way (unlike variables using the $, @, & notation) maintain their context and are persistent and available in all scenarios and for all users.

### Action

Actions offers enormous power to the scenario composer. Basically, it allows you to take control over the Bot Framework's APIs to be able to modify and extend your bots functionality.

### Wait

Temporarily pauses and suspends the scenario execution. Time period can be set by the user.

### LU

HTTPS calls to the LUIS (language understanding service). Interactions with LUIS automatically enforce a no-storage policy.
