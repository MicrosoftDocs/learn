The following table provides some detail to help you decide on a particular virtual machine approach for a sensitive workload. You can start with one technology and perhaps add the other over time, depending on your needs.

| **Technology** | **VMs with application enclaves** | **Virtual-machine-level confidentiality** |
|---|---|---|
| Control | Line-by-line code control for application workloads, aimed at developers. | Works at the virtual machine level, which allows for migrating existing virtual machines to take advantage of confidential memory operation. |
| Security model | Applications create Intel SGX enclaves, and applications access secure data from inside the enclave. | AMD SEV-SNP provides integrity and verifiable encryption of the memory used by virtual machines. |
| Memory | Up to 256 GiB memory based on the SKU. | Up to 672 GiB memory based on the SKU. |
| Effort | Have time to plan and develop a customized, confidential virtual machine solution. | Need to move virtualized workloads to a confidential computing environment quickly. |
| Use cases | Customized applications built for confidential computing. | Lift and shift of existing applications to confidential computing. |

The difference between the two approaches can be substantial. If you don't need the line-of-code control offered with the application-enclave-based option and your preference is to migrate existing virtual machines as quickly as possible and use Azure confidential computing capabilities, the virtual machine–level solution might be more appropriate for you. 

### Knowledge check

Choose the best response for each of the questions below. Then select "Check your answers."
