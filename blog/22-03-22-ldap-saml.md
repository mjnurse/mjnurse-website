---
title: 22-03-22 - LDAP / SAML
contents-list: h1,h2
---

# Introduction

What are LDAP and SAML?

# LDAP Overview

Lightweight Directory Access Protocol - a protocol to access a directory service such as MS Active Directory.

## LDAP Operation Types

Here are some basic operation types in LDAP:

### Bind (Authentication)

When you create a session by connecting to an LDAP server, the session's default authentication state is anonymous. The LDAP bind feature validates the authentication state and changes it from anonymous. Bind can occur either through the Simple or SASL (Simple Authentication and Security Layer) authentication method.

### Unbind

Unbind aborts outstanding operations and ends their connections. You can accomplish the same thing by closing the connection.  Unbind is preferred because it frees up resources that may remain assigned to the aborted operation.

### Add

Add new entries to the directory-server database. If the added name already exists, the server won't accept the entry. Instead, it will deliver an "entryAlreadyExists" notification.

### Modify

LDAP clients use the modify feature to edit information already stored in a database. Only three types of modifications are permissible: Adding a new value to the data, Replacing or overwriting an existing value, and Deleting an existing value.

### Search and Compare

The operation lets clients search for and read entries. You can search for entries based on their name, size, scope, type, and other attributes. The compare feature makes it easy to verify whether a named entry has specific attributes.

### Delete

Clients use this feature to delete entries from the directory. Note that deletion will not occur unless the client sends a perfectly composed delete request to the server. Some of the features the delete request must have are: The name of the entry you want to erase, Attached request controls.

## Levels of LDAP Directory

A typical LDAP configuration follows a "tree" hierarchy format. Below are the hierarchy levels from start to end:

- The starting place - a root directory
- Countries
- Organizations or companies
- Divisions, departments, and other organizational units
- People, files, and shared resources (printers, computers, and so on)

You can distribute an LDAP directory across several servers. Queries from the clients are distributed across the multiple servers with the help of replication. 

## LDAP Data Components

Several components work together for LDAP to complete its myriad of tasks, especially when it comes to how it queries and displays data to users. The most essential of these components are:

### Attributes

The actual data within an LDAP system are stored as attributes. Each attribute is associated with an attribute type that specifies how clients and the directory server should interact with that attribute. Also, attribute values contain most of the data that users store and access in LDAP systems.

### Entries

Attributes define the characteristics of a user or item, while an entry describes the user or item by listing all of their attributes under a name. On their own, attributes have limited functions. You have to associate an attribute with an entry before you can fully utilize it.

### Data Information Tree (DIT)

Within an LDAP system, the data defined by attributes represent only a fraction of an object's available information. The remaining information is obtainable from the entry's placement within the LDAP system and the relationships its placement suggests. For example, if you have an entry for "inventoryItems" and another for "people", the data entered under each one will provide a better idea of what each entry represents.

Every entry in an LDAP system is set up as branches on Data Information Trees (DITs). Since every entry in an LDAP tree can symbolize almost anything, users mostly use entries for keeping things organized.

### Schemas

Schema is a construct where related ObjectClasses and attribute definitions go under the same category. One DIT can have several unrelated schemas for generating the entries and attributes it needs.

## Is LDAP secure?

LDAP authentication provides standard security with an built-in layer of access management. Malicious actors may still eavesdrop during data transmission between Active Directory and clients. Optimize security by adding SSL/TLS encryption to the LDAP authentication process, which makes information transmitted during the authentication process less vulnerable by encrypting communications.

The default LDAP port used for authentication (Port 389) does not have its own security. Create a secure connection by adding security extensions, such as the LDAPv3 TLS extension or StartTLS mode.

# SAML vs LDAP

LDAP and SAML are both authentication protocols that help applications access IT resources. SAML sends user information to your identity provider and other online applications, while LDAP facilitates on-prem authentication and other server processes.

Most organizations combine the use of SAML, LDAP, and other authentication protocols to access various types of IT resources and achieve their business objectives.

# Kerberos vs LDAP

Kerberos is a single sign-on and authentication protocol for managing credentials securely. It lets a process connect to an authentication server and provides signed and encrypted tickets for accessing files, applications, and other resources.

LDAP, on the other hand, facilitates accessing OpenLDAP, Active Directory, and other directories. It authenticates connections by cross-checking usernames and passwords stored in the LDAP directory. 

Since Kerberos is more secure than LDAP and LDAP has more functions than Kerberos, most organizations use both protocols.


<hr>
