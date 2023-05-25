Your R&D team has several HPC options available with Azure, and the following table highlights the primary technical differences among the HB120_v2, HC44, and HB60 SKUs. Having several HPC SKUs to choose from allows you to select the right SKU for your HPC application's performance characteristics.

The items highlighted indicate which HPC virtual machine is strongest and preferred in a particular category.

|   | HB120_v2 | HC44 | HB60 |
|---|---|---|---|
| **Processor** | AMD EPYC 7742 (Rome) | Intel Platinum 8168 | AMD EPYC 7551 (Naples) |
| **No cores (SMT disabled)** | `120` | 44 | 60 |
| **CPU base frequency** | 2.45 GHz | `2.7 GHz` | 2.0 GHz |
| **Support AVX 512** | No (16 FLOPS per core) | `Yes` (32 FLOPS per core) | No (8 FLOPS per core) |
| **Theoretical MFLOPS (FP64)** | `~4000` | ~3000 | ~1000 |
| **NUMA domains** | 30 | `2` | 15 |
| **Max MPI job size** | `36000 cores` | 13200 cores | 18000 cores |
| **Memory size** | `480 GB` | 352 GB | 240 GB |
| **Memory bandwidth** | `340 GB/s` | 190 GB/s | 260 GB/s |
| **InfiniBand** | `200 GB HDR` (latency ~1.2 &mu;s) | 100 GB EDR (latency ~1.8 &mu;s) | 100 GB EDR (latency ~1.9 &mu;s) |
| **Local SSD size** | `960 GB` (NVMeDirect), `480 GB` | 700 GB | 700 GB |
| **Max attached disks** | `8` | 4 | 4 |
| **Cost ratio** | 1.58 | 1.39 | `1.0` |

## Reasons to choose HC44

- Your HPC application is floating-point bound and requires AVX 512 support.
- Your HPC application is sensitive to CPU frequency and generally performs better with a higher clock frequency.
- Intel has a mature development ecosystem, so it's easier to develop and run applications.
- You have a long history and experience with Intel processors and would prefer to use an Intel processor.

## Reasons to choose HB120_v2

- Your HPC application is floating-point bound and will use all available cores.
- Your HPC application is memory-bandwidth bound.
- Your tightly coupled HPC application is network bound and is sensitive to latency and bandwidth.
- Your tightly coupled HPC application is highly scalable and you plan on running your application with greater than 18000 cores.
- Your application needs a high-speed local NVMe SSD that supports NVMeDirect.
- Your application needs more than four managed disks per VM.

## Reasons to choose HB60

- Your HPC application will use &lt;= 60 cores per VM.
- Your HPC application is more memory bound than floating-point bound.
- Your HPC application will scale to a smaller total core count of less than 18000 cores.
