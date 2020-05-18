Microsoft Endpoint Manager supports several device platforms. 





Determine supported device platforms
You need to know what devices will be in the environment and verify whether they are supported or not by Intune when creating your design. Intune supports iOS/iPadOS, Android, and Windows platforms.

Complete list of Intune supported devices.

Devices
Intune manages mobile devices to secure corporate data and allow end users to work from more locations. Intune supports many device platforms, so we recommend that you document the devices and the OS platforms and the versions that will be supported in your organization's design. For example:

TABLE 2
Device platform	OS Versions
iOS - iPhone	10.0+
iOS - iPad	10.0+
Android – Samsung Knox Standard	4.0+
Windows 10 tablet	10+
You can download a template of the above table to develop your list of devices.

Device ownership
Intune supports both corporate-owned devices and personal devices. A device is considered corporate-owned if your enroll it by a device enrollment manager, or device enrollment program. For example, a device is enrolled with the Apple Device Enrollment Program (DEP), marked as corporate, and placed in a device group that receives targeted corporate policies and apps.

Refer to Section 3: Determine use case scenario requirements for more information about corporate and BYOD use cases.

Bulk enrollment
You can enroll devices in bulk in different ways depending on the platform. If you require bulk enrollment, first determine the bulk enrollment method and incorporate it in to your design.