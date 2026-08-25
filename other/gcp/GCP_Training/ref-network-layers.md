---
title: Ref - Network Layers
---

# HTTP vs HTTPS vs TCP vs TLS vs UDP

**Application Layer: (Layer 7)**
- HTTP(Hypertext Transfer Protocol): Stateless Request Response Cycle.
- HTTPS: Secure HTTP.
- SMTP: Email Transfer Protocol.
- FTP etc...

**Transport Layer: (Layer 4)**
- TCP (Transmission Control): Reliability > Performance.
- TLS (Transport Layer Security): Secure TCP.
- UDP (User Datagram Protocol): Performance > Reliability.
Some applications (eg. video streaming) might use this network layer (UDP protocol) directly (skipping the application layer).

**Network Layer: (Layer 3)**
- IP (Internet Protocol): Transfer bytes. Unreliable.


