In this unit, we look at patterns for autoscaling.

## Scale based on CPU

You have a web app and

- You want to scale out/scale in based on CPU.
- Additionally, you want to ensure there is a minimum number of instances.
- Also, you want to ensure that you set a maximum limit to the number of instances you can scale to.

## Scale differently on weekdays vs weekends

You have a web app and

- You want 3 instances by default (on weekdays)
- You don't expect traffic on weekends and hence you want to scale down to 1 instance on weekends.

## Scale differently during holidays

You have a web app and

- You want to scale up/down based on CPU usage by default
- However, during holiday season (or specific days that are important for your business) you want to override the defaults and have more capacity at your disposal.

## Scale based on custom metric

You have a web front end and an API tier that communicates with the backend.

- You want to scale the API tier based on custom events in the front end (example: You want to scale your checkout process based on the number of items in the shopping cart)
