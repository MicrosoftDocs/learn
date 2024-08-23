As per [SAP Note \#1928533](https://me.sap.com/notes/1928533), Azure Virtual Machine SKUs supported for SAP NetWeaver (A)SCS and SAP NetWeaver application server/dialog instances only include the following:

| VM Series | VM Type | VM Size | 2-Tier SAPS |
|-|-|-|-|
| Dv2-series | Standard\_D11\_v2 | 2 vCPU, 14 GiB | 3,530 |
| Dv2-series | Standard\_D12\_v2 | 4 vCPU, 28 GiB | 6,680 |
| Dv2-series | Standard\_D13\_v2 | 8 vCPU, 56 GiB | 12,300 |
| Dv2-series | Standard\_D14\_v2 | 16 vCPU, 112 GiB | 24,180 |
| Dv2-series | Standard\_D15\_v2 | 20 vCPU, 140 GiB | 30,430 |
| Dv3-series | Standard\_D2\_v3 | 2 vCPU, 8 GiB | 2,178 |
| Dv3-series | Standard\_D4\_v3 | 4 vCPU, 16 GiB | 4,355 |
| Dv3-series | Standard\_D8\_v3 | 8 vCPU, 32 GiB | 8,710 |
| Dv3-series | Standard\_D16\_v3 | 16 vCPU, 64 GiB | 17,420 |
| Dv3-series | Standard\_D32\_v3 | 32 vCPU, 128 GiB | 34,840 |
| Dv3-series | Standard\_D64\_v3 | 64 vCPU, 256 GiB | 69,680 |
| Ev3-series | Standard\_E2\_v3 | 2 vCPU, 16 GiB | 2,178 |
| Ev3-series | Standard\_E4\_v3 | 4 vCPU, 32 GiB | 4,355 |
| Ev3-series | Standard\_E8\_v3 | 8 vCPU, 64 GiB | 8,710 |
| Ev3-series | Standard\_E16\_v3 | 16 vCPU, 128 GiB | 17,420 |
| Ev3-series | Standard\_E32\_v3 | 32 vCPU, 256 GiB | 34,840 |
| Ev3-series | Standard\_E64\_v3 | 64 vCPU, 432 GiB | 70,050 |
| G-series | Standard\_G1 | 2 vCPU, 28 GiB | 3,580 |
| G-series | Standard\_G2 | 4 vCPU, 56 GiB | 6,900 |
| G-series | Standard\_G3 | 8 vCPU, 112 GiB | 11,870 |
| G-series | Standard\_G4 | 16 vCPU, 224 GiB | 22,680 |
| G-series | Standard\_G5 | 32 vCPU, 448 GiB | 41,670 |

Microsoft Azure offers Constrained vCPU capable virtual machine sizes with a reduced number of vCPUs. The vCPU count can be constrained to one half or one quarter of the original virtual machine size. These new virtual machine sizes have a suffix that specifies the number of active vCPUs. You can use these virtual machine sizes for SAP workload as well if the virtual machine size is derived from one of the virtual machine types listed above.
