Building on the basic tracing setup, you can implement more sophisticated tracing patterns for complex AI workflows. In this section, you learn how to trace applications with multiple model calls, handle structured data generation, and debug errors effectively.

The Trail Guide AI Assistant becomes more complex when it needs to generate structured trip profiles and match products. These scenarios require advanced tracing techniques.

## Trace complex workflows with multiple operations

Real-world AI applications often involve multiple steps: getting recommendations, generating structured data, and processing results. Each step needs its own tracing strategy.

### Generate structured data with error handling

When your AI application generates JSON or other structured data, you need to trace both the generation and parsing steps. Many AI applications fail in production at this point:

```python
def generate_trip_profile(hike_name):
    with tracer.start_as_current_span("trip_profile_generation") as span:
        # Build a prompt that should return JSON
        prompt = f"""
        Hike: {hike_name}
        Respond ONLY with a valid JSON object and nothing else.
        Format: {{ "trailType": ..., "typicalWeather": ..., "recommendedGear": [ ... ] }}
        """
        
        # Call the model
        response = call_model(
            "You are an AI assistant that returns structured hiking trip data in JSON format.",
            prompt,
            "trip_profile_model_call"
        )
        
        # Attempt to parse the response
        try:
            profile = json.loads(response)
            span.set_attribute("profile.success", True)
            span.set_attribute("gear.count", len(profile.get("recommendedGear", [])))
            return profile
        except json.JSONDecodeError as e:
            # Tracing captures why parsing failed
            span.set_attribute("profile.success", False)
            span.set_attribute("error.message", str(e))
            print(f"❌ JSON parsing failed: {e}")
            return {}
```

**Key tracing insights**: The `profile.success` attribute immediately tells you if the operation works. When the operation fails, you have the exact error message and can examine the raw model response in the child span.

### Trace business logic operations

Beyond AI calls, trace your application's business logic. Tracing business logic helps you understand how your application processes AI outputs:

```python
def match_products(recommended_gear):
    with tracer.start_as_current_span("product_matching") as span:
        # Your business logic with a mock product catalog
        mock_catalog = ["TrailMaster Boots", "WeatherShield Jacket", "ComfortPack Daypack"]
        
        matched = []
        for gear_item in recommended_gear:
            for product in mock_catalog:
                if any(word in product.lower() for word in gear_item.lower().split()):
                    matched.append(product)
                    break
        
        # Add metrics that help you understand matching effectiveness
        span.set_attribute("gear.requested", len(recommended_gear))
        span.set_attribute("products.matched", len(matched))
        span.set_attribute("match.success_rate", len(matched) / len(recommended_gear) if recommended_gear else 0)
        
        return matched
```

**Key tracing insights**: The `match.success_rate` attribute tells you how well your product matching logic works. Low success rates indicate you need better matching algorithms or a more complete product catalog.

## Handle errors with detailed tracing

When errors occur in AI applications, they can be mysterious. Detailed tracing helps you understand not just what fails, but why the failure occurs.

### Common AI application errors

AI applications commonly fail due to:

- **Model output formatting issues**: The model returns text that can't be parsed as expected.
- **Empty or unexpected responses**: The model doesn't follow instructions.
- **Rate limiting or API errors**: Infrastructure issues.

Here's how to trace these error scenarios:

```python
def generate_trip_profile_with_error_handling(hike_name):
    with tracer.start_as_current_span("trip_profile_generation") as span:
        try:
            span.set_attribute("hike.name", hike_name)
            span.set_attribute("operation.type", "json_generation")
            
            response = call_model(
                "You are an AI assistant that returns structured hiking trip data in JSON format.",
                f"Generate trip profile for: {hike_name}",
                "trip_profile_model_call"
            )
            
            # Handle common formatting issues
            if "```json" in response:
                # Model included markdown formatting - extract JSON
                json_start = response.find("```json") + 7
                json_end = response.find("```", json_start)
                response = response[json_start:json_end].strip()
                span.set_attribute("response.cleaned", True)
            
            profile = json.loads(response)
            span.set_attribute("parsing.success", True)
            return profile
            
        except json.JSONDecodeError as e:
            # Capture parsing error details for debugging
            span.set_attribute("parsing.success", False)
            span.set_attribute("error.type", "json_decode_error")
            span.set_attribute("error.message", str(e))
            span.set_attribute("response.raw", response[:200])  # First 200 chars for debugging
            return {}
            
        except Exception as e:
            # Capture any other errors
            span.set_attribute("error.type", type(e).__name__)
            span.set_attribute("error.message", str(e))
            raise
```

**Key tracing insights**: When JSON parsing fails, you can see the exact error, the first 200 characters of the response that causes the issue, and whether the response needs to be cleaned. The detailed trace information makes debugging faster.

## Analyze traces in Azure AI Foundry

When viewing traces in Azure AI Foundry, look for patterns in your trace data:

### Understanding error patterns

- **High `parsing.success: false` rates**: Your prompts may need improvement to generate better-formatted output.
- **Low `match.success_rate` values**: Your product matching logic needs enhancement.
- **Slow `response.time` values**: Consider optimizing prompts or using different models.

### Monitoring session success

- **`session.success: false` patterns**: Look at which operations fail most often.
- **`operations.completed` counts**: Understand where users drop off in multi-step workflows.

## Best practices for production

When implementing advanced tracing in production:

**Always trace**:

- Session-level operations (user journeys).
- AI model calls and their success/failure.
- Data parsing and validation steps.
- Business logic that processes AI outputs.

**Avoid tracing**:

- Individual string operations or basic calculations.
- Internal utility functions (simple helper functions that format text, clean data, or retrieve configuration values).
- Any operation containing sensitive user data.

### Performance and security considerations

**Performance**: Tracing adds minimal overhead, but avoid storing large text in span attributes. Use the first 200 characters for debugging purposes.

**Security**: Never include passwords, API keys, or sensitive personal information in trace attributes. Use placeholder values for debugging.

With these advanced patterns, you can build comprehensive observability into complex AI applications. You can quickly identify where problems occur, understand why problems happen, and measure the effectiveness of your AI operations.
