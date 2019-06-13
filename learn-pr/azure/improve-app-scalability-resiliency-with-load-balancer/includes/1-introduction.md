## Introduction

Imagine you work for a health care organization which is launching a new portal application where patients can schedule appointments. The application consists of a patient portal,which comprises a web application frontend and business tier database. The database is used by the frontend to retrieve and save patient information. The new portal needs to be available around the clock, and handle failures. It must adjust to fluctuations in load, by adding and removing resources to match load. The organization needs a load-balancing solution that can distribute work across the system to virtual machines as they're added. The load balancer should detect failures and reroute jobs to machines as appropriate. This improved resiliency and scalability ensures patients can schedule appointments from any location, whenever they need too.

## Learning objectives

In this module, you will:

- Identify the features and capabilities of Azure Load Balancer
- Deploy and configure an Azure Load Balancer

## Prerequisites

- Basic knowledge of networking concepts
- Basic knowledge of Azure virtual machines
- Familiarity with Azure portal