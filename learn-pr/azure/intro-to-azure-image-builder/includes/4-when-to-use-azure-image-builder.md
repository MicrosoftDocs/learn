Here are some criteria that should be considered for deciding whether the Azure Image Builder (AIB) service can meet your needs:

### Strengths

- AIB can create machine images for Azure environments using standardized virtual machine (VM) images. It also creates a configuration that describes your image and submits the image to the service for building and distribution.

- AIB can be integrated with existing image build pipelines for a click-and-go experience.

- AIB can fetch customization data from various sources, which removes the need to collect them all from one place.

- AIB can be integrated with Compute Gallery, which creates an image management system that you can use to distribute, replicate, version, and scale images globally. In addition, you can distribute the same resulting image as a virtual hard disk (VHD) or as one or more managed images, without having to rebuild them from scratch.

- AIB stores your VM image build artifacts as Azure resources. This practice removes both the need to maintain offline definitions and the risk of environment drifts that accidental deletions or updates cause.

- AIB enables you to create baseline images and allows other departments to customize them further. To help keep these images secure and compliant, you can use AIB to quickly rebuild a golden image that uses the latest patched version of a source image.

- AIB enables you to fetch your customization artifacts without having to make them publicly accessible. AIB can use your Azure Managed Identity to fetch these resources. You can restrict the privileges of this identity as tightly as required by using Azure role-based access control.

- AIB securely stores copies of customization artifacts, transient compute and storage resources, and their resulting images within your subscription. Access is controlled by Azure role-based access control (Azure RBAC).


## Limitations

- AIB is unsuitable for creating machine images for non-Azure environments.

- AIB requires technical knowledge of both the Azure platform and the technologies used to build the offer.

- AIB requires you to have a working container in your local registry to deploy an image to Azure Container Instances.