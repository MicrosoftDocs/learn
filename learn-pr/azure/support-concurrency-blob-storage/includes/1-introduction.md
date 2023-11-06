Concurrency strategies in Azure Blob storage allow you to avoid conflicts when multiple users are viewing and updating content simultaneously.

You're a developer for an online financial news organization. The company uses Blob storage to store content prior to publication. The newsroom is a chaotic place and stories change frequently throughout the day as multiple editors, reporters, and analysts submit their content. The online copywriting and editing application used by your company's reporters needs to provide a good experience in these situations, making sure that contributors are submitting changes without overwriting changes made by others.

There are three main concurrency strategies to consider:

- optimistic concurrency
- pessimistic concurrency
- last writer wins

By the end of this module you'll understand how to write code to handle concurrency issues when writing and reading from Blob storage.

## Learning objectives

In this module, you will:

- Identify issues associated with concurrency in multi-user applications
- Identify the three concurrency strategies used for data in Blob storage along with their tradeoffs
- Implement optimistic concurrency with blobs using ETags
- Implement pessimistic concurrency with blobs using leases

## Prerequisites

- Experience editing C# .NET code at a beginner level