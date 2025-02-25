When evaluating the cost of a solution that replicates across multiple regions, you should calculate the cost as a multiple of the single-region cost relative to the number of replicas. There are two ways to calculate this cost based upon the type of throughput being used, standard provisioned throughput or autoscale.

## Set throughput to standard provisioned

For standard provisioned throughput, the core formula is **RU/s x \# of regions**. For example, consider a solution that uses approximately **1,000 RU/s** per hour; data is written to one Azure region and replicated to five more regions. The formula for this throughput would be:

```
1,000 x (1+5) = 6,000
```

The account would be billed for **6,000 RU/s** used at a per-hour rate.

## Set throughput to dynamic autoscale

For dynamic autoscale throughput, the core formula is **Minimum RU/s x \# of regions + RU consumption per region**. For example, consider a solution that has autoscale of **1,000 RU/s**. The minimum RU/s for this throughput is 100 RU/s. The cost for that container in every region when it isn't in use is 100 RU/s. When the container in that region needs to scale, the cost is whatever the container scales to for every hour it's scaled out. The formula for this throughput would be:

```
100 x (1+5) = 600 + Consumed RU per hour, per region
```
