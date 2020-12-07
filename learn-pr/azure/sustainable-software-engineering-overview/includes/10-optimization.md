Sustainability isn't one optimization, it's thousands. One piece of advice is to look end-to-end and take it step by step. Often putting in the effort to understand the full stack, from user experience to data center design or electricity grids yield simple solutions that significantly improve carbon efficiency.

Weigh up the effort required to decarbonize vs. the potential rewards. Just like the broader global sustainability movement, some sectors will be harder to decarbonize than others. In computing, some application domains will be harder to decarbonize than others. Some parts of your application architecture will be harder to decarbonize than others.

The key to success in optimization is to choose a measurement criterion that will give clear signals as to where best to put optimization efforts. For example, is it worthwhile to spend two weeks reducing megabytes from network communication if the database queries cause 10 times more carbon to be emitted?

Rarely, can we directly measure our application's carbon cost, but if we follow a resource chain down and it eventually has a link to carbon emissions, then that is a good proxy for carbon.

## Carbon

Measuring emitted carbon is a complex challenge, with parts of the stack that need to be estimated rather than measured, but it's possible with some effort.

Because of the variability of carbon intensity and other dependencies, the total carbon emitted may change depending on the time of day or region the application is run.

The same application measured at different times will result in different amounts of carbon. This change could be a good signal, especially if you are open to demand-shifting workloads, or it could be noise if you are focusing on energy optimizations.

## Energy

The energy consumed by your application may vary every time it runs, this change may be something you want to take as an optimization signal, or it may be something you want to control for.

The same application run on different hardware may result in different amounts of energy consumed because of the differences in energy efficiency between the hardware components.

Because of the energy proportionality principle, the same application run on the same hardware but at different times may result in different amounts of energy consumed because the utilization of the hardware is different between the two runs. That is, the hardware might be running other applications during the second run, and this changes the hardware's overall energy efficiency.

Overall, though, creating applications that consume less electricity for the same human-perceptible performance and output is a good proxy for carbon reduction.

There are devices, tools, and libraries available to measure the energy consumed by an application.

<!-- TODO: Link to articles by Scott and Sara on the SSE blog. -->

## Cost

At some point, the cost of electricity and hardware is factored into most services. Building applications that run as cheaply as possible is usually a good proxy for applications that emit less carbon.

## Networking

The carbon-cost of networking is often not considered. Networking consumes electricity and requires hardware, so it is a proxy for carbon.

Measuring and then reducing the amount and distance your data must travel is a good proxy for reducing carbon.

## Performance

To build more performant applications is to build applications that utilize hardware and electricity more efficiently. Since hardware and electricity are proxies for carbon, if you can architect an application that performs better for the same level of utilization, this design will likely reduce overall carbon.