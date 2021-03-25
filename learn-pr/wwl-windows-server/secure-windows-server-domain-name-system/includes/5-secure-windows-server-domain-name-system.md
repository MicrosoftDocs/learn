Because DNS is a critical network service, IT infrastructure staff at Contoso are concerned about securing the DNS service. Windows Server DNS provides several options for protecting the DNS server role, including:

- DNS cache locking.
- DNS socket pool.
- DNS-Based Authentication of Named Entities (DANE).
- Response rate limiting (RRL).
- Unknown record support.
- Domain Name System Security Extensions (DNSSEC).

## DNS cache locking

Cache locking is a Windows Server  security feature that you can use to control when information in the DNS cache can be overwritten. When a recursive DNS server responds to a query, the server caches the results so that it can respond quickly if it receives another query requesting the same information.

The period of time that the DNS server keeps information in its cache is determined by a resource record’s TTL value. Information in the cache can be overwritten before the TTL expires if updated information about that resource record is received. If a malicious user successfully overwrites information in the cache, then the malicious user might be able to redirect your network traffic to a malicious site.

When you use cache locking, the DNS server prohibits cached records from being overwritten for the duration of the TTL value.

You configure cache locking as a percentage value. For example, if the cache locking value is set to 50, the DNS server will not overwrite a cached entry for half of the duration of the TTL. By default, the cache locking percentage value is 100. This means that cached entries will not be overwritten for the entire duration of the TTL.

You can configure cache locking by using the running `dnscmd /Config /CacheLockingPercent <percent>` at an elevated command prompt.

> [!TIP]
> You can also use the Windows PowerShell `Set-DnsServerCache –LockingPercent` cmdlet

## DNS socket pool

The DNS socket pool enables a DNS server to use source port randomization when issuing DNS queries. When the DNS service starts, the server chooses a source port from a pool of sockets that are available for issuing queries. Instead of using a predicable source port, the DNS server uses a random port number that it selects from the DNS socket pool.

The DNS socket pool makes cache-tampering attacks more difficult because a malicious user must correctly guess both the source port of a DNS query and a random transaction ID to successfully run the attack.

> [!NOTE]
> The DNS socket pool is enabled by default in Windows Server.

The larger the value, between 0 and 10,000, the greater the protection you will have against DNS spoofing attacks.

> [!NOTE]
> The default size of the DNS socket pool is 2,500.

You can configure the DNS socket pool size by running `dnscmd /Config /SocketPoolSize <value>` from an elevated command prompt.

## DANE

The DANE protocol is a feature available in the Windows Server DNS Server role. DANE allows you to use Transport Layer Security Authentication (TLSA) records to provide information to DNS clients that state the Certification Authority (CA) from which clients should expect a certificate for your domain name. This prevents man-in-the-middle attacks, where someone might corrupt the DNS cache to point to their website, and provide a certificate they issued from a different CA.

For example, suppose that your organization hosts a secure website using HTTPS at `www.Contoso.com` by using a certificate from a well-known authority named CANorth. Someone might still be able to get a certificate for `www.Contoso.com` from a relatively unknown, different certificate authority named CAEast.

At that point, an entity hosting non-legitimate `www.Contoso.com` website might be able to corrupt the DNS cache of a client or server to point `www.Contoso.com` over on its fake site. The end user is presented a certificate from CAEast and might unknowingly acknowledge it and connect to the non-legitimate site.

With DANE, the client makes a request to the DNS server for `Contoso.com` asking for the TLSA record and discovers that the certificate for `www.Contoso.com` was issued by CANorth. If offered a certificate from another CA, it terminates the connection.

## RRL

RRL is an enhancement of the DNS protocol that can help mitigate DNS amplification attacks. An amplification attack is a type of Distributed Denial of Service (DDoS) where attackers use publicly accessible open DNS servers to flood a target system with DNS response traffic. The main method involves an attacker sending a DNS name lookup request to an open DNS server with the source address spoofed to be the target’s address.

When the DNS server sends the DNS record response, it is sent to the target instead. You can avoid this by enabling RRL on your DNS servers. RRL constantly monitors client DNS queries and if a lot of queries originate from a single source asking for similar names within a specified short period, RRL flags them as potentially malicious. RRL can simply ignore the queries or reply to them in truncation, which forces the client to negotiate a TCP three-way handshake for confirmation.

## Unknown record support

Records that are not explicitly supported by the Windows DNS server can be added in a Windows Server DNS zone by using the unknown record functionality. This means that you can add the unsupported record types to the Windows DNS server zones in a binary format. A Windows Server DNS server will not do any record-specific processing for the unknown records, but will send the resolution back in responses if queries are received for that record.
