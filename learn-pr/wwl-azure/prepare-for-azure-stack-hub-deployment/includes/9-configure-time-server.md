You can use the privileged endpoint (PEP) to update the time server in Azure Stack Hub. Use a host name that resolves to two or more NTP (Network Time Protocol) server IP addresses.

Azure Stack Hub uses NTP to connect to time servers on the internet. NTP servers provide accurate system time. Time is used across Azure Stack Hub's physical network switches, hardware lifecycle host, infrastructure service, and virtual machines. If the clock isn't synchronized, Azure Stack Hub may experience severe issues with the network and authentication. Log files, documents, and other files may be created with incorrect timestamps.

Providing one time server (NTP) is required for Azure Stack Hub to synchronize time. When you deploy Azure Stack Hub, you provide the address of an NTP server. Time is a critical datacenter infrastructure service. If the service changes, you need to update the time.

## Configure time

1.  Connect to the privileged endpoint PEP.
2.  Run the following command to review the current configured NTP server:
    
    ```
    Get-AzsTimeSource
    
    ```

3.  Run the following command to update Azure Stack Hub to use the new NTP server and to immediately synchronize the time.
    
    ```
    Set-AzsTimeSource -TimeServer NEWTIMESERVERIP -resync
    
    ```

4.  For servers other than Windows-based time servers:
    
    ```
    Set-AzsTimeSource -TimeServer "NEWTIMESERVERIP,0x8" -resync
    
    ```

5.  Review the output of the command for any errors.
