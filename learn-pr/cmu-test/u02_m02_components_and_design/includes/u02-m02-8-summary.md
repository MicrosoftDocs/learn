<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u02_data_centers\_u02_m02_components_and_design\x-oli-workbook_page\_u02_m02_8_summary.xml -->
##  Data Center Components Summary

- Servers mount into racks, come in incremental heights, called rack units (e.g., 1U, 2U, 3U), and have various depths. Larger cases allow for more expansion and/or redundant components.
- Servers support more CPU sockets and DIMM slots than a desktop or laptop.
- There are many types of PCI express cards available to expand servers, including RAID controllers, network cards (1, 10, or 40 gigabit Ethernet), Infiniband HCAs, storage HBAs, and coprocessors/accelerators, such as GPUs.
- HDDs and SSDs can attach to a host through SATA or SAS and are used as building blocks for larger storage arrays, often employing RAID technology. These arrays can be a directly attached DAS, a remote block device SAN (using FC or iSCSI), or a remote file server NAS (using CIFS or NFS). Distributed file systems use many servers or arrays in parallel to increase performance and resiliency.
- Data center networking topology is often multitier, with the lowest tier switches in the same rack (top of rack) or in the same row (end of row).
- Ethernet remains the de-facto standard for data center networks, is available at a variety of speeds, and works over copper or fibre-optic cables.
- Infiniband is a high-speed interconnect, now popular with HPC, and gaining acceptance in enterprise IT data centers.
- Data centers and server rooms contain racks, raised floors, and cable trays and are designed with strong physical security.
- Power distribution comes from the utility company or a backup generator and typically goes through a UPS, through PDUs, to the rack, and then server level. Some systems improve efficiency by converting AC to DC fewer times and/or decentralizing the UPS.
- Servers are most often cooled through CRACs, which push cold air under a raised floor while taking in hot air and removing the heat through a chilled water loop. That loop is attached to a chiller, which itself removes heat by venting through the air or a secondary loop to a cooling tower. Higher densities/efficiencies can be achieved using in-row cooling with hot-aisle containment. Evaporative cooling is also becoming popular for data centers.
- Safety is important for both equipment and personnel. FM-200 provides fast, safe fire suppression. All metal surfaces should be properly grounded, and safety equipment should be used appropriately.
##  Introduction to Data Centers Quiz

This checkpoint will test your understanding of the material you have learned in this unit so far.