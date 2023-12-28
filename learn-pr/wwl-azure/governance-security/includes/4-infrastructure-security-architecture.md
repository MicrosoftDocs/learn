## Build scalable, modular Azure landing zones

Microsoft offers the Cloud Adoption Framework to provide customers a proven starting point for the cloud journey, including the Secure methodology.

Another critical component of the Cloud Adoption Framework in the Ready methodology is the Azure landing zone, which accelerates cloud adoption by providing automated implementation of complete architectures and operating environments, including security elements. Security best practices are integrated in Azure landing zones. With landing zones, you can quickly and securely migrate your first workloads with baked-in security and governance best practices.<br>

While you design and implement your organization's landing zone, use the reference architecture below as a target end-state. It captures mature and scaled-out environmental design considerations.

We recommend using Azure landing zones when possible in your cloud adoption plans. Landing zones provide an architectural starting point. Azure landing zones help you follow security and other best practices whether you deploy a new workload, migrate existing workloads, or improve already-deployed workloads. Using landing zones helps you follow best practices whether you implement them all at once or incrementally.<br>

> [!NOTE]
> *Your organization can customize the Azure landing zone architecture to meet your unique business requirements.*

Azure landing zones contain code that makes it easier for your organization's IT and security teams. Landing zones offer a repeatable, predictable method to apply a templatized implementation. That implementation includes a deployment approach, design principles, and design areas. Landing zones support security, management, and governance processes, as well as platform automation and DevOps.

## Use Zero Trust principles

Your organization can adapt Azure landing zones based on Azure Security Benchmark (ASB) best practices and Zero Trust (ZT) principles, which are included in the target architecture. Move toward the best practice-aligned target architecture, implementing other security considerations and Zero Trust principles that incrementally build on and improve your organization's security and governance MVP.

Extend Zero Trust architectural approaches that *never trust and always verify*. Integrate an end-to-end strategy across your digital state that encompasses identities, endpoints, network, data, applications, and infrastructure.<br>

## Follow Azure Security Benchmark security recommendations

We recommend that your organization follow the high-impact security recommendations of the Azure Security Benchmark. There's also guidance in Azure landing zones and the Cloud Adoption Framework itself. Include ASB recommendations as part of your architectural strategy by reviewing all pertinent documentation and service-specific baselines.

> [!TIP]
> *Azure landing zones assign the ASB policy by default to the top of its hierarchy. This approach ensures that all subscriptions and workloads in the landing zone are monitored for ASB compliance.*
