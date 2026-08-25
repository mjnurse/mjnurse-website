---
title: GCP VPC Networks
---

## Overview

-  VPCs are owned by projects.
-  VPCs connect instances to each other and to the internet.  VPCs have global scope.
-  VPC subnets can span zones - they have regional scope.
-  Routing Tables created automatically.
-  Firewalls - Global distributed firewall created automatically.
   -  Rules can use meta data tags for rules (eg. open port 80 for all instances tagged web)
   -  In a VPC Firewall everything is block by default (not open by default as perhaps my PC)
-  VPC Peering - VPCs in different projects can talk via VPC Peering.
-  Shared VPC - Can create shared VPC where IAM controls access.
-  Cloud load balancing - Single anycast IP address balanced across all instances.
   -  Load-balancing options:
      -  **Global**: Global HTTP(S) or Global SSL Proxy, Global TCP Proxy (only work of specific port numbers for TCP)
      -  **Regional**: Regional, Regional Internal.
-  Cloud DNS - Managed, programmable. (same solutions as Google public DNS 8.8.8.8).
-  Cloud CDN (Content Delivery Network) - Edge caches allow you to move content close to users.  Activate with a check box.
-  Can create a VPC network with "Private Google Access" which allows access to all the public facing GCP tools (like Cloud Storage) but without the tools public IP address

## VPC Networks

-  VPC can span regions without connecting to public internet (Googles own network).
-  Can expand CIDR (Classless Inter-Domain Routing - a method for allocating IP addresses and IP routing) ranges without downtime.
-  Cloud Router: Enable dynamic Border Gateway Protocol (BGP) route updates between VPC network and non-Google network with the virtual router.
-  VPN: Securely connect your existing network to VPC network over IPsec.
-  Firewall: Segment your networks with a global distributed firewall to restrict access to instances.
-  VPC Peering: Configure private communication across the same or different organizations without bandwidth bottlenecks or single points of failure.
-  Shared VPC: VPC Network can be shared across many projects in an organization. Connectivity routes and firewalls associated are managed centrally.
-  Routes: Forward traffic from one instance to another instance within the same network, even across subnets, without requiring external IP addresses.
-  VPC Flow Logs: Flow logs capture information about the IP traffic going to and from network interfaces on Google Compute Engine. VPC flow logs help with network monitoring, forensics, real-time security analysis and expense optimization.
-  Alias IP ranges: If you have multiple services running on a single VM instance, you can give each service a different internal IP address using Alias IP Ranges. The VPC network forwards packets destined for each configured alias IP to the corresponding VM.
-  Load balancing:
   -  Global external load balancing, including HTTP(S) load balancing, SSL Proxy, and TCP Proxy offerings.
   -  Regional, external network load balancing.
   -  Regional internal load balancing.
-  Private Google Access: Instances in a subnet of a VPC network can communicate with Google APIs and services using private IP addresses instead of external IP addresses when you enable 'Private Google Access' for the subnet.

### Network Tags

-  These are tag which can be added to VMs to allow firewall rules etc to be set for specific sets of VMs.

### Subnets

-  Subnets are regional resources - are associated to a region. Each subnet defines a range of IP addresses.
-  All subnets within a VPC must have unique IP addresses.
-  Subnets in different VPC can share IP addresses even if in same project.

### Routes

-  Routes define paths for data leaving network (egress).  Can be system generated or custom.
-  Every VPC has two system generated routes:
   -  'default route' - connection to internet (also used for 'Private Google Access' path).  Can delete this.
   -  'subnet route' - created for each IP range in a subnet.
-  Custom routes:
   -  Cannot match or be more specific than any subnet route in the network.
   -  Static routes.
   -  Dynamic routes are managed by Cloud Routers.  Always to IP outside VPC and are always Border Gateway Protocol (BGP) addresses

### Dynamic Routing

