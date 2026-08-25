---
title: GCP Cloud Storage
---

## Overview

Binary Large Object Storage - Fully managed, scalable.

-  Can be used to serve website content, archive data or content for download.
-  Each object has a URL.
-  Stored in buckets.
-  Immutable.
-  Can create ACLs (access control lists) - A scope (who) & permission (what).
-  New overwrites old but can keep previous versions (object versioning) - With rules on how many.
-  Lifecycle management policies can delete old versions of objects or simply old object.

## Cloud Storage Classes

-  Multi-regional - 99.95% - Frequent access.  Stored in 2 locations > 160km apart. (6 copies of data round the world).
-  Regional - 99.90% - Frequent access. (3 copies of data in a Region).
-  Nearline - 99.00% - Access less than once a month.  A cost to access.
-  Coldline - 99.00% - Access less than once a year.  A cost to access.  Quick (AWS Glacial is 4-6 hours).
Costs per GB per Month stored.  For Nearline, Coldline also a cost to access.

## Upload Data to Cloud Storage

-  Online Transfer - Command line, browser.
-  Storage Transfer Service - Scheduled managed batch.
-  Appliance (rackable).
-  Import/Export BigQuery & Cloud SQL.
-  App Engine.  Eg. logs, backups.
-  Compute Engine. eg. Startup scripts, images, large general object store.

## Structure

### Buckets

-  Projects own Buckets (the basic containers for all data).
-  Buckets have a default storage class.
-  Buckets cannot be nested.
-  There are limits to Bucket creation and deletion so favor Object or Bucket operations.
-  Have a globally unique name name, a geographical location and a default storage class (can override class though).
-  Name and location are fixed.
-  The existence of a bucket name can be globally tested so avoid usernames, email, PII etc.
-  Max 63 characters unless include . (dots) then can be 222 but max 63 between dots.
-  Name format: `[a-z][0-9][-_.]`
-  Bucket Labels: name:value pairs.
-  IAM can be applied to Project or Folder.

### Objects

-  Names can contain any UTF-8 char.
-  (obv) avoid characters like / in names.
-  Every object has a generation number.  Incremented each time object overwritten.
-  If object versioning enabled can refer to prev versions.
-  Objects have two version numbers, one for content the other for metadata.
-  Objects are opaque to GCP and immutable.
-  Cloud storage does not support a hierarchy but tools like GCP console can operate as if in a hierarchy.

## Access Control

-  IAM (Identity and Access Management) for Projects / Buckets. (Preferred).
-  ACL (Access Control List) for individual Objects.
-  Signed URLs - A unique URL giving access for a specified period of time.A

## Encryption

-  Google-managed encryption keys: Google creates and manages.
-  Customer-supplied encryption keys: Create and manage outside of google.
-  Customer-managed encryption keys: Use Google tool to generate and manage keys.
<hr>
