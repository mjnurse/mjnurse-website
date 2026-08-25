---
title: Creating a Compute Instance on GCP Using Terraform 
---

## Download and Install terraform

Download the most recent version of Terraform.  No install, its just an executable.  Move it to an accessible location.

```
> wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip
...
> unzip terraform_0.11.11_linux_amd64.zip
...
> mv terraform ~/bin
...
> terraform --version
Terraform v0.11.11
```

## Create a terraform Config File

Create a provider config file: `main.tf`

```
provider "google" {
  project = "mjnurse-terraform"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  #machine_type = "f1-micro"
  machine_type = "n1-standard-4"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "${google_compute_network.vpc_network.self_link}"
    access_config = {
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}
```

## Set Up the Required Credentials

From the Navigation Menu, select APIs & Services, Credentials.  From the Create credentials drop down, select 'Service account key'.  ENsure that the JSON option is selected amd choose the 'Compute Engine default service account' from the drop down.  Click create and a JSON document will be downloaded by the browser.

Copy the contents of the JSON download in to a file called google_cloud_keyfile.json.

create and environment variavle to point to this file:

```
> export GOOGLE_CLOUD_KEYFILE_JSON=google_cloud_keyfile.json
```

## Run the terraform Script to Create the Compute Instance

Run terraform init:

```
> terraform init

* provider.google: version = "~> 2.0"

Terraform has been successfully initialized!
```

Run the terraform `main.tf` script:

```
> terraform apply

martin@website-builder:~/terraform$ terraform apply
google_compute_network.vpc_network: Refreshing state... (ID: terraform-network)
google_compute_instance.vm_instance: Refreshing state... (ID: terraform-instance)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
...
Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_compute_instance.vm_instance: Creating...
...
google_compute_instance.vm_instance: Still creating... (10s elapsed)
google_compute_instance.vm_instance: Still creating... (20s elapsed)
google_compute_instance.vm_instance: Creation complete after 29s (ID: terraform-instance)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

## Removing the Compute Instance

```
> terraform destroy

google_compute_network.vpc_network: Refreshing state... (ID: terraform-network)
google_compute_instance.vm_instance: Refreshing state... (ID: terraform-instance)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:
  - google_compute_instance.vm_instance
  - google_compute_network.vpc_network

Plan: 0 to add, 0 to change, 2 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

google_compute_instance.vm_instance: Destroying... (ID: terraform-instance)
google_compute_instance.vm_instance: Destruction complete after 4s
google_compute_network.vpc_network: Destroying... (ID: terraform-network)
google_compute_network.vpc_network: Still destroying... (ID: terraform-network, 1m0s elapsed)
google_compute_network.vpc_network: Destruction complete after 1m6s

Destroy complete! Resources: 2 destroyed.
```
<hr>
