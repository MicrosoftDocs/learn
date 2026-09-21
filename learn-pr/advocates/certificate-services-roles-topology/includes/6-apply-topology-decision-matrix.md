The following matrix compares representative topologies across lifetime cost, operational complexity, assurance, availability, and recovery. Its judgments are relative and must be replaced with organization-specific evidence.

| Candidate topology | Cost | Complexity | Assurance | Availability | Recovery | Appropriate decision |
|---|---|---|---|---|---|---|
| One online enterprise root/issuer | Low initial; potentially extreme incident cost | Low component count | Low: root continuously online and directly issues leaves | Low: one CA/database/key; validation also depends on publication | Root loss or compromise requires broad trust replacement; simplest backup set but largest compromise scope | Lab or explicitly accepted small/noncritical scope; not default production |
| Offline standalone root + one enterprise issuer | Moderate | Moderate ceremony and publication process | High root isolation; issuer remains online exposure | Validation can be resilient; issuance/renewal depends on one issuer | Root and issuer have distinct recovery paths; issuer RTO must fit all renewals | Small production estate if one issuer outage is tolerable within renewal overlap |
| Offline standalone root + two enterprise issuers | Moderate-high | Higher template/configuration consistency and monitoring burden | High root isolation; independent issuer keys can bound failure | High enrollment/maintenance potential if clients and profiles can use either; publication must also be redundant | Either issuer can preserve critical enrollment while the other is restored; two database, key, and HSM recoveries must be tested | Common resilient enterprise reference design |
| Offline root + policy tier + multiple issuers | High | High: extra CA/CRL, renewal, policy, ceremony, and chain | Highest only when policy tier enforces a real independent boundary | Can isolate policy domains but adds validation dependencies and more failure points | More granular containment; longest and most complex full-hierarchy recovery | Regulated/legal/policy separation that can't be achieved through simpler controls |
| Offline root + regional issuers per site/region | High to very high | High configuration and operational consistency burden | Can isolate regions; also multiplies privileged surfaces | High regional continuity if dependencies are truly local | Regional recovery can be bounded, but common AD DS/HSM/publication dependencies may remain | Use only for demonstrated latency, sovereignty, isolation, or regional-RTO requirements |

Interpret each matrix dimension consistently. **Cost** includes staffing, ceremonies, HSMs, licenses and support, monitoring, test environments, and decommissioning rather than only server purchases. **Complexity** is itself a security property because every added component creates more ACLs, keys, databases, URLs, certificates, CRLs, renewals, and failure combinations.

An **assurance** score is meaningful only when it names the threat reduced by each boundary, and **availability** must be evaluated separately for validation, enrollment, renewal, and recovery. **Recovery** is demonstrated only when the key, CA identity, database, configuration, publication, and test issuance have been restored; a successful backup alone isn't proof.

## Applied two-tier enterprise PKI design with two issuing CAs

This scenario applies the preceding criteria to a representative enterprise and makes the tradeoff between issuer resilience and workload segmentation explicit.

### Requirements

The scenario assumes the following business, workload, and recovery requirements:

- One AD DS forest with two major datacenters and smaller connected sites.
- Domain-joined Windows Server 2025 systems, user/device authentication, internal TLS, and selected non-domain systems.
- Critical certificate renewal RTO of four hours; validation must continue during CA maintenance.
- A requirement to isolate the root key and use HSM protection for CA keys.
- A managed-device population that may later require NDES/SCEP.
- Remote and non-domain enrollment that may later require CEP/CES.
- No regulatory requirement for a separate policy/intermediate tier.

### Proposed design

The following table maps each proposed component to its placement, trust boundary, availability behavior, and recovery obligation.

| Component | Placement and role | Key/trust boundary | Availability and recovery design |
|---|---|---|---|
| `<RootCAName>` | Non-domain-joined offline standalone root in controlled custody | Root key in a dedicated offline-capable HSM/partition under quorum | Powered on only for approved ceremonies; protected backup/replica and replacement-HSM test; root CRL schedule with safe operational margin |
| `<IssuingCA01Name>` | Dedicated online enterprise issuing CA in datacenter A | Independent HSM key/partition; Tier 0 administration | Issues approved shared and/or explicitly assigned profiles; has its own database, logs, backup, CRL, monitoring, and restore test |
| `<IssuingCA02Name>` | Dedicated online enterprise issuing CA in datacenter B | Independent HSM key/partition and failure domain where feasible | Can issue critical profiles during CA01 maintenance/loss; configuration parity tested, not assumed |
| AD DS Public Key Services | Forest configuration partition | Templates, Enrollment Services, AIA/CDP, Certification Authorities, and NTAuth are separate governed objects | Monitor replication to representative DCs; forest PKI administration separate from routine CA operation |
| `<PkiWebHost>` publication service | Redundant HTTP service independent of either CA | Publishes CA certificates and CRLs; holds no CA private key | Reachable by domain, non-domain, and relevant extranet relying parties; content freshness and restore tested |
| Online Responder array, if justified | Separate servers in both datacenters | Dedicated OCSP signing profiles/keys and revocation configurations | Deploy only for workloads that consume OCSP; test upstream CRL loss, responder signing renewal, and array failover |
| CEP/CES tier, if required | Separate hardened HTTPS servers behind a tested load balancer | Brokers policy/enrollment across remote/non-domain boundary | Authentication/delegation, state, CA selection, logs, and failover designed before exposure |
| NDES tier, if required | Separate hardened server integrated with device management | Constrained RA/service identities and dedicated SCEP templates | No broad template rights; one-time-password (OTP) and administration endpoints protected; renewal and outage behavior tested |

