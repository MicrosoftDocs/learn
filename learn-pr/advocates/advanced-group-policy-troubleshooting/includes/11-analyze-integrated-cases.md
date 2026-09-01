These fictional cases apply the same troubleshooting method across different failure domains as a way of operationalizing the content of this module. Each case separates symptom, evidence, reasoning, correction, plus validation.

## Case 1: Kiosk policy is denied

### Symptom

Users who sign in to `KIOSK01` receive their normal desktop. Kiosk restrictions don't apply.

### Selected evidence

- User `Adele` is in `OU=Sales Users`.
- Computer `KIOSK01` is in `OU=Kiosks`.
- Loopback Replace is enabled through `Kiosk Processing`, linked to `OU=Kiosks`.
- `Kiosk User Restrictions` is linked to `OU=Kiosks`.
- The GPO's User Configuration side is enabled.
- `gpresult` shows loopback Replace.
- `Kiosk User Restrictions` is denied as inaccessible.
- Security filtering grants the kiosk user group **Apply Group Policy**.
- **Authenticated Users** was removed.
- The computer has no remaining Read permission.

### Reasoning

Object placement plus loopback mode are correct. Replace mode gathers user settings from the kiosk computer's scope. The GPO is found but denied as inaccessible.

The user group has Apply permission. The computer that retrieves user policy can't read the GPO. This is a read-path failure, not a loopback-precedence failure.

### Root cause

Removing **Authenticated Users** removed computer Read access from the user GPO.

### Smallest safe correction

Retain the intended user group with **Read** plus **Apply Group Policy**. Grant **Authenticated Users** or **Domain Computers** Read through delegation without Apply.

Don't restore broad Apply permission.

### Validation evidence

- Fresh user RSoP shows the GPO applied.
- Operational events show successful retrieval plus user CSE completion.
- Kiosk restrictions appear.
- A non-kiosk computer doesn't receive the restrictions.

## Case 2: Applied policy has no effective result

### Symptom

A supported Windows client reports `Browser Security Policy` as applied. The expected browser restriction remains disabled.

### Selected evidence

- `gpresult` lists the GPO under applied objects.
- The Administrative Templates extension completes successfully.
- The GPO report contains the expected setting.
- The target build supports the policy.
- The effective registry policy value isn't present.
- The device is MDM-enrolled.
- MDM diagnostic data shows an equivalent Policy CSP setting.
- `MDMWinsOverGP` is enabled.

### Reasoning

Scope, retrieval, plus CSE processing succeeded. The missing effective value means RSoP isn't the final authority.

The device has an equivalent MDM policy. `MDMWinsOverGP` can block applicable Group Policy settings that have Policy CSP equivalents.

### Root cause

Two management authorities configure the same setting. MDM has precedence for this applicable Policy CSP setting.

### Smallest safe correction

Assign one authority to the setting. Remove the overlapping assignment from the unintended source through the approved endpoint-management process.

Don't unlink unrelated GPOs or disable MDM enrollment.

### Validation evidence

- MDM diagnostics show one assigned source.
- The effective registry or policy state matches the intended value.
- `gpresult` plus the MDM report no longer describe conflicting ownership.
- Browser behavior matches the effective state.

## Case 3: Policy differs by domain controller

### Symptom

`APP01` receives the new server policy. `APP02` retains the old value. Both computers are in the same organizational unit with equivalent security groups.

### Selected evidence

- `APP01` used `DC01`.
- `APP02` used `DC02`.
- GPMC shows computer version `18`.
- `Get-GPO -Server DC01` reports AD version `18`, SYSVOL version `18`.
- `Get-GPO -Server DC02` reports AD version `18`, SYSVOL version `17`.
- `repadmin /showrepl DC02` shows successful AD DS replication.
- The server-specific `GPT.ini` on `DC02` has the older version.
- DFS Replication events on `DC02` report a paused replicated folder after a disk condition.

### Reasoning

Scope plus AD DS metadata are consistent. The difference follows domain controller selection. The GPC reached `DC02`; the GPT didn't converge.

Client refresh on `APP02` can't correct stale server content.

### Root cause

DFSR for SYSVOL is paused on `DC02`.

### Smallest safe correction

Resolve the reported disk condition. Resume DFSR through the supported operational procedure. Confirm the replicated folder returns to a healthy state.

Don't copy the GPT manually or perform authoritative synchronization for one paused member.

### Validation evidence

- DFSR events report healthy replication.
- `DC02` shows matching GPC plus GPT versions.
- The expected GPT artifacts exist.
- `APP02` processes the new version from `DC02`.
- Effective state matches `APP01`.

## Case 4: Hardening exposes two independent faults

### Symptom

After an LDAP hardening pilot, an inventory application can't query AD DS. Administrators also report slower startup on pilot application servers.

### Selected evidence

- The hardening GPO applies to pilot domain controllers.
- Effective LDAP signing plus channel-binding settings match the intended values.
- Directory Service event 2889 identifies unsigned binds from the inventory server, collected with `16 LDAP Interface Events` temporarily set to `2`.
- The application uses an older LDAP library.
- Application-server Group Policy operational logs show a WMI filter taking 42 seconds.
- The slow WMI filter belongs to a separate server-targeting GPO.
- No Group Policy retrieval failures occur.

### Reasoning

The application outage follows successful hardening enforcement. The dependency uses an incompatible bind.

Startup delay is real but has a separate cause. The WMI filter delay doesn't explain the LDAP bind rejection. Treating both symptoms as one Group Policy failure would lead to the wrong correction.

### Root cause

- Application outage: LDAP client incompatibility.
- Startup delay: expensive WMI filter.

### Smallest safe correction

- Place only the inventory dependency in a time-bound pilot exception while the application library is updated.
- Replace the expensive WMI query with a narrower supported target condition.

Don't disable LDAP protection across the domain.

### Validation evidence

- Updated application uses signed LDAP or correctly configured TLS.
- A repeated inventory-application test produces no further event 2889 while `16 LDAP Interface Events` is still set to `2`.
- The recorded prior `16 LDAP Interface Events` value is restored after validation.
- Exception is removed.
- WMI filter elapsed time falls within the target.
- Group Policy plus application validation both succeed.

## Apply the pattern

Across all four cases in the following order:

1. Define expected state.
1. Preserve the failing instance.
1. Classify the failure domain.
1. Compare equivalent systems.
1. Test one hypothesis.
1. Make the smallest safe correction.
1. Validate policy plus behavior.

The same symptom can cross several domains. Evidence determines whether faults are related.
