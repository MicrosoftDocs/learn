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
        // Get Patient information
        [HttpGet("{name}")]
        public PatientRecord Get(string name)
        {
            BlobClient blob = _container.GetBlobClient(name);
            return new PatientRecord { Name=blob.Name, ImageURI=blob.Uri.AbsoluteUri };
        }

        // GET PatientRecord/patient-nnnnnn/secure 
        // Using this API will return a Patient Record with a SAS validated image URI
        [HttpGet("{name}/{password}")]
        public PatientRecord Get(string name, string password)
        {
            if (password == "Lamna123") {
                BlobClient blob = _container.GetBlobClient(name);
                return new PatientRecord { Name=blob.Name, ImageURI=BuildSASUri(blob.Uri).AbsoluteUri };
            } else {
                return null;
            }
        }

        // Create a SAS token for a given image URI
        private Uri BuildSASUri(Uri StorageAccountBlobUri)
        {
            // Create an object level SAS
            AccountSasBuilder sas = new AccountSasBuilder
            {
                // Allow access to blobs
                Services = AccountSasServices.Blobs,

                // Allow access to images
                ResourceTypes = AccountSasResourceTypes.Object,

                // Access expires in 1 minute
                ExpiresOn = DateTimeOffset.UtcNow.AddMinutes(1)
            };
            // Allow read access
            sas.SetPermissions(AccountSasPermissions.Read);

            // Create a SharedKeyCredential that we can use to sign the SAS token
            StorageSharedKeyCredential credential = new StorageSharedKeyCredential(
                _iconfiguration.GetValue<string>("StorageAccount:AccountName"), 
                _iconfiguration.GetValue<string>("StorageAccount:AccountKey")
            );

            // Finish building a URI with the SAS token appended 
            UriBuilder sasUri = new UriBuilder(StorageAccountBlobUri);
            sasUri.Query = sas.ToSasQueryParameters(credential).ToString();
        
            return sasUri.Uri;
        }

    }
}
