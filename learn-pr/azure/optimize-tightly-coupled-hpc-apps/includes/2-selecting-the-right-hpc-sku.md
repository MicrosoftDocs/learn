Your R&D team has several HPC options available with Azure, and the following table highlights the primary technical differences between the **HB120_v2**, **HC44** and **HB60** SKUs. Having several HPC SKUs to choose from allows you to select the right SKU for your HPC applications performance characteristics.

The items highlighted indicate which HPC virtual machine is strongest and preferred in a particular category.


|   | HB120_v2 | HC44 | HB60 |
|---|---|---|---|
| Processor | AMD EPYC 7742 (Rome) | Intel Platinum 8168 | AMD EPYC 7551 (Naples) |
| No cores (SMT disabled) | <code>120</code> | 44 | 60 |
| CPU base frequency | 2.45 GHz | <code>2.7 GHz</code> | 2.0 GHz |
| Support AVX 512 | No (16 FLOPS per core) | <code>Yes (32 FLOPS per core)</code> | No (8 FLOPS per core) |
| Theoretical MFLOPS (FP64) | <code>~4000</code> | ~3000 | ~1000 |
| NUMA domains | 30 | <code>2</code> | 15 |
| Max MPI job Size | <code>36000 cores</code> | 13200 cores | 18000 cores |
| Memory size | <code>480 GB</code> | 352 GB | 240 GB |
| Memory bandwidth | <code>340 GB/s</code> | 190 GB/s | 260 GB/s |
| InfiniBand | <code>200 GB HDR (latency ~1.2 &mu;s)</code> | 100 GB EDR (latency ~1.8 &mu;s) | 100 GB EDR (latency ~1.9 &mu;s) |
| Local SSD size | <code>960 GB (NVMeDirect), 480 GB</code> | 700 GB | 700 GB |
| Max attached disks | <code>8</code> | 4 | 4 |
| Cost ratio | 1.58 | 1.39 | <code>1.0</code> |

## Reasons to choose HC44 

1. Your HPC application is floating point bound and requires AVX 512 support.
1. Your HPC application is sensitive to CPU frequency and generally performs better with a higher clock frequency.
1. Intel has a mature development ecosystem, easier to develop and run applications.
1. You have a long history and experience with Intel processors and would prefer to use an Intel processor.

## Reasons to choose HB120_v2

1. Your HPC application is floating-point bound and will utilize all available cores.
1. Your HPC application is memory bandwidth bound.
1. Your tightly coupled HPC application is network bound and is sensitive to latency and bandwidth.
1. Your tightly coupled HPC application is highly scalable and you plan on running your application &gt; 18000 cores.
1. Your application needs a high-speed local NVMe SSD that supports NVMeDirect.
1. Your application needs more than four managed disks per VM.

## Reasons to choose HB60

1. Your HPC application will utilize &lt;= 60 cores per VM.
1. Your HPC application is more memory bound than floating-point bound.
1. Your HPC application will scale to a smaller total core count &lt; 18000 cores.
