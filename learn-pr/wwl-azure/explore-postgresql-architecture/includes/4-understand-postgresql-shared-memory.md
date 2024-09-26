PostgreSQL uses memory that can be classified as:

- **Local memory** - allocated to each process
- **Shared memory** - used by all processes

### Local memory

Each process in PostgreSQL requires memory for query processing. The following server parameters allow you to define memory usage:

**work_mem** defines memory required for sorting tuples for ORDER BY and DISTINCT operations. This parameter determines the amount of memory available for internal sort operations and hash tables. If you have large amount of available memory and your workload has queries with complex sorting, increasing this parameter value could improve performance by allowing larger scans in-memory before spilling to disk.

However, one complex query could have many sort and hash operations running concurrently. Each operation uses as much memory as this value allows before it starts writing to disk based temporary files. On a busy system, therefore, total memory usage is many times that of an individual **work_mem** parameter.

To tune this value, use Total RAM * 0.25 / **max_connections** as initial value.

**maintenance_work_mem** is memory required by **vacuum** and **reindex**. This parameter determines the amount of memory available for internal sort operations and hash tables. The default value is 64 KB but increasing this value improves performance for vacuuming.

**autovacuum_work_mem** sets the maximum memory to be used by each autovacuum process.

**temp_buffers** defines memory for storing temporary tables. This parameter sets the maximum number of temporary buffers used by each database session.

**effective_cache_size** defines the amount of available memory for disk caching by the operating system and within the database. The PostgreSQL query planner determines whether this memory is fixed in RAM. Index scans are most likely to be used against higher values; otherwise, sequential scans are used if the value is low.

Set **effective_cache_size** to 50% of the machine's total RAM.

### Shared memory

Shared memory is allocated at startup. Shared memory is used for:

**shared_buffers** defines the shared memory buffers used by the server. PostgreSQL loads pages of tables and indexes from persistent storage to a shared buffer pool, and then works on them in memory. This shared buffer pool is the major component of the shared memory used by the server. The default value is 128 MB (depending on the compute tier). If you decide to allocate more memory, you need to restart the server.

**wal_buffers** defines the number of disk page buffers in shared memory for write ahead logging (WAL) before writing it to persistent storage.

In summary, the important server parameters relating to memory that you could want tune are:

- shared_buffers
- work_mem
- effective_cache_size
