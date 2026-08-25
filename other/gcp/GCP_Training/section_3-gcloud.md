---
title: Section 3 - gcloud
contents-list: h1,h2
---

# Overview

Some services have specific tools:

- Cloud Storage - `gsutil`.
- Cloud BigQuery - `bq`.
- Cloud Bigtable - `cbt`.
- Kubernetes - `kubectl` (Note: `gcloud` is used to manage clusters).

gcloud is part of Google Cloud SDK (Cloud SDK requires Python).

Install: https://cloud.google.com/sdk/docs/install

Syntax: `gcloud GROUP SUBGROUP ACTION ...`

Connecting to GCP:

`gcloud init` - initialize or reinitialize gcloud.

- Authorize gcloud to use your user account credentials).
- Setup configuration (includes current project, default zone etc).

`gcloud config list` - lists all properties of the active configuration.

Other Examples:

`gcloud compute instances list`

`gcloud compute zones list`

`gcloud compute regions list`

`gcloud compute machine-types list`

`gcloud compute machine-types list --filter="zone:us-central1-b"`

`gcloud compute machine-types list --filter="zone:( us-central1-b europe-west1-d )"`

## Cloud Shell

- Cloud Shell is backed by a VM instance (automatically provisioned by Google Cloud when you launch Cloud Shell).
- 5 GB of free persistent disk storage is provided as your $HOME directory.
- Pre-packaged with latest version of Cloud SDK, Docker etc.
- Files in your home directory persist between sessions (scripts, user configuration files like .bashrc and .vimrc etc).
- Instance is terminated if you are inactive for more than 20 minutes.
- Any modifications that you made to it outside your $HOME will be lost.
- After 120 days of inactivity, even your $HOME directory is deleted.
- Cloud Shell can be used to SSH into virtual machines using their private IP addresses.



