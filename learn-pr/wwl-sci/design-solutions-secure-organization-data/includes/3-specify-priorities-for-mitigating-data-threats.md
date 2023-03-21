This unit is a summary of the recommendations from the Microsoft Threat Modeling methodology for mitigating threats to sensitive data.

The Threat Modeling Tool is a core element of the Microsoft Security Development Lifecycle (SDL). It allows software architects to identify and mitigate potential security issues early, when they are relatively easy and cost-effective to resolve. As a result, it greatly reduces the total cost of development. Also, we designed the tool with non-security experts in mind, making threat modeling easier for all developers by providing clear guidance on creating and analyzing threat models.

**Sensitive data** refers to how your application handles any data that must be protected either in memory, over the network, or in persistent stores.

The following table summarizes mitigates for sensitive data at different points in an application architecture.

| Product/Service | Article |
| --------------- | ------- |
| **Machine Trust Boundary** | <ul><li>[Ensure that binaries are obfuscated if they contain sensitive information](#binaries-info)</li><li>[Consider using Encrypted File System (EFS) is used to protect confidential user-specific data](#efs-user)</li><li>[Ensure that sensitive data stored by the application on the file system is encrypted](#filesystem)</li></ul> | 
| **Web Application** | <ul><li>[Ensure that sensitive content is not cached on the browser](#cache-browser)</li><li>[Encrypt sections of Web App's configuration files that contain sensitive data](#encrypt-data)</li><li>[Explicitly disable the autocomplete HTML attribute in sensitive forms and inputs](#autocomplete-input)</li><li>[Ensure that sensitive data displayed on the user screen is masked](#data-mask)</li></ul> | 
| **Database** | <ul><li>[Implement dynamic data masking to limit sensitive data exposure non privileged users](#dynamic-users)</li><li>[Ensure that passwords are stored in salted hash format](#salted-hash)</li><li>[Ensure that sensitive data in database columns is encrypted](#db-encrypted)</li><li>[Ensure that database-level encryption (TDE) is enabled](#tde-enabled)</li><li>[Ensure that database backups are encrypted](#backup)</li></ul> | 
| **Web API** | <ul><li>[Ensure that sensitive data relevant to Web API is not stored in browser's storage](#api-browser)</li></ul> | 
| Azure Document DB | <ul><li>[Encrypt sensitive data stored in Azure Cosmos DB](#encrypt-docdb)</li></ul> | 
| **Azure IaaS VM Trust Boundary** | <ul><li>[Use Azure Disk Encryption to encrypt disks used by Virtual Machines](#disk-vm)</li></ul> | 
| **Service Fabric Trust Boundary** | <ul><li>[Encrypt secrets in Service Fabric applications](#fabric-apps)</li></ul> | 
| **Dynamics CRM** | <ul><li>[Perform security modeling and use Business Units/Teams where required](#modeling-teams)</li><li>[Minimize access to share feature on critical entities](#entities)</li><li>[Train users on the risks associated with the Dynamics CRM Share feature and good security practices](#good-practices)</li><li>[Include a development standards rule proscribing showing config details in exception management](#exception-mgmt)</li></ul> | 
| **Azure Storage** | <ul><li>[Use Azure Storage Service Encryption (SSE) for Data at Rest (Preview)](#sse-preview)</li><li>[Use Client-Side Encryption to store sensitive data in Azure Storage](#client-storage)</li></ul> | 
| **Mobile Client** | <ul><li>[Encrypt sensitive or PII data written to phones local storage](#pii-phones)</li><li>[Obfuscate generated binaries before distributing to end users](#binaries-end)</li></ul> | 
| **WCF** | <ul><li>[Set clientCredentialType to Certificate or Windows](#cert)</li><li>[WCF-Security Mode is not enabled](#security)</li></ul> | 
