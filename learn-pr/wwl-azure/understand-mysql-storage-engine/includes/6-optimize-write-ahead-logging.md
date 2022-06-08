Write ahead logging (WAL) writes changes first to the log, and then commits them to the database. The InnoDB storage engine log is called the **redo log**. If the server crashes, or is disconnected from power, any changes not written to disk are applied from the redo log.

This means that many changes can be written to disk together, rather than each one being committed individually. This can have a significant and positive impact on performance.

This also means that configuring the redo log file size correctly is important. Too small, and changes must be written to disk more frequently, which has a negative impact on performance.

By default, the redo log is made up of two files. Azure Database for MySQL allows you to configure the log file storage:

- **innodb_log_files_in_group** sets the number of log files - the default and recommended value is 2.
- **Innodb_log_file_size** defines the log size in bytes - the default is 268435456 bytes (256 MB).
- **Innodb_log_write_ahead_size** defines the write ahead block size for the redo log - the default is 8192 bytes.
- **Innodb_redo_log_encrypt** defines whether the redo log data should be encrypted for encrypted tables - the default is OFF.
