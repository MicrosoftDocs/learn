## When to use Azure Image Builder?

Here are some criteria that should be considered when deciding whether or not the Azure Image Builder (AIB) service will meet your needs:

### Strengths

- AIB can create machine images for Azure environments using standardized VM images and create a configuration that describes your image and submit it to the service for building and distribution
- AIB can be integrated with existing image build pipelines for a click-and-go experience.
- AIB can fetch customization data from various sources, which removes the need to collect them all from one place
- AIB can be integrated with Compute Gallery, which creates an image management system with which to distribute, replicate, version, and scale images globally. Additionally, you can distribute the same resulting image as a VHD or as one or more managed images, without having to rebuild them from scratch
- AIB stores your VM image build artifacts as Azure resources, which removes both the need to maintain offline definitions and the risk of environment drifts that are caused by accidental deletions or updates
- AIB enables you to create baseline images and allows other departments to customize them further. You can help keep these images secure and compliant by using AIB to quickly rebuild a golden image that uses the latest patched version of a source image
- AIB enables you to fetch your customization artifacts without having to make them publicly accessible. AIB can use your Azure Managed Identity to fetch these resources, and you can restrict the privileges of this identity as tightly as required by using Azure role-based access control
- AIB securely stores copies of customization artifacts, transient compute and storage resources, and their resulting images within your subscription, because access is controlled by Azure RBAC

## Limitations

- AIB isn't suitable for creating machine images for non-Azure environments
- AIB requires technical knowledge of both the Azure platform and the technologies used to build the offer
- AIB requires you to have a working container in your local registry to deploy an image to Azure Container Instances