In this unit, a failure domain means a set of systems or dependencies that can be disrupted by the same event, such as one datacenter, HSM chassis, network path, or administrative compromise.

CA availability has at least four separate service objectives:

- **Validation availability** means existing certificates can build chains and obtain acceptable revocation status.
- **Enrollment availability** covers submission, approval, issuance, retrieval, and installation of new requests.
- **Renewal availability** determines whether existing identities can renew before service interruption. 
- **Administrative and recovery availability** covers the operator's ability to revoke, publish, back up, restore, and investigate.

Don't report "PKI availability" as one number. For each objective, define a recovery time objective (RTO), which is the maximum acceptable restoration time, and where state can be lost, a recovery point objective (RPO), which is the maximum acceptable data-loss interval.

## Multiple issuing CAs

Multiple issuing CAs are independent security principals. They don't become replicas merely because they publish the same templates.

The following table shows the design decisions needed to obtain useful resilience or workload isolation without treating separate CA identities and databases as replicated state.

| Design point | Decision criteria | Security consequence | Expected success indicator |
|---|---|---|---|
| Number of issuers | Enrollment/renewal RTO, maintenance windows, geographic failure domains, profile separation, HSM capacity | More issuers create more private keys, administrators, databases, CRLs, and compromise paths | Loss of one issuer doesn't prevent critical populations from renewing within their window |
| Template/profile publication | A template can be published on one or several enterprise CAs | Inconsistent CA configuration can make the same template produce different policy or publication results | Certificates from either approved issuer meet the same profile and relying-party tests |
| Key separation | Each CA has its own key and certificate | Shared HSM administration or partitions can create a common-mode failure | Keys are independently identifiable, revocable, backed up/recovered, and audited |
| Workload segmentation | Separate high-risk authentication, device, or public-facing workloads when reducing the scope of compromise justifies it | Poor segmentation can increase complexity without constraining privileges | Compromise analysis identifies a bounded certificate population and trust authorization |
| Failure handling | Define request retry, pending-request ownership, and client CA selection | Blind resubmission can create duplicate certificates or inconsistent state | Runbook distinguishes unsubmitted, pending, issued-not-retrieved, and installed requests |

### Issuer independence and failure behavior

Another CA can improve selected service objectives without duplicating requests, database state, or every trust dependency. Each CA database is authoritative only for that CA.

Existing certificates don't fail merely because their issuing CA service stops; they fail when trust, issuer certificates, revocation data, time, or application policy becomes unacceptable. Even so, an unavailable CA can create a near-term outage as renewal windows close or a fresh CRL becomes due. Publishing the same template on two CAs can provide more issuance options, but clients and enrollment services still require testing for CA discovery, selection, retry, duplicate issuance, and ownership of pending requests.

## Geographic placement

Place issuing and enrollment services based on meaningful organizational requirements, rather than assuming that every site needs a CA. 

Consider:

- AD DS site connectivity and configuration-partition replication.
- Client-to-CA RPC/DCOM path for native enrollment.
- CEP/CES or NDES HTTPS latency, proxy, load balancer, and authentication path.
- CA-to-domain-controller, CA-to-HSM, and CA-to-publication dependencies.
- Regional failure domains, data-sovereignty requirements, and operations staffing.
- HSM network latency and the consequence of intersite partition.
- Where requests, CA database records, logs, and certificate identity data may reside.
- Whether a regional outage leaves clients with enough renewal overlap to wait for recovery.

> [!NOTE]
> Prefer fewer well-protected issuing CAs with resilient enrollment paths unless latency, regulation, isolation, or recovery objectives demonstrate the need for regional CAs.

## Enrollment service load balancing

Web role services can be scaled separately from CAs, but the load balancer doesn't remove identity or state constraints.

For CEP, CES, NDES, Web Enrollment, and Online Responder, document:

- TLS name and certificate lifecycle.
- Authentication mechanism and whether source affinity is required, meaning that a client must return to the same web node during a transaction.
- Service-account identity, delegation, protocol transition, and constrained target services.
- Which state is local, shared, or recoverable.
- Health probes that verify the role's dependency, not just TCP 443.
- Request replay, pending request, renewal, and failover behavior.
- Logging correlation from edge to web role to CA request ID.
- Maintenance behavior when one node or one downstream CA is unavailable.

Don't place a generic unauthenticated reverse proxy in front of an enrollment service without proving channel binding between authentication and the protected TLS connection, client identity propagation, relay resistance, and end-to-end authorization.

## CA database and transaction-log capacity

Capacity planning must include:

- Peak and sustained issued/denied/pending request rate.
- Autoenrollment or short-lived-certificate renewal storms.
- Database growth from retained request attributes and issued certificate blobs.
- Transaction-log write rate and storage latency.
- CRL size growth with revoked serials.
- Backup duration, log handling, restore duration, and storage failure domains.
- Query/reporting load and audit retention.
- HSM signing throughput and session limits.

Separating database and transaction-log volumes can improve performance and failure isolation, but it's not a substitute for a consistent supported backup. Record volume sizing, alert thresholds, the RPO and RTO defined for the service, and the result of a restore test.
