Building on the basic tracing setup, you can implement more sophisticated tracing patterns for complex AI workflows.

In this section, you learn to implement two essential advanced tracing patterns:

- **Structured data generation with error handling** - Trace AI operations that generate JSON or structured data, capturing both successful parsing and common failure scenarios.
- **Business logic tracing** - Trace your application's processing logic that operates on AI outputs to measure effectiveness and identify bottlenecks.

The Trail Guide AI Assistant becomes more complex when it needs to generate structured trip profiles and match products. These scenarios require advanced tracing techniques.

## Trace complex workflows with multiple operations

Real-world AI applications often involve multiple steps: getting recommendations, generating structured data, and processing results. Each step needs its own tracing strategy.

### Generate structured data with comprehensive error handling

**Purpose**: The structured data tracing pattern shows how to trace AI operations that generate structured data (like JSON), capturing detailed information about both successful operations and parsing failures. Comprehensive error handling is critical because many AI applications fail during the JSON parsing step, and you need visibility into why.

**What you trace**: Model calls, response cleaning, parsing success/failure, and error details.

When your AI application generates JSON or other structured data, you need to trace both the generation and parsing steps:

```python
def generate_trip_profile(hike_name):
    with tracer.start_as_current_span("trip_profile_generation") as span:
        try:
            span.set_attribute("hike.name", hike_name)
            span.set_attribute("operation.type", "json_generation")
            
            # Build a prompt that should return JSON
            prompt = f"""
            Hike: {hike_name}
            Respond ONLY with a valid JSON object and nothing else.
            Format: {{ "trailType": ..., "typicalWeather": ..., "recommendedGear": [ ... ] }}
            """
            
            response = call_model(
                "You are an AI assistant that returns structured hiking trip data in JSON format.",
                prompt,
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
            span.set_attribute("gear.count", len(profile.get("recommendedGear", [])))
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

The structured data tracing pattern captures detailed information about both successful operations and failures. The key attributes (`parsing.success`, `error.type`, `response.raw`) provide the data needed for debugging and analysis.

### Trace business logic operations

**Purpose**: The business logic tracing pattern shows how to trace your application's processing logic that operates on AI outputs. Business logic includes operations like matching AI recommendations to your product catalog, filtering results, calculating scores, or transforming data. Unlike AI model calls, business logic operations happen entirely within your application, but they're equally important to monitor for performance and effectiveness.

**What you trace**: Input/output metrics, success rates, and processing effectiveness to identify optimization opportunities.

Beyond AI calls, trace your application's business logic that processes AI outputs. In the Trail Guide example, the business logic matches AI-recommended gear to actual products in your catalog:

```python
def match_products(recommended_gear):
    with tracer.start_as_current_span("product_matching") as span:
        # Business logic: Match AI recommendations to your product catalog
        # In a real application, this might query a database or API
        mock_catalog = ["TrailMaster Boots", "WeatherShield Jacket", "ComfortPack Daypack"]
        
        matched = []
        for gear_item in recommended_gear:
            # Custom matching algorithm (your business logic)
            for product in mock_catalog:
                if any(word in product.lower() for word in gear_item.lower().split()):
                    matched.append(product)
                    break
        
        # Trace metrics that help you understand business logic effectiveness
        span.set_attribute("gear.requested", len(recommended_gear))
        span.set_attribute("products.matched", len(matched))
        span.set_attribute("match.success_rate", len(matched) / len(recommended_gear) if recommended_gear else 0)
        
        return matched
```

The business logic tracing pattern captures input and output metrics (`gear.requested`, `products.matched`, `match.success_rate`) that help you understand processing effectiveness and identify areas for improvement.
