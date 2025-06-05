The generative AI CoE should develop organizational best practices around monitoring and optimization that can be leveraged by the teams that manage individual workloads. The AI CoE should develop methods and practices at the organizational level around what to workload elements to monitor, how to perform the monitoring, how telemetry data is collected and stored, and how analysis and review of telemetry occurs.

Monitoring and output metrics are essential throughout a generative AI's solution's lifecycle to evaluate workload performance and the relevance of generated output. Having robust metrics allows you to perform iterative refinements. It also allows you to verify that your deployed generative AI workload is producing high-quality outputs and will warn you if drift is starting to occur leading to unexpected results.

Generative AI solutions require specialized metrics because their outputs are probabilistic and dynamic, rather than deterministic:

- Generated content often varies with each input, even under similar conditions.
- There's no single "correct" solution, making traditional pass/fail testing insufficient.
- Evaluating alignment with desired outputs involves know-how about the use case, and can be subjective; context-dependent criteria, such as relevance and tone, can differ by use case.

Metrics can identify shifts in model behavior, such as changes introduced by private model upgrades or mismatches between training and live inputs. Metrics also ensure that the system continues to perform reliably under real-world conditions and adapts to evolving conditions. Metrics can include:

- **Non-supervised metrics (real-world usage)**: these metrics provide insights into the system's operational variability and biases in live environments, revealing areas for improvement.
- **Change detection**: identifies behavioral shifts in systems, leveraging anomaly detection frameworks. For instance, sudden output anomalies may signal changes in model behavior or input types and performance degradations might indicate infrastructure bottlenecks or changes in user interaction patterns.

Instrumenting Generative AI systems to collect detailed information about their internal state enables deeper understanding of how they're functioning, beyond simply monitoring resource utilization. This includes distributed tracing, which tracks requests as they propagate through different components of the system, and log aggregation, which provides a centralized view of logs from various sources.