### Issuing-CA profile strategy

In a **resilience pattern**, both issuers publish the same critical profiles and must produce identical cryptographic, policy, AIA/CDP, audit, and authorization outcomes. Client and enrollment-service selection, duplicate issuance, retry, and pending-request behavior must be tested because common template publication doesn't replicate CA state.

In a **segmentation pattern**, distinct high-risk workloads are assigned to different issuers to limit the scope of compromise. This separation removes immediate alternate issuance for a failed issuer unless a tested emergency publication or migration process can authorize and activate the other CA within the required RTO.

Don't claim both full segmentation and immediate transparent failover without showing how the alternate issuer becomes authorized, compatible, and available within the RTO.

### Trust plan

The trust plan must distribute chain material and grant authentication authority separately. Distribute `<RootCAName>` through forest-appropriate Group Policy or AD DS mechanisms for domain systems and through managed platform or application mechanisms for non-domain systems. Publish both issuing CA certificates through the designed AIA or intermediate-distribution path so clients can construct their chains.

Only CA generations that issue AD DS authentication certificates should be authorized in the following Enterprise NTAuth object:

```text
CN=NTAuthCertificates,CN=Public Key Services,CN=Services,CN=Configuration,<ForestDN>
```

Services that pin an issuer, use a private trust bundle, or interpret policy OIDs need separate application-specific trust configuration. Validate all of these paths from clean domain and non-domain clients rather than relying on the caches of an administrator workstation.

### Administrative model

The administrative model must separate routine, forest-level, HSM, and emergency authority so that one everyday credential can't control all of them. Offline root custodians shouldn't use daily domain administrative credentials. Where assurance requires separation, assign the issuing CA Administrator, Certificate Manager, Auditor, Backup Operator, template administrator, HSM officer, and forest PKI trust administrator functions to distinct principals.

Enterprise Admin credentials should be used only for approved forest-level changes, not routine CA operation, and online PKI roles should be managed from dedicated privileged access workstations. Break-glass identities and HSM recovery material must remain sealed, monitored, tested, and subject to independent approval.

### Availability interpretation

Evaluate the proposed topology against each component failure rather than treating two issuing CAs as universal redundancy. If one issuer is lost, existing certificates remain usable while chain and revocation services are healthy, and critical enrollment can move to the other issuer only for profiles already published and tested there. If both issuers are lost, validation can continue only while previously published chain and revocation data remain available and current, but issuance and renewal stop immediately; restore priority then follows the earliest critical renewal and revocation-signing deadlines.

Loss of `<PkiWebHost>` can make healthy CAs appear failed to clean clients that can't retrieve CA certificates or CRLs, so publication needs its own RTO. Loss of AD DS configuration replication can produce site-specific differences in template discovery, CA metadata, and NTAuth views. Loss of the root has no immediate effect on leaf issuance, but subordinate renewal or revocation and the hierarchy's long-term survival still depend on tested root recovery.

## Key decisions

Use these questions to convert the topology into an evidence-backed architecture decision:

- Which AD CS role services are required, and which servers/zones host them?
- Which CA functions require enterprise template integration, and which require standalone isolation?
- What explicit boundary justifies each hierarchy tier?
- How many issuing CAs are required for renewal RTO, maintenance, geography, capacity, and compromise-containment objectives?
- Are duplicate issuers providing resilience, workload segmentation, or a documented combination?
- Where are AIA/CDP/OCSP publication services hosted so validation survives CA downtime?
- How will each forest, non-domain population, and application receive root and chain trust?
- Which exact CA certificate generations belong in Enterprise NTAuth, and who can change them?
- Which administrative and HSM roles must be separated, and how is break-glass access audited?
- Can root and issuing HSM keys be recovered on supported replacement hardware within their RTO?
- What ceremony keeps the root offline while ensuring timely subordinate and CRL operations?
- Does the selected topology's assurance benefit justify its lifetime cost and recovery complexity?

## Operational risks

The following risks indicate that a topology may look redundant or isolated on a diagram while retaining an unaddressed trust or failure dependency:

- Installing every AD CS role service on a CA and coupling an IIS compromise to the signing service.
- Using legacy Web Enrollment when CEP/CES or native enrollment better matches the workload.
- Treating a second issuing CA as a replica without testing template consistency, client selection, pending requests, HSM, database, and publication.
- Building a CA per site without measured latency, sovereignty, or recovery justification.
- Keeping the root offline without a reliable CRL, ceremony, hardware, credential, and vendor-support schedule.
- Assuming root trust, chain trust, NTAuth authorization, and application trust are interchangeable.
- Publishing a standalone, migrated, third-party, or cross-forest CA to NTAuth without reviewing every authentication profile it can issue.
- Removing an old NTAuth CA generation before dependent authentication certificates are replaced.
- Sharing one HSM chassis, administrator, network, or partition design and calling two CAs independent.
- Enforcing role separation without enough trained staff or a tested recovery/break-glass workflow.
- Exposing CA RPC or enrollment web services directly to an extranet without a designed identity and relay-resistance boundary.
- Counting a backup as recovery proof without restoring the CA identity, key, database, configuration, publication, and test issuance.
