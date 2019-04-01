<!-- Original file: C:\Users\Mark\Desktop\CMU\v_5_3\content\_u04_cloud_storage\_u04_m04_cloud_object_storage_case_studies\x-oli-workbook_page\_u04_m04_2_summary.xml -->
##  Case Studies: Cloud Object Storage Summary

- Amazon Simple Storage Service (S3) is an online file storage Web service offered by Amazon Web Services.
- S3 structures data into buckets and objects; a bucket is a container for objects in S3, and objects consist of the binary data of the object as well as metadata. Buckets and objects are accessed by a string, called _bucket name_, and object key, respectively. 
- The data stored in a single object in S3 can be between 1 byte and 5 terabytes in size.
- S3 supports simple create, read, update, and delete options through a RESTful interface.
- S3 utilizes eventual consistency, and developers must account for several scenarios where stale data might be accessed. 
- OpenStack Swift is an open-source object storage system that be deployed in public or private clouds.
- Swift proves an S3-like REST interface to access objects.
- Ceph object gateway is a access layer over the RADOS distributed object store. This offers both S3 and SWIFT compatible interfaces into RADOS.
##  Cloud Storage Quiz
This checkpoint will test your understanding of the material you have learned in this unit.