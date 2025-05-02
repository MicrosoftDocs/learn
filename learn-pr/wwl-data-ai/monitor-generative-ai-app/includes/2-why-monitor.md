When you move from experimentation to production with a generative AI solution, one of the earliest and most important decisions you face is **how to deploy** it. Specifically, what kind of compute should you allocate to your model? This decision directly affects performance, cost, and scalability.

## Why deployment choices matter

In Azure AI Foundry, like many cloud platforms, deploying a generative AI application means binding it to a **compute resource**. That resource defines the horsepower behind your app: how fast it can respond, how many requests it can handle at once, and ultimately how much it costs to operate.

Let’s consider two extremes:

- A **small VM (for example, Standard_F2s)** might be low-cost and sufficient for light usage. But it could struggle with:
  - Slow response times under load.
  - Inability to scale well for concurrent requests.
  - Occasional time-out or retry behavior.

- A **larger VM (for example, Standard_F4s or F8s)** might offer faster performance and better concurrency, but:
  - It costs more, even when idle.
  - Can be overkill for low-traffic applications.
  - Doesn’t guarantee better *token efficiency*.

The problem is: **you can't know what’s right for your use case until you see it in action**.

## Understand the objectives generative AI workloads

Generative AI workloads are different from traditional web apps:

- **They’re unpredictable.** A prompt that works well today might behave differently with a slight input change.
- **They’re compute-intensive.** Even small requests can spike resource usage because the language model must generate responses on the fly.
- **They scale differently.** Token generation and model latency are more sensitive to input/output length than request rate alone.

So when you deploy a generative AI solution like a summarization app or a chatbot, you're not just asking *"Will it run?"* You’re asking:

- How fast will it respond?
- Can it handle 10 users? Or 100?
- How much is each call going to cost us?

In production, these questions become even more urgent. Product managers and business stakeholders want **fast response times** to keep users engaged, **cost predictability** to maintain return on investment (ROI), and **stable performance** as the user base grows.

But as an engineer, you’re making choices with incomplete information unless you’ve **measured** how your deployment behaves.

To measure, is to **monitor**. Monitoring isn't just a technical tool, but also a critical input to business and engineering decisions.

## Iterate with monitoring

Through monitoring, you iteratively improve the performance of your generative AI solution:

1. **Deploy your app** with a specific Virtual Machine (VM) size or architecture.
2. **Simulate traffic** to generate real usage data.
3. **Monitor performance** in terms of latency, throughput, and cost.
4. **Reflect on trade-offs** based on the metrics.
5. Optionally, **adjust your configuration** and observe again.

Monitoring and adjusting iteratively is the same process production teams use to tune their infrastructure, plan for scale, and minimize wasted spend.

By starting this process with simulated traffic, you can test in a safe, lightweight way, while already ensuring your decisions are data-driven.

Choosing a deployment option isn't just a checkbox, it's a **design decision**. The only way to make the right choice *for you*, is to **observe your system under real (or simulated) load**, and use performance data to guide your next steps.

Next, let's explore *what* to observe in your generative AI solution.
