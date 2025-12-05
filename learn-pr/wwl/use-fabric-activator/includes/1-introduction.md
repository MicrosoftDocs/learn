Imagine you manage package delivery for a company with temperature-sensitive medicines that must stay cold during transport. You track the temperature readings and delivery status from your trucks and need to take immediate action when temperature variances threaten medicine safety. Activator in Microsoft Fabric can help you automatically evaluate these conditions and trigger actions like alerting your dispatch team or starting workflows that could initiate delivery changes when problems occur.

## What is Activator?

Activator is Microsoft Fabric's event detection and rules engine within Real-Time Intelligence.

To use Activator, first you connect to real-time data sources. Then you create **rules** to check for specific conditions, and when those conditions are met, Activator executes **actions** like sending email alerts, posting Teams messages, starting Power Automate flows, or running Fabric notebooks.

## Real-world scenarios

Activator is useful in scenarios where timely responses matter:

- **Manufacturing operations** can automatically alert maintenance teams when equipment temperatures exceed safe operating ranges
- **Supply chain managers** can be notified when shipments deviate from planned routes or experience unexpected delays
- **Retail managers** can trigger inventory reorders when stock levels fall below critical thresholds
- **IT operations teams** can automatically restart services when performance metrics indicate system degradation
- **Financial institutions** can flag unusual transaction patterns for immediate review
- **Healthcare facilities** can alert staff when patient monitoring devices detect critical changes

In this module, you'll learn how to connect Activator to your streaming data sources, create rules that automatically detect important conditions, and configure the actions that should be triggered when those conditions occur.