Disconnected systems still need new software, security intelligence, and compatible updates. Removing direct internet access moves software-acquisition work into your operating process. It doesn't remove that work.

An *artifact* is a deployable or installable item such as an operating-system image, container image, update package, driver, command-line extension, or application package. An artifact is useful only when its dependencies and the means to verify it are also available.

## Acquire the complete dependency set

A container application can depend on a base image, additional container images, a Helm chart, language packages, configuration, and an external identity endpoint. Downloading its primary image doesn't necessarily make the application deployable offline.

Likewise, an operating-system image might require local update sources, activation arrangements, guest drivers, or application installers. Document each dependency and decide whether to supply it locally, remove it from the design, or handle it through a supported approved exception.

Contoso should maintain an approved artifact manifest. A manifest records what a release contains and how to identify each item. Include the publisher, authenticated source, package version, intended platform combination, digest, signature-validation result, dependencies, acquisition date, scan result, and approval reference.

Keep credentials and signing private keys out of the manifest. Preserve its approval record separately enough that replacing a transferred file doesn't also let the same person silently replace its trusted reference.

## Separate integrity, authenticity, and suitability

*Integrity* asks whether the bytes match the expected bytes. A cryptographic digest such as Secure Hash Algorithm 256-bit (SHA-256) helps detect changes.

*Authenticity* asks whether the artifact came from the expected publisher. It depends on a trusted source, an authenticated manifest, and the publisher's documented signature mechanism. A digest written beside an untrusted file doesn't establish authenticity.

*Suitability* asks whether that authentic artifact is appropriate for this environment. It includes compatibility, licensing, dependency completeness, malware assessment, and change approval. A validly signed package can still be the wrong version.

Use the following flow to make each decision explicit.

:::image type="content" source="../media/artifact-pipeline.svg" alt-text="Diagram that shows software acquisition, verification, transfer, quarantine, approval, and local use." border="false" lightbox="../media/artifact-pipeline.svg":::

The *quarantine area* is a staging location that production consumers can't use as an approved source. Restrict its permissions and keep it separate from the production image catalog or registry.

After every transfer, recalculate digests and compare them with the independently trusted manifest. Update malware-scanning intelligence through its own approved supply process. Use the publisher's supported signature-validation method for the package type. An executable-signature check doesn't validate every file inside an arbitrary archive.

For container workloads, promote approved content to a local registry and use immutable digests where the workload supports them. A mutable tag can point to different content later. Preserve the mapping from the application release to its exact image content.

## Compare an artifact with a trusted SHA-256 digest

The following read-only example uses the built-in `Get-FileHash` command. Run it on a Windows computer that can read the quarantined file. Obtain the expected digest through the approved manifest-verification process, not merely from a text file on the same transfer drive.

```powershell
$ErrorActionPreference = 'Stop'
$artifactPath = Read-Host 'Quarantined artifact path'
$expectedHash = (Read-Host 'SHA-256 from the trusted manifest').Trim()

if ($expectedHash -notmatch '^[0-9A-Fa-f]{64}$') {
    throw 'The approved digest is not a SHA-256 value.'
}

$actual = Get-FileHash -LiteralPath $artifactPath -Algorithm SHA256
if ($actual.Hash -ine $expectedHash) {
    throw 'Integrity mismatch: keep the artifact quarantined.'
}

[pscustomobject]@{
    Integrity = 'Matches supplied digest'
    Authenticity = 'Requires separate provenance and signature approval'
}
```

A match means that the file's digest agrees with the supplied value. The script deliberately doesn't report "safe," "trusted," or "approved." It doesn't scan for malware, validate a publisher signature, inspect dependencies, or import anything.

If the digest doesn't match, stop promotion. Reacquire or investigate the artifact through the approved process. Don't generate a new expected digest from the suspect file and treat that as a successful retry.

## Treat exports as controlled transfers too

Support archives, audit evidence, and self-attestation information can reveal identifiers, topology, configuration, or credentials. Define who can collect each export, where the original is protected, how a transfer copy is reviewed and redacted, and which approved channel receives it.

An air-gapped environment with an uncontrolled USB import or unrestricted diagnostic export still has a weak boundary. Treat both directions as part of the architecture, not as exceptions outside it.
