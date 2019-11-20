using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Azure.Storage;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using Microsoft.Extensions.Configuration; 
using Azure.Storage.Sas;

namespace test.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PatientRecordsController : ControllerBase
    {
        private readonly ILogger<PatientRecordsController> _logger;
        private IConfiguration _iconfiguration;

        private BlobContainerClient _container;

        public PatientRecordsController(ILogger<PatientRecordsController> logger, IConfiguration iconfiguration)
        {
            _logger = logger;
            _iconfiguration = iconfiguration; 
            _container = new BlobContainerClient(
                _iconfiguration.GetValue<string>("StorageAccount:ConnectionString"),
                _iconfiguration.GetValue<string>("StorageAccount:Container")
            );
        }

        // GET PatientRecord
        [HttpGet]
        public IEnumerable<PatientRecord> Get()
        {
            List<PatientRecord> records = new List<PatientRecord>();

            foreach (BlobItem blobItem in _container.GetBlobs())
            {
                BlobClient blob = _container.GetBlobClient(blobItem.Name);
                var patient = new PatientRecord { Name=blob.Name, ImageURI=blob.Uri.ToString() };
                records.Add(patient);
            }

            return records;
        }

        // GET PatientRecord/patient-nnnnnn
        [HttpGet("{Name}")]
        public PatientRecord Get(string name)
        {
            BlobClient blob = _container.GetBlobClient(name);
            return new PatientRecord { Name=blob.Name, ImageURI=blob.Uri.AbsoluteUri };
        }

        // GET PatientRecord/patient-nnnnnn/secure
        [HttpGet("{Name}/{secure}")]
        public PatientRecord Get(string name, string flag)
        {
            BlobClient blob = _container.GetBlobClient(name);
            return new PatientRecord { Name=blob.Name, ImageURI=BuildSASUri(blob.Uri).AbsoluteUri };
        }

        private Uri BuildSASUri(Uri StorageAccountBlobUri)
        {
            // Create a service level SAS that only allows reading from service
            // level APIs
            AccountSasBuilder sas = new AccountSasBuilder
            {
                // Allow access to blobs
                Services = AccountSasServices.Blobs,

                // Allow access to the container
                ResourceTypes = AccountSasResourceTypes.Object,

                // Access expires in 5 minutes!
                ExpiresOn = DateTimeOffset.UtcNow.AddMinutes(5)
            };
            // Allow read access
            sas.SetPermissions(AccountSasPermissions.Read);

            // Create a SharedKeyCredential that we can use to sign the SAS token
            StorageSharedKeyCredential credential = new StorageSharedKeyCredential(
                _iconfiguration.GetValue<string>("StorageAccount:AccountName"), 
                _iconfiguration.GetValue<string>("StorageAccount:AccountKey")
            );

            UriBuilder sasUri = new UriBuilder(StorageAccountBlobUri);
            sasUri.Query = sas.ToSasQueryParameters(credential).ToString();
        
            return sasUri.Uri;
        }

    }
}
