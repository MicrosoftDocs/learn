In this practical exercise you work end to end in an isolated lab forest: inspect a site topology and spot its defects, validate DC Locator under the Windows Server 2025 DNS-only default, read replication metadata to prove convergence, diagnose an induced replication failure, and apply a Replication Priority Boost. Every step uses fictitious names and runs only against lab systems.

> [!CAUTION]
> Perform this exercise **only in an isolated lab forest**. It induces a replication failure and modifies RootDSE replication priority. Never run these steps against production. 

## Lab prerequisites

- An isolated forest `contoso.com` with at least two Windows Server 2025 domain controllers: `NYDC1` (site `NewYork`) and `CHIDC1` (site `Chicago`). A third DC `BRDC1` in site `Branch` is optional but useful for the priority-boost step.
- One site link `NY-CHI` joining `NewYork` and `Chicago`.
- A management workstation (or one of the DCs) with RSAT: the Active Directory module for Windows PowerShell, `repadmin`, `dcdiag`, `nltest`, and **Ldp.exe**.
- Domain/Enterprise Admin credentials.

```powershell
# Baseline: confirm DCs, sites, and that the DCs run Windows Server 2025
Get-ADDomainController -Filter * |
    Select-Object Name, Site, IPv4Address, OperatingSystem | Sort-Object Site
Get-ADReplicationSite -Filter * | Select-Object Name
```

## Exercise 1 - Inspect and evaluate the site topology

1. Enumerate the topology objects and look for the anti-patterns from earlier in the module:

    ```powershell
    Get-ADReplicationSubnet -Filter * | Select-Object Name, Site | Sort-Object Site
    Get-ADReplicationSiteLink -Filter * |
        Select-Object Name, Cost, ReplicationFrequencyInMinutes, SitesIncluded
    Get-ADReplicationSite -Filter * |
        ForEach-Object { [pscustomobject]@{ Site = $_.Name
            DCs = (Get-ADDomainController -Filter "Site -eq '$($_.Name)'").Count } }
    ```

1. Answer for your lab:

    - **Subnets:** Is every DC's subnet mapped to exactly one site? Are there sites with subnets but no DC (relying on automatic site coverage)?
    - **Site links:** Does any link contain three or more sites? Is every link still at the default cost `100` and interval `180`?
    - **Coverage:** For any DC-less site, which DC covers it, and is that the intended least-cost neighbor?

1. See how the engine evaluated the intersite topology and chose bridgeheads:

    ```cmd
    repadmin /istg
    repadmin /bridgeheads /verbose
    repadmin /showism
    ```