-  Each VPC network has a dynamic routing mode that controls the behaviour of all if its Cloud Routers. Cloud Routers share routes to VPC network and learn custom dynamic routes from connected networks (Cloud VPN tunnel using dynamic routing, Dedicated Interconnect, or Partner Interconnect).
-  Regional dynamic routing is the default. Routes to on-premises resources learned by Cloud Router in the VPC only apply to the subnets in the same region as the Cloud Router. Unless modified by custom advertisements, each Cloud Router only shares the routes to subnets in its region with its on-premises counterpart.
-  Global dynamic routing changes the behaviour of all Cloud Routers in the VPC such that the routes to on-premises resources that they learn are available in all of subnets in the VPC network, regardless of region. Unless modified by custom advertisements, each Cloud Router shares routes to all subnets in the VPC network with its on-premises counterpart.

### Applicable Routes

Routes apply to instances according to the following rules:
-  System routes apply to all instances in a VPC network. The instances to which subnet routes apply cannot be altered but can replace the default route.
-  Custom static routes can apply to all or specific instances.
-  Static routes with a tag attribute apply to instances that have the network tag. If no tag, the static route applies to all instances in the network.
-  Dynamic routes apply to instances based on the dynamic routing mode of the VPC network.
   -  If the VPC network is in regional dynamic routing mode, all Cloud Routers apply routes they learn within their respective regions.
   -  If the network is in global dynamic routing mode, all Cloud Routers apply routes they learn in the whole network.
-  GCP ignores custom routes if their next hops are not available.

### Routing order

GCP uses the following procedure to select the next hop for a packet from the pool of applicable routes:
-  Subnet routes are considered first because GCP requires that subnet routes have the most specific destinations matching the IP address ranges of their subnets.
-  GCP does not allow a static route to have an equal or more specific destination than a subnet route.
-  For dynamic routes, every Cloud Router ignores any routes it receives that have equal or more specific destinations than any subnet route.
-  If the packet does not fit in the destination for a subnet route, GCP looks for another route with the most specific destination.
   -  Example: For destination: 10.240.1.4 - 10.240.1.0/24 is more specific than 10.240.0.0/16.
-  If more than one route has equal most specific route then route priority considered.
-  If more than one matches the traffic distributed.
-  If no applicable destination is found, GCP drops the packet, replying with an ICMP destination or network unreachable error.

### Static route parameters

Each static route consists of the following components:
-  Name and Description: A (unique within project) name is required, but a description is optional.
-  Network: Each route must be associated with exactly one VPC network.
-  Destination range: The destination range is a single IPv4 CIDR block containing the IP addresses of systems that receive incoming packets.
-  Priority: Lower numbers indicate higher priorities.
-  Next hop: Static routes can have next hops that point to the default Internet gateway, a GCP instance, or a Cloud VPN tunnel.
-  Tags: You can specify a list of network tags so that the route will only apply to instances that have at least one of the listed tags.

### Static Route Next Hops

The following are valid next hops for static routes.
-  Next Hop Gateway: You can specify a default Internet gateway to define a path to public IP addresses.
-  Next Hop Instance: You can direct traffic to an existing instance in GCP by specifying the name and zone of the instance. Traffic is directed to the primary internal IP address in the network.
-  Next Hop IP: You can reference an existing instance in GCP using the internal IP address of its primary network interface.
-  Next Hop VPN Tunnel: For Cloud VPN tunnels using policy based routing and route based VPNs, you can direct traffic to the VPN tunnel by creating routes whose next hops refer to the tunnel by its name and region.

#### Instances as Next Hops

When creating a static routes whose next hop is an instance, either by virtue of using next hop instance or next hop IP, the instance acting as the next hop must be configured to receive incoming traffic from other instances

### Firewalls

-  Firewall rules apply to both outgoing (egress) and incoming (ingress) traffic in the network.
-  Firewall rules control traffic even if it is entirely within the network, such as instance-to-instance communication.
-  Every VPC network has two implied firewall rules.
   -  Allow all egress traffic, destination 0.0.0.0/0 (all IP), priority 65535 (lowest possible)
   -  Deny all ingress traffic, destination 0.0.0.0/0 (all IP), priority 65535 (lowest possible)
