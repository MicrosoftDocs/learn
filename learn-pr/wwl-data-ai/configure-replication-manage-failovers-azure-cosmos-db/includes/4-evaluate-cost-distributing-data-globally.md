When evaluating the cost of a solution that replicates across multiple regions, you should calculate the cost as a multiple of the single-region cost relative to the number of replicas.

The core formula is **RU/s x \# of regions**. For example, consider a solution that uses approximately **1,000 RU/s** per hour; data is written to one Azure region and replicated to five more regions. The formula for this would be:

```
1,000 x (1+5) = 6,000
```

The account would be billed for **6,000 RU/s** used at a per-hour rate.