1. Improve one defect, then confirm the change. For example, lower the link interval and enable inter-site change notification on a fast lab link. First save the actual initial interval and option state. Run this block as a single script from a writable working directory, and keep the baseline file for cleanup. For a repeat run, use a fresh directory or file name rather than overwrite an earlier baseline:

    ```powershell
    $server = 'NYDC1.contoso.com'
    $link = Get-ADReplicationSiteLink -Identity 'NY-CHI' `
        -Properties options -Server $server -ErrorAction Stop
    $baseline = [pscustomobject]@{
        Server = $server
        LinkDN = $link.DistinguishedName
        Interval = $link.ReplicationFrequencyInMinutes
        HadOptions = ($null -ne $link.options)
        Options = [int]$link.options
    }
    $baseline | Export-Clixml -LiteralPath '.\NY-CHI-before.xml' `
        -NoClobber -ErrorAction Stop

    Set-ADReplicationSiteLink -Identity $baseline.LinkDN -Server $server `
        -ReplicationFrequencyInMinutes 15 `
        -Replace @{ options = ($baseline.Options -bor 1) } -ErrorAction Stop

    Get-ADReplicationSiteLink -Identity $baseline.LinkDN -Server $server `
        -Properties options -ErrorAction Stop |
        Select-Object Name, ReplicationFrequencyInMinutes, options
    ```

    > [!IMPORTANT]
    > The `options` attribute is a bitfield. Set only the intended bit, preserving other flags. Restore the recorded initial state, not assumed defaults. This rollback example assumes no one else edits the isolated lab link during the exercise.

**Expected result:** You can name each site's bridgehead and ISTG, identify at least one topology defect, and verify a corrected site-link property.

## Exercise 2 - Validate DC Locator on Windows Server 2025

Run this exercise locally on `NYDC1` or `CHIDC1`, both of which run Windows Server 2025 in this lab. For additional client tests, record each client's OS and effective discovery policy separately. Don't infer a client's policy from the DC it locates.

1. Confirm the local OS, then check whether `BlockNetBIOSDiscovery` is explicitly configured. An absent policy value on Windows Server 2025 doesn't mean NetBIOS-style discovery is allowed. Handle missing keys or values intentionally, without suppressing registry read errors:

    ```powershell
    Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction Stop |
        Select-Object Caption, Version, BuildNumber

    $path = 'HKLM:\Software\Policies\Microsoft\Netlogon\Parameters'
    $value = $null
    if (Test-Path -LiteralPath $path -ErrorAction Stop) {
        $keyProperties = Get-ItemProperty -LiteralPath $path -ErrorAction Stop
        $policyProperty = $keyProperties.PSObject.Properties['BlockNetBIOSDiscovery']
        if ($null -ne $policyProperty) {
            $value = $policyProperty.Value
        }
    }

    if ($null -eq $value) {
        'Not configured. On Windows Server 2025, NetBIOS-style discovery is blocked by default.'
    }
    else {
        switch ($value) {
            0 { 'Policy permits legacy discovery, subject to other legacy constraints.' }
            1 { 'Policy blocks NetBIOS-style discovery.' }
            default { throw "Unexpected BlockNetBIOSDiscovery value: $value" }
        }
    }
    ```

    A value of `1`, or no configured policy value on Windows Server 2025, means Netlogon uses DNS-based discovery only, with no NetBIOS/mailslot fallback. If the value is `0`, record the override and use a Windows Server 2025 lab computer with the default blocking behavior or an explicit value of `1` for this DNS-only exercise.

1. Discover a DC and compare its reported site with the calling computer's expected site. Don't treat discovery success alone as proof that the selected DC is site-local:

    ```cmd
    nltest /dsgetdc:contoso.com /force
    nltest /dsgetsite
    nltest /dsaddresstosite:<a-lab-client-IP>
    ```

    ```powershell
    Get-ADDomainController -Discover -DomainName contoso.com -SiteName "Chicago"
    ```

    The `-SiteName "Chicago"` request checks discovery for that specified site. It doesn't establish the calling computer's own subnet-to-site mapping.

1. Inspect the DNS records used for domain-wide discovery and site selection:

    ```cmd
    dcdiag /test:DNS /DnsRecordRegistration /v
    dcdiag /test:LocatorCheck
    nslookup -type=SRV _ldap._tcp.dc._msdcs.contoso.com
    nslookup -type=SRV _ldap._tcp.Chicago._sites.dc._msdcs.contoso.com
    ```

1. Reflect: if a client has no usable site mapping or site-specific records, can it still discover a DC through domain-wide DNS? Which DC does it select, and what is the effect on locality?

**Expected result:** You establish the discovery policy on the tested Windows Server 2025 computer, locate a DC through DNS, and compare the returned DC site with the client's expected site. A successful remote-DC result can demonstrate a locality problem rather than a discovery failure.

## Exercise 3 - Read replication metadata and prove convergence

1. Create a change on `NYDC1` and trace its USN, then force replication to `CHIDC1`. (If the lab `OU=Eng` and `Engineers` group don't already exist, create them first.)

    ```powershell
    New-ADOrganizationalUnit -Name "Eng" -Path "DC=contoso,DC=com" -Server "NYDC1.contoso.com" -ErrorAction SilentlyContinue
    New-ADOrganizationalUnit -Name "Groups" -Path "DC=contoso,DC=com" -Server "NYDC1.contoso.com" -ErrorAction SilentlyContinue
    New-ADGroup -Name "Engineers" -GroupScope Global -Path "OU=Groups,DC=contoso,DC=com" -Server "NYDC1.contoso.com" -ErrorAction SilentlyContinue
    New-ADUser -Name "Ada Lovelace" -SamAccountName ada -Path "OU=Eng,DC=contoso,DC=com" `
        -Server "NYDC1.contoso.com" -Enabled $true -AccountPassword (Read-Host -AsSecureString)
    Get-ADReplicationPartnerMetadata -Target "CHIDC1.contoso.com" -Partition "DC=contoso,DC=com"
    repadmin /replicate CHIDC1 NYDC1 "DC=contoso,DC=com"
    ```

