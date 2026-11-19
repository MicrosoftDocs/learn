Use these scenarios to distinguish design decisions, configuration ownership, and operational evidence. Select one answer for each question before reading the rationales.

## Interpret a mixed result

An illustrative deployment has correct intents and required status on both nodes. A TCP 445 probe succeeds, but active SMB connections use management interfaces and the expected storage VLAN is absent from one switch path.

The host configuration gates have passed, but storage workload acceptance hasn't. Investigate the fabric and source-path selection before changing migration concurrency or RDMA technology. Neither the successful TCP probe nor the provisioning status proves the intended storage path.

For a change review, state the decision in operational terms: don't place the workload on the unaccepted path, identify the missing dependency, correct it through its owner, and repeat end-to-end acceptance.
