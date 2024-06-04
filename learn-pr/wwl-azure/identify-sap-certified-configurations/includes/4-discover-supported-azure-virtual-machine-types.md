For non-HANA RDBMS platforms, the following Azure Virtual Machine types (server sizes) are supported in 2-tier or 3-tier configurations and can be used as application servers and standalone database servers.

For A- and D- series virtual machines, SAP database files can be stored on Standard Storage or any higher quality storage types. All other virtual machine series aren't supported with SAP database files on Standard Storage or Standard SSD Storage.

| VM Series | VM Type | VM Size | 2-Tier SAPS |
|---|---|---|---|
| A-series | Standard\_A5 | 2 vCPU, 14 GiB | 1,500 |
| A-series | Standard\_A6 | 4 vCPU, 28 GiB | 3,000 |
| A-series | Standard\_A7 | 8 vCPU, 56 GiB | 6,000 |
| A-series | Standard\_A8 / Standard\_A10 | 8 vCPU, 56 GiB | 11,000 |
| A-series | Standard\_A9 / Standard\_A11 | 16 vCPU, 112 GiB | 22,000 |
| D-series | Standard\_D11 | 2 vCPU, 14 GiB | 2,325 |
| D-series | Standard\_D12 | 4 vCPU, 28 GiB | 4,650 |
| D-series | Standard\_D13 | 8 vCPU, 56 GiB | 9,300 |
| D-series | Standard\_D14 | 16 vCPU, 112 GiB | 18,600 |
| DS-series | Standard\_DS11 | 2 vCPU, 14 GiB | 2,325 |
| DS-series | Standard\_DS12 | 4 vCPU, 28 GiB | 4,650 |
| DS-series | Standard\_DS13 | 8 vCPU, 56 GiB | 9,300 |
| DS-series | Standard\_DS14 | 16 vCPU, 112 GiB | 18,600 |
| DSv2-series | Standard\_DS11\_v2 | 2 vCPU, 14 GiB | 3,530 |
| DSv2-series | Standard\_DS12\_v2 | 4 vCPU, 28 GiB | 6,680 |
| DSv2-series | Standard\_DS13\_v2 | 8 vCPU, 56 GiB | 12,300 |
| DSv2-series | Standard\_DS14\_v2 | 16 vCPU, 112 GiB | 24,180 |
| DSv2-series | Standard\_DS15\_v2 | 20 vCPU, 140 GiB | 30,430 |
| Dsv3-series | Standard\_D2s\_v3 | 2 vCPU, 8 GiB | 2,178 |
| Dsv3-series | Standard\_D4s\_v3 | 4 vCPU, 16 GiB | 4,355 |
| Dsv3-series | Standard\_D8s\_v3 | 8 vCPU, 32 GiB | 8,710 |
| Dsv3-series | Standard\_D16s\_v3 | 16 vCPU, 64 GiB | 17,420 |
| Dsv3-series | Standard\_D32s\_v3 | 32 vCPU, 128 GiB | 34,840 |
| Dsv3-series | Standard\_D48s\_v3 | 48 vCPU, 192 GiB | 52,224 |
| Dsv3-series | Standard\_D64s\_v3 | 64 vCPU, 256 GiB | 69,680 |
| Easv4-series | Standard\_E2as\_v4 | 2 vCPU, 16 GiB | 3,022 |
| Easv4-series | Standard\_E4as\_v4 | 4 vCPU, 32 GiB | 6,044 |
| Easv4-series | Standard\_E8as\_v4 | 8 vCPU, 64 GiB | 12,088 |
| Easv4-series | Standard\_E16as\_v4 | 16 vCPU, 128 GiB | 24,175 |
| Easv4-series | Standard\_E20as\_v4 | 20 vCPU, 160 GiB | 30,219 |
| Easv4-series | Standard\_E32as\_v4 | 32 vCPU, 256 GiB | 48,350 |
| Easv4-series | Standard\_E48as\_v4 | 48 vCPU, 384 GiB | 72,525 |
| Easv4-series | Standard\_E64as\_v4 | 64 vCPU, 512 GiB | 96,700 |
| Easv4-series | Standard\_E96as\_v4 | 96 vCPU, 672 GiB | 135,080 |
| Dasv4-series | Standard\_D2as\_v4 | 2 vCPU, 8 GiB | 3,022 |
| Dasv4-series | Standard\_D4as\_v4 | 4 vCPU, 16 GiB | 6,044 |
| Dasv4-series | Standard\_D8as\_v4 | 8 vCPU, 32 GiB | 12,088 |
| Dasv4-series | Standard\_D16as\_v4 | 16 vCPU, 64 GiB | 24,175 |
| Dasv4-series | Standard\_D32as\_v4 | 32 vCPU, 128 GiB | 48,350 |
| Dasv4-series | Standard\_D48as\_v4 | 48 vCPU, 192 GiB | 72,525 |
| Dasv4-series | Standard\_D64as\_v4 | 64 vCPU, 256 GiB | 96,700 |
| Dasv4-series | Standard\_D96as\_v4 | 96 vCPU, 384 GiB | 135,080 |
| Esv3-series | Standard\_E2s\_v3 | 2 vCPU, 16 GiB | 2,178 |
| Esv3-series | Standard\_E4s\_v3 | 4 vCPU, 32 GiB | 4,355 |
| Esv3-series | Standard\_E8-4s\_v3 | 4 vCPU, 64 GiB | 4,378 |
| Esv3-series | Standard\_E8s\_v3 | 8 vCPU, 64 GiB | 8,710 |
| Esv3-series | Standard\_E16s\_v3 | 16 vCPU, 128 GiB | 17,420 |
| Esv3-series | Standard\_E20s\_v3 | 20 vCPU, 160 GiB | 21,775 |
| Esv3-series | Standard\_E32s\_v3 | 32 vCPU, 256 GiB | 34,840 |
| Esv3-series | Standard\_E48s\_v3 | 48 vCPU, 384 GiB | 52,512 |
| Esv3-series | Standard\_E64is\_v3 | 64 vCPU, 432 GiB | 70,050 |
| Esv3-series | Standard\_E64s\_v3 | 64 vCPU, 432 GiB | 70,050 |
| Ddsv4-series | Standard\_D2ds\_v4 | 2 vCPU, 8 GiB | 3,142 |
| Ddsv4-series | Standard\_D4ds\_v4 | 4 vCPU, 16 GiB | 6,284 |
| Ddsv4-series | Standard\_D8ds\_v4 | 8 vCPU, 32 GiB | 12,569 |
| Ddsv4-series | Standard\_D16ds\_v4 | 16 vCPU, 64 GiB | 25,138 |
| Ddsv4-series | Standard\_D32ds\_v4 | 32 vCPU, 128 GiB | 50,275 |
| Ddsv4-series | Standard\_D48ds\_v4 | 48 vCPU, 192 GiB | 75,413 |
| Ddsv4-series | Standard\_D64ds\_v4 | 64 vCPU, 256 GiB | 100,550 |
| D(d)sv5-series | Standard\_D2(d)s\_v5 | 2 vCPU, 8 GiB | 3,405 |
| D(d)sv5-series | Standard\_D4(d)s\_v5 | 4 vCPU, 16 GiB | 6,810 |
| D(d)sv5-series | Standard\_D8(d)s\_v5 | 8 vCPU, 32 GiB | 13,621 |
| D(d)sv5-series | Standard\_D16(d)s\_v5 | 16 vCPU, 64 GiB | 27,242 |
| D(d)sv5-series | Standard\_D32(d)s\_v5 | 32 vCPU, 128 GiB | 54,483 |
| D(d)sv5-series | Standard\_D48(d)s\_v5 | 48 vCPU, 196 GiB | 81,725 |
| D(d)sv5-series | Standard\_D64(d)s\_v5 | 64 vCPU, 256 GiB | 108,967 |
| D(d)sv5-series | Standard\_D96(d)s\_v5 | 96 vCPU, 384 GiB | 163,450 |
| Da(d)sv5-series | Standard_D2a(d)_s_v5 | 2 vCPU, 8 GiB | 3,070 |
| Da(d)sv5-series | Standard_D4a(d)_s_v5 | 4 vCPU, 16 GiB | 6,140 |
| Da(d)sv5-series | Standard_D8a(d)_s_v5 | 8 vCPU, 32 GiB | 12,281 |
| Da(d)sv5-series | Standard_D16a(d)_s_v5 | 16 vCPU, 64 GiB | 25,562 |
| Da(d)sv5-series | Standard_D32a(d)_s_v5 | 32 vCPU, 128 GiB | 49,123 |
| Da(d)sv5-series | Standard_D48a(d)_s_v5 | 48 vCPU, 196 GiB | 73,685 |
| Da(d)sv5-series | Standard_D64a(d)_s_v5 | 64 vCPU, 256 GiB | 98,247 |
| Da(d)sv5-series | Standard_D96a(d)_s_v5 | 96 vCPU, 384 GiB | 147,370 |
| Edsv4-series | Standard\_E2ds\_v4 | 2 vCPU, 16 GiB | 3,142 |
| Edsv4-series | Standard\_E4ds\_v4 | 4 vCPU, 32 GiB | 6,284 |
| Edsv4-series | Standard\_E8ds\_v4 | 8 vCPU, 64 GiB | 12,569 |
| Edsv4-series | Standard\_E16ds\_v4 | 16 vCPU, 128 GiB | 25,138 |
| Edsv4-series | Standard\_E20ds\_v4 | 20 vCPU, 160 GiB | 31,422 |
| Edsv4-series | Standard\_E32ds\_v4 | 32 vCPU, 256 GiB | 50,275 |
| Edsv4-series | Standard\_E48ds\_v4 | 48 vCPU, 384 GiB | 75,413 |
| Edsv4-series | Standard\_E64ds\_v4 | 64 vCPU, 504 GiB | 100,550 |
| E(d)sv5-series | Standard\_E2(d)s\_v5 | 2 vCPU, 16 GiB | 3,405 |
| E(d)sv5-series | Standard\_E4(d)s\_v5 | 4 vCPU, 32 GiB | 6,810 |
| E(d)sv5-series | Standard\_E8(d)s\_v5 | 8 vCPU, 64 GiB | 13,621 |
| E(d)sv5-series | Standard\_E16(d)s\_v5 | 16 vCPU, 128 GiB | 27,242 |
| E(d)sv5-series | Standard\_E20(d)s\_v5 | 20 vCPU, 160 GiB | 34,052 |
| E(d)sv5-series | Standard\_E32(d)s\_v5 | 32 vCPU, 256 GiB | 54,483 |
| E(d)sv5-series | Standard\_E48(d)s\_v5 | 48 vCPU, 384 GiB | 81,725 |
| E(d)sv5-series | Standard\_E64(d)s\_v5 | 64 vCPU, 512 GiB | 108,967 |
| E(d)sv5-series | Standard\_E96(d)s\_v5 | 96 vCPU, 672 GiB | 163,450 |
| Ea(d)sv5-series | Standard\_E2a(d)s\_v5 | 2 vCPU, 16 GiB | 3,070 |
| Ea(d)sv5-series | Standard\_E4a(d)s\_v5 | 4 vCPU, 32 GiB | 6,140 |
| Ea(d)sv5-series | Standard\_E8a(d)s\_v5 | 8 vCPU, 64 GiB | 12,281 |
| Ea(d)sv5-series | Standard\_E16a(d)s\_v5 | 16 vCPU, 128 GiB | 24,562 |
| Ea(d)sv5-series | Standard\_E20a(d)s\_v5 | 20 vCPU, 160 GiB | 30,702 |
| Ea(d)sv5-series | Standard\_E32a(d)s\_v5 | 32 vCPU, 256 GiB | 49,123 |
| Ea(d)sv5-series | Standard\_E48a(d)s\_v5 | 48 vCPU, 384 GiB | 73,685 |
| Ea(d)sv5-series | Standard\_E64a(d)s\_v5 | 64 vCPU, 512 GiB | 98,247 |
| Ea(d)sv5-series | Standard\_E96a(d)s\_v5 | 96 vCPU, 672 GiB | 147,370 |
| GS-series | Standard\_GS1 | 2 vCPU, 28 GiB | 3,580 |
| GS-series | Standard\_GS2 | 4 vCPU, 56 GiB | 6,900 |
| GS-series | Standard\_GS3 | 8 vCPU, 112 GiB | 11,870 |
| GS-series | Standard\_GS4 | 16 vCPU, 224 GiB | 22,680 |
| GS-series | Standard\_GS5 | 32 vCPU, 448 GiB | 41,670 |
| M-series | Standard\_M8ms | 8 vCPU, 219 GiB | 8,616 |
| M-series | Standard\_M16ms | 16 vCPU, 438 GiB | 17,232 |
| M-series | Standard\_M32ts | 32 vCPU, 192 GiB | 33,670 |
| M-series | Standard\_M32ls | 32 vCPU, 256 GiB | 33,670 |
| M-series | Standard\_M32ms | 32 vCPU, 875 GiB | 34,465 |
| M-series | Standard\_M64ls | 64 vCPU, 512 GiB | 66,600 |
| M-series | Standard\_M64s | 64 vCPU, 1024 GiB | 67,315 |
| M-series | Standard\_M64ms | 64 vCPU, 1792 GiB | 68,930 |
| M-series | Standard\_M128s | 128 vCPU, 2048 GiB | 134,630 |
| M-series | Standard\_M128ms | 128 vCPU, 3892 GiB | 134,630 |
| Mv2-series | Standard\_M208s\_v2 | 208 vCPU, 2.85 TiB | 259,950 |
| Mv2-series | Standard\_M208ms\_v2 | 208 vCPU, 5.7 TiB | 259,950 |
| Mv2-series | Standard\_M416s\_v2 | 416 vCPU, 5.7 TiB | 488,230 |
| Mv2-series | Standard\_M416s\_8\_v2 | 416 vCPU, 7.6 TiB | 488,230 |
| Mv2-series | Standard\_M416ms\_v2 | 416 vCPU, 11.4 TiB | 488,230 |
| Msv2-series | Standard\_M32ms\_v2 | 32 vCPU, 875 GiB | 42,711 |
| Msv2-series | Standard\_M64s\_v2 | 64 vCPU, 1024 GiB | 85,432 |
| Msv2-series | Standard\_M64ms\_v2 | 64 vCPU, 1792 GiB | 85,432 |
| Msv2-series | Standard\_M128s\_v2 | 128 vCPU, 2048 GiB | 170,846 |
| Msv2-series | Standard\_M128ms\_v2 | 128 vCPU, 3892 GiB | 170,846 |
| Msv2-series | Standard\_M192is\_v2 | 192 vCPU, 2048 GiB | 256,750 |
| Msv2-series | Standard\_M192ims\_v2 | 192 vCPU, 4096 GiB | 256,750 |
| Mdsv2-series | Standard\_M32dms\_v2 | 32 vCPU, 875 GiB | 42,711 |
| Mdsv2-series | Standard\_M64ds\_v2 | 64 vCPU, 1024 GiB | 85,432 |
| Mdsv2-series | Standard\_M64dms\_v2 | 64 vCPU, 1792 GiB | 85,432 |
| Mdsv2-series | Standard\_M128ds\_v2 | 128 vCPU, 2048 GiB | 170,846 |
| Mdsv2-series | Standard\_M128dms\_v2 | 128 vCPU, 3892 GiB | 170,846 |
| Mdsv2-series | Standard\_M192ids\_v2 | 192 vCPU, 2048 GiB | 256,750 |
| Mdsv2-series | Standard\_M192idms\_v2 | 192 vCPU, 4096 GiB | 256,750 |
| Msv3-series | Standard\_M12s\_v3 | 12 vCPU, 240 GiB | 17,531 |
| Msv3-series | Standard\_M24s\_v3 | 24 vCPU, 480 GiB | 35,062 |
| Msv3-series | Standard\_M48s\_1\_v3 | 48 vCPU, 974 GiB | 70,124 |
| Msv3-series | Standard\_M96s\_1\_v3 | 96 vCPU, 974 GiB | 140,247 |
| Msv3-series | Standard\_M96s\_2\_v3 | 96 vCPU, 1,946 GiB | 140,247 |
| Msv3-series | Standard\_M176s\_3\_v3 | 176 vCPU, 2,794 GiB | 257,120 |
| Msv3-series | Standard\_M176s\_3\_v4 | 176 vCPU, 3,750 GiB | 257,120 |
| Mdsv3-series | Standard\_M12ds\_v3 | 12 vCPU, 240 GiB | 17,531 |
| Mdsv3-series | Standard\_M24ds\_v3 | 24 vCPU, 480 GiB | 35,062 |
| Mdsv3-series | Standard\_M48dv\_1_v3 | 48 vCPU, 974 GiB | 70,124 |
| Mdsv3-series | Standard\_M96ds\_1\_v3 | 96 vCPU, 974 GiB | 140,247 |
| Mdsv3-series | Standard\_M96ds\_2\_v3 | 96 vCPU, 1,946 GiB | 140,247 |
| Mdsv3-series | Standard\_M176ds\_3\_v3 | 176 vCPU, 2,794 GiB | 257,120 |
| Mdsv3-series | Standard\_M176ds\_4\_v3 | 176 vCPU, 3,750 GiB | 257,120 |

