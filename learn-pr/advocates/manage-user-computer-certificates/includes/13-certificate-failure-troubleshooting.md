When troubleshooting certificate failures, identify the computer, process identity, application, target name, and expected certificate before modifying trust or permissions.

## Validate the selected certificate

Export the exact public certificate, then perform chain and revocation diagnostics from the intended computer:

```console
certutil.exe -verify -urlfetch "C:\CertWork\server.cer"
```

Inspect the certificate separately for the expected DNS SAN and Server Authentication EKU. Chain verification doesn't validate a requested hostname, connect to the application, or prove private-key access.

For an existing test endpoint that permits the request, make an application-level connection with normal TLS validation:

```console
curl.exe --verbose "https://app.contoso.com/"
```

Inspect the certificate presented by the endpoint and the TLS result. An HTTP authentication or authorization failure can occur after TLS succeeds. For a user authentication certificate, inspect the Client Authentication EKU and perform the actual authentication workflow under the intended user identity rather than applying a server-hostname test.

## Use focused native diagnostics

Inspect the user and machine Personal stores separately:

```console
certutil.exe -user -store My
certutil.exe -store My
```

To inspect one certificate, append its exact thumbprint. The output can identify provider, key-container, and certificate information. Avoid sharing it without reviewing internal names and account details.

Inspect a public file with `certutil.exe -dump`. For a certificate exported without its private key, use chain and URL-fetch diagnostics:

```console
certutil.exe -verify -urlfetch "C:\CertWork\server.cer"
```

This operation can contact locations embedded in the certificate chain. Use approved input files and account for AIA, CDP, OCSP, DNS, firewall, and proxy access. Don't assume the administrator's network context matches the service's context.

Use `certutil.exe -error "<ErrorCode>"` to decode a captured Windows error. Preserve the original code and surrounding context rather than replacing evidence with a guessed diagnosis.

## Capture useful events

CAPI2 operational events expose chain-building and validation activity. The CAPI2 Operational log is disabled by default. Enable it before reproducing the problem to capture certificate chain-building and validation events.

1. Open **Event Viewer** and navigate to **Applications and Services Logs** > **Microsoft** > **Windows** > **CAPI2** > **Operational**.
1. If the log is disabled, select **Enable Log** from its shortcut menu.
1. Reproduce the specific failure and note the time and process context.
1. Inspect the matching events and save the required evidence. Restore the prior logging state after the approved collection if required.

Read the newest CAPI2 events with the native event utility:

```console
wevtutil.exe qe "Microsoft-Windows-CAPI2/Operational" /c:50 /rd:true /f:text
```

No matching events isn't proof of successful validation. Check whether the log was enabled during reproduction and whether the application uses the Windows cryptographic stack. A no-matching-events error should remain distinguishable from inability to access the log.

CertificateServicesClient logs report enrollment and autoenrollment activity. Discover the available channels on the installed Windows version instead of assuming every event lives in one channel:

```console
wevtutil.exe el | findstr.exe /i "CertificateServicesClient"
```

Query a discovered channel by its exact name with `wevtutil.exe qe "<LogName>" /c:50 /rd:true /f:text`.

For Schannel-related TLS errors, inspect recent System events:

```console
wevtutil.exe qe System /q:"*[System[Provider[@Name='Schannel']]]" /c:30 /rd:true /f:text
```

Event text can contain internal hostnames, account identities, URLs, and certificate details. Keep original evidence in approved storage and sanitize extracts before sharing.

## Diagnose missing certificates and keys

If the application can't find a certificate, compare its search context with the actual store. Check user versus computer scope, service-specific stores, EKU requirements, key association, provider compatibility, and selection rules.

If private-key export is unavailable, distinguish a missing key from insufficient access and deliberate non-exportability. Don't bypass hardware or export policy.

If an issued certificate has no usable key, check the request's originating computer and identity. Confirm the pending request and matching public key, then use the appropriate acceptance path. If the key is gone and no recovery copy exists, request a new certificate with a new key.

A PFX import error can reflect a wrong password, damaged file, unsupported package protection, destination permission, or provider problem. Preserve the error and inspect compatibility before blaming the password.

## Diagnose enrollment failures

For a missing template, verify that the CA issues it, the requester has Read and Enroll permissions, and the template supports the user or machine context. Check template and provider compatibility.

For an access-denied result, distinguish local key creation permissions from template eligibility and CA request permission. Elevation doesn't solve every enrollment authorization failure.

For a pending request, preserve its ID and contact the authorized approver. Retrieve the response after issuance. Don't create repeated keys and requests while waiting.

For autoenrollment without a resulting certificate, compare local and applied policy, inspect template permissions, and verify domain and CA connectivity. Correlate processing events and renewal conditions. A successful pulse isn't an issued certificate.

## Diagnose trust and identity failures

A missing intermediate prevents chain construction even when the root is approved. Install the correct intermediate or repair its approved distribution path. Don't promote it to a root.

An untrusted root requires a trust decision, not automatic import of whatever certificate the remote server supplies. Verify the CA and deployment source.

Wrong SAN or EKU requires a correctly issued replacement. Root-store changes can't rewrite the leaf certificate's identity or purpose.

For expiry or not-yet-valid errors, check the clock and validity interval. Use renewal or new issuance as appropriate. Don't remove historical encryption keys merely because a current authentication attempt rejects an expired certificate.

For offline or unknown revocation status, inspect endpoint accessibility, cached status freshness, and application policy. Don't classify unknown as either good or revoked, and don't disable checking as the routine fix.

If removed trust returns, inspect Group Policy, MDM, enterprise distribution, and Windows-managed trust. Change the authoritative source rather than repeating local deletion.

## Diagnose application selection failures

If the service still presents the old certificate, inspect its binding or selection configuration. Check whether it caches certificates, requires a reload, or lacks access to the new key.

If certificate validation succeeds but authentication fails, inspect the application account mapping and authorization. For Active Directory authentication, verify strong mapping and the required issuer trust with the identity administrators.

Record the exact error, request ID where applicable, template, store, account context, thumbprint, and relevant events before changing configuration. Don't disable TLS validation, broaden key permissions, or import unapproved roots to make a diagnostic check pass.
