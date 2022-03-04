It's important to understand the difference between DNS record sets and individual DNS records. A record set is a collection of records in a zone that have the same name and are the same type.

:::image type="content" source="../media/record-sets-470ec9d5.png" alt-text="Screenshot of the Add a record set page.":::


A record set cannot contain two identical records. Empty record sets (with zero records) can be created, but do not appear on the Azure DNS name servers. Record sets of type CNAME can contain one record at most.

The **Add record set** page will change depending on the type of record you select. For an A record, you will need the TTL (Time to Live) and IP address. The time to live, or TTL, specifies how long each record is cached by clients before being requeried.

:::image type="content" source="../media/add-record-sets-e5e85778.png" alt-text="Screenshot of the Add a record page.":::