- [SAP Note \#1928533](https://me.sap.com/notes/1928533) provides an up-to-date listing of Azure Virtual Machine SKUs supported for non-HANA RDBMS platforms serving SAP workloads. At the time of authoring this content, the listing was as reproduced above.
- All **A8**-**A11** virtual machines were retired in March 2021. For more information, see [Previous generations of virtual machine sizes](/azure/virtual-machines/sizes-previous-gen).
- **Dsv3-series**, **Edsv4-series**: CPU hyperthreading enabled on the hypervisor layer.
- **D(d)sv5-series**, **Da(d)sv5-series**: Only usage of Azure Gen2 virtual machine format is supported. CPU hyperthreading enabled on the hypervisor layer. Supported OS versions: Windows Server 2012 R2 and higher, SLES 12 SP4 and higher, Red Hat Enterprise Linux 7.6 and higher, Oracle Linux 7.7 and higher. Base VHD minimum size supported for virtual machines without temp disk Standard\_Dsv5 or Standard\_Das_v5: 128GB.
- **E(d)sv5-series**, **Ea(d)sv5-series**: Only usage of Azure Gen2 virtual machine format is supported. CPU hyperthreading enabled on the hypervisor layer. Supported OS versions: Windows Server 2012 R2 and higher, SLES 12 SP4 and higher, Red Hat Enterprise Linux 7.6 and higher, Oracle Linux 7.7 and higher. Base VHD minimum size supported for virtual machines without temp disk Standard\_Es_v5 or Standard\_Eas_v5: 128GB.
- **M-series**: CPU hyperthreading enabled on the hypervisor layer. Supported OS versions: Windows Server 2016, 2019, and 2022; SLES 12 SP4 and higher; Red Hat Enterprise Linux 7.6 and higher; Oracle Linux 7.3 and higher.
- **Mv2-series**, **Msv2-series**, **Mdsv2-series**: CPU hyperthreading enabled on the hypervisor layer. Supported OS versions: Windows Server 2016, 2019, and 2022; SLES 12 SP4 and higher; Red Hat Enterprise Linux 7.6 and higher; Oracle Linux 7.7 and higher. For Windows guest OS Registry Key described in [SAP Note \#2553235](https://me.sap.com/notes/2553235) is required to be applied.
- **Msv2-series**, **Msv3-series**, **Mdsv3-series**: Base VHD minimum size supported is 128 GB.
- **Msv3-series**, **Mdsv3-series**: CPU hyperthreading enabled on the hypervisor layer. Supported OS versions: Windows Server 2019 and 2022; SLES 15 SP4 and higher; Red Hat Enterprise Linux 7.9, 8.6, 8.8, 9.2 and higher; Oracle Linux 7.9, 8.6, 8.7, 9.0, 9.1 and higher.
- SAP performance is measured by relying on the SAP Application Performance Standard metric (SAPS). SAPS is a hardware-independent unit of measurement that describes the performance of a system configuration in the SAP environment. It's derived from the Sales and Distribution benchmark, where 100 SAPS is defined as 2,000 fully business processed order line items per hour. In the Sales and Distribution Benchmark, fully business-processed means the full business process of an order line item, which includes creating the order, creating a delivery note for the order, displaying the order, changing the delivery, posting a goods issue, listing orders, and creating an invoice. Another way to look at the performance rating is to consider that one SAPS is equal to 24 Sales and Distribution transactions per hour. In general SAPS are used to size CPU and memory of an SAP system.
