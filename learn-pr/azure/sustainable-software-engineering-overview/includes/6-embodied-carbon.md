> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWwTWD]

The device on which you're reading this document released some carbon in its creation; once it reaches the end of life, disposing of it may release more. Embodied carbon (otherwise referred to as "Embedded Carbon") is the amount of carbon pollution emitted during the creation and disposal of a device. When calculating the total carbon pollution for the computers running your software, account for both the carbon pollution to run the computer and the computer's embodied carbon.

## Embodied carbon is significant

Depending on your energy mix's carbon intensity, the embodied carbon cost of a device can be high compared to the carbon cost of the electricity powering it.

For example, a [2019 R640 Dell Server](https://i.dell.com/sites/csdocuments/CorpComm_Docs/en/carbon-footprint-poweredge-r640.pdf) has an amortized embedded carbon cost of <nobr>320 kg CO<sub>2</sub>eq/year</nobr>. It's also expected to consume <nobr>1760.3 kWh/year</nobr> of electricity. The average carbon intensity in the EU was <nobr>0.276 kg CO<sub>2</sub>eq/kWh</nobr> for 2019.

Therefore, the total carbon cost will be <nobr>320 + (0.276 \* 1760.3) = 805 kg</nobr> of carbon/year, of which 320 kilograms or about 40% is from the embodied carbon. Embodied carbon is a significant contributor to the total emitted carbon of servers.

> [!NOTE]
>
> The embodied carbon cost is often much higher for consumer devices, sometimes more significant than the lifetime carbon cost from electricity consumption. For an example, reference *[Smartphones Are Killing The Planet Faster Than Anyone Expected](https://www.fastcompany.com/90165365/smartphones-are-wrecking-the-planet-faster-than-anyone-expected)*.
>

## Don't waste hardware

By the time you buy a computer, it's already emitted a whole load of carbon. Computers also have an expiry date; they get old, can't handle modern workloads, and need to be refreshed. If you think about it in this way, hardware is then a proxy for carbon, so as Sustainable Software Engineers we must be hardware efficient if our goal is to be **carbon-efficient**.

You can do many things to be hardware efficient, but one thing you can do is help extend the expiry date on hardware. Computers don't wear out, there are no moving parts; they just become obsolete. They become obsolete because we are continually creating software that pushes limits.

## Extending the lifespan of hardware

A way to account for embodied carbon is to amortize the carbon over a device's expected life span. For example, if it took <nobr>4,000 Kg</nobr> of carbon to build a hypothetical server and we hoped that the server would have a four-year lifespan, we can consider this equivalent to 1,000 Kg of carbon released per year during its lifespan.

![Diagram of embodied carbon of a server amortized over 4 years.](../media/6-embodied-carbon-1.svg)

By thinking of embodied carbon in this way, any device, even one that isn't consuming electricity, is effectively releasing carbon over its lifetime. With that in mind, if we were to amortize the same <nobr>4,000 Kg</nobr> of carbon for our hypothetical server over a five-year lifespan instead of four, the carbon released per year would be reduced to 800 Kg.

![Diagram of embodied carbon of the same server amortized over 5 years.](../media/6-embodied-carbon-2.svg)

If we apply this concept to the lifespan of the 2019 R640 Dell Server that we discussed earlier, the amortized carbon would drop from <nobr>**320 kg CO<sub>2</sub>eq/year**</nobr> to <nobr>**256 kg CO<sub>2</sub>eq/year**</nobr> if we extended its lifespan over five years instead of four.

Hardware is retired either because it breaks down or because it struggles to handle modern workloads. Software can't help with the first; however, if we focus on building applications that can run on older hardware, we can help with the second.