1. Compare USNs and per-attribute metadata on both DCs. Note that the **current USN** differs but the **originating** stamp is identical:

    ```cmd
    repadmin /showobjmeta NYDC1  "CN=Ada Lovelace,OU=Eng,DC=contoso,DC=com"
    repadmin /showobjmeta CHIDC1 "CN=Ada Lovelace,OU=Eng,DC=contoso,DC=com"
    ```

1. Read the two vectors and the DC signatures:

    ```cmd
    repadmin /showrepl CHIDC1 /verbose
    repadmin /showutdvec CHIDC1 dc=contoso,dc=com
    repadmin /showsig CHIDC1
    ```

1. Inspect linked-value metadata by changing a group membership, then deleted-object metadata by deleting the user:

    ```powershell
    Add-ADGroupMember -Identity "Engineers" -Members ada -Server "NYDC1.contoso.com"
    Get-ADReplicationAttributeMetadata -Object "CN=Engineers,OU=Groups,DC=contoso,DC=com" `
        -Server "NYDC1.contoso.com" -ShowAllLinkedValues |
        Where-Object AttributeName -eq 'member' |
        Select-Object AttributeValue, Version, LastOriginatingChangeTime

    Remove-ADUser ada -Server "NYDC1.contoso.com" -Confirm:$false
    Get-ADObject -IncludeDeletedObjects -SearchBase "DC=contoso,DC=com" `
        -LDAPFilter "(&(isDeleted=TRUE)(sAMAccountName=ada))" `
        -Properties whenChanged, lastKnownParent, isRecycled
    ```

**Expected result:** You can prove `CHIDC1` is converged with `NYDC1` from the up-to-dateness vector, explain why current USNs differ while originating metadata matches, and locate the deleted user in the **Deleted Objects** container.

## Exercise 4 - Diagnose an induced replication failure

1. On `CHIDC1` (the destination DC that pulls from `NYDC1`), induce a failure by blocking the outbound replication RPC path to `NYDC1`. If you're running from a management workstation, run the command in a remote session to `CHIDC1`; don't create the rule on the workstation.

    ```powershell
    # Run on CHIDC1. From a management workstation, wrap this in Invoke-Command -ComputerName CHIDC1.
    New-NetFirewallRule -DisplayName "LAB-Block-Repl" -Direction Outbound `
        -RemoteAddress (Resolve-DnsName NYDC1.contoso.com).IPAddress `
        -Protocol TCP -RemotePort 135 -Action Block
    ```

1. Detect it from the top down, then read the specific error:

    ```cmd
    repadmin /replsummary
    repadmin /showrepl CHIDC1 /verbose
    dcdiag /test:Replications /test:CheckSecurityError /s:CHIDC1 /v
    ```

1. Map the error you see (expect `1722 RPC server unavailable`) to its cause using the table from the previous unit, then remove the firewall rule from `CHIDC1` and confirm recovery:

    ```powershell
    # Run on CHIDC1, or use Invoke-Command -ComputerName CHIDC1 from a management workstation.
    Remove-NetFirewallRule -DisplayName "LAB-Block-Repl"
    ```

    ```cmd
    repadmin /replicate CHIDC1 NYDC1 "DC=contoso,DC=com"
    repadmin /showrepl CHIDC1 /verbose
    ```

**Expected result:** You detected the failure from `repadmin /replsummary`, identified the failing partner and Win32 error, and confirmed the *last success* time advances after you clear the block.

## Exercise 5 - Apply a Replication Priority Boost

Simulate the over-the-wire promotion scenario: you want `CHIDC1` to service the domain NC from `NYDC1` ahead of its other partners.

1. Get the source DC's DSA `objectGUID`—the partner GUID you boost:

    ```powershell
    (Get-ADDomainController -Identity NYDC1).NTDSSettingsObjectDN
    Get-ADObject (Get-ADDomainController -Identity NYDC1).NTDSSettingsObjectDN -Properties objectGUID |
        Select-Object -ExpandProperty objectGUID
    ```

1. On the **Windows Server 2025** destination `CHIDC1`, open **Ldp.exe**, connect and bind, then **Browse > Modify** with an empty **DN** (RootDSE). Add attribute `setPriorityBoost` with the value (boost factor `10` makes the domain NC outrank the configuration NC):

    ```text
    DC=contoso,DC=com:<NYDC1-DSA-objectGUID>:10
    ```

    Set the operation to **Add** and **Run**; expect `Modified ""`.

1. Confirm the boost via the parameterized `msDS-PriorityBoost` RootDSE attribute. In **Browse > Search**, leave **Base DN** empty, set **Scope** to **Base**, use filter `(objectClass=*)`, and request this attribute:

    ```text
    "msDS-PriorityBoost;parameter=DC=contoso,DC=com:<NYDC1-DSA-objectGUID>"
    ```

    The LDP output should return the same parameterized attribute with value `10`.

1. Generate change on `NYDC1`, force convergence, and observe that the boosted partner is serviced first:

    ```cmd
    repadmin /queue CHIDC1
    repadmin /replicate CHIDC1 NYDC1 "DC=contoso,DC=com"
    repadmin /showrepl CHIDC1 /verbose
    ```

**Expected result:** The parameterized `msDS-PriorityBoost` read returns value `10`, and `CHIDC1` prioritizes the domain NC from `NYDC1`. You can explain when this boost is appropriate—and when fixing site cost or topology is the better answer.

## Clean up

```powershell
# Remove any lab firewall rule still present
# Run on CHIDC1, or use Invoke-Command -ComputerName CHIDC1 from a management workstation.
Get-NetFirewallRule -DisplayName "LAB-Block-Repl" -ErrorAction SilentlyContinue | Remove-NetFirewallRule
# Reset the priority boost in LDP: Browse > Modify, attribute setPriorityBoost,
#   value <NC>:<partner DSA GUID>:0, operation Replace, then verify msDS-PriorityBoost.
```

If you changed the site link in Exercise 1, restore its saved baseline. Return to the computer and working directory where you saved `NY-CHI-before.xml`, or supply that file's full path. If you used a different file name, use the same name here. Don't substitute assumed defaults if the baseline file is missing.

```powershell
$baseline = Import-Clixml -LiteralPath '.\NY-CHI-before.xml' -ErrorAction Stop
$restore = @{
    Identity = $baseline.LinkDN
    Server = $baseline.Server
    ReplicationFrequencyInMinutes = $baseline.Interval
    ErrorAction = 'Stop'
}
if ($baseline.HadOptions) {
    Set-ADReplicationSiteLink @restore `
        -Replace @{ options = [int]$baseline.Options }
}
else {
    Set-ADReplicationSiteLink @restore -Clear options
}

Get-ADReplicationSiteLink -Identity $baseline.LinkDN `
    -Server $baseline.Server -Properties options -ErrorAction Stop |
    Select-Object Name, ReplicationFrequencyInMinutes, options
```

You've now explored the full lifecycle: design evaluation, DC Locator validation under the Windows Server 2025 DNS-only default, metadata-based convergence proof, failure diagnosis, and targeted priority control. The summary consolidates these into a checklist you can carry into production reviews.
