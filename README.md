# SimpleTimeService

### TASK 1

### Steps to pull the container from artifact registry
```bash
docker pull us-central1-docker.pkg.dev/myproject-481217/myregistry/simpletimeservice:v1.0.1
docker run -p 8000:8080 -d us-central1-docker.pkg.dev/myproject-481217/myregistry/simpletimeservice:v1.0.1
curl http://localhost:8000
```


### Steps to build and run the container locally
```bash
cd app
docker build -t myapp:v1.0.0 .
docker run -p 8000:8080 -d myapp:v1.0.0
curl http://localhost:8000
```

### TASK 2

1. Create a new GCP project/use an existing one.
2. Enable required APIs within your GCP project using gcloud command - 
```bash
gcloud services enable \
  run.googleapis.com \
  compute.googleapis.com \
  vpcaccess.googleapis.com \
  artifactregistry.googleapis.com \
  cloudresourcemanager.googleapis.com \
  iam.googleapis.com
```

3. Update terraform/terraform.tfvars file with your project's values
4. Run terraform plan and apply
```bash
cd terraform
terraform plan
terraform apply
```

5. To test the cloud run service, run the following command 
** Make sure you are within the terraform folder before running the above command
```bash
make test
```


### Extra Credit!!
1. A remote Terraform backend is set up in terraform/backend.tf for maintaining terraform state. Uncomment the entire code present in this file and ensure you are updating the bucket and prefix values to your GCS bucket. You can create a new GCS bucket using this command
```bash
gcloud storage buckets create gs://<your-bucket> \
    --location=us-central1 \
    --uniform-bucket-level-access

gcloud storage buckets update gs://<your-bucket> --versioning

```

Your backend.tf should look like this
```terraform
terraform {
   backend "gcs" {
     bucket = "your-bucket"
     prefix = "your-prefix"
   }
}
```

Once bucket is created and backend.tf is updated, run the following terraform commands
```bash
terraform init -migrate-state
terraform plan
terraform apply
```



