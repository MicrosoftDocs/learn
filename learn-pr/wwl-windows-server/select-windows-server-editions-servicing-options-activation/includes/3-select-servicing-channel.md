Servicing channels allow you to choose if new features and functionality are delivered regularly during the production lifespan of the server, or if you will choose when to move to a new server version. Windows Server supports two release channels, Long Term Servicing Channel (LTSC) and the Semi-Annual Channel (SAC).

## Long-Term Servicing Channel

Long-Term Servicing Channel (LTSC) dictates that a major version of Windows Server will release every two or three years. This includes five years of mainstream support and five years of extended support from the release date. Normal security updates and Windows updates  continue to deliver on a regular basis as in the past, but without new features or functionality. LTSC releases do get some new feature functionality. For example, Storage Migration Services is available on Windows Server 2019 and includes updates for workloads such as migrating Linux NAS appliances.

LTSC is the traditional "numbered" version of Windows Server. Windows Server 2016 and Windows Server 2019 are LTSC releases.

> [!TIP]
> For most server requirements, the LTSC will be the best choice.

## Semi-Annual Channel

SAC only releases as Server Core or Nano Server container images, so it's restricted in the roles and features that you can install. New features are delivered semi-annually, once in the second quarter and once in the fourth quarter. SAC is limited to software assurance and cloud customers.

> [!NOTE]
> These releases are supported for 18 months from the initial date of release.

Normal security updates and Windows updates will continue to be delivered on a regular basis.

> [!NOTE]
> Features that are included in SAC are rolled up and delivered to the LTSC on the next major release.

You can identify SAC releases by their version number, which until recently was a combination of the year and month of the features' release. For example, version 1903 means the feature was released in the third month of 2019. However, now SAC releases are numbered by year and in which half of the year. So, 20H2 indicates the second release of 2020, while 21H1 would indicate the first update of 2021.

SAC releases will always be a clean installation. SAC implies you have a CI/CD type pipeline where you'd just deploy the newer operating-system image in the same way that you'd deploy a new container when the base container image got updates.

> [!IMPORTANT]
> You can't do an in-place upgrade from an LTSC release to a SAC release.

## Choosing a servicing channel

LTSC is recommended for:

- General purpose file servers.
- Microsoft and non-Microsoft workloads.
- Traditional apps.
- Infrastructure roles.
- Software-defined Datacenter.
- Hyper-converged infrastructure.

Semi-Annual Channel is recommended for:

- Containerized applications.
- Container hosts.
- Application scenarios benefiting from adaption of new features.
