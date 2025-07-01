
Choose the best response for each question.

  

---

## Multiple Choice  
What is the purpose of setting a delete lock on an Azure resource?  
( ) To prevent the resource from being modified  
( ) To allow only administrators to access the resource  
(x) To prevent accidental or unauthorized deletion of the resource {{Correct. A delete lock ensures the resource cannot be deleted until the lock is removed.}}  

---

## Multiple Choice  
Which of the following actions would help minimize Azure costs when creating a virtual machine?  
(x) Selecting a small VM size like Standard_B1s {{Correct. Smaller VM sizes are more cost-effective for basic workloads.}}  
( ) Enabling auto-scaling for the VM {{Incorrect. Auto-scaling is not applicable to individual VMs and does not directly reduce cost.}}  
( ) Using a premium SSD for the OS disk {{Incorrect. Premium SSDs are more expensive and not necessary for cost-saving scenarios.}}  

---

## Multiple Choice  
What happens when a shared access signature (SAS) URL is used after its associated key has been rotated?  
( ) The file becomes read-only  
( ) The SAS URL continues to work until it expires  
(x) The SAS URL becomes invalid and access is denied {{Correct. Rotating the key invalidates any SAS tokens generated with the old key.}}