You can give your AI agent capabilities beyond language processing by using plugins. Plugins are containers for native code that can be added to your agent with the Semantic Kernel. Configuring plugin functions enables your agent to interact with external services, process user input, and automate workflows. 

Using plugins allows you to leverage your existing skills as an app developer to extend the capabilities of your AI agents. Behind the scenes, the Semantic Kernel describes the plugin to the AI agent, allowing the agent to understand the capabilities of the plugin and how to use its functions.

## Create a plugin

To create a plugin, you can start with a class and add methods with the `KernelFunction` attribute. For example, this plugin class retrieves weather information:

```python
class WeatherPlugin:
    def __init__(self):
        self.conditions = ["Sunny", "Cloudy", "Rainy"]
    
    @kernel_function(name="GetWeather", description="Gets the current weather for a city")
    def get_weather(self, city: str):
        """Retrieve mock weather data for a given city."""
        weather_data = {
            "city": city,
            "temperature": round(random.uniform(-10, 40), 1),
            "condition": random.choice(self.conditions)
        }
        return weather_data
```

The `name` and `description` fields help the AI agent understand the function and its purpose.

## Add the plugin to the agent definitions

To add your plugin to an `AzureAIAgent` you can include it in the list of plugins in the constructor:

```python
agent_incident = AzureAIAgent(
    client=client,
    definition=incident_agent_definition,
    plugins=[WeatherPlugin()]
)
```

The agent can call **get_weather** dynamically when needed. For example:

```python
# Create a chat thread to test the incident manager agent
thread = await client.agents.create_thread()

await agent.add_chat_message(thread_id=thread.id, message="What is the weather in Chicago?")
response = await agent.get_response(thread_id=thread.id)
print(response)
```

When the user asks about the weather in a city, the agent automatically invokes the `get_weather` function to complete the request. Now you can equip your AI agent with skills to perform tasks based on the user's needs.