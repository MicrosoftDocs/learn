# Introduction

Azure NetApp Files is widely used as the underlying shared file-storage service in various scenarios, including High Performance Compute (HPC) infrastructure. Azure NetApp Files supports three service levels: Ultra, Premium, and Standard, which is differentiated by allowed maximum throughput.

You will learn how to choose the best Service Level of Azure NetApp Files for your HPC applications.

## Scenario

Suppose you're a member of a semiconductor company, tasked with designing their IC Chips, which needs numerous EDA (Electronic Design Automation) simulation. You don't have sufficient capacity on premises for this project and so will be using Azure for those HPC simulation needs.

Management would like this project to be completed in a timely and cost-effective manner. You choose Azure NetApp Files as the back-end storage solution as it provides an on-premises-like experience and performance.

You'll need to figure out the most optimal and cost-effective way of building and running your HPC applications in Azure.

## What will we be doing?

In this module, you'll examine the decision criteria that determines Azure NetApp Files performance. Then you'll map your throughput or IOPS requirements to choose the best cost-effectiveness service level.

## Learning objectives

By the end of this module, you'll be able to:

- Describe the factors that determine throughput limits of Azure NetApp Files volume.
- Choose the best Service Level of Azure NetApp Files for HPC applications.

## Prerequisites

- Learner should understand the concepts of storage hierarchy of Azure NetApp Files, including NetApp accounts, Capacity Pool, and Volumes.
- Ability to set up Azure NetApp Files and create a Volume.
