<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u02_data_centers\_u02_m03_software_stack\x-oli-workbook_page\_u02_m03_3_metering.xml -->
Cloud service providers (CSPs) charge their customers according to usage of their services. In order to do that, providers have to monitor the usage of their services carefully and have to include the cost of running these services in their infrastructure. This is mission critical for both CSPs and their customers. 

The revenue stream of a CSP depends on the correctness of metering and monitoring their resources. Considering AWS revenues in 2014, losing resource usage data for a couple of hours can cost Amazon millions of dollars. On the other, overcharging customers for a couple of hours can highly affect their credibility.

From the customer’s point of view, the cost of cloud resources forms an important part of their expenses. In order for cloud clients to make budget plans, they must receive consistent bills every month. This poses important challenges to cloud providers for metering and monitoring.

##  Challenges in Monitoring and Metering
There are various costs included in cloud resources. Fixed costs such as facilities, staff, and servers are easy to calculate. Variable costs, however, require constant metering and monitoring. The advantage of using CSPs comes from paying only for the resources which are used. For example, provisioning an EC2 instance includes the cost of instance usage per hour, storage per GB-month for each storage type, and data transfer per GB-month. Even for this one resource, AWS has to keep track of these metrics for every instance and attached volume. In Figure 2.24, a possible break down of various cost for services can be found. If we imagine doing this for more than 1 million AWS customers for tens of different types of services, this will require the metering and monitoring of gigabytes of logs every minute and charging customers accordingly. The most popular model which is used to define such metrics is called the chargeback model. 

![Figure 2.24: Metering in Different Types of Cloud Services]("..\media\metering1.png")
_Figure 2.24: Metering in Different Types of Cloud Services_

##  Chargeback Model
Basically the chargeback model is the ability of an IT organization to measure the usage of resources and chargeback their customers accordingly. Traditionally the chargeback model is easy to implement since an IT department can easily divide its budget for the business units that it serves like software licences, stand-alone servers etc. This is challenging in cloud because the CSP needs to consider the rate and time of consumption. 

##  Validation of Metering and Monitoring
From the customer’s point of view, verifiable metering is an important issue. There are some costs which are easy to measure like EC2 usage (hourly usage * cost per hour) but it is hard for customers to measure other resources such as data transitions or I/O requests. In order to verify metering and monitoring, users can work with certified cloud providers. For instance, IBM’s “Resilient Cloud Validation” program allows businesses who collaborate with IBM to perform a consistent program of benchmarking and validation of cloud services. 

##  Case Study: Ceilometer
Although the underlying architecture of metering and measuring is hidden by corporate CSPs, Ceilometer is designed for OpenStack metering, billing and rating. The high-level architecture of OpenStack Ceilometer can be summarized as follows (Figure 2.25): 

![Figure 2.25: Ceilometer Architecture]("..\media\metering2.png")
_Figure 2.25: Ceilometer Architecture_

 _Polling Agent_: A daemon which polls OpenStack services for metering. 

 _Notification Agent_: A daemon which listens to notifications on the message queue and converts them into samples and events. 

 _Collector_: Daemon designed to gather metering data created by the notification and polling agents. 

 _API_: Service to query the data recorded by the collector. 

 _Alarming_: Daemons to evaluate and trigger notifications based on predefined rules. 

Each of these services are designed to scale horizontally. Additional workers and nodes can be added according to expected load.