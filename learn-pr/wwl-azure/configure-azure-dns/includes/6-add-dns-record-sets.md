It's important to understand the difference between **DNS record sets** and individual DNS records. A DNS record set (also known as a _resource record set_) is a collection of records in a DNS zone.

You define record sets in the Azure portal. The configuration settings depend on the record type for the set to create.

Suppose you choose to create a set of `A` records (or _Address record_) to identify IP addresses associated with your domain. To create the `A` records, you need to provide the TTL (time to live) and the IP addresses. The TTL value specifies how long each record is cached by clients.

:::image type="content" source="../media/add-record-sets-e5e85778.png" alt-text="Screenshot that shows how to add a DNS record set in the Azure portal.":::

### Things to know about DNS record sets

Let's examine some characteristics of DNS record sets.

- All records in a DNS record set must have the same name and the same record type.

   Consider the following example where we have two records in a record set. All records have the same name, `www.contoso.com.`. All records have the same record type, `A`. Each record in the set has a different value. In this case, each record provides a different IP address.

   ```console
   www.contoso.com.        3600    IN    A     134.170.185.46
   www.contoso.com.        3600    IN    A     134.170.188.221
   ```

- A DNS record set can't contain two identical records.

- A record set of type `CNAME` can contain only one record.

   A `CNAME` record (or _Canonical name record_) provides an alias of one domain name to another. This record is used to provide another name for your domain. The DNS `lookup` operation tries to find your domain by retrying the `lookup` with the other name specified in the `CNAME` record.

- You can create a record set that doesn't have any records. This set is called an _empty record set_.

- If you have an empty record set for your domain, this set doesn't appear on your Azure DNS name servers.