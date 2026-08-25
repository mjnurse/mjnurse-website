---
title: Section 1 - GCE - Compute Engine
---

# Regions / Zones

Regions contain zones.

# Machine Families

Different Machine Families for Different Workloads:

### General Purpose (E2, N2, N2D, N1) : Best price-performance ratio

Web and application servers, Small-medium databases, Dev environments

### Memory Optimized (M2, M1): Ultra high memory workloads

Large in-memory databases and In-memory analytics

### Compute Optimized (C2): Compute intensive workloads

Gaming applications

# Machine Images

- Public images.

- Customer images.

# IP Addresses

## External IP Addresses

- External IP addresses are lost when a machine is stopped.

## Static IP Addresses - Remember

- Static IP can be switched to another VM instance in same project.  Use `External IP addresses` in the menu.

- Static IP remains attached even if you stop the instance. You have to manually detach it.

- Remember : You are billed for an Static IP when you are NOT using it! (You pay **more** if you are not using it!).A

# Bootstrapping - Startup Script

- Available in the machine configuration.

# Instance Templates

- Define machine type, image, labels, Startup script and other properties.

- Used to create VM instances and managed instance groups.

- (Optional) Image family can be specified (example - debian-9): Latest non-deprecated version of the family is used.

# Custom Image

- Installing OS patches and software at launch of VM instances increases boot up time.  Prefer customer images.

- Image can be stored in Cloud Storage.

- Deprecate old images (& specify replacement image).

# Other

- If you want dedicated hardware for your compliance, licensing, and management needs - use `Sole-tenant nodes`.

- To manage 1,000's nodes use `VM Manager`.