-  Cannot delete the implied rules, but you can override them with your own.
-  Firewalls specify:
   -  Priority, determines if the rule will be applied. The highest priority (lowest priority number) wins.
   -  The direction of traffic: ingress (incoming), egress (outgoing).
   -  Action on match, either allow or deny, which determines if the rule permits or blocks traffic.
   -  A target, instances (including GKE clusters and App Engine Flex instances) to which the rule will apply.
   -  A source for ingress rules or a destination for egress rules (IP range)
   -  The protocol (such as TCP, UDP, or ICMP) and port number e.g. TCP:22, ICMP, TCP:0-65534 (all ports).

### Default Network

-  Comes with 17 subnets (1 for each region)
-  IP Range (for eg us-west-1) - 10.138.0.0/20 so Min IP: 10.138.0.0 Max IP: 10.138.31.255
-  Default firewalls allows comms between all instances on VPC, egress to internet and ingress on port 3389 (rdp) and port 22 (ssh).

## Shared VPC Networks

-  Shared VPC allows networks to be managed separately to creating and managing instances (VMs).
-  VPC can only be shared within an Organisation.
-  **Host Project** owns Shared VPC.  **Service Projects** use Shared VPC.  A Project cannot be both.  A **Standalone Project** is neither.
-  A Service Project can only connect to a single Shared VPC.
-  When Host Project is enabled all existing and future VPC are shared.
-  Billing is attributed to the Service Projects.
-  External IP addresses defined in the host project are only usable by resources in that project. They are not available for use in service projects.
-  Internal DNS - project ids used in DNS names are that of the service project.  Eg:
   -  Internal Zonal DNS: `[INSTANCE_NAME].[ZONE].c.[SERVICE_PROJECT_ID].internal`
   -  Internal Global DNS: `[INSTANCE_NAME].c.[SERVICE_PROJECT_ID].internal`

### Shared VPC Administration

-  **Shared VPC Admins** have the Shared VPC Admin (compute.xpnAdmin) role for the org. They can:
   -  Enable host projects
   -  Attach service projects to host projects
   -  Delegate access to some or all of the subnets in Shared VPC networks to Service Project Admins.
-  A Shared VPC Admin for a given host project is typically its project owner as well.

-  A Shared VPC Admin can define **Service Project Admin** by granting Network User (compute.networkUser) role to:
   -  The whole host project
   -  Select subnets of its Shared VPC networks.

-  A Shared VPC Admin can make an IAM member a:
   -  **Network Admin** by granting the Network Admin (compute.networkAdmin) role to the host project. Network Admins have full control over all network resources except for firewall rules and SSL certificates.
   -  **Security Admin** by granting the Security Admin (compute.securityAdmin) role to the host project. Security Admins manage firewall rules and SSL certificates.

## VPC Network Peering

VPC Network Peering allows private RFC 1918 connectivity across two VPC networks regardless of whether or not they belong to the same project or the same organization.

For multiple network administrative domains within an organization, VPC Network Peering makes services available across VPC networks in private RFC 1918 space.

Peered VPC networks:
-  VPC Network Peering works with Compute Engine, Kubernetes Engine, and App Engine flexible environment.
-  Routes, firewalls, VPNs, and other traffic management tools are administered and applied separately in each VPC network.
-  Each side of a peering association is set up independently.
-  A given VPC network can peer with multiple VPC networks, but there is a limit.
-  A subnet CIDR prefix in one peered VPC network cannot overlap with a subnet CIDR prefix in another peered network. This means that two auto mode VPC networks that only have the default subnets cannot peer. GCP checks for overlap in the following circumstances:
   -  When you peer VPC networks for the first time
   -  When you create a new subnet in a peered VPC network
-  A subnet CIDR range in one peered VPC network cannot overlap a route in another peered network. This rule covers both subnet routes and custom routes. GCP checks for overlap in the following circumstances and generates an error when an overlap occurs.
   -  When you peer VPC networks for the first time
   -  When you create a static route in a peered VPC network
   -  When you create a new subnet in a peered VPC network
-  IAM Permissions: There are new IAM permissions for creating and deleting VPC Network Peering.
-  Once networks have peered, every internal, private IP is accessible across peered networks.
-  The following types of endpoints/resources are reachable across directly peered networks:
   -  Virtual machine (VM) internal IPs in all subnets
   -  Internal load balanced IPs in all subnets
-  The following types of endpoints/resources are NOT propagated to directly peered networks:
   -  Static routes
   -  VPNs
-  Only directly peered networks can communicate. Transitive peering is not supported.  No route to C via B etc.
-  Peering traffic (traffic flowing between peered networks) has the same latency, throughput, and availability as private traffic in the same network.
-  Billing policy for peering traffic remains unchanged from billing policy for private traffic in same network.

## Walk-through Of Network Operation

### VM Instance 1: Wants to send packet of data to Instance 2 using server name.

-  Inst 1: Calls DNS on its metadata server and gets back IP address.
-  Inst 1: Checks if IP address in address range on its subnet (all instances know subnet range).
-  If the IP address is outside the VPC network:
   -  Inst 1 sends the packet to the subnet's gateway MAC address with the destination set to the packet's final destination. The instance might need to make an ARP (Address Resolution Protocol) request to resolve the gateway's MAC address.
   -  The VPC rewrites IP header to declare the instance's external IP address as the source. If the instance has no external IP address, the call is not allowed, and the VPC network drops the packet without informing the sender.
   -  The VPC network records the outgoing packet and adds the source and destination to the active connections table.
   -  The VPC network sends the packet on to its destination.
   -  The destination gets the packet and responds if it chooses.
   -  The VPC receives the response, consults the active connections table, notes that this is an active connection, and allows it. The VPC network consults its network/external IP lookup table and replaces the instance's external IP address with the matching network address and sends the packet to the source instance.
   -  The instance receives the packet.
-  If the destination IP address is within the VPC network:
   -  The instance is configured with an IP with 255.255.255.255 mask, so the instance sends the packet to the subnet's gateway MAC address. The instance first might need to make an ARP request to resolve the gateway's MAC address.
   -  The VPC network, using Proxy ARP, responds with the MAC address of the destination instance.
   -  GCP forwards the packet to the destination IP within the VPC network.
   -  The target instance receives the packet. The target instance checks ingress firewall to determine if packet is allowed. If not, the packet is dropped silently. Otherwise, the instance processes the packet.

### An external instance or computer calls an instance:

-  The external caller sends a packet to an instance's external IP address, which is owned by the VPC network.
-  The VPC network compares the packet against the active connections table to see whether this is an existing connection:
   -  If it is not an existing connection, then the VPC network looks for a firewall rule to allow the connection.
   -  If there is no firewall rule, the VPC network drops the packet without informing the sender.
   -  If there is an existing connection or valid firewall rule, the VPC network examines its lookup table and replaces the external IP with the corresponding internal IP in the packet, logs the incoming packet in the active connections table, and sends the packet to the target instance.
-  The instance receives the packet and responds as described in "If the IP address is outside the VPC network IP range" above.
-  The VPC network receives the reply, finds the matching incoming request in the active connections table, and allows the packet through. Before sending, it modifies the source IP address by replacing the instance's internal IP with the corresponding external IP from its lookup table.

## Connecting to GCP: GCP Interconnection Options

-  VPN - IPSec protocol - Can use "Cloud Router".
-  Direct Peering - Private connect between you & Google for hybrid cloud networks.  Connection in a data centre where GCP has a point of presence.
-  Carrier Peering - Connect through the largest partner network of service providers.
-  Dedicated Interconnect - 10G transport circuits to Google Cloud at Google POPs.

## VPC Service Controls - Private Beta (as of Nov-2018)

*"VPC Service Controls allow users to define a security perimeter around Google Cloud Platform resources such as Cloud Storage buckets, Bigtable instances, and BigQuery datasets to constrain data within a VPC and help mitigate data ex filtration risks. With VPC Service Controls, enterprises can keep their sensitive data private as they take advantage of the fully managed storage and data processing capabilities of Google Cloud Platform."*

This means we can:
-  Define security perimeters for sensitive data in Google Cloud Platform services.
-  Establish virtual security perimeters for API-based services
-  **We can limit access to data in BigQuery to users connected via a specific VPC.**

<hr>
